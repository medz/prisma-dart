import 'package:json_annotation/json_annotation.dart';

part 'types.g.dart';

@JsonSerializable()
class EnvValue {
  final String? formEnvVar;
  final String? value;

  const EnvValue({this.formEnvVar, this.value});
  factory EnvValue.fromJson(Map<String, dynamic> json) =>
      _$EnvValueFromJson(json);

  Map<String, dynamic> toJson() => _$EnvValueToJson(this);
}

@JsonSerializable()
class BinaryTargetsEnvValue extends EnvValue {
  final bool native;

  const BinaryTargetsEnvValue({
    required final String value,
    required this.native,
    super.formEnvVar,
  }) : super(value: value);

  @override
  String get value => super.value!;

  factory BinaryTargetsEnvValue.fromJson(Map<String, dynamic> json) =>
      _$BinaryTargetsEnvValueFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BinaryTargetsEnvValueToJson(this);
}

@JsonSerializable()
class GeneratorConfig {
  final String name;
  final EnvValue provider;
  final EnvValue? output;
  final Map config;
  final Iterable<BinaryTargetsEnvValue> binaryTargets;
  final Iterable<String> previewFeatures;

  const GeneratorConfig({
    required this.name,
    required this.provider,
    required this.config,
    required this.binaryTargets,
    required this.previewFeatures,
    this.output,
  });

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorConfigToJson(this);
}

@JsonSerializable()
class DenyLists {
  final Iterable<String>? models;
  final Iterable<String>? fields;

  const DenyLists({this.models, this.fields});
  factory DenyLists.fromJson(Map<String, dynamic> json) =>
      _$DenyListsFromJson(json);

  Map<String, dynamic> toJson() => _$DenyListsToJson(this);
}

/// https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L102
@JsonSerializable()
class GeneratorManifest {
  final String? prettyName;
  final String? defaultOutput;
  final DenyLists? denylists;
  final Iterable<String>? requiresGenerators;
  final String? version;
  final String? requiresEngineVersion;

  const GeneratorManifest({
    this.prettyName,
    this.defaultOutput,
    this.denylists,
    this.requiresGenerators,
    this.version,
    this.requiresEngineVersion,
  });
  factory GeneratorManifest.fromJson(Map<String, dynamic> json) =>
      _$GeneratorManifestFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorManifestToJson(this);
}

enum ConnectorType {
  mysql,
  mongodb,
  sqlite,
  postgresql,
  sqlserver,
  cockroachdb
}

@JsonSerializable()
class DataSource {
  final String name;
  final ConnectorType provider;
  final ConnectorType activeProvider;
  final EnvValue url;
  final EnvValue? directUrl;
  final Iterable<String> schemas;

  const DataSource({
    required this.name,
    required this.provider,
    required this.activeProvider,
    required this.url,
    this.directUrl,
    required this.schemas,
  });
  factory DataSource.fromJson(Map<String, dynamic> json) =>
      _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}

@JsonSerializable()
class GeneratorOptions {
  final GeneratorConfig generator;
  final String schemaPath;
  final String datamodel;
  final Iterable<DataSource> datasources;
  final String version;
  final Map<String, dynamic> dmmf;

  const GeneratorOptions({
    required this.generator,
    required this.schemaPath,
    required this.datamodel,
    required this.datasources,
    required this.version,
    required this.dmmf,
  });

  factory GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$GeneratorOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorOptionsToJson(this);
}
