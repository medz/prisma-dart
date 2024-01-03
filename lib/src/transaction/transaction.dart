class Transaction<T> {
  /// Transaction ID returned by the query engine.
  final String id;

  final T payload;

  const Transaction(this.id, this.payload);
}
