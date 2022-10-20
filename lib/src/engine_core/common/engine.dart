import 'dart:async';

import '../../configure/environment.dart';
import '../../dmmf/dmmf.dart' show Document;
import '../../runtime/datasource.dart';
import '../../runtime/prisma_log.dart';
import 'get_config_result.dart';
import 'types/query_engine.dart';
import 'types/transaction.dart';

abstract class Engine {
  const Engine({
    required this.schema,
    required this.dmmf,
    required this.datasources,
    required this.environment,
    required this.logEmitter,
  });

  /// Prisma log emitter
  final PrismaLogEmitter logEmitter;

  /// Prisma schema as SDL string.
  final String schema;

  /// Prisma schema as [Document].
  final Document dmmf;

  /// Data sources.
  final Map<String, Datasource> datasources;

  /// Environment variables.
  final Future<PrismaEnvironment> environment;

  /// Start the engine.
  Future<void> start();

  /// Stop the engine.
  Future<void> stop();

  /// Get Current configuration.
  FutureOr<GetConfigResult> getConfig();

  /// Get Current DMMF.
  FutureOr<Document> getDmmf() => dmmf;

  /// Get current engine version.
  Future<String> version({bool forceRun = false}) async => 'unknown';

  /// Request a query execution.
  Future<QueryEngineResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
  });

  /// Start a transaction.
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    TransactionOptions options = const TransactionOptions(),
  });

  /// Commit a transaction.
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  });

  /// Rollback a transaction.
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  });
}
