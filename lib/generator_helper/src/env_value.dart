import 'dart:io';

sealed class Env {
  factory Env.fromJson(Map json) {
    return switch (json) {
      {'value': final String value} => EnvValue(value),
      {'fromEnvVar': final String name} => EnvVar(name),
      _ => throw FormatException('Invalid env value: $json'),
    };
  }

  String get value;
}

final class EnvVar implements Env {
  final String name;

  const EnvVar(this.name);

  @override
  String get value {
    if (bool.hasEnvironment(name)) {
      return String.fromEnvironment(name);
    } else if (Platform.environment.containsKey(name)) {
      return Platform.environment[name]!;
    }

    throw StateError('Env var $name is not set');
  }
}

final class EnvValue implements Env {
  @override
  final String value;

  const EnvValue(this.value);
}
