// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvValue _$EnvValueFromJson(Map<String, dynamic> json) => EnvValue(
      formEnvVar: json['formEnvVar'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$EnvValueToJson(EnvValue instance) => <String, dynamic>{
      'formEnvVar': instance.formEnvVar,
      'value': instance.value,
    };

BinaryTargetsEnvValue _$BinaryTargetsEnvValueFromJson(
        Map<String, dynamic> json) =>
    BinaryTargetsEnvValue(
      value: json['value'] as String,
      native: json['native'] as bool,
      formEnvVar: json['formEnvVar'] as String?,
    );

Map<String, dynamic> _$BinaryTargetsEnvValueToJson(
        BinaryTargetsEnvValue instance) =>
    <String, dynamic>{
      'formEnvVar': instance.formEnvVar,
      'native': instance.native,
      'value': instance.value,
    };

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) =>
    GeneratorConfig(
      name: json['name'] as String,
      provider: EnvValue.fromJson(json['provider'] as Map<String, dynamic>),
      config: json['config'] as Map<String, dynamic>,
      binaryTargets: (json['binaryTargets'] as List<dynamic>).map(
          (e) => BinaryTargetsEnvValue.fromJson(e as Map<String, dynamic>)),
      previewFeatures:
          (json['previewFeatures'] as List<dynamic>).map((e) => e as String),
      output: json['output'] == null
          ? null
          : EnvValue.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneratorConfigToJson(GeneratorConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'provider': instance.provider,
      'output': instance.output,
      'config': instance.config,
      'binaryTargets': instance.binaryTargets.toList(),
      'previewFeatures': instance.previewFeatures.toList(),
    };

DenyLists _$DenyListsFromJson(Map<String, dynamic> json) => DenyLists(
      models: (json['models'] as List<dynamic>?)?.map((e) => e as String),
      fields: (json['fields'] as List<dynamic>?)?.map((e) => e as String),
    );

Map<String, dynamic> _$DenyListsToJson(DenyLists instance) => <String, dynamic>{
      'models': instance.models?.toList(),
      'fields': instance.fields?.toList(),
    };

GeneratorManifest _$GeneratorManifestFromJson(Map<String, dynamic> json) =>
    GeneratorManifest(
      prettyName: json['prettyName'] as String?,
      defaultOutput: json['defaultOutput'] as String?,
      denylists: json['denylists'] == null
          ? null
          : DenyLists.fromJson(json['denylists'] as Map<String, dynamic>),
      requiresGenerators: (json['requiresGenerators'] as List<dynamic>?)
          ?.map((e) => e as String),
      version: json['version'] as String?,
      requiresEngineVersion: json['requiresEngineVersion'] as String?,
    );

Map<String, dynamic> _$GeneratorManifestToJson(GeneratorManifest instance) =>
    <String, dynamic>{
      'prettyName': instance.prettyName,
      'defaultOutput': instance.defaultOutput,
      'denylists': instance.denylists,
      'requiresGenerators': instance.requiresGenerators?.toList(),
      'version': instance.version,
      'requiresEngineVersion': instance.requiresEngineVersion,
    };

DataSource _$DataSourceFromJson(Map<String, dynamic> json) => DataSource(
      name: json['name'] as String,
      provider: $enumDecode(_$ConnectorTypeEnumMap, json['provider']),
      activeProvider:
          $enumDecode(_$ConnectorTypeEnumMap, json['activeProvider']),
      url: EnvValue.fromJson(json['url'] as Map<String, dynamic>),
      directUrl: json['directUrl'] == null
          ? null
          : EnvValue.fromJson(json['directUrl'] as Map<String, dynamic>),
      schemas: (json['schemas'] as List<dynamic>).map((e) => e as String),
    );

Map<String, dynamic> _$DataSourceToJson(DataSource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'provider': _$ConnectorTypeEnumMap[instance.provider]!,
      'activeProvider': _$ConnectorTypeEnumMap[instance.activeProvider]!,
      'url': instance.url,
      'directUrl': instance.directUrl,
      'schemas': instance.schemas.toList(),
    };

const _$ConnectorTypeEnumMap = {
  ConnectorType.mysql: 'mysql',
  ConnectorType.mongodb: 'mongodb',
  ConnectorType.sqlite: 'sqlite',
  ConnectorType.postgresql: 'postgresql',
  ConnectorType.sqlserver: 'sqlserver',
  ConnectorType.cockroachdb: 'cockroachdb',
};

GeneratorOptions _$GeneratorOptionsFromJson(Map<String, dynamic> json) =>
    GeneratorOptions(
      generator:
          GeneratorConfig.fromJson(json['generator'] as Map<String, dynamic>),
      schemaPath: json['schemaPath'] as String,
      datamodel: json['datamodel'] as String,
      datasources: (json['datasources'] as List<dynamic>)
          .map((e) => DataSource.fromJson(e as Map<String, dynamic>)),
      version: json['version'] as String,
      dmmf: json['dmmf'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GeneratorOptionsToJson(GeneratorOptions instance) =>
    <String, dynamic>{
      'generator': instance.generator,
      'schemaPath': instance.schemaPath,
      'datamodel': instance.datamodel,
      'datasources': instance.datasources.toList(),
      'version': instance.version,
      'dmmf': instance.dmmf,
    };
