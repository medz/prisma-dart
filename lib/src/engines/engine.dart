import 'package:orm/logger.dart' as logger;

import 'graphql_result.dart';
import 'query_engine_request_headers.dart';
import 'transaction.dart';

/// Prisma Query engine interfact.
abstract class Engine {
  /// Starts the engine.
  Future<void> start();

  /// Stops the engine.
  Future<void> stop();

  /// Register a new event listener.
  void on(logger.Event event, logger.Listener listener);

  /// Requests a query execution.
  Future<GraphQLResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  });

  /// Starts a transaction.
  Future<TransactionInfo> startTransaction({
    TransactionHeaders? headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    IsolationLevel? isolationLevel,
  });

  /// Commits a transaction.
  Future<void> commitTransaction({
    required TransactionInfo info,
    TransactionHeaders? headers,
  });

  /// Rolls back a transaction.
  Future<void> rollbackTransaction({
    required TransactionInfo info,
    TransactionHeaders? headers,
  });
}
