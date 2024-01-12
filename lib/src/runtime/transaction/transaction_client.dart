import '../engine.dart';
import 'isolation_level.dart';
import 'transaction_headers.dart';
import 'transaction.dart';

class TransactionClient<T> {
  final Engine _engine;
  final T Function(TransactionClient<T> transactionClient) _factory;

  final TransactionHeaders? headers;
  final Transaction? transaction;

  const TransactionClient._({
    required T Function(TransactionClient<T>) factory,
    required Engine engine,
    required this.headers,
    required this.transaction,
  })  : _factory = factory,
        _engine = engine;

  const TransactionClient(
      Engine engine, T Function(TransactionClient<T>) factory)
      : _factory = factory,
        _engine = engine,
        headers = null,
        transaction = null;

  /// Start a new transaction.
  Future<T> start({
    TransactionHeaders? headers,
    int maxWait = 2000,
    int timeout = 5000,
    IsolationLevel? isolationLevel,
  }) async {
    if (this.transaction?.id != null) {
      throw Exception('Cannot nest start transactions.');
    }

    headers ??= TransactionHeaders();
    headers.traceparent ??= generateTraceparent();

    final transaction = await _engine.startTransaction(
      headers: headers,
      maxWait: maxWait,
      timeout: timeout,
      isolationLevel: isolationLevel,
    );
    final client = TransactionClient._(
      factory: _factory,
      engine: _engine,
      headers: headers,
      transaction: transaction,
    );

    return _factory(client);
  }

  /// Commit a transaction.
  Future<void> commit() {
    if (headers == null || transaction == null) {
      throw Exception('Cannot commit a transaction that has not been started.');
    }

    return _engine.commitTransaction(
      headers: headers!,
      transaction: transaction!,
    );
  }

  /// Rollback a transaction.
  Future<void> rollback() {
    if (headers == null || transaction == null) {
      throw Exception(
          'Cannot rollback a transaction that has not been started.');
    }

    return _engine.rollbackTransaction(
      headers: headers!,
      transaction: transaction!,
    );
  }

  /// Interactive transactions.
  ///
  /// ### Example
  /// ```dart
  /// prisma.$transaction((prisma) async {
  ///   final user = await prisma.user.create(...);
  ///   await prisma.user.update(...);
  ///   return user;
  /// });
  /// ```
  Future<R> call<R>(
    Future<R> Function(T client) fn, {
    int maxWait = 2000,
    int timeout = 5000,
    IsolationLevel? isolationLevel,
  }) async {
    final client = await start(
      maxWait: maxWait,
      timeout: timeout,
      isolationLevel: isolationLevel,
    );

    try {
      final result = await fn(client);
      await commit();

      return result;
    } catch (e) {
      await rollback();

      rethrow;
    }
  }

  /// Generate current transaction traceparent.
  static String generateTraceparent() {
    return 'T${DateTime.now().millisecondsSinceEpoch}';
  }
}
