import 'package:json_annotation/json_annotation.dart';

part 'types.g.dart';

/// https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L54
enum ConnectorType {
  mysql("mysql"),
  mongodb("mongodb"),
  sqlite("sqlite"),
  postgresql("postgresql"),
  sqlserver("sqlserver"),

  @JsonValue('jdbc:sqlserver')
  jdbcSqlserver("jdbc:sqlserver"),

  cockroachdb("cockroachdb"),
  ;

  const ConnectorType(this.value);

  /// Connector type value.
  final String value;
}

@JsonSerializable(createFactory: true, createToJson: true)
class EnvValue {
  final String? fromEnvVar;
  final String value;

  const EnvValue(this.value, {this.fromEnvVar});

  factory EnvValue.fromJson(Map<String, dynamic> json) =>
      _$EnvValueFromJson(json);

  Map<String, dynamic> toJson() => _$EnvValueToJson(this);
}

/// https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L63
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class DataSource {
  final String name;
  final ConnectorType activeProvider;
  final ConnectorType provider;
  final EnvValue url;
  final Map<String, String> config;

  const DataSource({
    required this.name,
    required this.activeProvider,
    required this.provider,
    required this.url,
    required this.config,
  });

  factory DataSource.fromJson(Map<String, dynamic> json) =>
      _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}

/// https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L33
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class GeneratorConfig {
  final String name;
  final EnvValue? output;
  final bool? isCustomOutput;
  final EnvValue provider;
  final Map<String, String> config;
  final List<EnvValue> binaryTargets;
  final List<String> previewFeatures;

  const GeneratorConfig({
    required this.name,
    required this.output,
    required this.isCustomOutput,
    required this.provider,
    required this.config,
    required this.binaryTargets,
    required this.previewFeatures,
  });

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorConfigToJson(this);
}
