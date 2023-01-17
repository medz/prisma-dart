import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:prisma_event/prisma_event.dart' as event;
import 'package:retry/retry.dart' as retry;

import 'graphql_result.dart';
import 'query_engine_request_headers.dart';
import 'transaction.dart';

/// Default query request headers.
const Map<String, String> _defaultRequestHeaders = {
  'user-agent': 'Prisma ORM (https://prisma.pub)',
  'content-type': 'application/json; charset=utf-8',
  'accept': 'application/json; charset=utf-8',
};

/// Create RetryOptions with exponential backoff.
const retry.RetryOptions _retryOptions = retry.RetryOptions(
  maxAttempts: 10,
  randomizationFactor: 0.2,
  delayFactor: Duration(milliseconds: 50),
);

/// Prisma query engine interface.
class Engine {
  /// The GraphQL endpoint.
  final Uri endpoint;

  /// HTTP headers.
  final Map<String, String>? headers;

  /// Prisma Emitter.
  final event.Emitter emitter;

  /// Create a new instance of [Engine].
  const Engine({
    required this.endpoint,
    required this.emitter,
    this.headers,
  });

  /// Starts the engine.
  Future<void> start() async {}

  /// Stops the engine.
  Future<void> stop() async {}

  /// Register a new event listener.
  void on(event.Event event, void Function(event.Payload payload) listener) =>
      emitter.on({event}, listener);

  /// Requests a query execution.
  Future<GraphQLResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  }) async {
    emitter.emit(event.Event.query, event.QueryPayload(query: query));

    final url = endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'graphql'],
    );
    final resolvedHeaders =
        _resolveHeaders(headers: headers, transaction: transaction);
    final body = _stringifyQuery(query);

    /// Create a retry function.
    Future<GraphQLResult> fn(void Function(Uri) logger) async {
      logger(url);

      final response =
          await http.post(url, headers: resolvedHeaders, body: body);
      final json =
          (convert.json.decode(response.body) as Map).cast<String, dynamic>();

      return GraphQLResult.fromJson(json);
    }

    return withRetry<GraphQLResult>(fn, gerund: 'querying');
  }

  /// Starts a transaction.
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    IsolationLevel? isolationLevel,
  }) async {
    final url = endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'transaction', 'start'],
    );
    final body = convert.json.encode({
      'max_wait': timeout.inMilliseconds,
      'timeout': maxWait.inMilliseconds,
      'isolation_level': isolationLevel?.value,
    });

    // Create a retry function.
    Future<TransactionInfo> fn(void Function(Uri) logger) async {
      logger(url);

      final response = await http.post(url,
          headers: _resolveHeaders(headers: headers), body: body);
      final json =
          (convert.json.decode(response.body) as Map).cast<String, dynamic>();

      if (json.containsKey('id')) {
        // If the request not is data-proxy, generate a transaction endpoint.
        if (!json.containsKey('data-proxy')) {
          json['endpoint'] = endpoint.replace(
            pathSegments: [...endpoint.pathSegments, 'transaction', json['id']],
          );
        }

        return TransactionInfo.fromJson(json);
      }

      throw json;
    }

    return withRetry<TransactionInfo>(fn, gerund: 'starting transaction');
  }

  /// Commits a transaction.
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) async {
    final url = info.endpoint
        .replace(pathSegments: [...info.endpoint.pathSegments, 'rollback']);

    return _otherTransaction(url, gerund: 'committing');
  }

  /// Rolls back a transaction.
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) async {
    final url = info.endpoint
        .replace(pathSegments: [...info.endpoint.pathSegments, 'rollback']);

    return _otherTransaction(url, gerund: 'rolling back');
  }

  /// Other transaction operations.
  Future<void> _otherTransaction(
    Uri url, {
    required String gerund,
  }) async {
    // Create a retry function.
    Future<void> fn(void Function(Uri) logger) async {
      logger(url);

      await http.post(url);
    }

    await withRetry<void>(fn, gerund: '$gerund transaction');
  }

  /// Retry a request.
  Future<T> withRetry<T>(
    Future<T> Function(void Function(Uri uri) logger) fn, {
    required String gerund,
    FutureOr<bool> Function(Exception)? retryIf,
    FutureOr<void> Function(Exception)? onRetry,
  }) {
    int attempt = 0;

    // Create a logger.
    void logger(Uri uri) => emitter.emit(
        event.Event.info, event.Payload(message: 'Calling $uri (n=$attempt)'));

    // Create a retry function.
    Future<T> callback() {
      if (attempt > 0) {
        emitter.emit(
          event.Event.warn,
          event.Payload(
            message:
                'Retrying after ${_retryOptions.delay(attempt).inMilliseconds}ms',
          ),
        );
      }

      attempt++;
      return fn(logger);
    }

    return _retryOptions.retry<T>(
      callback,
      retryIf: retryIf,
      onRetry: (e) async {
        emitter.emit(
          event.Event.warn,
          event.Payload(
            message:
                'Attempt $attempt/${_retryOptions.maxAttempts} failed for $gerund: $e',
          ),
        );

        return await onRetry?.call(e);
      },
    );
  }

  /// Resolve the HTTP headers.
  Map<String, String> _resolveHeaders({
    Map<String, String>? headers,
    TransactionInfo? transaction,
  }) {
    final resolvedHeaders = <String, String>{
      ..._defaultRequestHeaders,
      ...?this.headers,
      ...?headers,
    };

    if (transaction != null) {
      resolvedHeaders['x-transaction-id'] = transaction.id;
    }

    return resolvedHeaders;
  }

  /// Generate a GraphQL body.
  static String _stringifyQuery(String query) => convert.json.encode({
        'query': query,
        'variables': {},
      });
}
