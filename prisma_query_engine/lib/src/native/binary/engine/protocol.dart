import 'package:json_annotation/json_annotation.dart';

part "protocol.g.dart";

@JsonSerializable()
class GQLResponse {
  final Data data;
  final List<GQLError> errors;
  final Map<String, dynamic> extensions;

  Map<String, dynamic> toJson() => _$GQLResponseToJson(this);
  factory GQLResponse.fromJson(Map<String, dynamic> json) =>
      _$GQLResponseFromJson(json);
  GQLResponse(this.data, this.errors, this.extensions);
}

@JsonSerializable()
class Data {
  final Map<String, dynamic> result;

  Data(this.result);
  Map<String, dynamic> toJson() => _$DataToJson(this);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class GQLBatchResponse {
  final List<GQLError> errors;
  final List<GQLResponse> batchResult;

  Map<String, dynamic> toJson() => _$GQLBatchResponseToJson(this);
  factory GQLBatchResponse.fromJson(Map<String, dynamic> json) =>
      _$GQLBatchResponseFromJson(json);
  GQLBatchResponse(this.errors, this.batchResult);
}

@JsonSerializable()
class GQLRequest {
  final String query;
  final Map<String, dynamic> variables;
  Map<String, dynamic> toJson() => _$GQLRequestToJson(this);
  factory GQLRequest.fromJson(Map<String, dynamic> json) =>
      _$GQLRequestFromJson(json);
  GQLRequest(this.query, this.variables);
}

@JsonSerializable()
class GQLBatchRequest {
  final List<GQLRequest> batch;
  final bool transaction;

  Map<String, dynamic> toJson() => _$GQLBatchRequestToJson(this);
  factory GQLBatchRequest.fromJson(Map<String, dynamic> json) =>
      _$GQLBatchRequestFromJson(json);
  GQLBatchRequest(this.batch, this.transaction);
}

@JsonSerializable()
class GQLError {
  final String message;
  final List<String> path;
  final Map<String, dynamic> query;
  Map<String, dynamic> toJson() => _$GQLErrorToJson(this);
  factory GQLError.fromJson(Map<String, dynamic> json) =>
      _$GQLErrorFromJson(json);
  GQLError(this.message, this.path, this.query);

  String rawMessage() => message.replaceAll("\n", " ") ;
}


