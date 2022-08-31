// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHeaders _$TransactionHeadersFromJson(Map<String, dynamic> json) =>
    TransactionHeaders(
      traceparent: json['traceparent'] as String?,
    );

Map<String, dynamic> _$TransactionHeadersToJson(TransactionHeaders instance) =>
    <String, dynamic>{
      'traceparent': instance.traceparent,
    };

TransactionInfo _$TransactionInfoFromJson(Map<String, dynamic> json) =>
    TransactionInfo(
      json['id'] as String,
    );

Map<String, dynamic> _$TransactionInfoToJson(TransactionInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
