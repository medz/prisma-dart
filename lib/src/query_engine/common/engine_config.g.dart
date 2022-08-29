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

DatasourceOverwrite _$DatasourceOverwriteFromJson(Map<String, dynamic> json) =>
    DatasourceOverwrite(
      name: json['name'] as String,
      url: json['url'] as String?,
      env: json['env'] as String?,
    );

Map<String, dynamic> _$DatasourceOverwriteToJson(
        DatasourceOverwrite instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'env': instance.env,
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
