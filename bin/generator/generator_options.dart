// ignore_for_file: invalid_annotation_target

import 'package:orm/orm.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart' show Document;

part 'generator_options.g.dart';
part 'generator_options.freezed.dart';

@freezed
class GeneratorOptions with _$GeneratorOptions {
  @jsonSerializable
  const factory GeneratorOptions({
    required GeneratorConfig generator,
    required String schemaPath,
    required Document dmmf,
    required Iterable<Datasource> datasources,
    required String datamodel,
    required Map<String, Map<String, String>> binaryPaths,
    required bool dataProxy,
  }) = _GeneratorOptions;

  factory GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$GeneratorOptionsFromJson(json);
}

@freezed
class GeneratorConfig with _$GeneratorConfig {
  @jsonSerializable
  const factory GeneratorConfig({
    required String name,
    EnvValue? output,
    bool? isCustomOutput,
    required EnvValue provider,
    required Map<String, String> config,
  }) = _GeneratorConfig;

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);
}

@freezed
class EnvValue with _$EnvValue {
  @jsonSerializable
  const factory EnvValue({
    String? fromEnvVar,
    String? value,
  }) = _EnvValue;

  factory EnvValue.fromJson(Map<String, dynamic> json) =>
      _$EnvValueFromJson(json);
}

@freezed
class Datasource with _$Datasource {
  @jsonSerializable
  const factory Datasource({
    required String name,
    required String provider,
    required String activeProvider,
    required EnvValue url,
  }) = _Datasource;

  factory Datasource.fromJson(Map<String, dynamic> json) =>
      _$DatasourceFromJson(json);
}
