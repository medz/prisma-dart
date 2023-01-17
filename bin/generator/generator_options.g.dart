// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeneratorOptions _$$_GeneratorOptionsFromJson(Map<String, dynamic> json) =>
    _$_GeneratorOptions(
      generator:
          GeneratorConfig.fromJson(json['generator'] as Map<String, dynamic>),
      schemaPath: json['schemaPath'] as String,
      dmmf: Document.fromJson(json['dmmf'] as Map<String, dynamic>),
      datasources: (json['datasources'] as List<dynamic>)
          .map((e) => Datasource.fromJson(e as Map<String, dynamic>)),
      datamodel: json['datamodel'] as String,
      binaryPaths: (json['binaryPaths'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
      ),
      dataProxy: json['dataProxy'] as bool,
    );

Map<String, dynamic> _$$_GeneratorOptionsToJson(_$_GeneratorOptions instance) =>
    <String, dynamic>{
      'generator': instance.generator.toJson(),
      'schemaPath': instance.schemaPath,
      'dmmf': instance.dmmf.toJson(),
      'datasources': instance.datasources.map((e) => e.toJson()).toList(),
      'datamodel': instance.datamodel,
      'binaryPaths': instance.binaryPaths,
      'dataProxy': instance.dataProxy,
    };

_$_GeneratorConfig _$$_GeneratorConfigFromJson(Map<String, dynamic> json) =>
    _$_GeneratorConfig(
      name: json['name'] as String,
      output: json['output'] == null
          ? null
          : EnvValue.fromJson(json['output'] as Map<String, dynamic>),
      isCustomOutput: json['isCustomOutput'] as bool?,
      provider: EnvValue.fromJson(json['provider'] as Map<String, dynamic>),
      config: Map<String, String>.from(json['config'] as Map),
    );

Map<String, dynamic> _$$_GeneratorConfigToJson(_$_GeneratorConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'output': instance.output?.toJson(),
      'isCustomOutput': instance.isCustomOutput,
      'provider': instance.provider.toJson(),
      'config': instance.config,
    };

_$_EnvValue _$$_EnvValueFromJson(Map<String, dynamic> json) => _$_EnvValue(
      fromEnvVar: json['fromEnvVar'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$_EnvValueToJson(_$_EnvValue instance) =>
    <String, dynamic>{
      'fromEnvVar': instance.fromEnvVar,
      'value': instance.value,
    };

_$_Datasource _$$_DatasourceFromJson(Map<String, dynamic> json) =>
    _$_Datasource(
      name: json['name'] as String,
      provider: json['provider'] as String,
      activeProvider: json['activeProvider'] as String,
      url: EnvValue.fromJson(json['url'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DatasourceToJson(_$_Datasource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'provider': instance.provider,
      'activeProvider': instance.activeProvider,
      'url': instance.url.toJson(),
    };
