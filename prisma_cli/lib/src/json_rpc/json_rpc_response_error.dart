import 'json_rpc_serializable.dart';

class JsonRpcResponseError extends JsonRpcDeserializable {
  late bool isPanic;
  late String message;
  String? errorCode;
  dynamic meta;

  @override
  void fromJson(Map<String, dynamic> json) {
    isPanic = json['is_panic'] as bool;
    message = json['message'] as String;
    errorCode = json['error_code'] as String?;
    meta = json['meta'];
  }
}
