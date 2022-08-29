// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorOptions _$GeneratorOptionsFromJson(Map<String, dynamic> json) =>
    GeneratorOptions(
      config: GeneratorConfig.fromJson(json['config'] as Map<String, dynamic>),
      dataProxy: json['dataProxy'] as bool,
      datasources: (json['datasources'] as List<dynamic>)
          .map((e) => DataSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      dmmf: Document.fromJson(json['dmmf'] as Map<String, dynamic>),
      executable: json['executable'] as String,
      schema: json['schema'] as String,
      schemaPath: json['schemaPath'] as String,
      version: json['version'] as String,
    );

Map<String, dynamic> _$GeneratorOptionsToJson(GeneratorOptions instance) =>
    <String, dynamic>{
      'dmmf': instance.dmmf.toJson(),
      'config': instance.config.toJson(),
      'schemaPath': instance.schemaPath,
      'datasources': instance.datasources.map((e) => e.toJson()).toList(),
      'schema': instance.schema,
      'version': instance.version,
      'executable': instance.executable,
      'dataProxy': instance.dataProxy,
    };
