import 'package:json_annotation/json_annotation.dart';

import '../../generator_helper/types.dart';

part 'engine_config.g.dart';

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class FetcherResult {
  final dynamic data;
  final dynamic error;

  const FetcherResult({
    this.data,
    this.error,
  });

  factory FetcherResult.fromJson(Map<String, dynamic> json) =>
      _$FetcherResultFromJson(json);

  Map<String, dynamic> toJson() => _$FetcherResultToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class DatasourceOverwrite {
  final String name;
  final String? url;
  final String? env;

  const DatasourceOverwrite({
    required this.name,
    this.url,
    this.env,
  });

  factory DatasourceOverwrite.fromJson(Map<String, dynamic> json) =>
      _$DatasourceOverwriteFromJson(json);

  Map<String, dynamic> toJson() => _$DatasourceOverwriteToJson(this);
}

enum LogLevel {
  info,
  warn,
}

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class NullableEnvValue {
  final String? fromEnvVar;
  final String? value;

  const NullableEnvValue({
    this.fromEnvVar,
    this.value,
  });

  factory NullableEnvValue.fromJson(Map<String, dynamic> json) =>
      _$NullableEnvValueFromJson(json);

  Map<String, dynamic> toJson() => _$NullableEnvValueToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class InlineDatasource {
  final NullableEnvValue url;

  const InlineDatasource(this.url);

  factory InlineDatasource.fromJson(Map<String, dynamic> json) =>
      _$InlineDatasourceFromJson(json);

  Map<String, dynamic> toJson() => _$InlineDatasourceToJson(this);
}

class TracingConfig {
  final bool enabled;
  final bool middleware;

  const TracingConfig({
    required this.enabled,
    required this.middleware,
  });
}

class EngineConfig {
  final String? cwd;
  final String? dirname;
  final String datamodelPath;
  final bool? enableDebugLogs;
  final bool?
      allowTriggerPanic; // dangerous! https://github.com/prisma/prisma-engines/issues/764
  final String? prismaPath;
  final Future<FetcherResult> Function(String query)? fetcher;
  final GeneratorConfig? generator;
  final List<DatasourceOverwrite>? datasources;
  final bool? showColors;
  final bool? logQueries;
  final LogLevel? logLevel;
  final Map<String, String>? env;
  final List<String>? flags;
  final String? clientVersion;
  final List<String>? previewFeatures;
  final String? engineEndpoint;
  final String? activeProvider;

  /// The contents of the schema encoded into a string
  /// @remarks only used for the purpose of data proxy
  final String? inlineSchema;

  /// The contents of the datasource url saved in a string
  /// @remarks only used for the purpose of data proxy
  final Map<String, InlineDatasource>? inlineDatasources;

  /// The string hash that was produced for a given schema
  /// @remarks only used for the purpose of data proxy
  final String? inlineSchemaHash;

  /// The configuration object for enabling tracing
  /// @remarks enabling is determined by the client
  final TracingConfig? tracingConfig;

  const EngineConfig({
    this.cwd,
    this.dirname,
    required this.datamodelPath,
    this.enableDebugLogs,
    this.allowTriggerPanic,
    this.prismaPath,
    this.fetcher,
    this.generator,
    this.datasources,
    this.showColors,
    this.logQueries,
    this.logLevel,
    this.env,
    this.flags,
    this.clientVersion,
    this.previewFeatures,
    this.engineEndpoint,
    this.activeProvider,
    this.inlineSchema,
    this.inlineDatasources,
    this.inlineSchemaHash,
    this.tracingConfig,
  });
}
