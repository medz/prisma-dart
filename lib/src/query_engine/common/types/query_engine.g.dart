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
