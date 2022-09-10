// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_engine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryEngineRequestHeaders _$QueryEngineRequestHeadersFromJson(
        Map<String, dynamic> json) =>
    QueryEngineRequestHeaders(
      traceparent: json['traceparent'] as String?,
      transactionId: json['transactionId'] as String?,
      fatal: json['fatal'] as String?,
    );

Map<String, dynamic> _$QueryEngineRequestHeadersToJson(
        QueryEngineRequestHeaders instance) =>
    <String, dynamic>{
      'traceparent': instance.traceparent,
      'transactionId': instance.transactionId,
      'fatal': instance.fatal,
    };

QueryEngineResult _$QueryEngineResultFromJson(Map<String, dynamic> json) =>
    QueryEngineResult(
      json['data'] as Map<String, dynamic>,
      json['elapsed'] as int,
    );

Map<String, dynamic> _$QueryEngineResultToJson(QueryEngineResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'elapsed': instance.elapsed,
    };
