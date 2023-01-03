import 'dart:async';

import '../engine_core/common/engine.dart';
import '../engine_core/common/types/query_engine.dart';
import '../engine_core/common/types/transaction.dart';

/// Prisma transaction function.
typedef PrismaTransactionCallback<T> = FutureOr<T> Function(
    PrismaClient transaction);

/// Prisma client base class
class PrismaClient {
  /// The prisma engine.
  final Engine $engine;

  /// Query engine request headers.
  final QueryEngineRequestHeaders? $headers;

  /// Create a new prisma client for the given engine.
  const PrismaClient.fromEngine(this.$engine,
      {QueryEngineRequestHeaders? headers})
      : $headers = headers;

  /// Connect to the prisma engine.
  Future<void> $connect() => $engine.start();

  /// Disconnect from the prisma engine.
  Future<void> $disconnect() => $engine.stop();

  /// Interactive transactions.
  ///
  /// Sometimes you need more control over what queries execute within a
  /// transaction. Interactive transactions are meant to provide you with
  /// an escape hatch.
  ///
  /// ### Example
  ///
  /// ```dart
  /// final prisma = PrismaClient();
  /// prisma.$transaction((transaction) async {
  ///   await transaction.user.create({ ... });
  ///   await transaction.post.create({ ... });
  /// });
  /// ```
  Future<T> $transaction<T>(
    PrismaTransactionCallback<T> callback, {
    TransactionOptions options = const TransactionOptions(),
    TransactionHeaders headers = const TransactionHeaders(),
  }) async {
    // If the client is a transaction, use it.
    if ($headers?.transactionId != null) {
      return callback(this);
    }

    // Request a new transaction.
    final TransactionInfo transactionInfo = await $engine.startTransaction(
      options: options,
      headers: headers,
    );

    // Create a new client for the transaction.
    final PrismaClient transactionClient = PrismaClient.fromEngine(
      $engine,
      headers: QueryEngineRequestHeaders(
        transactionId: transactionInfo.id,
        traceparent: headers.traceparent,
      ),
    );

    // Execute the transaction.
    try {
      final T result = await callback(transactionClient);
      await $engine.commitTransaction(
        headers: headers,
        info: transactionInfo,
      );
      return result;
    } catch (e) {
      await $engine.rollbackTransaction(
        headers: headers,
        info: transactionInfo,
      );
      rethrow;
    }
  }
}
