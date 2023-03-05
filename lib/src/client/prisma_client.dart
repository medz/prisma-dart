import 'dart:async';

import '../../engine_core.dart';
import '../../logger.dart';
import '../graphql/arg.dart';
import '../graphql/field.dart';
import 'prisma_raw_codec.dart';

/// Prisma transaction function.
typedef PrismaTransactionCallback<T, Client extends BasePrismaClient<Client>>
    = FutureOr<T> Function(Client transaction);

/// Prisma client base class
abstract class BasePrismaClient<Client extends BasePrismaClient<Client>> {
  /// Finalizer
  static final Finalizer<Engine> finalizer =
      Finalizer<Engine>((engine) => engine.stop());

  /// Create a new instance of [BasePrismaClient].
  BasePrismaClient(
    Engine engine, {
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  })  : _transaction = transaction,
        _headers = headers,
        _engine = engine {
    // finalizer.attach(this, engine, detach: this);
  }

  /// The prisma engine.
  final Engine _engine;

  /// Query engine request headers.
  final QueryEngineRequestHeaders? _headers;

  /// Transaction info.
  final TransactionInfo? _transaction;

  /// Copy the client with new headers.
  Client copyWith({
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  });

  /// Connect to the prisma engine.
  Future<void> $connect() {
    finalizer.attach(this, _engine, detach: this);

    return _engine.start();
  }

  /// Disconnect from the prisma engine.
  Future<void> $disconnect() async {
    await _engine.stop();
    finalizer.detach(this);
  }

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
    PrismaTransactionCallback<T, Client> callback, {
    TransactionHeaders? headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    TransactionIsolationLevel? isolationLevel,
  }) async {
    // If the client is a transaction, use it.
    if (_headers?.transactionId != null || _transaction != null) {
      return callback(this as Client);
    }

    // Request a new transaction.
    final TransactionInfo transactionInfo = await _engine.startTransaction(
      headers: headers,
      timeout: timeout,
      maxWait: maxWait,
      isolationLevel: isolationLevel,
    );

    // Create a new client for the transaction.
    final Client client = copyWith(
      headers: QueryEngineRequestHeaders(
        transactionId: transactionInfo.id,
        traceparent: headers?.traceparent,
      ),
      transaction: transactionInfo,
    );

    // Execute the transaction.
    try {
      final T result = await callback(client);
      await _engine.commitTransaction(
        headers: headers,
        info: transactionInfo,
      );
      return result;
    } catch (e) {
      await _engine.rollbackTransaction(
        headers: headers,
        info: transactionInfo,
      );
      rethrow;
    }
  }

  /// The $on() method allows you to subscribe to events.
  ///
  /// All message use a [Exception] class wrapper.
  ///
  /// ### Example:
  /// ```dart
  /// prisma.$on({PrismaLogLevel.query}, (e) {
  ///   if (e is PrismaQueryEvent) {
  ///     print(e.query);
  ///   }
  /// });
  /// ```
  void $on(Event event, Listener listener) =>
      _engine.logger.on(event, listener);

  /// Query raw SQL.
  ///
  /// ### Example:
  /// ```dart
  /// final result = await prisma.$queryRaw('SELECT * FROM User');
  /// ```
  Future<dynamic> $queryRaw(
    String query, {
    Iterable<dynamic> parameters = const [],
  }) async {
    final String sdl = GraphQLField(
      'mutation',
      fields: [
        GraphQLField(
          'queryRaw',
          args: [
            GraphQLArg('query', query),
            GraphQLArg('parameters', prismaRawParameter.encode(parameters)),
          ],
        )
      ],
    ).toSdl();

    // Request the query.
    final GraphQLResult result = await _engine.request(
      query: sdl,
      headers: _headers,
      transaction: _transaction,
    );

    // Get query result.
    final dynamic queryRawResult = result.data?['queryRaw'];

    // Return the result.
    return prismaRawParameter.decode(queryRawResult);
  }

  /// Execute raw SQL.
  ///
  /// ### Example:
  /// ```dart
  /// final int affectedRows = await prisma.$executeRaw('DELETE FROM User');
  /// ```
  Future<int> $executeRaw(
    String query, {
    Iterable<dynamic> parameters = const [],
  }) async {
    final String sdl = GraphQLField(
      'mutation',
      fields: [
        GraphQLField('queryRaw', args: [
          GraphQLArg('query', query),
          GraphQLArg('parameters', prismaRawParameter.encode(parameters)),
        ])
      ],
    ).toSdl();

    // Request the query.
    final GraphQLResult result = await _engine.request(
      query: sdl,
      headers: _headers,
      transaction: _transaction,
    );

    return result.data?['executeRaw'];
  }
}
