import 'json_convertible.dart';

abstract interface class IsolationLevel {
  String get value;
}

class Transaction<T> {
  /// Transaction ID returned by the query engine.
  final String id;

  final T payload;

  const Transaction(this.id, this.payload);
}

class TransactionHeaders implements JsonConvertible<Map<String, String>> {
  final String? traceparent;

  const TransactionHeaders({this.traceparent});

  @override
  Map<String, String> toJson() =>
      {if (traceparent != null) 'traceparent': traceparent!};
}
