import 'package:prisma_engine_core/prisma_engine_core.dart' as core;

class DatasourceOverwrite {
  /// Name of the datasource.
  final String name;

  /// Url of the datasource.
  final Uri? url;

  /// Environment name.
  final String? env;

  /// Creates a new datasource overwrite.
  const DatasourceOverwrite({required this.name, this.url, this.env})
      : assert(url != null || env != null, 'Either url or env must be set');
}

/// Prisma binary query engine.
class Engine implements core.Engine {
  /// Query engine binary path.
  final String binaryPath;

  /// Prisma schema string.
  final String schema;

  /// Prisma overwrite datasources.
  final Iterable<DatasourceOverwrite>? datasources;

  /// Creates a new query engine.
  const Engine({
    required this.binaryPath,
    required this.schema,
    this.datasources,
  });

  @override
  Future<core.TransactionInfo> startTransaction(
      {required core.TransactionHeaders headers,
      Duration timeout = const Duration(seconds: 5),
      Duration maxWait = const Duration(seconds: 2),
      core.IsolationLevel? isolationLevel}) {
    // TODO: implement startTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> commitTransaction(
      {required core.TransactionHeaders headers,
      required core.TransactionInfo info}) {
    // TODO: implement commitTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> rollbackTransaction(
      {required core.TransactionHeaders headers,
      required core.TransactionInfo info}) {
    // TODO: implement rollbackTransaction
    throw UnimplementedError();
  }

  @override
  Future request(
      {required String query,
      int? attempt,
      core.QueryEngineRequestHeaders? headers,
      core.TransactionInfo? transaction}) {
    // TODO: implement request
    throw UnimplementedError();
  }

  @override
  Future<void> start() {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }
}
