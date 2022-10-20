// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregateSaySomething _$AggregateSaySomethingFromJson(
        Map<String, dynamic> json) =>
    AggregateSaySomething(
      $count: json['_count'] == null
          ? null
          : SaySomethingCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : SaySomethingAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : SaySomethingSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : SaySomethingMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : SaySomethingMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateSaySomethingToJson(
        AggregateSaySomething instance) =>
    <String, dynamic>{
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

SaySomethingGroupByOutputType _$SaySomethingGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    SaySomethingGroupByOutputType(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String,
      $count: json['_count'] == null
          ? null
          : SaySomethingCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : SaySomethingAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : SaySomethingSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : SaySomethingMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : SaySomethingMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaySomethingGroupByOutputTypeToJson(
        SaySomethingGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'text': instance.text,
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int,
    );

Map<String, dynamic> _$AffectedRowsOutputToJson(AffectedRowsOutput instance) =>
    <String, dynamic>{
      'count': instance.count,
    };

SaySomethingCountAggregateOutputType
    _$SaySomethingCountAggregateOutputTypeFromJson(Map<String, dynamic> json) =>
        SaySomethingCountAggregateOutputType(
          id: json['id'] as int,
          createdAt: json['createdAt'] as int,
          updatedAt: json['updatedAt'] as int,
          text: json['text'] as int,
          $all: json['_all'] as int,
        );

Map<String, dynamic> _$SaySomethingCountAggregateOutputTypeToJson(
        SaySomethingCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
      '_all': instance.$all,
    };

SaySomethingAvgAggregateOutputType _$SaySomethingAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    SaySomethingAvgAggregateOutputType(
      id: (json['id'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SaySomethingAvgAggregateOutputTypeToJson(
        SaySomethingAvgAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SaySomethingSumAggregateOutputType _$SaySomethingSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    SaySomethingSumAggregateOutputType(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SaySomethingSumAggregateOutputTypeToJson(
        SaySomethingSumAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SaySomethingMinAggregateOutputType _$SaySomethingMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    SaySomethingMinAggregateOutputType(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$SaySomethingMinAggregateOutputTypeToJson(
        SaySomethingMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'text': instance.text,
    };

SaySomethingMaxAggregateOutputType _$SaySomethingMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    SaySomethingMaxAggregateOutputType(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$SaySomethingMaxAggregateOutputTypeToJson(
        SaySomethingMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'text': instance.text,
    };

SaySomething _$SaySomethingFromJson(Map<String, dynamic> json) => SaySomething(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$SaySomethingToJson(SaySomething instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'text': instance.text,
    };
