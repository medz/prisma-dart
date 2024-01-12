import 'dart:convert';

import '../../dmmf/datamodel.dart' show DataModel;
import '../engine.dart';
import '../json_protocol/protocol.dart';
import '../json_protocol/serialize.dart';
import '../transaction/transaction_client.dart';
import '_internal/raw_parameter_codec.dart';

class RawClient<T> {
  final Engine _engine;
  final DataModel _datamodel;
  final TransactionClient<T> _client;

  const RawClient(
      Engine engine, DataModel datamodel, TransactionClient<T> transaction)
      : _engine = engine,
        _datamodel = datamodel,
        _client = transaction;

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

    final query =
        serializeJsonQuery(datamodel: _datamodel, action: action, args: args);

    final result = await _engine.request(
      query,
      headers: _client.headers,
      transaction: _client.transaction,
    );

    return rawParameter.decode(result[action.name]);
  }
}
