import 'package:json_annotation/json_annotation.dart';

part 'query_engine.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class QueryEngineRequestHeaders {
  final String? traceparent;
  final String? transactionId;
  final String? fatal;

  const QueryEngineRequestHeaders({
    this.traceparent,
    this.transactionId,
    this.fatal,
  });

  factory QueryEngineRequestHeaders.fromJson(Map<String, dynamic> json) =>
      _$QueryEngineRequestHeadersFromJson(json);

  Map<String, dynamic> toJson() => _$QueryEngineRequestHeadersToJson(this);
}
