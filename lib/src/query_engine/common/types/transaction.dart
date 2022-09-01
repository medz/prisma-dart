// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class TransactionHeaders {
  final String? traceparent;

  const TransactionHeaders({
    this.traceparent,
  });

  factory TransactionHeaders.fromJson(Map<String, dynamic> json) =>
      _$TransactionHeadersFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHeadersToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: true)
class TransactionInfo {
  final String id;

  const TransactionInfo(this.id);

  factory TransactionInfo.fromJson(Map<String, dynamic> json) =>
      _$TransactionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionInfoToJson(this);
}

enum TransactionIsolationLevel {
  ReadUncommitted,
  ReadCommitted,
  RepeatableRead,
  Snapshot,
  Serializable,
}

class TransactionOptions {
  final int maxWait;
  final int timeout;
  final TransactionIsolationLevel? isolationLevel;

  const TransactionOptions({
    this.maxWait = 2000,
    this.timeout = 5000,
    this.isolationLevel,
  });
}
