import '../../base_prisma_client.dart';
import '../../errors.dart';
import '../engine.dart';
import 'isolation_level.dart';
import 'transaction_headers.dart';
import 'transaction.dart';

class TransactionClient<Client extends BasePrismaClient<Client>> {
  final Engine _engine;
  final Client Function(TransactionClient<Client> transactionClient) _factory;

  final TransactionHeaders? headers;
  final Transaction? transaction;

  const TransactionClient._({
    required Client Function(TransactionClient<Client>) factory,
    required Engine engine,
    required this.headers,
    required this.transaction,
  })  : _factory = factory,
        _engine = engine;

  const TransactionClient(
      Engine engine, Client Function(TransactionClient<Client>) factory)
      : _factory = factory,
        _engine = engine,
        headers = null,
        transaction = null;

  /// Start a new transaction.
  Future<Client> start({
    TransactionHeaders? headers,
    int maxWait = 2000,
    int timeout = 5000,
    TransactionIsolationLevel? isolationLevel,
  }) async {
    if (this.transaction?.id != null) {
      throw PrismaClientUnknownRequestError(
          message: 'Cannot nest start transactions.');
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
      throw PrismaClientValidationError(
          message: 'Cannot commit a transaction that has not been started.');
    }

    return _engine.commitTransaction(
      headers: headers!,
      transaction: transaction!,
    );
  }

  /// Rollback a transaction.
  Future<void> rollback() {
    if (headers == null || transaction == null) {
      throw PrismaClientValidationError(
          message: 'Cannot rollback a transaction that has not been started.');
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
    Future<R> Function(Client prisma) fn, {
    int maxWait = 2000,
    int timeout = 5000,
    TransactionIsolationLevel? isolationLevel,
  }) async {
    final client = await start(
      headers: headers,
      maxWait: maxWait,
      timeout: timeout,
      isolationLevel: isolationLevel,
    );

    try {
      final result = await fn(client);
      await client.$transaction.commit();

      return result;
    } catch (e) {
      await client.$transaction.rollback();

      rethrow;
    }
  }

  /// Generate current transaction traceparent.
  static String generateTraceparent() {
    return 'T${DateTime.now().millisecondsSinceEpoch}';
  }
}
