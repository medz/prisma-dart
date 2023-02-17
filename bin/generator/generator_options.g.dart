// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorOptions _$GeneratorOptionsFromJson(Map<String, dynamic> json) =>
    GeneratorOptions(
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

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) =>
    GeneratorConfig(
      name: json['name'] as String,
      output: json['output'] == null
          ? null
          : EnvValue.fromJson(json['output'] as Map<String, dynamic>),
      isCustomOutput: json['isCustomOutput'] as bool?,
      provider: EnvValue.fromJson(json['provider'] as Map<String, dynamic>),
      config: Map<String, String>.from(json['config'] as Map),
    );

EnvValue _$EnvValueFromJson(Map<String, dynamic> json) => EnvValue(
      fromEnvVar: json['fromEnvVar'] as String?,
      value: json['value'] as String?,
    );

Datasource _$DatasourceFromJson(Map<String, dynamic> json) => Datasource(
      name: json['name'] as String,
      provider: json['provider'] as String,
      activeProvider: json['activeProvider'] as String,
      url: EnvValue.fromJson(json['url'] as Map<String, dynamic>),
    );
