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

    if (result.data == null) {
      throw PrismaUnknownException(_engine);
    }

    return result.data!;
  }
}
