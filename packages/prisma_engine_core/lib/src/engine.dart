import 'query_engine_request_headers.dart';
import 'transaction.dart';

/// Prisma query engine interface.
abstract class Engine {
  /// Starts the engine.
  Future<void> start();

  /// Stops the engine.
  Future<void> stop();

  /// Requests a query execution.
  Future<dynamic> request({
    required String query,
    int? attempt,
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  });

  /// Starts a transaction.
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    IsolationLevel? isolationLevel,
  });

  /// Commits a transaction.
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  });

  /// Rolls back a transaction.
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  });
}
