import 'dart:convert';

import 'environment.dart';
import '_internal/internal.dart' as internal show printToConsole;
import 'query_engine_type.dart';

/// Prisma environment namespace.
enum PrismaEnvironmentNamespace {
  /// Prisma environment namespace.
  prisma,

  /// Other environment namespace.
  other,

  /// Override environment namespace.
  override,
}

/// Development environment printer
class DevelopmentEnvironmentPrinter {
  const DevelopmentEnvironmentPrinter();

  /// Print environment to console.
  void _print({
    required PrismaEnvironmentNamespace namespace,
    required String key,
    Object? value,
  }) {
    if (namespace == PrismaEnvironmentNamespace.override) {
      internal.printToConsole(json.encode({
        'namespace': namespace.name,
        'key': key,
        'value': value,
      }));
    } else if (value != null) {
      internal.printToConsole(json.encode({
        'namespace': namespace.name,
        'key': key,
        'value': value is QueryEngineType ? value.name : value.toString(),
      }));
    }
  }

  /// Update Prisma environment variables.
  void prisma<T>(PrismaEnvironment<T> key, T value) => _print(
      namespace: PrismaEnvironmentNamespace.prisma,
      key: key.name,
      value: value);

  /// Update all Prisma environment variables.
  void allPrisma(Map<PrismaEnvironment, dynamic> values) =>
      values.forEach((key, value) => prisma(key, value));

  /// Update other environment variables.
  void other(String key, String value) => _print(
      namespace: PrismaEnvironmentNamespace.other, key: key, value: value);

  /// Update all other environment variables.
  void allOther(Map<String, String> values) =>
      values.forEach((key, value) => other(key, value));

  /// Override environment variables.
  void override(Object key, Object? value) {
    if (key is PrismaEnvironment) {
      return _print(
        namespace: PrismaEnvironmentNamespace.override,
        key: key.name,
        value: value,
      );
    }

    _print(
      namespace: PrismaEnvironmentNamespace.override,
      key: key.toString(),
      value: value?.toString(),
    );
  }
}
