import 'transaction.dart';

abstract interface class Engine<T> {
  /// Start the engine.
  Future<void> start();

  /// Stop the engine.
  Future<void> stop();

  /// Returns current engine version.
  Future<String> version([bool force = false]);

  /// Request a new query.
  Future request(
    Map query, {
    final int? numTry,
    required final bool isWrite,
    final InteractiveTransactionInfo<T>? transaction,
  });

  /// Start a new transaction.
  Future<InteractiveTransactionInfo<T>> startTransaction({
    final int maxWait = 2000,
    final int timeout = 5000,
    final IsolationLevel? isolationLevel,
  });

  /// Commit a transaction.
  Future<void> commitTransaction(InteractiveTransactionInfo<T> transaction);

  /// Rollback a transaction.
  Future<void> rollbackTransaction(InteractiveTransactionInfo<T> transaction);

  // TODO: metrics, on
}
