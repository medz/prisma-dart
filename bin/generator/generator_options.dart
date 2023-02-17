import 'package:json_annotation/json_annotation.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart' show Document;

part 'generator_options.g.dart';

const json = JsonSerializable(createFactory: true, createToJson: false);

@json
class GeneratorOptions {
  final GeneratorConfig generator;
  final String schemaPath;
  final Document dmmf;
  final Iterable<Datasource> datasources;
  final String datamodel;
  final Map<String, Map<String, String>> binaryPaths;
  final bool dataProxy;

  const GeneratorOptions({
    required this.generator,
    required this.schemaPath,
    required this.dmmf,
    required this.datasources,
    required this.datamodel,
    required this.binaryPaths,
    required this.dataProxy,
  });

  factory GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$GeneratorOptionsFromJson(json);
}

@json
class GeneratorConfig {
  final String name;
  final EnvValue? output;
  final bool? isCustomOutput;
  final EnvValue provider;
  final Map<String, String> config;

  const GeneratorConfig({
    required this.name,
    this.output,
    this.isCustomOutput,
    required this.provider,
    required this.config,
  });

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);
}

@json
class EnvValue {
  final String? fromEnvVar;
  final String? value;

  const EnvValue({
    this.fromEnvVar,
    this.value,
  });

  factory EnvValue.fromJson(Map<String, dynamic> json) =>
      _$EnvValueFromJson(json);
}

@json
class Datasource {
  final String name;
  final String provider;
  final String activeProvider;
  final EnvValue url;

  const Datasource({
    required this.name,
    required this.provider,
    required this.activeProvider,
    required this.url,
  });

  factory Datasource.fromJson(Map<String, dynamic> json) =>
      _$DatasourceFromJson(json);
}
