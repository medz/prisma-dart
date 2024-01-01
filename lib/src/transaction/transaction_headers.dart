import '../json_convertible.dart';

class TransactionHeaders implements JsonConvertible<Map<String, String>> {
  final String? traceparent;

  const TransactionHeaders({this.traceparent});

  @override
  Map<String, String> toJson() =>
      {if (traceparent != null) 'traceparent': traceparent!};
}
