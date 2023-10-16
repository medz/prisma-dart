import 'package:json_annotation/json_annotation.dart';

part 'types.g.dart';

const _jsonSerializable = JsonSerializable(
  anyMap: true,
  createToJson: true,
  createFactory: true,
  checked: true,
  createFieldMap: false,
  explicitToJson: true,
  includeIfNull: false,
);

@_jsonSerializable
class EnvValue {
  final String? formEnvVar;
  final String? value;

  const EnvValue({this.formEnvVar, this.value});
  factory EnvValue.fromJson(Map json) => _$EnvValueFromJson(json);

  Map<String, dynamic> toJson() => _$EnvValueToJson(this);
}

@_jsonSerializable
class BinaryTargetsEnvValue extends EnvValue {
  final bool native;

  const BinaryTargetsEnvValue({
    required final String value,
    required this.native,
    super.formEnvVar,
  }) : super(value: value);

  @override
  String get value => super.value!;

  factory BinaryTargetsEnvValue.fromJson(Map json) =>
      _$BinaryTargetsEnvValueFromJson(json);

  Map<String, dynamic> toJson() => _$BinaryTargetsEnvValueToJson(this);
}

@_jsonSerializable
class GeneratorCustomConfig {
  static const _packagePrefix = 'package';
  static const _defaultPackageName = 'prisma_client';

  final String? outputType;

  const GeneratorCustomConfig({this.outputType});
  factory GeneratorCustomConfig.fromJson(Map json) =>
      _$GeneratorCustomConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorCustomConfigToJson(this);

  String? get outputPackageName {
    if (outputType == _packagePrefix) return _defaultPackageName;
    if (outputType?.startsWith('$_packagePrefix:') == true) {
      final name = outputType?.substring(_packagePrefix.length + 1);

      return name?.isEmpty == true ? _defaultPackageName : name;
    }

    return null;
  }
}

@_jsonSerializable
class GeneratorConfig {
  final String name;
  final EnvValue provider;
  final EnvValue? output;
  final GeneratorCustomConfig config;
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

  factory GeneratorConfig.fromJson(Map json) => _$GeneratorConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorConfigToJson(this);
}

@_jsonSerializable
class DenyLists {
  final Iterable<String>? models;
  final Iterable<String>? fields;

  const DenyLists({this.models, this.fields});
  factory DenyLists.fromJson(Map json) => _$DenyListsFromJson(json);

  Map<String, dynamic> toJson() => _$DenyListsToJson(this);
}

/// https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L102
@_jsonSerializable
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
  factory GeneratorManifest.fromJson(Map json) =>
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

@_jsonSerializable
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
  factory DataSource.fromJson(Map json) => _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}

@_jsonSerializable
class GeneratorOptions {
  final GeneratorConfig generator;
  final String schemaPath;
  final String datamodel;
  final Iterable<DataSource> datasources;
  final String version;
  // TODO: DMMF

  const GeneratorOptions({
    required this.generator,
    required this.schemaPath,
    required this.datamodel,
    required this.datasources,
    required this.version,
  });

  factory GeneratorOptions.fromJson(Map json) =>
      _$GeneratorOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorOptionsToJson(this);
}
