import 'dart:convert';

import '../../base_prisma_client.dart';
import '../json_protocol/protocol.dart';
import '../json_protocol/serialize.dart';
import '_internal/raw_parameter_codec.dart';

class RawClient<Client extends BasePrismaClient<Client>> {
  final Client _client;

  const RawClient(Client client) : _client = client;

  Future<dynamic> query(String sql, [Iterable<dynamic>? parameters]) => _inner(
        action: JsonQueryAction.queryRaw,
        sql: sql,
        parameters: parameters?.toList(growable: false),
      );

  Future<dynamic> execute(String sql, [Iterable<dynamic>? parameters]) =>
      _inner(
        action: JsonQueryAction.executeRaw,
        sql: sql,
        parameters: parameters?.toList(growable: false),
      );

  Future<dynamic> _inner({
    required String sql,
    required JsonQueryAction action,
    List<dynamic>? parameters,
  }) async {
    final args = {
      'query': sql,
      'parameters': json.encode(rawParameter.encode(parameters ?? const [])),
    };

    final query = serializeJsonQuery(
      datamodel: _client.$datamodel,
      action: action,
      args: args,
    );

    final result = await _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );

    return rawParameter.decode(result[action.name]);
  }
}
