import '../utils/prisma_enum.dart';

/// Prisma ISO lation level
///
/// @see https://github.com/prisma/prisma/blob/main/packages/client/src/runtime/core/engines/common/types/Transaction.ts
enum IsolationLevel implements PrismaEnum {
  readUncommitted('ReadUncommitted'),
  readCommitted('ReadCommitted'),
  repeatableRead('RepeatableRead'),
  snapshot('Snapshot'),
  serializable('Serializable');

  /// Returns the enum value.
  @override
  final String value;

  /// Inner constructor.
  const IsolationLevel(this.value);
}

/// Prisma interactive transaction info.
class InteractiveTransactionInfo<T> {
  /// Transaction identifier.
  final String id;

  /// Transaction payload.
  final T payload;

  /// Creates a new instance of [InteractiveTransactionInfo].
  const InteractiveTransactionInfo(this.id, this.payload);
}

/// Prisma transaction headers.
class TransactionHeaders {
  /// Transaction identifier.
  final String? traceparent;

  /// Creates a new instance of [TransactionHeaders].
  const TransactionHeaders([this.traceparent]);
}
