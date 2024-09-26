// ignore_for_file: library_prefixes

import 'package:json/json.dart';
import '../../dmmf.dart' as DMMF;

/// Represents an environment variable or a direct value.
@JsonCodable()
class EnvValue {
  /// The direct value, if provided.
  final String? value;

  /// The name of the environment variable to fetch the value from.
  final String? fromEnvVar;
}

/// Represents binary targets with additional native flag.
@JsonCodable()
class BinaryTargetsEnvValue extends EnvValue {
  /// Overrides the value getter to ensure non-null value.
  @override
  String get value => super.value!;

  /// Indicates if the binary target is native.
  final bool? native;
}

@JsonCodable()
class EnvPaths {
  final String? rootEnvPath;
  final String? schemaEnvPath;
}

/// Represents the configuration for the application.
@JsonCodable()
class GeneratorConfig {
  /// The name of the configuration.
  final String name;

  /// The output environment, if specified.
  final EnvValue? output;

  /// Indicates if the output is custom.
  final bool? isCustomOutput;

  /// The provider environment.
  final EnvValue provider;

  /// Additional configuration key-value pairs.
  final Map<String, String> config;

  /// List of binary targets.
  final List<BinaryTargetsEnvValue> binaryTargets;

  /// List of preview features.
  final List<String> previewFeatures;
  final EnvPaths? envPaths;
  final String sourceFilePath;
}

/// Represents the manifest of the generator.
@JsonCodable()
class Manifest {
  /// Constructor for the Manifest class.
  const Manifest({
    this.prettyName,
    this.defaultOutput,
    this.version,
    this.requiresEngineVersion,
    this.requiresGenerators,
    this.requiresEngines,
    this.denylists,
  });

  /// The pretty name of the generator.
  final String? prettyName;

  /// The default output configuration.
  final String? defaultOutput;

  /// The version of the application.
  final String? version;

  /// The required engine version.
  final String? requiresEngineVersion;

  /// List of required generators.
  final List<String>? requiresGenerators;

  /// List of required engines.
  final List<String>? requiresEngines;

  /// The denylist configuration for the manifest.
  final ManifestDenylist? denylists;
}

/// Represents the denylist configuration in the manifest.
@JsonCodable()
class ManifestDenylist {
  /// Constructor for the ManifestDenylist class.
  const ManifestDenylist({
    this.models,
    this.fields,
  });

  /// List of denied models.
  final List<String>? models;

  /// List of denied fields.
  final List<String>? fields;
}

@JsonCodable()
class Datasource {
  final String name;
  final String provider;
  final String activeProvider;
  final EnvValue url;
  final EnvValue? directUrl;
  final List<String> schemas;
  final String sourceFilePath;
}

@JsonCodable()
class BinaryPaths {
  final Map<String, String>? schemaEngine;
  final Map<String, String>? queryEngine;
  final Map<String, String>? libqueryEngine;
}

@JsonCodable()
class SqlQueryParameterOutput {
  final String name;
  final String query;
  final String typ;
  final String? documentation;
  final bool nullable;
}

@JsonCodable()
class SqlQueryColumnOutput {
  final String name;
  final String typ;
  final bool nullable;
}

@JsonCodable()
class SqlQueryOutput {
  final String name;
  final String source;
  final String? documentation;
  final List<SqlQueryParameterOutput> parameters;
  final List<SqlQueryColumnOutput> resultColumns;
}

@JsonCodable()
class GeneratorOptions {
  final GeneratorConfig generator;
  final List<GeneratorConfig> otherGenerators;
  final String schemaPath;
  final String schema;
  final DMMF.Document dmmf;
  final List<Datasource> datasources;
  final String datamodel;
  final String version;
  final BinaryPaths? binaryPaths;
  final bool? postinstall;
  final bool? noEngine;
  final bool? noHints;
  final bool? allowNoModels;
  final EnvPaths? envPaths;
  final List<SqlQueryOutput>? typedSql;
}
