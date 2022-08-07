// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfigResponse _$GetConfigResponseFromJson(Map<String, dynamic> json) =>
    GetConfigResponse(
      (json['generators'] as List<dynamic>)
          .map((e) => GeneratorConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['datasources'] as List<dynamic>)
          .map((e) => Datasource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConfigResponseToJson(GetConfigResponse instance) =>
    <String, dynamic>{
      'generators': instance.generators.map((e) => e.toJson()).toList(),
      'datasources': instance.datasources.map((e) => e.toJson()).toList(),
    };

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) =>
    GeneratorConfig(
      name: json['name'] as String,
      provider: Value.fromJson(json['provider'] as Map<String, dynamic>),
      config: Config.fromJson(json['config'] as Map<String, dynamic>),
      output: json['output'] == null
          ? null
          : Value.fromJson(json['output'] as Map<String, dynamic>),
      binaryTargets: (json['binaryTargets'] as List<dynamic>)
          .map((e) => Value.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeneratorConfigToJson(GeneratorConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'provider': instance.provider.toJson(),
      'config': instance.config.toJson(),
      'output': instance.output?.toJson(),
      'binaryTargets': instance.binaryTargets.map((e) => e.toJson()).toList(),
    };

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      engineType: $enumDecodeNullable(_$EngineTypeEnumMap, json['engineType']),
      binaryTargets: (json['binaryTargets'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      output: json['output'] == null
          ? null
          : Value.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'engineType': _$EngineTypeEnumMap[instance.engineType],
      'binaryTargets': instance.binaryTargets,
      'output': instance.output,
    };

const _$EngineTypeEnumMap = {
  EngineType.dataproxy: 'dataproxy',
  EngineType.binary: 'binary',
  EngineType.library: 'library',
};

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      json['fromEnvVar'] as String?,
      json['value'] as String,
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'fromEnvVar': instance.fromEnvVar,
      'value': instance.value,
    };

Datasource _$DatasourceFromJson(Map<String, dynamic> json) => Datasource(
      json['name'] as String,
      $enumDecodeNullable(_$DataSourceProviderEnumMap, json['connectorType']),
      Value.fromJson(json['url'] as Map<String, dynamic>),
      json['config'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DatasourceToJson(Datasource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'connectorType': _$DataSourceProviderEnumMap[instance.connectorType],
      'url': instance.url,
      'config': instance.config,
    };

const _$DataSourceProviderEnumMap = {
  DataSourceProvider.postgresql: 'postgresql',
  DataSourceProvider.mysql: 'mysql',
  DataSourceProvider.sqlite: 'sqlite',
  DataSourceProvider.sqlserver: 'sqlserver',
  DataSourceProvider.mongodb: 'mongodb',
  DataSourceProvider.cockroachdb: 'cockroachdb',
};
