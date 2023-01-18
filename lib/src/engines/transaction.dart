import 'case_insensitive_map.dart';

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

/// Transaction Info.
class TransactionInfo extends CaseInsensitiveMap<String, dynamic> {
  TransactionInfo.fromJson(super.store);

  /// Transaction info ready.
  bool get ready => _id is String;

  String? get _id {
    final id = this['id'];

    return id is String ? id : null;
  }

  /// Returns the transaction id.
  String get id {
    if (_id is String) return _id!;

    throw ArgumentError.value(this, 'id', 'Transaction id not found.');
  }
}

/// Transaction Headers.
class TransactionHeaders extends CaseInsensitiveMap<String, String> {
  TransactionHeaders.fromJson(super.store);

  /// Create a new instance of [TransactionHeaders].
  TransactionHeaders({String? traceparent}) : super({}) {
    this.traceparent = traceparent;
  }

  /// Returns the traceparent.
  String? get traceparent => this['traceparent'];

  /// Sets the traceparent.
  set traceparent(String? value) {
    if (value != null && value.isNotEmpty) {
      this['traceparent'] = value;
    }
  }
}
