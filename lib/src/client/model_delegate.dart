import 'package:meta/meta.dart';
import 'package:orm/engine_core.dart';
import 'package:orm/graphql.dart';
import 'package:orm/src/exceptions.dart';

/// Model delegate
class ModelDelegate<T> {
  /// Prisma engine.
  final Engine _engine;

  /// Query engine request headers.
  final QueryEngineRequestHeaders? _headers;

  /// Transaction info.
  final TransactionInfo? _transaction;

  /// Creates a new model delegate.
  const ModelDelegate(
    Engine engine, {
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  })  : _engine = engine,
        _headers = headers,
        _transaction = transaction;

  /// Executes a GraphQL query.
  @internal
  Future<Map<String, dynamic>?> $query(Iterable<GraphQLField> fields) =>
      _execute('query', fields);

  /// Executes a GraphQL mutation.
  @internal
  Future<Map<String, dynamic>?> $mutation(Iterable<GraphQLField> fields) =>
      _execute('mutation', fields);

  /// Common GraphQL execute method.
  Future<Map<String, dynamic>> _execute(
      String operation, Iterable<GraphQLField> fields) async {
    final query = GraphQLField(operation, fields: fields).toSdl();
    final result = await _engine.request(
      query: query,
      headers: _headers,
      transaction: _transaction,
    );

    final exceptions = result.errors?.map((e) => e.toException(_engine));
    if (exceptions != null && exceptions.isNotEmpty) {
      throw _generateThrownException(exceptions);

      // If data is null, throw an exception.
    } else if (result.data == null) {
      throw PrismaUnknownException(_engine);
    }

    return result.data!;
  }

  /// Returns thrown exception.
  PrismaException _generateThrownException(
      Iterable<PrismaRequestException> exceptions) {
    // If exceptions only contains one exception, throw it.
    if (exceptions.length == 1) {
      return exceptions.first;
    }

    // Otherwise, throw a [MultiplePrismaRequestException].
    return MultiplePrismaRequestException(
      engine: _engine,
      message: 'Multiple exceptions occurred',
      exceptions: exceptions,
    );
  }
}
