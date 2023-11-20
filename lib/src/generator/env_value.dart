sealed class Env {
  factory Env.fromJson(Map json) {
    return switch (json) {
      {'value': final String value} => EnvValue(value),
      {'fromEnvVar': final String name} => EnvVar(name),
      _ => throw FormatException('Invalid env value: $json'),
    };
  }
}

final class EnvVar implements Env {
  final String name;

  const EnvVar(this.name);
}

final class EnvValue implements Env {
  final String value;

  const EnvValue(this.value);
}
