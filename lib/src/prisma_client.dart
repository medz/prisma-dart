import 'engine.dart';
import 'metrics/metrics_client.dart';
import 'transaction/isolation_level.dart';
import 'transaction/transaction_headers.dart';
import 'transaction/transaction_info.dart';

class PrismaClient<T> {
  /// The client transaction headers.
  final TransactionHeaders? $headers;

  /// The client transaction information.
  final TransactionInfo<T>? $info;

  /// the client with engine.
  final Engine<T> $engine;

  /// Creates a new client from parameters.
  const PrismaClient.from({
    required Engine<T> engine,
    TransactionHeaders? headers,
    TransactionInfo<T>? transaction,
  })  : $headers = headers,
        $info = transaction,
        $engine = engine;

  /// Connect with the database.
  Future<void> $connect() => $engine.start();

  /// Disconnect from the database.
  Future<void> $disconnect() => $engine.stop();

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
    Future<R> Function(PrismaClient<T> prisma) fn, {
    int maxWait = 2000,
    int timeout = 5000,
    IsolationLevel? isolationLevel,
  }) async {
    if ($info != null) {
      throw Exception('Cannot nest transactions.');
    }

    const headers = TransactionHeaders(traceparent: "");
    final transaction = await $engine.startTransaction(
      headers: headers,
      maxWait: maxWait,
      timeout: timeout,
      isolationLevel: isolationLevel,
    );
    final prisma = PrismaClient<T>.from(
        engine: $engine, headers: headers, transaction: transaction);

    try {
      final result = await fn(prisma);
      await $engine.commitTransaction(
        headers: headers,
        transaction: transaction,
      );

      return result;
    } catch (e) {
      await $engine.rollbackTransaction(
        headers: headers,
        transaction: transaction,
      );

      rethrow;
    }
  }

  MetricsClient<T> get $metrics => MetricsClient($engine);
}
