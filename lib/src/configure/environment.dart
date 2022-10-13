import 'dart:collection';

import 'package:rc/rc.dart';

import '../../version.dart';
import 'query_engine_type.dart';

/// See https://www.prisma.io/docs/reference/api-reference/environment-variables-reference
class PrismaEnvironment extends MapBase<String, String> implements Environment {
  /// Create a new prisma environment.
  PrismaEnvironment({
    bool includePlatformEnvironment = true,
  }) {
    _environment =
        Environment(includePlatformEnvironment: includePlatformEnvironment);
  }

  /// Environment variable store.
  late final Environment _environment;

  @override
  String? operator [](Object? key) => _environment[key];

  @override
  void operator []=(String key, String value) => _environment[key] = value;

  @override
  void clear() => _environment.clear();

  @override
  Iterable<String> get keys => _environment.keys;

  @override
  String? remove(Object? key) => _environment.remove(key);

  bool get debug => this['DEBUG'] == 'true';
  String? get noColor => this['NO_COLOR'];

  QueryEngineType get clientEngineType =>
      QueryEngineType.lookup(this['PRISMA_CLIENT_ENGINE_TYPE'].toString());

  String get enginesMirror =>
      this['PRISMA_ENGINES_MIRROR'] ?? r'https://binaries.prisma.sh';

  String? get queryEngineBinary => this['PRISMA_QUERY_ENGINE_BINARY'];
  String? get queryEngineLibrary => this['PRISMA_QUERY_ENGINE_LIBRARY'];
  String? get migrationEngineBinary => this['PRISMA_MIGRATION_ENGINE_BINARY'];
  String? get introspectionEngineBinary =>
      this['PRISMA_INTROSPECTION_ENGINE_BINARY'];
  String? get fmtBinary => this['PRISMA_FMT_BINARY'];

  String get clientDataProxyClientVersion =>
      this['PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION'] ??
      dataProxyRemoteClientVersion;
  bool get generateDataProxy => this['PRISMA_GENERATE_DATAPROXY'] == 'true';
}
