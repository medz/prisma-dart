class InteractiveTransactionInfo<T> {
  final String id;
  final T payload;

  const InteractiveTransactionInfo(this.id, this.payload);
}

enum IsolationLevel {
  readUncommitted('ReadUncommitted'),
  readCommitted('ReadCommitted'),
  repeatableRead('RepeatableRead'),
  snapshot('Snapshot'),
  serializable('Serializable'),

  //----------------------------
  // For beautiful
  ;
  //----------------------------

  final String value;

  const IsolationLevel(this.value);
}
