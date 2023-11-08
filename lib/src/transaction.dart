import 'json_convertible.dart';

class Transaction<T> {
  const Transaction(this.id, this.payload);

  /// The interctive transaction identifier.
  final String id;

  /// The transaction payload.
  final T payload;
}

abstract interface class IsolationLevel implements JsonConvertible<String> {
  const IsolationLevel();
}
