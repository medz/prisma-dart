import 'dart:convert';

import 'json_rpc_response_error.dart';
import 'json_rpc_serializable.dart';

abstract class BaseJsonRpcRequest
    extends JsonRpcSerializable<Map<String, dynamic>> {
  BaseJsonRpcRequest({required this.id});

  /// Message id.
  final int id;

  /// json rpc version.
  String get jsonrpc => '2.0';

  /// to json object.
  @override
  Map<String, dynamic> toJson() => {
        'jsonrpc': jsonrpc,
        'id': id,
      };

  /// to string.
  @override
  String toString() => json.encode(toJson());
}

abstract class JsonRpcResponse<T> extends JsonRpcDeserializable {
  late String jsonrpc;
  late int id;
  T? result;
  JsonRpcResponseError? error;

  @override
  void fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];

    if (json.containsKey('error')) {
      error = JsonRpcResponseError();
      error?.fromJson(json['error']['data']);
    }

    if (json.containsKey('result')) {
      result = parseResult(json['result']);
    }
  }

  /// Parse result.
  T parseResult(dynamic json);
}
