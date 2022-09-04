import 'package:json_annotation/json_annotation.dart';

part 'query_engine.g.dart';

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
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

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class QueryEngineResult {
  final Map<String, dynamic> data;
  final int elapsed;

  const QueryEngineResult(this.data, this.elapsed);

  factory QueryEngineResult.fromJson(Map<String, dynamic> json) =>
      _$QueryEngineResultFromJson(json);

  Map<String, dynamic> toJson() => _$QueryEngineResultToJson(this);
}
