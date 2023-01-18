import 'dart:async';
import 'dart:convert' as convert;

import 'package:orm/logger.dart' as logger_package;
import 'package:retry/retry.dart' as retry;
import 'package:http/http.dart' as http;

import '../engine.dart';
import '../graphql_result.dart';
import '../query_engine_request_headers.dart';
import '../transaction.dart';
import '../_internal/headers_wrapper.dart';
import '../_internal/stringify_query.dart';

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
///
/// **Note**: If the endpoint is a Data Proxy, the Universal Engine has no special optimizations for Data Proxy.
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

  /// Resolve the request endpoint.
  Uri resolveRequestEndpoint() {
    return endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'graphql'],
    );
  }

  @override
  Future<GraphQLResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  }) {
    logger.emit(
        logger_package.Event.query, logger_package.QueryPayload(query: query));

    final url = resolveRequestEndpoint();
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

      // TODO: Handle errors.

      return GraphQLResult.fromJson(json);
    }

    return withRetry<GraphQLResult>(fn, gerund: 'querying');
  }

  /// Resolve start transaction endpoint.
  Uri resolveStartTransactionEndpoint() {
    return endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'transaction', 'start'],
    );
  }

  @override
  Future<TransactionInfo> startTransaction({
    TransactionHeaders? headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    IsolationLevel? isolationLevel,
  }) {
    final url = resolveStartTransactionEndpoint();
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

      // TODO Error handling

      return TransactionInfo.fromJson(json);
    }

    return withRetry<TransactionInfo>(fn, gerund: 'starting transaction');
  }

  /// Resolve the commit transaction endpoint.
  Uri resolveCommitTransactionEndpoint(TransactionInfo info) {
    return endpoint.replace(
      pathSegments: [
        ...endpoint.pathSegments,
        'transaction',
        info.id,
        'commit',
      ],
    );
  }

  @override
  Future<void> commitTransaction(
      {required TransactionInfo info, TransactionHeaders? headers}) {
    final url = resolveCommitTransactionEndpoint(info);

    return _otherTransaction(url, gerund: 'committing');
  }

  /// Resolve the rollback transaction endpoint.
  Uri resolveRollbackTransactionEndpoint(TransactionInfo info) {
    return endpoint.replace(
      pathSegments: [
        ...endpoint.pathSegments,
        'transaction',
        info.id,
        'rollback',
      ],
    );
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionInfo info, TransactionHeaders? headers}) {
    final url = resolveRollbackTransactionEndpoint(info);

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

      // TODO: Handle errors.
    }

    await withRetry<void>(fn, gerund: '$gerund transaction');
  }
}
