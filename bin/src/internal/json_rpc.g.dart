// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcMessage _$JsonRpcMessageFromJson(Map<String, dynamic> json) =>
    JsonRpcMessage(
      id: json['id'] as int,
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
    );

Map<String, dynamic> _$JsonRpcMessageToJson(JsonRpcMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
    };

JsonRpcError _$JsonRpcErrorFromJson(Map<String, dynamic> json) => JsonRpcError(
      code: json['code'] as int,
      message: json['message'] as String,
      data: JsonRpcErrorData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonRpcErrorToJson(JsonRpcError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

JsonRpcErrorData _$JsonRpcErrorDataFromJson(Map<String, dynamic> json) =>
    JsonRpcErrorData(
      isPanic: json['is_panic'] as bool,
      message: json['message'] as String,
      errorCode: json['error_code'] as String?,
    );

Map<String, dynamic> _$JsonRpcErrorDataToJson(JsonRpcErrorData instance) =>
    <String, dynamic>{
      'is_panic': instance.isPanic,
      'message': instance.message,
      'error_code': instance.errorCode,
    };

Map<String, dynamic> _$JsonRpcPayloadToJson(JsonRpcPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
    };

JsonRpcResponse _$JsonRpcResponseFromJson(Map<String, dynamic> json) =>
    JsonRpcResponse(
      id: json['id'] as int,
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      error: json['error'] == null
          ? null
          : JsonRpcError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchemaPushRequestToJson(SchemaPushRequest instance) =>
    <String, dynamic>{
      'schema': instance.schema,
      'force': instance.force,
    };

SchemaPushResult _$SchemaPushResultFromJson(Map<String, dynamic> json) =>
    SchemaPushResult(
      executedSteps: json['executedSteps'] as int,
      unexecutable: json['unexecutable'] as List<dynamic>,
      warnings: json['warnings'] as List<dynamic>,
    );

SchemaPushResponse _$SchemaPushResponseFromJson(Map<String, dynamic> json) =>
    SchemaPushResponse(
      id: json['id'] as int,
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      error: json['error'] == null
          ? null
          : JsonRpcError.fromJson(json['error'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : SchemaPushResult.fromJson(json['result'] as Map<String, dynamic>),
    );

IntrospectResult _$IntrospectResultFromJson(Map<String, dynamic> json) =>
    IntrospectResult(
      datamodel: json['datamodel'] as String,
      version: json['version'] as String,
      warnings: json['warnings'] as List<dynamic>,
    );

Map<String, dynamic> _$IntrospectResultToJson(IntrospectResult instance) =>
    <String, dynamic>{
      'datamodel': instance.datamodel,
      'version': instance.version,
      'warnings': instance.warnings,
    };

IntrospectResponse _$IntrospectResponseFromJson(Map<String, dynamic> json) =>
    IntrospectResponse(
      id: json['id'] as int,
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      error: json['error'] == null
          ? null
          : JsonRpcError.fromJson(json['error'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : IntrospectResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntrospectResponseToJson(IntrospectResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'error': instance.error?.toJson(),
      'result': instance.result?.toJson(),
    };
