import 'base_json_rpc_message.dart';
import 'json_rpc_serializable.dart';

class SchemaPushRequest extends JsonRpcSerializable<Map<String, dynamic>> {
  final String schema;
  final bool force;

  SchemaPushRequest({
    required this.schema,
    this.force = false,
  });

  @override
  Map<String, dynamic> toJson() => {
        'schema': schema,
        'force': force,
      };
}

class SchemaPushResponse extends JsonRpcResponse<SchemaPushResponse> {
  late int executedSteps;
  late List<dynamic> warnings;
  late List<dynamic> unexecutable;

  @override
  SchemaPushResponse parseResult(dynamic json) {
    executedSteps = json['executedSteps'];
    warnings = json['warnings'];
    unexecutable = json['unexecutable'];
    return this;
  }
}
