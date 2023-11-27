import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:stream_channel/stream_channel.dart';

import 'dmmf.dart';

part 'prisma_generator_helper.freezed.dart';
part 'prisma_generator_helper.g.dart';

/// Prisma generator
Future<void> generator(Handler handler) async {
  final input = stdin.transform(utf8.decoder).transform(const LineSplitter());
  final controller = StreamController<String>();

  // Listen the output stream, write to stderr
  controller.stream.listen((event) => stderr.writeln(event));

  final channel = StreamChannel<String>(input, controller.sink);
  final server = Server(channel);

  // Register the manifest method
  server.registerMethod('getManifest', (Parameters params) async {
    final config = GeneratorConfig.fromJson(params.asMap.cast());
    final manifest = await handler.onManifest(config);

    return {
      'manifest': manifest.toJson(),
    };
  });

  // Register the generate method
  server.registerMethod('generate', (Parameters params) async {
    File('dmmf.json').writeAsStringSync(json.encode(params.asMap));

    final options = GeneratorOptions.fromJson(params.asMap.cast());

    await handler.onGenerate(options);
  });

  // Listen for requests
  await server.listen();
}

/// Prisma generator handler.
///
/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/generatorHandler.ts#L4
abstract interface class Handler {
  /// Generator on manifest handler.
  Future<GeneratorManifest> onManifest(GeneratorConfig config);

  /// Generator on generate handler.
  Future<void> onGenerate(GeneratorOptions options);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L102
@freezed
class GeneratorManifest with _$GeneratorManifest {
  const factory GeneratorManifest({
    String? prettyName,
    @Default('.') String defaultOutput,
    DenyLists? denylists,
    List<String>? requiresGenerators,
    List<EngineType>? requiresEngines,
    String? version,
    String? requiresEngineVersion,
  }) = _GeneratorManifest;

  factory GeneratorManifest.fromJson(Map<String, dynamic> json) =>
      _$GeneratorManifestFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L105
@freezed
class DenyLists with _$DenyLists {
  const factory DenyLists({
    List<String>? models,
    List<String>? fields,
  }) = _DenyLists;

  factory DenyLists.fromJson(Map<String, dynamic> json) =>
      _$DenyListsFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L100
enum EngineType {
  queryEngine,
  migrationEngine,
  // libqueryEngine, // - This is Node.js only, not supported
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L84
@freezed
class GeneratorOptions with _$GeneratorOptions {
  const factory GeneratorOptions({
    required GeneratorConfig generator,
    List<GeneratorConfig>? otherGenerators,
    required String schemaPath,
    required Document dmmf,
    required List<DataSource> datasources,
    required String datamodel,
    required String version,
    BinaryPaths? binaryPaths,
    @Default(false) bool dataProxy,
    bool? postinstall,
  }) = _GeneratorOptions;

  factory GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$GeneratorOptionsFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L33
@freezed
class GeneratorConfig with _$GeneratorConfig {
  const factory GeneratorConfig({
    required String name,
    @_EnvValueConverter() EnvValue? output,
    bool? isCustomOutput,
    @_EnvValueConverter() required EnvValue provider,
    required Map<String, String> config,
    required List<BinaryTargetsEnvValue> binaryTargets,
    required List<String> previewFeatures,
  }) = _GeneratorConfig;

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L44
@freezed
sealed class EnvValue with _$EnvValue {
  const factory EnvValue.env(String name) = EnvValueViaName;
  const factory EnvValue.value(String value) = EnvValueViaValue;

  factory EnvValue.fromJson(Map<String, dynamic> json) =>
      _$EnvValueFromJson(json);
}

class _EnvValueConverter implements JsonConverter<EnvValue, Map> {
  const _EnvValueConverter();

  @override
  EnvValue fromJson(Map json) {
    if (json.containsKey('value') && json['value'] != null) {
      return EnvValue.value(json['value'] as String);
    } else if (json.containsKey('fromEnvVar') && json['fromEnvVar'] != null) {
      return EnvValue.env(json['fromEnvVar'] as String);
    }

    throw ArgumentError.value(json, 'json', 'Invalid env value');
  }

  @override
  Map toJson(EnvValue object) {
    return switch (object) {
      EnvValueViaName(name: final name) => {'fromEnvVar': name},
      EnvValueViaValue(value: final value) => {'value': value},
    };
  }
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L49
@freezed
class BinaryTargetsEnvValue with _$BinaryTargetsEnvValue {
  const factory BinaryTargetsEnvValue({
    String? fromEnvVar,
    required String value,
    bool? native,
  }) = _BinaryTargetsEnvValue;

  factory BinaryTargetsEnvValue.fromJson(Map<String, dynamic> json) =>
      _$BinaryTargetsEnvValueFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L68
@freezed
class DataSource with _$DataSource {
  const factory DataSource({
    required String name,
    required ConnectorType provider,
    required ConnectorType activeProvider,
    @_EnvValueConverter() required EnvValue url,
    @_EnvValueConverter() EnvValue? directUrl,
    required List<String> schemas,
  }) = _DataSource;

  factory DataSource.fromJson(Map<String, dynamic> json) =>
      _$DataSourceFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L55
enum ConnectorType {
  mysql,
  mongodb,
  sqlite,
  postgresql,
  postgres,
  sqlserver,
  cockroachdb,

  @JsonValue('jdbc:sqlserver')
  jdbcSqlserver,
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/types.ts#L77
@freezed
class BinaryPaths with _$BinaryPaths {
  const factory BinaryPaths({
    Map<String, String>? migrationEngine,
    Map<String, String>? queryEngine,
  }) = _BinaryPaths;

  factory BinaryPaths.fromJson(Map<String, dynamic> json) =>
      _$BinaryPathsFromJson(json);
}
