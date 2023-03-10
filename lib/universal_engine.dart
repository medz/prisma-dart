library prisma.engine.universal;

import 'dart:async';
import 'dart:convert' as convert;

import 'package:retry/retry.dart' as retry;
import 'package:http/http.dart' as http;

import 'engine_core.dart';
import 'logger.dart';
import 'src/_internal/engines/headers_wrapper.dart';
import 'src/_internal/engines/stringify_query.dart';
import 'src/exceptions.dart';

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
  @override
  final Logger logger;

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
  }) async {
    await start();
    logger.emit(Event.query, QueryPayload(query: query));

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

      return GraphQLResult.fromJson(json);
    }

    return withRetry<GraphQLResult>(
      fn,
      gerund: 'querying',
    );
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
    TransactionIsolationLevel? isolationLevel,
  }) async {
    await start();
    final url = resolveStartTransactionEndpoint();
    final body = convert.json.encode({
      'max_wait': timeout.inMilliseconds,
      'timeout': maxWait.inMilliseconds,
      'isolation_level': isolationLevel?.originalName,
    });
    final wrappedHeaders = headersWrapper(headers: [this.headers, headers]);

    // Create a retry function.
    Future<TransactionInfo> fn(void Function(Uri) logger) async {
      logger(url);

      final response =
          await http.post(url, headers: wrappedHeaders, body: body);
      _tryThrowExceptionFromStatusCode(response.statusCode);

      final json =
          (convert.json.decode(response.body) as Map).cast<String, dynamic>();
      _tryThrowPrismaException(json);

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
      {required TransactionInfo info, TransactionHeaders? headers}) async {
    await start();
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
      {required TransactionInfo info, TransactionHeaders? headers}) async {
    await start();
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
    final retry = _InternalRetry(
      gerund: gerund,
      emit: logger.emit,
      fn: fn,
      retryIf: retryIf,
      onRetry: onRetry,
    );

    return _retryOptions.retry<T>(
      retry,
      retryIf: retry.retryIf,
      onRetry: retry.onRetry,
    );
  }

  /// Other transaction operations.
  Future<void> _otherTransaction(
    Uri url, {
    required String gerund,
  }) {
    return withRetry(gerund: '$gerund transaction', (logger) async {
      logger(url);

      final response = await http.post(url);

      _tryThrowExceptionFromStatusCode(response.statusCode);
      _tryThrowPrismaException(_tryDecodeJson(response.body));
    });
  }

  /// Try to decode json, if failed, return a Map.
  Map<String, dynamic> _tryDecodeJson(String body) {
    try {
      return (convert.json.decode(body) as Map).cast<String, dynamic>();
    } catch (e) {
      return const <String, dynamic>{};
    }
  }

  /// Try throw an [PrismaException] from the [json].
  void _tryThrowPrismaException(Map<String, dynamic> json) {
    final errors = json['errors'];
    if (errors != null && errors is Iterable && errors.isEmpty) {
      final exceptions =
          errors.map((e) => GraphQLError.fromJson(json).toException(this));

      if (exceptions.length == 1) {
        final exception = exceptions.first;
        logger.emit(Event.error, Payload(message: exception.message));

        throw exception;
      }

      throw MultiplePrismaRequestException(
        message: 'Multiple exceptions occurred',
        engine: this,
        exceptions: exceptions,
      );
    }
  }

  /// Try throw exception from http status code
  void _tryThrowExceptionFromStatusCode(int statusCode) {
    if (statusCode >= 400) {
      throw PrismaException(
        message: 'Request failed with status code $statusCode',
        engine: this,
      );
    }
  }
}

/// Internel retry
class _InternalRetry<T> {
  int attempts = 0;
  final String gerund;
  final void Function(Event event, Payload payload) _emit;
  final Future<T> Function(void Function(Uri uri) logger) _fn;
  final FutureOr<bool> Function(Exception)? _retryIf;
  final FutureOr<void> Function(Exception)? _onRetry;

  _InternalRetry({
    required this.gerund,
    required void Function(Event event, Payload payload) emit,
    required Future<T> Function(void Function(Uri uri) logger) fn,
    FutureOr<bool> Function(Exception)? retryIf,
    FutureOr<void> Function(Exception)? onRetry,
  })  : _emit = emit,
        _fn = fn,
        _retryIf = retryIf,
        _onRetry = onRetry;

  void logger(Uri uri) {
    _emit(
      Event.info,
      Payload(message: 'Calling $uri (n=$attempts)'),
    );
  }

  Future<T> call() {
    if (attempts > 0) {
      _emit(
        Event.warn,
        Payload(
          message:
              'Retrying after ${_retryOptions.delay(attempts).inMilliseconds}ms',
        ),
      );
    }

    attempts++;
    return _fn(logger);
  }

  FutureOr<bool> retryIf(Exception e) {
    if (e is PrismaException) return false;

    return _retryIf?.call(e) ?? true;
  }

  FutureOr<void> onRetry(Exception e) {
    _emit(
      Event.warn,
      Payload(
        message:
            'Attempt $attempts/${_retryOptions.maxAttempts} failed for $gerund: $e',
      ),
    );

    return _onRetry?.call(e);
  }
}
