// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GQLResponse _$GQLResponseFromJson(Map<String, dynamic> json) => GQLResponse(
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      (json['errors'] as List<dynamic>?)
          ?.map((e) => GQLError.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['extensions'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GQLResponseToJson(GQLResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errors': instance.errors,
      'extensions': instance.extensions,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['result'],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'result': instance.result,
    };

GQLBatchResponse _$GQLBatchResponseFromJson(Map<String, dynamic> json) =>
    GQLBatchResponse(
      (json['errors'] as List<dynamic>)
          .map((e) => GQLError.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['batchResult'] as List<dynamic>)
          .map((e) => GQLResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GQLBatchResponseToJson(GQLBatchResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'batchResult': instance.batchResult,
    };

GQLRequest _$GQLRequestFromJson(Map<String, dynamic> json) => GQLRequest(
      json['query'] as String,
      json['variables'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GQLRequestToJson(GQLRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'variables': instance.variables,
    };

GQLBatchRequest _$GQLBatchRequestFromJson(Map<String, dynamic> json) =>
    GQLBatchRequest(
      (json['batch'] as List<dynamic>)
          .map((e) => GQLRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['transaction'] as bool,
    );

Map<String, dynamic> _$GQLBatchRequestToJson(GQLBatchRequest instance) =>
    <String, dynamic>{
      'batch': instance.batch,
      'transaction': instance.transaction,
    };

GQLError _$GQLErrorFromJson(Map<String, dynamic> json) => GQLError(
      json['error'] as String,
      (json['path'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['query'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GQLErrorToJson(GQLError instance) => <String, dynamic>{
      'error': instance.error,
      'path': instance.path,
      'query': instance.query,
    };
