import 'json_convertible.dart';
import 'metrics/metrics_format.dart';
import 'transaction.dart';

/// Prisma engine interface.
abstract class Engine<T> {
  const Engine({
    required this.schema,
    required String version,
  }) : _version = version;

  /// The Prisma schema string.
  final String schema;

  /// Built-in Prisma engine version.
  final String _version;

  /// Start the engine.
  Future<void> start();

  /// Stop the engine.
  Future<void> stop();

  /// Returns current engine version.
  ///
  /// [force] - Force the engine to return the version even if it is not running.
  Future<String> version([bool force = false]) async => _version;

  /// Request a query to be executed.
  Future<dynamic> request(
    JsonConvertible payload, {
    int attempts = 0,
    required bool isWrite,
    Transaction<T> transaction,
  });

  /// Start a new transaction.
  Future<Transaction<T>> startTransaction({
    int maxWait = 2000,
    int timeout = 5000,
    IsolationLevel isolationLevel,
  });

  /// Commit a transaction.
  Future<void> commitTransaction(Transaction<T> transaction);

  /// Rollback a transaction.
  Future<void> rollbackTransaction(Transaction<T> transaction);

  /// Returns the engine metrics.
  ///
  /// - [globalLabels] - Global labels to be added to the metrics.
  /// - [format] - The format of the metrics.
  ///   - [MetricsFormat.prometheus] - Prometheus format.
  ///   - [MetricsFormat.json] - JSON format.
  Future<Object> metrics({
    Map<String, String>? globalLabels,
    required MetricsFormat format,
  });
}
