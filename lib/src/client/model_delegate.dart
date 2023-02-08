import 'package:orm/engine_core.dart';
import 'package:orm/graphql.dart';

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
  Future<Map<String, dynamic>?> $query(GraphQLField field) =>
      _execute('query', field);

  /// Executes a GraphQL mutation.
  Future<Map<String, dynamic>?> $mutation(GraphQLField field) =>
      _execute('mutation', field);

  /// Common GraphQL execute method.
  Future<Map<String, dynamic>?> _execute(
      String operation, GraphQLField field) async {
    final query = GraphQLField(operation, fields: [field]).toSdl();
    final result = await _engine.request(
      query: query,
      headers: _headers,
      transaction: _transaction,
    );

    // TODO: GraphQL error handling

    return result.data?[operation];
  }
}
