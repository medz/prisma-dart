import 'package:json_annotation/json_annotation.dart';
import 'package:prisma_cli/src/data_source/data_source_provider.dart';

part 'get_config_response.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: true, createToJson: true)
class GetConfigResponse {
  final List<GeneratorConfig> generators;
  final List<Datasource> datasources;

  const GetConfigResponse(this.generators, this.datasources);

  factory GetConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$GetConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetConfigResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GeneratorConfig {
  final String name;
  final Value provider;
  final Config config;
  final Value? output;
  final List<Value> binaryTargets;

  const GeneratorConfig({
    required this.name,
    required this.provider,
    required this.config,
    required this.output,
    required this.binaryTargets,
  });

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorConfigToJson(this);
}

@JsonSerializable()
class Config {
  final EngineType? engineType;
  final List<String>? binaryTargets;
  final Value? output;
  Config(
      {required this.engineType,
      required this.binaryTargets,
      required this.output});
  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

@JsonSerializable()
class Value {
  final String? fromEnvVar;
  final String value;
  Value(this.fromEnvVar, this.value);

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);
  Map<String, dynamic> toJson() => _$ValueToJson(this);
}

@JsonSerializable()
class Datasource {
  final String name;
  final DataSourceProvider? connectorType;
  final Value url;
  final Map? config;

  Datasource(this.name, this.connectorType, this.url, this.config);

  factory Datasource.fromJson(Map<String, dynamic> json) =>
      _$DatasourceFromJson(json);
  Map<String, dynamic> toJson() => _$DatasourceToJson(this);
}

enum EngineType { dataproxy, binary, library }
