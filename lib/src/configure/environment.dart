// ignore_for_file: non_constant_identifier_names

import 'package:rc/rc.dart';

import '../../version.dart';
import 'query_engine_type.dart';

/// See https://www.prisma.io/docs/reference/api-reference/environment-variables-reference
class Environment {
  /// Create a new [Environment] from [RuntimeConfiguration].
  Environment(RuntimeConfiguration prismarc) : _prismarc = prismarc;

  /// Current [RuntimeConfiguration].
  RuntimeConfiguration _prismarc;

  /// Custom runtime configuration.
  void custom(RuntimeConfiguration runtimeConfiguration) =>
      _prismarc = runtimeConfiguration;

  /// Merge [Environment] with [other].
  void merge({
    String? DEBUG,
    String? NO_COLOR,
    String? BROWSER,
    QueryEngineType? PRISMA_CLI_QUERY_ENGINE_TYPE,
    QueryEngineType? PRISMA_CLIENT_ENGINE_TYPE,
    String? PRISMA_ENGINES_MIRROR,
    String? PRISMA_QUERY_ENGINE_BINARY,
    String? PRISMA_QUERY_ENGINE_LIBRARY,
    String? PRISMA_MIGRATION_ENGINE_BINARY,
    String? PRISMA_INTROSPECTION_ENGINE_BINARY,
    String? PRISMA_FMT_BINARY,
    bool? PRISMA_GENERATE_DATAPROXY,
  }) {
    final Map<String, String?> configuration = <String, String?>{
      'DEBUG': DEBUG,
      'NO_COLOR': NO_COLOR,
      'BROWSER': BROWSER,
      'PRISMA_CLI_QUERY_ENGINE_TYPE': PRISMA_CLI_QUERY_ENGINE_TYPE?.name,
      'PRISMA_CLIENT_ENGINE_TYPE': PRISMA_CLIENT_ENGINE_TYPE?.name,
      'PRISMA_ENGINES_MIRROR': PRISMA_ENGINES_MIRROR,
      'PRISMA_QUERY_ENGINE_BINARY': PRISMA_QUERY_ENGINE_BINARY,
      'PRISMA_QUERY_ENGINE_LIBRARY': PRISMA_QUERY_ENGINE_LIBRARY,
      'PRISMA_MIGRATION_ENGINE_BINARY': PRISMA_MIGRATION_ENGINE_BINARY,
      'PRISMA_INTROSPECTION_ENGINE_BINARY': PRISMA_INTROSPECTION_ENGINE_BINARY,
      'PRISMA_FMT_BINARY': PRISMA_FMT_BINARY,
      'PRISMA_GENERATE_DATAPROXY': PRISMA_GENERATE_DATAPROXY?.toString(),
    };

    for (final MapEntry<String, String?> entry in configuration.entries) {
      if (entry.value != null && entry.value?.isNotEmpty == true) {
        _prismarc.context.configuration[entry.key] = entry.value;
      }
    }
  }

  /// Get all environment variables
  Map<String, String> get _all =>
      _prismarc.all.map((key, value) => MapEntry(key, value.toString()));

  /// Debugging
  String? get DEBUG => _all['DEBUG'];

  /// NO_COLOR
  String? get NO_COLOR => _all['NO_COLOR'];

  /// BROWSER is for Prisma Studio to force which browser it should be open in, if not set it will open in the default browser. It's also used as a flag when starting the studio from the CLI.
  /// BROWSER=firefox prisma studio --port 5555
  String? get BROWSER => _all['BROWSER'];

  /// PRISMA_CLI_QUERY_ENGINE_TYPE is used to define the query engine type Prisma CLI downloads and uses. Defaults to library, but can be set to binary
  QueryEngineType get PRISMA_CLI_QUERY_ENGINE_TYPE =>
      QueryEngineType.values.firstWhere(
        (element) =>
            element.name ==
            _all['PRISMA_CLI_QUERY_ENGINE_TYPE']?.trim().toLowerCase(),
        orElse: () => QueryEngineType.library,
      );

  /// PRISMA_CLIENT_ENGINE_TYPE is used to define the query engine type Prisma Client downloads and uses. Defaults to library, but can be set to binary
  QueryEngineType get PRISMA_CLIENT_ENGINE_TYPE =>
      QueryEngineType.values.firstWhere(
        (element) =>
            element.name ==
            _all['PRISMA_CLIENT_ENGINE_TYPE']?.trim().toLowerCase(),
        orElse: () => QueryEngineType.library,
      );

  /// PRISMA_ENGINES_MIRROR can be used to specify a custom CDN (or server) endpoint to download the engines files for the CLI/Client. The default value is https://binaries.prisma.sh, where Prisma hosts the engine files
  String get PRISMA_ENGINES_MIRROR =>
      _all['PRISMA_ENGINES_MIRROR'] ?? 'https://binaries.prisma.sh';

  /// PRISMA_QUERY_ENGINE_BINARY is used to set a custom location for your own query engine binary.
  String? get PRISMA_QUERY_ENGINE_BINARY => _all['PRISMA_QUERY_ENGINE_BINARY'];

  /// PRISMA_QUERY_ENGINE_LIBRARY is used to set a custom location for your own query engine library.
  String? get PRISMA_QUERY_ENGINE_LIBRARY =>
      _all['PRISMA_QUERY_ENGINE_LIBRARY'];

  /// PRISMA_MIGRATION_ENGINE_BINARY is used to set a custom location for your own migration engine binary.
  String? get PRISMA_MIGRATION_ENGINE_BINARY =>
      _all['PRISMA_MIGRATION_ENGINE_BINARY'];

  /// PRISMA_INTROSPECTION_ENGINE_BINARY is used to set a custom location for your own introspection engine binary.
  String? get PRISMA_INTROSPECTION_ENGINE_BINARY =>
      _all['PRISMA_INTROSPECTION_ENGINE_BINARY'];

  /// PRISMA_FMT_BINARY is used to set a custom location for your own format engine binary.
  String? get PRISMA_FMT_BINARY => _all['PRISMA_FMT_BINARY'];

  /// If [PRISMA_GENERATE_DATAPROXY] is `true`, then `dart run orm generate` will generate a client that supports Prisma data proxy.
  bool get PRISMA_GENERATE_DATAPROXY {
    if (_prismarc('PRISMA_GENERATE_DATAPROXY') is bool) {
      return _prismarc<bool>('PRISMA_GENERATE_DATAPROXY')!;
    }

    return _all['PRISMA_GENERATE_DATAPROXY']?.toLowerCase() == 'true';
  }

  /// PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION is used to set a custom version for the Prisma data proxy remote client version.
  String get PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION =>
      _all['PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION'] ??
      dataProxyRemoteClientVersion;

  /// Returns map environment variables
  Map<String, String> get all {
    final Map<String, String> environment = <String, String>{
      ..._all,
      'PRISMA_CLI_QUERY_ENGINE_TYPE': PRISMA_CLI_QUERY_ENGINE_TYPE.name,
      'PRISMA_CLIENT_ENGINE_TYPE': PRISMA_CLIENT_ENGINE_TYPE.name,
      'PRISMA_ENGINES_MIRROR': PRISMA_ENGINES_MIRROR,
      'PRISMA_GENERATE_DATAPROXY': PRISMA_GENERATE_DATAPROXY.toString(),
      'PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION':
          PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION,
    };

    return environment;
  }
}
