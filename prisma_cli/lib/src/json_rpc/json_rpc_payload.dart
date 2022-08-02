import 'base_json_rpc_message.dart';
import 'json_rpc_serializable.dart';

class JsonRpcPayload extends BaseJsonRpcRequest {
  JsonRpcPayload({
    required super.id,
    required this.method,
    this.params,
  });

  /// Method
  final String method;

  /// params
  final JsonRpcSerializable? params;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'method': method,
      'params': params?.toJson(),
    };
  }
}
