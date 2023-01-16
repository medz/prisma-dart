/// Transaction Info.
class TransactionInfo {
  /// Transaction id.
  final String id;

  /// Creates a new instance of [TransactionInfo].
  const TransactionInfo({required this.id});
}

/// Transaction Headers.
class TransactionHeaders {
  /// Traceparent header.
  final String? traceparent;

  /// Creates a new instance of [TransactionHeaders].
  const TransactionHeaders({this.traceparent});
}

/// Isolation level.
enum IsolationLevel {
  /// Read uncommitted.
  readUncommitted('ReadUncommitted'),

  /// Read committed.
  readCommitted('ReadCommitted'),

  /// Repeatable read.
  repeatableRead('RepeatableRead'),

  /// Serializable.
  serializable('Serializable'),

  /// Snapshot.
  snapshot('Snapshot');

  /// String representation.
  final String value;

  /// Creates a new instance of [IsolationLevel].
  const IsolationLevel(this.value);
}
