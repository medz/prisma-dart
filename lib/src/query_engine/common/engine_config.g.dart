// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engine_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetcherResult _$FetcherResultFromJson(Map<String, dynamic> json) =>
    FetcherResult(
      data: json['data'],
      error: json['error'],
    );

Map<String, dynamic> _$FetcherResultToJson(FetcherResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
    };

NullableEnvValue _$NullableEnvValueFromJson(Map<String, dynamic> json) =>
    NullableEnvValue(
      fromEnvVar: json['fromEnvVar'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$NullableEnvValueToJson(NullableEnvValue instance) =>
    <String, dynamic>{
      'fromEnvVar': instance.fromEnvVar,
      'value': instance.value,
    };

InlineDatasource _$InlineDatasourceFromJson(Map<String, dynamic> json) =>
    InlineDatasource(
      NullableEnvValue.fromJson(json['url'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InlineDatasourceToJson(InlineDatasource instance) =>
    <String, dynamic>{
      'url': instance.url.toJson(),
    };
