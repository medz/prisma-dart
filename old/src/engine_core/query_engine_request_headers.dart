import 'transaction.dart';

/// Query engine request headers.
class QueryEngineRequestHeaders extends TransactionHeaders {
  QueryEngineRequestHeaders.fromJson(super.store) : super.fromJson();

  /// Create a new instance of [QueryEngineRequestHeaders].
  QueryEngineRequestHeaders({
    super.traceparent,
    String? transactionId,
  }) {
    this.transactionId = transactionId;
  }

  /// Returns the transaction id.
  String? get transactionId => this['x-transaction-id'];

  /// Sets the transaction id.
  set transactionId(String? value) {
    if (value != null && value.isNotEmpty) {
      this['x-transaction-id'] = value;
    }
  }
}
