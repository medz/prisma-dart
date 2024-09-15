import '../../base_prisma_client.dart';
import '../json_protocol/protocol.dart';
import '../json_protocol/serialize.dart';
import '_serialize_raw_params.dart';
import '_deserialize_raw_results.dart';

class RawClient<Client extends BasePrismaClient<Client>> {
  final Client _client;

  const RawClient(Client client) : _client = client;

  Future<List<Map<String, Object?>>> query(
    String sql, [
    Iterable<Object>? parameters,
  ]) async {
    final results = await _innerRunSQL(
      action: JsonQueryAction.queryRaw,
      sql: sql,
      parameters: parameters,
    );

    return deserializeRawResult(results[JsonQueryAction.queryRaw.name]);
  }

  Future<int> execute(String sql, [Iterable<Object>? parameters]) async {
    final results = await _innerRunSQL(
      action: JsonQueryAction.executeRaw,
      sql: sql,
      parameters: parameters,
    );

    return results[JsonQueryAction.executeRaw.name];
  }

  Future<Map> _innerRunSQL({
    required String sql,
    required JsonQueryAction action,
    Iterable<Object>? parameters,
  }) async {
    final args = {
      'query': sql,
      'parameters': serializeRawParams(parameters ?? const []),
    };

    final query = serializeJsonQuery(
      datamodel: _client.$datamodel,
      action: action,
      args: args,
    );

    return _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
  }
}
