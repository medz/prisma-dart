import 'package:prisma_generator_helper/dmmf.dart' show Document;

import 'transaction.dart';

/// Prisma engine query.
abstract interface class EngineQuery {}

/// Prisma engine event type.
enum EngineEventType {
  query,
  info,
  warn,
  error,
}

/// Prisma engine interface.
abstract interface class Engine<T> {
  /// Starts the engine.
  Future<void> start();

  /// Stops the engine.
  Future<void> stop();

  /// Requests a query execution.
  Future<dynamic> request<R>(
    EngineQuery query, {
    String? traceparent,
    InteractiveTransactionInfo<T>? transaction,
    required bool isWrite,
  });

  /// Returns current client DMMF.
  Future<Document> dmmf();

  /// Returns the engine version.
  Future<String> version([bool force = false]);

  /// Starts a transaction.
  Future<InteractiveTransactionInfo> startTransaction({
    required TransactionHeaders headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    IsolationLevel? isolationLevel,
  });

  /// Commits a transaction.
  Future<void> commitTransaction({
    required InteractiveTransactionInfo info,
    required TransactionHeaders headers,
  });

  /// Rolls back a transaction.
  Future<void> rollbackTransaction({
    required InteractiveTransactionInfo info,
    required TransactionHeaders headers,
  });

  /// Registers a logger event handler.
  void on(EngineEventType type, void Function(dynamic) listener);

  /// Metrics.
  Future<String> metrics({Map<String, String>? globalLabels});
}
