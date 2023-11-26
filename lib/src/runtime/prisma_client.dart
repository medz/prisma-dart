import 'dart:async';

import 'engine.dart';
import 'transaction.dart';

class PrismaClient<T> {
  const PrismaClient._internal({
    required Engine<T> engine,
    TransactionHeaders? headers,
    Transaction<T>? transaction,
  })  : _engine = engine,
        _headers = headers,
        _transaction = transaction;

  static TransactionHeaders? $getPrismaClientHeaders(PrismaClient prisma) =>
      prisma._headers;

  static Transaction<T>? $getPrismaClientTransaction<T>(
          PrismaClient<T> prisma) =>
      prisma._transaction;

  static Engine<T> $getPrismaEngine<T>(PrismaClient<T> prisma) =>
      prisma._engine;

  const PrismaClient({required Engine<T> engine})
      : this._internal(engine: engine);

  //-------------------- Inner fields ----------------------
  final TransactionHeaders? _headers;
  final Transaction<T>? _transaction;
  //------------------ Inner fields end --------------------

  final Engine<T> _engine;

  /// Connect with the database.
  Future<void> $connect() => _engine.start();

  /// Disconnect from the database.
  Future<void> $disconnect() => _engine.stop();

  /// Interactive Transactions
  ///
  /// Interactive transactions allow you to thread into a function that accepts
  /// a [PrismaClient] instance. You can complete a series of database
  /// operations within the function and then submit.
  ///
  /// ### Example
  ///
  /// ```dart
  /// prisma.$transaction((prisma) async {
  ///   final user = await prisma.user.create(
  ///     data: UserCreateInput(
  ///       email: 'seven@odroe.com',
  ///       name: 'Seven',
  ///     ),
  ///   );
  ///
  ///   await prisma.user.update(
  ///     where: UserWhereUniqueInput(id: user.id),
  ///     data: UserUpdateInput(
  ///       age: 7,
  ///     ),
  ///   );
  ///
  ///   return user;
  /// });
  /// ```
  Future<R> $transaction<R>(
    FutureOr<R> Function(PrismaClient<T> prisma) fn, {
    int maxWait = 2000,
    int timeout = 5000,
    IsolationLevel? isolationLevel,
  }) async {
    if (_transaction != null) {
      throw Exception('Cannot nest transactions.');
    }

    const headers = TransactionHeaders();
    final transaction = await _engine.startTransaction(
      headers: headers,
      maxWait: maxWait,
      timeout: timeout,
      isolationLevel: isolationLevel,
    );
    final prisma = PrismaClient<T>._internal(
        engine: _engine, headers: headers, transaction: transaction);

    try {
      final result = await fn(prisma);
      await _engine.commitTransaction(
        headers: headers,
        transaction: transaction,
      );

      return result;
    } catch (e) {
      await _engine.rollbackTransaction(
        headers: headers,
        transaction: transaction,
      );

      rethrow;
    }
  }
}
