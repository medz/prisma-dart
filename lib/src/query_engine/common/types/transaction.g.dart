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

TransactionOptions _$TransactionOptionsFromJson(Map<String, dynamic> json) =>
    TransactionOptions(
      maxWait: json['maxWait'] as int? ?? 2000,
      timeout: json['timeout'] as int? ?? 5000,
      isolationLevel: $enumDecodeNullable(
          _$TransactionIsolationLevelEnumMap, json['isolationLevel']),
    );

Map<String, dynamic> _$TransactionOptionsToJson(TransactionOptions instance) =>
    <String, dynamic>{
      'maxWait': instance.maxWait,
      'timeout': instance.timeout,
      'isolationLevel':
          _$TransactionIsolationLevelEnumMap[instance.isolationLevel],
    };

const _$TransactionIsolationLevelEnumMap = {
  TransactionIsolationLevel.readUncommitted: 'ReadUncommitted',
  TransactionIsolationLevel.readCommitted: 'ReadCommitted',
  TransactionIsolationLevel.repeatableRead: 'RepeatableRead',
  TransactionIsolationLevel.snapshot: 'Snapshot',
  TransactionIsolationLevel.serializable: 'Serializable',
};
