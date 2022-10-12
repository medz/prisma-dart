// ignore_for_file: constant_identifier_names

import '../../version.dart';
import 'query_engine_type.dart';
import '_internal/internal.dart' as internal;

/// See https://www.prisma.io/docs/reference/api-reference/environment-variables-reference
enum PrismaEnvironment<T> {
  DEBUG<String?>(_nullableStringParser),
  NO_COLOR<bool>(_boolParser),
  PRISMA_GENERATE_DATAPROXY<bool>(_boolParser),
  PRISMA_CLI_QUERY_ENGINE_TYPE<QueryEngineType>(_queryEngineTypeParser),
  PRISMA_CLIENT_ENGINE_TYPE<QueryEngineType>(_queryEngineTypeParser),
  PRISMA_ENGINES_MIRROR<Uri>(_enginesMirrorParser),
  PRISMA_QUERY_ENGINE_BINARY<String?>(_nullableStringParser),
  PRISMA_QUERY_ENGINE_LIBRARY<String?>(_nullableStringParser),
  PRISMA_MIGRATION_ENGINE_BINARY<String?>(_nullableStringParser),
  PRISMA_INTROSPECTION_ENGINE_BINARY<String?>(_nullableStringParser),
  PRISMA_FMT_BINARY<String?>(_nullableStringParser),
  PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION<String>(
      _dataProxyClientVersionParser),

  /// Internal environment variables
  _internal<String?>(_nullableStringParser);

  final T Function(dynamic value) parser;
  const PrismaEnvironment(this.parser);

  /// Lookup the Prisma environment
  static PrismaEnvironment lookup(String name) {
    return PrismaEnvironment.values.firstWhere(
      (e) => e.name.toLowerCase().trim() == name.toLowerCase().trim(),
      orElse: () => PrismaEnvironment._internal,
    );
  }

  static String _dataProxyClientVersionParser(dynamic value) {
    if (value != null) return value.toString();

    return dataProxyRemoteClientVersion;
  }

  static Uri _enginesMirrorParser(dynamic value) {
    if (value is Uri) return value;

    final Uri uri = Uri.parse(r'https://binaries.prisma.sh');
    if (value is! String) return uri;

    return Uri.tryParse(value) ?? uri;
  }

  static QueryEngineType _queryEngineTypeParser(dynamic value) {
    if (value is QueryEngineType) return value;

    return QueryEngineType.values.firstWhere(
      (e) =>
          e.name.toLowerCase().trim() == value.toString().toLowerCase().trim(),
      orElse: () => QueryEngineType.binary,
    );
  }

  static String? _nullableStringParser<T>(dynamic value) => value?.toString();

  static bool _boolParser<T>(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value.toString().toLowerCase().trim() == 'true') {
      return true;
    } else if (value is int && value != 0) {
      return true;
    } else if (value.toString().trim().isEmpty) {
      return true;
    }

    return false;
  }
}

/// Prisma environment operator
class PrismaEnvironmentOperator {
  /// Create a new instance of [PrismaEnvironmentOperator]
  PrismaEnvironmentOperator({
    Map<PrismaEnvironment, dynamic>? prisma,
    Map<String, String>? other,
  }) {
    _prisma = prisma != null ? Map.from(prisma) : {};
    _other = other != null ? Map.from(other) : {};

    // **Note**: Why copy the map?
    //
    // The reason is that we want to be able to modify the map
    // without affecting the original map.
  }

  late final Map<PrismaEnvironment, dynamic> _prisma;
  late final Map<String, String> _other;
  Map<Object, Object> _override = {};

  /// Read override or then.
  Object? _overrideOrThen(Object key, Object? Function() then) {
    if (_override.containsKey(key)) {
      return _override[key];
    }

    return then();
  }

  /// Override the environment
  void override(Object key, Object value) {
    _override[key] = value;
  }

  /// Override all environment
  void overrideAll(Map<Object, Object> map) {
    _override = {..._override, ...map};
  }

  /// Read a Prisma environment variable.
  T prisma<T>(PrismaEnvironment<T> key) {
    final value = _overrideOrThen(
      key,
      () => _overrideOrThen(
        key.name,
        () => _prisma[key] ?? _other[key.name],
      ),
    );

    return key.parser(value);
  }

  /// Update a Prisma environment variable.
  void updatePrisma<T>(PrismaEnvironment<T> key, T value) =>
      _prisma[key] = key.parser(value);

  /// Update all Prisma environment variables.
  void updateAllPrisma(Map<PrismaEnvironment, dynamic> values) =>
      values.forEach((key, value) => updatePrisma(key, value));

  /// Read a other environment variable.
  String? other(String key) {
    final Object? value = _overrideOrThen(
      key,
      () => _other[key] ?? internal.environment[key],
    );
    final parsed = PrismaEnvironment.lookup(key).parser(value);

    return parsed ? parsed.toString() : null;
  }

  /// Update a other environment variable.
  void updateOther(String key, String value) {
    final PrismaEnvironment environment = PrismaEnvironment.lookup(key);

    if (environment != PrismaEnvironment._internal) {
      return updatePrisma(environment, environment.parser(value));
    }

    _other[key] = value;
  }

  /// Update all other environment variables.
  void updateAllOther(Map<String, String> values) {
    for (final entry in values.entries) {
      updateOther(entry.key, entry.value);
    }
  }

  /// Return the environment as a map
  Map<String, String> toEnvironment({
    bool includeSystemEnvironment = false,
  }) {
    return {
      if (includeSystemEnvironment) ...internal.environment,
      ..._other,
      ..._prisma.map((key, value) => MapEntry(
          key.name, value is QueryEngineType ? value.name : value.toString())),
      ..._override
          .map((key, value) => MapEntry(key.toString(), value.toString())),
    };
  }
}
