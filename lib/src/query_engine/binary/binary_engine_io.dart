import 'dart:convert';
import 'dart:io';

import '../../../configure.dart';
import '../../dmmf/dmmf.dart' as dmmf;
import '../common/engine.dart';
import '../common/engine_config.dart';
import '../common/get_config_result.dart';
import '../common/types/query_engine.dart';
import '../common/types/transaction.dart';

/// Omit enviroment variables.
Map<String, String> _omitEnviroment(
    Map<String, String> enviroment, List<String> keys) {
  final List<String> resolvedKeys = keys.map((e) => e.toUpperCase()).toList();

  return enviroment
    ..removeWhere((key, value) => resolvedKeys.contains(key.toUpperCase()));
}

class BinaryEngine extends Engine {
  BinaryEngine(super.config);

  GetConfigResult? _getedConfigResult;
  dmmf.Document? _dmmf;

  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers, required TransactionInfo info}) {
    throw UnimplementedError();
  }

  @override
  Future<GetConfigResult> getConfig() async {
    if (_getedConfigResult != null) {
      return _getedConfigResult!;
    }

    final ProcessResult result = await Process.run(
      _executable,
      ['cli', 'get-config'],
      includeParentEnvironment: false,
      environment: _omitEnviroment(_env, ['port']),
      workingDirectory: config.cwd,
    );

    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }

    return _getedConfigResult =
        GetConfigResult.fromJson(json.decode(result.stdout));
  }

  @override
  Future<dmmf.Document> getDmmf() async {
    if (_dmmf != null) return _dmmf!;

    final ProcessResult result = await Process.run(
      _executable,
      ['--enable-raw-queries', 'cli', 'dmmf'],
      includeParentEnvironment: false,
      environment: _omitEnviroment(_env, ['port']),
      workingDirectory: config.cwd,
    );

    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }

    return _dmmf = dmmf.Document.fromJson(json.decode(result.stdout));
  }

  @override
  Future<QueryEngineResult> request(
      {required String query,
      QueryEngineRequestHeaders? headers,
      int? numTry}) {
    throw UnimplementedError();
  }

  @override
  Future<QueryEngineResult> requestBatch(
      {required List<String> queries,
      QueryEngineRequestHeaders? headers,
      bool? transaction,
      int? numTry}) {
    throw UnimplementedError();
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionHeaders headers, required TransactionInfo info}) {
    throw UnimplementedError();
  }

  @override
  Future<void> start() {
    throw UnimplementedError();
  }

  @override
  Future<TransactionInfo> startTransaction(
      {required TransactionHeaders headers, TransactionOptions? options}) {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }

  @override
  Future<String> version({bool forceRun = false}) {
    throw UnimplementedError();
  }

  /// Get prisma query engine executable.
  String get _executable {
    // If set prisma path, return it.
    if (config.prismaPath != null) {
      final executable = File(config.prismaPath!);
      if (executable.existsSync()) {
        return executable.path;
      }
    }

    // Find query engine in project.
    if (configure.environment.containsKey('PRISMA_QUERY_ENGINE_BINARY')) {
      final String binary = configure.env('PRISMA_QUERY_ENGINE_BINARY')!;
      final File executable = File(binary);
      if (executable.existsSync()) {
        return executable.path;
      }
    }

    throw Exception('Prisma binray query engine not found.');
  }

  /// Get Resolved environment variables.
  Map<String, String> get _env {
    final Map<String, String> env = <String, String>{
      'PRISMA_DML_PATH': config.datamodelPath
    };

    if (config.logQueries == true) {
      env['LOG_QUERIES'] = 'true';
    }

    if (config.datasources?.isNotEmpty == true) {
      env['OVERWRITE_DATASOURCES'] = _datasourcesToJson();
    }

    if (Platform.environment.containsKey('NO_COLOR') &&
        config.env?.containsKey('NO_COLOR') == false &&
        config.showColors == true) {
      env['CLICOLOR_FORCE'] = '1';
    }

    return <String, String>{
      ...Platform.environment,
      ...config.env ?? const <String, String>{},
      ...env,
      // use value from process.env or use default
      'RUST_BACKTRACE': Platform.environment['RUST_BACKTRACE'] ??
          config.env?['RUST_BACKTRACE'] ??
          '1',
      'RUST_LOG':
          Platform.environment['RUST_LOG'] ?? config.env?['RUST_LOG'] ?? 'info',
    };
  }

  /// Data sources to json.
  String _datasourcesToJson() {
    final List<dynamic> datasources = <dynamic>[];
    for (final DatasourceOverwrite datasource
        in config.datasources ?? const []) {
      datasources.add(datasource.toJson());
    }

    return json.encode(datasources);
  }
}
