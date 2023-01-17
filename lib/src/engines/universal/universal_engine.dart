import 'dart:async';
import 'dart:convert' as convert;

import 'package:orm/logger.dart' as logger_package;
import 'package:retry/retry.dart' as retry;
import 'package:http/http.dart' as http;

import '../engine.dart';
import '../graphql_result.dart';
import '../query_engine_request_headers.dart';
import '../transaction.dart';
import '_internal/headers_wrapper.dart';
import '_internal/stringify_query.dart';

/// Create RetryOptions with exponential backoff.
const retry.RetryOptions _retryOptions = retry.RetryOptions(
  maxAttempts: 10,
  randomizationFactor: 0.2,
  delayFactor: Duration(milliseconds: 50),
);

/// Prisma Universal Engine.
///
/// The Universal Engine is a wrapper around the Prisma GraphQL and the
/// Prisma Data Proxy (if enabled).
class UniversalEngine implements Engine {
  /// The GraphQL endpoint.
  final Uri endpoint;

  /// HTTP headers.
  final Map<String, String>? headers;

  /// Prisma Emitter.
  final logger_package.Logger logger;

  /// Create a new instance of [UniversalEngine].
  const UniversalEngine({
    required this.endpoint,
    required this.logger,
    this.headers,
  });

  @override
  void on(logger_package.Event event, logger_package.Listener listener) =>
      logger.on(event, listener);

  @override
  Future<GraphQLResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  }) {
    logger.emit(
        logger_package.Event.query, logger_package.QueryPayload(query: query));

    final url = endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'graphql'],
    );
    final wrappedHeaders =
        headersWrapper(headers: [this.headers, headers], info: transaction);
    final body = stringifyQuery(query);

    /// Create a retry function.
    Future<GraphQLResult> fn(void Function(Uri) logger) async {
      logger(url);

      final response =
          await http.post(url, headers: wrappedHeaders, body: body);
      final json =
          (convert.json.decode(response.body) as Map).cast<String, dynamic>();

      return GraphQLResult.fromJson(json);
    }

    return withRetry<GraphQLResult>(fn, gerund: 'querying');
  }

  @override
  Future<TransactionInfo> startTransaction({
    TransactionHeaders? headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    IsolationLevel? isolationLevel,
  }) {
    final url = endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'transaction', 'start'],
    );
    final body = convert.json.encode({
      'max_wait': timeout.inMilliseconds,
      'timeout': maxWait.inMilliseconds,
      'isolation_level': isolationLevel?.value,
    });
    final wrappedHeaders = headersWrapper(headers: [this.headers, headers]);

    // Create a retry function.
    Future<TransactionInfo> fn(void Function(Uri) logger) async {
      logger(url);

      final response =
          await http.post(url, headers: wrappedHeaders, body: body);
      final json =
          (convert.json.decode(response.body) as Map).cast<String, dynamic>();

      return TransactionInfo.fromJson(json);
    }

    return withRetry<TransactionInfo>(fn, gerund: 'starting transaction');
  }

  @override
  Future<void> commitTransaction(
      {required TransactionInfo info, TransactionHeaders? headers}) {
    final url = info.endpoint
        .replace(pathSegments: [...info.endpoint.pathSegments, 'rollback']);

    return _otherTransaction(url, gerund: 'committing');
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionInfo info, TransactionHeaders? headers}) {
    final url = info.endpoint
        .replace(pathSegments: [...info.endpoint.pathSegments, 'rollback']);

    return _otherTransaction(url, gerund: 'rolling back');
  }

  @override
  Future<void> start() async {
    // Universal Engine does not need to be started.
  }

  @override
  Future<void> stop() async {
    // Universal Engine does not need to be stopped.
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
    void logger(Uri uri) => this.logger.emit(logger_package.Event.info,
        logger_package.Payload(message: 'Calling $uri (n=$attempt)'));

    // Create a retry function.
    Future<T> callback() {
      if (attempt > 0) {
        this.logger.emit(
              logger_package.Event.warn,
              logger_package.Payload(
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
        this.logger.emit(
              logger_package.Event.warn,
              logger_package.Payload(
                message:
                    'Attempt $attempt/${_retryOptions.maxAttempts} failed for $gerund: $e',
              ),
            );

        return await onRetry?.call(e);
      },
    );
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
}
