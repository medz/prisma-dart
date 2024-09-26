import 'package:json/json.dart';

/// Represents an environment variable or a direct value.
@JsonCodable()
class Env {
  /// The direct value, if provided.
  final String? value;

  /// The name of the environment variable to fetch the value from.
  final String? fromEnvVar;

  /// Indicates whether this Env instance represents an environment variable.
  bool get isEnvironment => fromEnvVar != null;

  /// Resolves and returns the actual value, either direct or environment variable.
  String get resolved {
    return switch (this) {
      Env(value: final String value) => value,
      Env(fromEnvVar: final String name) => name,
      _ => throw StateError('Invalid env value: $this'),
    };
  }
}

/// Represents binary targets with additional native flag.
@JsonCodable()
class BinaryTargetsEnv extends Env {
  /// Overrides the value getter to ensure non-null value.
  @override
  String get value => super.value!;

  /// Indicates if the binary target is native.
  final bool native;
}

/// Represents the configuration for the application.
@JsonCodable()
class Config {
  /// The name of the configuration.
  final String name;

  /// The output environment, if specified.
  final Env? output;

  /// Indicates if the output is custom.
  final bool isCustomOutput;

  /// The provider environment.
  final Env provider;

  /// Additional configuration key-value pairs.
  final Map<String, String> config;

  /// List of binary targets.
  final List<BinaryTargetsEnv> binaryTargets;

  /// List of preview features.
  final List<String> previewFeatures;
}
