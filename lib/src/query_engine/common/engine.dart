import 'dart:async';

import '../../dmmf/dmmf.dart' as dmmf show Document;
import 'get_config_result.dart';
import 'types/query_engine.dart';
import 'types/transaction.dart';

abstract class Engine {
  const Engine();

  /// Start the engine.
  Future<void> start();

  /// Stop the engine.
  Future<void> stop();

  /// Get Current configuration.
  Future<GetConfigResult> getConfig();

  /// Get Current DMMF.
  Future<dmmf.Document> getDmmf();

  /// Get current engine version.
  FutureOr<String> version({bool forceRun = false});

  /// Request a query execution.
  Future<T> request<T>({
    required String query,
    QueryEngineRequestHeaders? headers,
    int? numTry,
  });

  /// Request batch query execution.
  Future<List<T>> requestBatch<T>({
    required List<String> queries,
    QueryEngineRequestHeaders? headers,
    bool? transaction,
    int? numTry,
  });

  /// Start a transaction.
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    TransactionOptions? options,
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
