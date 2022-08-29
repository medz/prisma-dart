// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvValue _$EnvValueFromJson(Map<String, dynamic> json) => EnvValue(
      json['value'] as String,
      fromEnvVar: json['fromEnvVar'] as String?,
    );

Map<String, dynamic> _$EnvValueToJson(EnvValue instance) => <String, dynamic>{
      'fromEnvVar': instance.fromEnvVar,
      'value': instance.value,
    };

DataSource _$DataSourceFromJson(Map<String, dynamic> json) => DataSource(
      name: json['name'] as String,
      activeProvider:
          $enumDecode(_$ConnectorTypeEnumMap, json['activeProvider']),
      provider: $enumDecode(_$ConnectorTypeEnumMap, json['provider']),
      url: EnvValue.fromJson(json['url'] as Map<String, dynamic>),
      config: Map<String, String>.from(json['config'] as Map),
    );

Map<String, dynamic> _$DataSourceToJson(DataSource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'activeProvider': _$ConnectorTypeEnumMap[instance.activeProvider]!,
      'provider': _$ConnectorTypeEnumMap[instance.provider]!,
      'url': instance.url,
      'config': instance.config,
    };

const _$ConnectorTypeEnumMap = {
  ConnectorType.mysql: 'mysql',
  ConnectorType.mongodb: 'mongodb',
  ConnectorType.sqlite: 'sqlite',
  ConnectorType.postgresql: 'postgresql',
  ConnectorType.sqlserver: 'sqlserver',
  ConnectorType.jdbcSqlserver: 'jdbc:sqlserver',
  ConnectorType.cockroachdb: 'cockroachdb',
};

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) =>
    GeneratorConfig(
      name: json['name'] as String,
      output: json['output'] == null
          ? null
          : EnvValue.fromJson(json['output'] as Map<String, dynamic>),
      isCustomOutput: json['isCustomOutput'] as bool?,
      provider: EnvValue.fromJson(json['provider'] as Map<String, dynamic>),
      config: Map<String, String>.from(json['config'] as Map),
      binaryTargets: (json['binaryTargets'] as List<dynamic>)
          .map((e) => EnvValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      previewFeatures: (json['previewFeatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GeneratorConfigToJson(GeneratorConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'output': instance.output,
      'isCustomOutput': instance.isCustomOutput,
      'provider': instance.provider,
      'config': instance.config,
      'binaryTargets': instance.binaryTargets,
      'previewFeatures': instance.previewFeatures,
    };
