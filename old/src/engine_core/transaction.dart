import '../client/prisma_enum.dart';
import 'case_insensitive_map.dart';

/// Isolation level.
enum TransactionIsolationLevel implements PrismaEnum {
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
  @override
  final String originalName;

  /// Creates a new instance of [TransactionIsolationLevel].
  const TransactionIsolationLevel(this.originalName);
}

/// Transaction Info.
class TransactionInfo extends CaseInsensitiveMap<String, dynamic> {
  TransactionInfo.fromJson(super.store);

  /// Returns the transaction id.
  String get id => this['id'] as String;
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
