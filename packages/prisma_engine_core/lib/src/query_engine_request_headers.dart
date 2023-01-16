import 'transaction.dart';

/// Query engine request headers.
class QueryEngineRequestHeaders extends TransactionHeaders {
  /// Transaction id header.
  final String? transactionId;

  /// Creates a new instance of [QueryEngineRequestHeaders].
  const QueryEngineRequestHeaders({
    super.traceparent,
    this.transactionId,
  });
}
