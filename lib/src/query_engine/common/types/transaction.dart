import 'package:json_annotation/json_annotation.dart';

import '../../../runtime/prisma_enum.dart';

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

enum TransactionIsolationLevel implements PrismaEnum {
  @JsonValue('ReadUncommitted')
  readUncommitted('ReadUncommitted'),

  @JsonValue('ReadCommitted')
  readCommitted('ReadCommitted'),

  @JsonValue('RepeatableRead')
  repeatableRead('RepeatableRead'),

  @JsonValue('Snapshot')
  snapshot('Snapshot'),

  @JsonValue('Serializable')
  serializable('Serializable'),
  ;

  @override
  final String value;

  const TransactionIsolationLevel(this.value);
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
