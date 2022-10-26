import 'package:json_annotation/json_annotation.dart';

part 'json_rpc.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class JsonRpcMessage {
  final int id;
  final String jsonrpc;

  const JsonRpcMessage({
    required this.id,
    this.jsonrpc = '2.0',
  });

  factory JsonRpcMessage.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcMessageFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRpcMessageToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: true)
class JsonRpcError {
  final int code;
  final String message;
  final JsonRpcErrorData data;

  const JsonRpcError({
    required this.code,
    required this.message,
    required this.data,
  });

  factory JsonRpcError.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRpcErrorToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: true)
class JsonRpcErrorData {
  @JsonKey(name: 'is_panic')
  final bool isPanic;

  final String message;

  @JsonKey(name: 'error_code')
  final String? errorCode;

  const JsonRpcErrorData({
    required this.isPanic,
    required this.message,
    this.errorCode,
  });

  factory JsonRpcErrorData.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorDataFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRpcErrorDataToJson(this);
}

@JsonSerializable(createFactory: false, createToJson: true)
class JsonRpcPayload extends JsonRpcMessage {
  const JsonRpcPayload({
    required super.id,
    required this.method,
    super.jsonrpc,
    this.params,
  });

  /// Method
  final String method;

  /// params
  final dynamic params;

  @override
  Map<String, dynamic> toJson() => _$JsonRpcPayloadToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: false)
class JsonRpcResponse extends JsonRpcMessage {
  const JsonRpcResponse({
    required super.id,
    super.jsonrpc,
    this.error,
  });

  final JsonRpcError? error;

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcResponseFromJson(json);
}

@JsonSerializable(createFactory: false, createToJson: true)
class SchemaPushRequest {
  final String schema;
  final bool force;

  const SchemaPushRequest({
    required this.schema,
    this.force = false,
  });

  Map<String, dynamic> toJson() => _$SchemaPushRequestToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: false)
class SchemaPushResult {
  final int executedSteps;
  final List<dynamic> unexecutable;
  final List<dynamic> warnings;

  const SchemaPushResult({
    required this.executedSteps,
    required this.unexecutable,
    required this.warnings,
  });

  factory SchemaPushResult.fromJson(Map<String, dynamic> json) =>
      _$SchemaPushResultFromJson(json);
}

@JsonSerializable(createFactory: true, createToJson: false)
class SchemaPushResponse extends JsonRpcResponse {
  const SchemaPushResponse({
    required super.id,
    super.jsonrpc,
    super.error,
    this.result,
  });

  final SchemaPushResult? result;

  factory SchemaPushResponse.fromJson(Map<String, dynamic> json) =>
      _$SchemaPushResponseFromJson(json);
}

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class IntrospectResult {
  final String datamodel;
  final String version;
  final List<dynamic> warnings;

  const IntrospectResult({
    required this.datamodel,
    required this.version,
    required this.warnings,
  });

  factory IntrospectResult.fromJson(Map<String, dynamic> json) =>
      _$IntrospectResultFromJson(json);

  Map<String, dynamic> toJson() => _$IntrospectResultToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class IntrospectResponse extends JsonRpcResponse {
  IntrospectResponse({
    required super.id,
    super.jsonrpc,
    super.error,
    this.result,
  });

  final IntrospectResult? result;

  factory IntrospectResponse.fromJson(Map<String, dynamic> json) =>
      _$IntrospectResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IntrospectResponseToJson(this);
}
