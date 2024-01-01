class TransactionInfo<T> {
  /// Transaction ID returned by the query engine.
  final String id;

  final T payload;

  const TransactionInfo(this.id, this.payload);
}
