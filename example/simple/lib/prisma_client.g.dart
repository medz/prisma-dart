// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregateSaySomething _$AggregateSaySomethingFromJson(
        Map<String, dynamic> json) =>
    AggregateSaySomething(
      prisma__count: json['_count'] == null
          ? null
          : SaySomethingCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      prisma__avg: json['_avg'] == null
          ? null
          : SaySomethingAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      prisma__sum: json['_sum'] == null
          ? null
          : SaySomethingSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : SaySomethingMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : SaySomethingMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateSaySomethingToJson(
        AggregateSaySomething instance) =>
    <String, dynamic>{
      '_count': instance.prisma__count?.toJson(),
      '_avg': instance.prisma__avg?.toJson(),
      '_sum': instance.prisma__sum?.toJson(),
      '_min': instance.prisma__min?.toJson(),
      '_max': instance.prisma__max?.toJson(),
    };

SaySomethingGroupByOutputType _$SaySomethingGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    SaySomethingGroupByOutputType(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String,
      prisma__count: json['_count'] == null
          ? null
          : SaySomethingCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      prisma__avg: json['_avg'] == null
          ? null
          : SaySomethingAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      prisma__sum: json['_sum'] == null
          ? null
          : SaySomethingSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : SaySomethingMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
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
      '_count': instance.prisma__count?.toJson(),
      '_avg': instance.prisma__avg?.toJson(),
      '_sum': instance.prisma__sum?.toJson(),
      '_min': instance.prisma__min?.toJson(),
      '_max': instance.prisma__max?.toJson(),
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
          prisma__all: json['_all'] as int,
        );

Map<String, dynamic> _$SaySomethingCountAggregateOutputTypeToJson(
        SaySomethingCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
      '_all': instance.prisma__all,
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

_$SaySomethingWhereInput_AND_withSaySomethingWhereInput
    _$$SaySomethingWhereInput_AND_withSaySomethingWhereInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_AND_withSaySomethingWhereInput(
          SaySomethingWhereInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingWhereInput_AND_withSaySomethingWhereInputToJson(
            _$SaySomethingWhereInput_AND_withSaySomethingWhereInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingWhereInput_AND_withSaySomethingWhereInputList
    _$$SaySomethingWhereInput_AND_withSaySomethingWhereInputListFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_AND_withSaySomethingWhereInputList(
          (json['value'] as List<dynamic>)
              .map((e) =>
                  SaySomethingWhereInput.fromJson(e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$SaySomethingWhereInput_AND_withSaySomethingWhereInputListToJson(
        _$SaySomethingWhereInput_AND_withSaySomethingWhereInputList instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingWhereInput_NOT_withSaySomethingWhereInput
    _$$SaySomethingWhereInput_NOT_withSaySomethingWhereInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_NOT_withSaySomethingWhereInput(
          SaySomethingWhereInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingWhereInput_NOT_withSaySomethingWhereInputToJson(
            _$SaySomethingWhereInput_NOT_withSaySomethingWhereInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingWhereInput_NOT_withSaySomethingWhereInputList
    _$$SaySomethingWhereInput_NOT_withSaySomethingWhereInputListFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_NOT_withSaySomethingWhereInputList(
          (json['value'] as List<dynamic>)
              .map((e) =>
                  SaySomethingWhereInput.fromJson(e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$SaySomethingWhereInput_NOT_withSaySomethingWhereInputListToJson(
        _$SaySomethingWhereInput_NOT_withSaySomethingWhereInputList instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingWhereInput_id_withIntFilter
    _$$SaySomethingWhereInput_id_withIntFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_id_withIntFilter(
          IntFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingWhereInput_id_withIntFilterToJson(
        _$SaySomethingWhereInput_id_withIntFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingWhereInput_id_withInt
    _$$SaySomethingWhereInput_id_withIntFromJson(Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_id_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingWhereInput_id_withIntToJson(
        _$SaySomethingWhereInput_id_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingWhereInput_createdAt_withDateTimeFilter
    _$$SaySomethingWhereInput_createdAt_withDateTimeFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_createdAt_withDateTimeFilter(
          DateTimeFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingWhereInput_createdAt_withDateTimeFilterToJson(
            _$SaySomethingWhereInput_createdAt_withDateTimeFilter instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingWhereInput_createdAt_withDateTime
    _$$SaySomethingWhereInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingWhereInput_createdAt_withDateTimeToJson(
        _$SaySomethingWhereInput_createdAt_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$SaySomethingWhereInput_updatedAt_withDateTimeFilter
    _$$SaySomethingWhereInput_updatedAt_withDateTimeFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_updatedAt_withDateTimeFilter(
          DateTimeFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingWhereInput_updatedAt_withDateTimeFilterToJson(
            _$SaySomethingWhereInput_updatedAt_withDateTimeFilter instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingWhereInput_updatedAt_withDateTime
    _$$SaySomethingWhereInput_updatedAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_updatedAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingWhereInput_updatedAt_withDateTimeToJson(
        _$SaySomethingWhereInput_updatedAt_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$SaySomethingWhereInput_text_withStringFilter
    _$$SaySomethingWhereInput_text_withStringFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_text_withStringFilter(
          StringFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingWhereInput_text_withStringFilterToJson(
        _$SaySomethingWhereInput_text_withStringFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingWhereInput_text_withString
    _$$SaySomethingWhereInput_text_withStringFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingWhereInput_text_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingWhereInput_text_withStringToJson(
        _$SaySomethingWhereInput_text_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_SaySomethingWhereInput _$$_SaySomethingWhereInputFromJson(
        Map<String, dynamic> json) =>
    _$_SaySomethingWhereInput(
      AND: json['AND'] == null
          ? null
          : SaySomethingWhereInput_AND.fromJson(
              json['AND'] as Map<String, dynamic>),
      OR: (json['OR'] as List<dynamic>?)
          ?.map(
              (e) => SaySomethingWhereInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      NOT: json['NOT'] == null
          ? null
          : SaySomethingWhereInput_NOT.fromJson(
              json['NOT'] as Map<String, dynamic>),
      id: json['id'] == null
          ? null
          : SaySomethingWhereInput_id.fromJson(
              json['id'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : SaySomethingWhereInput_createdAt.fromJson(
              json['createdAt'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : SaySomethingWhereInput_updatedAt.fromJson(
              json['updatedAt'] as Map<String, dynamic>),
      text: json['text'] == null
          ? null
          : SaySomethingWhereInput_text.fromJson(
              json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SaySomethingWhereInputToJson(
        _$_SaySomethingWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.AND,
      'OR': instance.OR,
      'NOT': instance.NOT,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
    };

_$_SaySomethingOrderByWithRelationInput
    _$$_SaySomethingOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingOrderByWithRelationInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$$_SaySomethingOrderByWithRelationInputToJson(
        _$_SaySomethingOrderByWithRelationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
    };

const _$SortOrderEnumMap = {
  SortOrder.asc: 'asc',
  SortOrder.desc: 'desc',
};

_$_SaySomethingWhereUniqueInput _$$_SaySomethingWhereUniqueInputFromJson(
        Map<String, dynamic> json) =>
    _$_SaySomethingWhereUniqueInput(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$_SaySomethingWhereUniqueInputToJson(
        _$_SaySomethingWhereUniqueInput instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$_SaySomethingOrderByWithAggregationInput
    _$$_SaySomethingOrderByWithAggregationInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingOrderByWithAggregationInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
          prisma__count: json['_count'] == null
              ? null
              : SaySomethingCountOrderByAggregateInput.fromJson(
                  json['_count'] as Map<String, dynamic>),
          prisma__avg: json['_avg'] == null
              ? null
              : SaySomethingAvgOrderByAggregateInput.fromJson(
                  json['_avg'] as Map<String, dynamic>),
          prisma__max: json['_max'] == null
              ? null
              : SaySomethingMaxOrderByAggregateInput.fromJson(
                  json['_max'] as Map<String, dynamic>),
          prisma__min: json['_min'] == null
              ? null
              : SaySomethingMinOrderByAggregateInput.fromJson(
                  json['_min'] as Map<String, dynamic>),
          prisma__sum: json['_sum'] == null
              ? null
              : SaySomethingSumOrderByAggregateInput.fromJson(
                  json['_sum'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_SaySomethingOrderByWithAggregationInputToJson(
        _$_SaySomethingOrderByWithAggregationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
      '_count': instance.prisma__count,
      '_avg': instance.prisma__avg,
      '_max': instance.prisma__max,
      '_min': instance.prisma__min,
      '_sum': instance.prisma__sum,
    };

_$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInput
    _$$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInput(
          SaySomethingScalarWhereWithAggregatesInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInputToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInputList
    _$$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInputListFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInputList(
          (json['value'] as List<dynamic>)
              .map((e) => SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInputListToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_AND_withSaySomethingScalarWhereWithAggregatesInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInput
    _$$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInput(
          SaySomethingScalarWhereWithAggregatesInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInputToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInputList
    _$$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInputListFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInputList(
          (json['value'] as List<dynamic>)
              .map((e) => SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInputListToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_NOT_withSaySomethingScalarWhereWithAggregatesInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilter
    _$$SaySomethingScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilter(
          IntWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilterToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_id_withInt
    _$$SaySomethingScalarWhereWithAggregatesInput_id_withIntFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_id_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_id_withIntToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_id_withInt instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilter
    _$$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilter(
          DateTimeWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilterToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTime
    _$$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTimeToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_createdAt_withDateTime
                instance) =>
        <String, dynamic>{
          'value': instance.value.toIso8601String(),
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTimeWithAggregatesFilter
    _$$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTimeWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTimeWithAggregatesFilter(
          DateTimeWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTimeWithAggregatesFilterToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTimeWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTime
    _$$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTimeToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_updatedAt_withDateTime
                instance) =>
        <String, dynamic>{
          'value': instance.value.toIso8601String(),
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_text_withStringWithAggregatesFilter
    _$$SaySomethingScalarWhereWithAggregatesInput_text_withStringWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_text_withStringWithAggregatesFilter(
          StringWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_text_withStringWithAggregatesFilterToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_text_withStringWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingScalarWhereWithAggregatesInput_text_withString
    _$$SaySomethingScalarWhereWithAggregatesInput_text_withStringFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingScalarWhereWithAggregatesInput_text_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingScalarWhereWithAggregatesInput_text_withStringToJson(
            _$SaySomethingScalarWhereWithAggregatesInput_text_withString
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_SaySomethingScalarWhereWithAggregatesInput
    _$$_SaySomethingScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingScalarWhereWithAggregatesInput(
          AND: json['AND'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput_AND.fromJson(
                  json['AND'] as Map<String, dynamic>),
          OR: (json['OR'] as List<dynamic>?)
              ?.map((e) => SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          NOT: json['NOT'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput_NOT.fromJson(
                  json['NOT'] as Map<String, dynamic>),
          id: json['id'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput_id.fromJson(
                  json['id'] as Map<String, dynamic>),
          createdAt: json['createdAt'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput_createdAt.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
          updatedAt: json['updatedAt'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput_updatedAt.fromJson(
                  json['updatedAt'] as Map<String, dynamic>),
          text: json['text'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput_text.fromJson(
                  json['text'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_SaySomethingScalarWhereWithAggregatesInputToJson(
        _$_SaySomethingScalarWhereWithAggregatesInput instance) =>
    <String, dynamic>{
      'AND': instance.AND,
      'OR': instance.OR,
      'NOT': instance.NOT,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
    };

_$_SaySomethingCreateInput _$$_SaySomethingCreateInputFromJson(
        Map<String, dynamic> json) =>
    _$_SaySomethingCreateInput(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$$_SaySomethingCreateInputToJson(
        _$_SaySomethingCreateInput instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'text': instance.text,
    };

_$_SaySomethingUncheckedCreateInput
    _$$_SaySomethingUncheckedCreateInputFromJson(Map<String, dynamic> json) =>
        _$_SaySomethingUncheckedCreateInput(
          id: json['id'] as int?,
          createdAt: json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
          updatedAt: json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
          text: json['text'] as String,
        );

Map<String, dynamic> _$$_SaySomethingUncheckedCreateInputToJson(
        _$_SaySomethingUncheckedCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'text': instance.text,
    };

_$SaySomethingUpdateInput_createdAt_withDateTime
    _$$SaySomethingUpdateInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingUpdateInput_createdAt_withDateTimeToJson(
        _$SaySomethingUpdateInput_createdAt_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$SaySomethingUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUpdateInput_updatedAt_withDateTime
    _$$SaySomethingUpdateInput_updatedAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateInput_updatedAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingUpdateInput_updatedAt_withDateTimeToJson(
        _$SaySomethingUpdateInput_updatedAt_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$SaySomethingUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUpdateInput_text_withString
    _$$SaySomethingUpdateInput_text_withStringFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateInput_text_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingUpdateInput_text_withStringToJson(
        _$SaySomethingUpdateInput_text_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingUpdateInput_text_withStringFieldUpdateOperationsInput
    _$$SaySomethingUpdateInput_text_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateInput_text_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateInput_text_withStringFieldUpdateOperationsInputToJson(
            _$SaySomethingUpdateInput_text_withStringFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_SaySomethingUpdateInput _$$_SaySomethingUpdateInputFromJson(
        Map<String, dynamic> json) =>
    _$_SaySomethingUpdateInput(
      createdAt: json['createdAt'] == null
          ? null
          : SaySomethingUpdateInput_createdAt.fromJson(
              json['createdAt'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : SaySomethingUpdateInput_updatedAt.fromJson(
              json['updatedAt'] as Map<String, dynamic>),
      text: json['text'] == null
          ? null
          : SaySomethingUpdateInput_text.fromJson(
              json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SaySomethingUpdateInputToJson(
        _$_SaySomethingUpdateInput instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
    };

_$SaySomethingUncheckedUpdateInput_id_withInt
    _$$SaySomethingUncheckedUpdateInput_id_withIntFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_id_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingUncheckedUpdateInput_id_withIntToJson(
        _$SaySomethingUncheckedUpdateInput_id_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingUncheckedUpdateInput_id_withIntFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateInput_id_withIntFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_id_withIntFieldUpdateOperationsInput(
          IntFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateInput_id_withIntFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateInput_id_withIntFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateInput_createdAt_withDateTime
    _$$SaySomethingUncheckedUpdateInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$SaySomethingUncheckedUpdateInput_createdAt_withDateTimeToJson(
        _$SaySomethingUncheckedUpdateInput_createdAt_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$SaySomethingUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateInput_updatedAt_withDateTime
    _$$SaySomethingUncheckedUpdateInput_updatedAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_updatedAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$SaySomethingUncheckedUpdateInput_updatedAt_withDateTimeToJson(
        _$SaySomethingUncheckedUpdateInput_updatedAt_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$SaySomethingUncheckedUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateInput_updatedAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateInput_text_withString
    _$$SaySomethingUncheckedUpdateInput_text_withStringFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_text_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingUncheckedUpdateInput_text_withStringToJson(
        _$SaySomethingUncheckedUpdateInput_text_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingUncheckedUpdateInput_text_withStringFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateInput_text_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateInput_text_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateInput_text_withStringFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateInput_text_withStringFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_SaySomethingUncheckedUpdateInput
    _$$_SaySomethingUncheckedUpdateInputFromJson(Map<String, dynamic> json) =>
        _$_SaySomethingUncheckedUpdateInput(
          id: json['id'] == null
              ? null
              : SaySomethingUncheckedUpdateInput_id.fromJson(
                  json['id'] as Map<String, dynamic>),
          createdAt: json['createdAt'] == null
              ? null
              : SaySomethingUncheckedUpdateInput_createdAt.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
          updatedAt: json['updatedAt'] == null
              ? null
              : SaySomethingUncheckedUpdateInput_updatedAt.fromJson(
                  json['updatedAt'] as Map<String, dynamic>),
          text: json['text'] == null
              ? null
              : SaySomethingUncheckedUpdateInput_text.fromJson(
                  json['text'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_SaySomethingUncheckedUpdateInputToJson(
        _$_SaySomethingUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
    };

_$SaySomethingUpdateManyMutationInput_createdAt_withDateTime
    _$$SaySomethingUpdateManyMutationInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateManyMutationInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateManyMutationInput_createdAt_withDateTimeToJson(
            _$SaySomethingUpdateManyMutationInput_createdAt_withDateTime
                instance) =>
        <String, dynamic>{
          'value': instance.value.toIso8601String(),
          'runtimeType': instance.$type,
        };

_$SaySomethingUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUpdateManyMutationInput_updatedAt_withDateTime
    _$$SaySomethingUpdateManyMutationInput_updatedAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateManyMutationInput_updatedAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateManyMutationInput_updatedAt_withDateTimeToJson(
            _$SaySomethingUpdateManyMutationInput_updatedAt_withDateTime
                instance) =>
        <String, dynamic>{
          'value': instance.value.toIso8601String(),
          'runtimeType': instance.$type,
        };

_$SaySomethingUpdateManyMutationInput_updatedAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUpdateManyMutationInput_updatedAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateManyMutationInput_updatedAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateManyMutationInput_updatedAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUpdateManyMutationInput_updatedAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUpdateManyMutationInput_text_withString
    _$$SaySomethingUpdateManyMutationInput_text_withStringFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateManyMutationInput_text_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateManyMutationInput_text_withStringToJson(
            _$SaySomethingUpdateManyMutationInput_text_withString instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUpdateManyMutationInput_text_withStringFieldUpdateOperationsInput
    _$$SaySomethingUpdateManyMutationInput_text_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUpdateManyMutationInput_text_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUpdateManyMutationInput_text_withStringFieldUpdateOperationsInputToJson(
            _$SaySomethingUpdateManyMutationInput_text_withStringFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_SaySomethingUpdateManyMutationInput
    _$$_SaySomethingUpdateManyMutationInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingUpdateManyMutationInput(
          createdAt: json['createdAt'] == null
              ? null
              : SaySomethingUpdateManyMutationInput_createdAt.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
          updatedAt: json['updatedAt'] == null
              ? null
              : SaySomethingUpdateManyMutationInput_updatedAt.fromJson(
                  json['updatedAt'] as Map<String, dynamic>),
          text: json['text'] == null
              ? null
              : SaySomethingUpdateManyMutationInput_text.fromJson(
                  json['text'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_SaySomethingUpdateManyMutationInputToJson(
        _$_SaySomethingUpdateManyMutationInput instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
    };

_$SaySomethingUncheckedUpdateManyInput_id_withInt
    _$$SaySomethingUncheckedUpdateManyInput_id_withIntFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_id_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SaySomethingUncheckedUpdateManyInput_id_withIntToJson(
        _$SaySomethingUncheckedUpdateManyInput_id_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SaySomethingUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInput(
          IntFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTime
    _$$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTimeToJson(
            _$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTime
                instance) =>
        <String, dynamic>{
          'value': instance.value.toIso8601String(),
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTime
    _$$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTimeToJson(
            _$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTime
                instance) =>
        <String, dynamic>{
          'value': instance.value.toIso8601String(),
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTimeFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateManyInput_updatedAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateManyInput_text_withString
    _$$SaySomethingUncheckedUpdateManyInput_text_withStringFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_text_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateManyInput_text_withStringToJson(
            _$SaySomethingUncheckedUpdateManyInput_text_withString instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$SaySomethingUncheckedUpdateManyInput_text_withStringFieldUpdateOperationsInput
    _$$SaySomethingUncheckedUpdateManyInput_text_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$SaySomethingUncheckedUpdateManyInput_text_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$SaySomethingUncheckedUpdateManyInput_text_withStringFieldUpdateOperationsInputToJson(
            _$SaySomethingUncheckedUpdateManyInput_text_withStringFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_SaySomethingUncheckedUpdateManyInput
    _$$_SaySomethingUncheckedUpdateManyInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingUncheckedUpdateManyInput(
          id: json['id'] == null
              ? null
              : SaySomethingUncheckedUpdateManyInput_id.fromJson(
                  json['id'] as Map<String, dynamic>),
          createdAt: json['createdAt'] == null
              ? null
              : SaySomethingUncheckedUpdateManyInput_createdAt.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
          updatedAt: json['updatedAt'] == null
              ? null
              : SaySomethingUncheckedUpdateManyInput_updatedAt.fromJson(
                  json['updatedAt'] as Map<String, dynamic>),
          text: json['text'] == null
              ? null
              : SaySomethingUncheckedUpdateManyInput_text.fromJson(
                  json['text'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_SaySomethingUncheckedUpdateManyInputToJson(
        _$_SaySomethingUncheckedUpdateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
    };

_$IntFilter_not_withInt _$$IntFilter_not_withIntFromJson(
        Map<String, dynamic> json) =>
    _$IntFilter_not_withInt(
      json['value'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$IntFilter_not_withIntToJson(
        _$IntFilter_not_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$IntFilter_not_withNestedIntFilter
    _$$IntFilter_not_withNestedIntFilterFromJson(Map<String, dynamic> json) =>
        _$IntFilter_not_withNestedIntFilter(
          NestedIntFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$IntFilter_not_withNestedIntFilterToJson(
        _$IntFilter_not_withNestedIntFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_IntFilter _$$_IntFilterFromJson(Map<String, dynamic> json) => _$_IntFilter(
      equals: json['equals'] as int?,
      dart__in: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : IntFilter_not.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_IntFilterToJson(_$_IntFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

_$DateTimeFilter_not_withDateTime _$$DateTimeFilter_not_withDateTimeFromJson(
        Map<String, dynamic> json) =>
    _$DateTimeFilter_not_withDateTime(
      DateTime.parse(json['value'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DateTimeFilter_not_withDateTimeToJson(
        _$DateTimeFilter_not_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$DateTimeFilter_not_withNestedDateTimeFilter
    _$$DateTimeFilter_not_withNestedDateTimeFilterFromJson(
            Map<String, dynamic> json) =>
        _$DateTimeFilter_not_withNestedDateTimeFilter(
          NestedDateTimeFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$DateTimeFilter_not_withNestedDateTimeFilterToJson(
        _$DateTimeFilter_not_withNestedDateTimeFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_DateTimeFilter _$$_DateTimeFilterFromJson(Map<String, dynamic> json) =>
    _$_DateTimeFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      dart__in: (json['in'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      lt: json['lt'] == null ? null : DateTime.parse(json['lt'] as String),
      lte: json['lte'] == null ? null : DateTime.parse(json['lte'] as String),
      gt: json['gt'] == null ? null : DateTime.parse(json['gt'] as String),
      gte: json['gte'] == null ? null : DateTime.parse(json['gte'] as String),
      not: json['not'] == null
          ? null
          : DateTimeFilter_not.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DateTimeFilterToJson(_$_DateTimeFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.dart__in?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not,
    };

_$StringFilter_not_withString _$$StringFilter_not_withStringFromJson(
        Map<String, dynamic> json) =>
    _$StringFilter_not_withString(
      json['value'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StringFilter_not_withStringToJson(
        _$StringFilter_not_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$StringFilter_not_withNestedStringFilter
    _$$StringFilter_not_withNestedStringFilterFromJson(
            Map<String, dynamic> json) =>
        _$StringFilter_not_withNestedStringFilter(
          NestedStringFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$StringFilter_not_withNestedStringFilterToJson(
        _$StringFilter_not_withNestedStringFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_StringFilter _$$_StringFilterFromJson(Map<String, dynamic> json) =>
    _$_StringFilter(
      equals: json['equals'] as String?,
      dart__in:
          (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lt: json['lt'] as String?,
      lte: json['lte'] as String?,
      gt: json['gt'] as String?,
      gte: json['gte'] as String?,
      contains: json['contains'] as String?,
      startsWith: json['startsWith'] as String?,
      endsWith: json['endsWith'] as String?,
      not: json['not'] == null
          ? null
          : StringFilter_not.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_StringFilterToJson(_$_StringFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not,
    };

_$_SaySomethingCountOrderByAggregateInput
    _$$_SaySomethingCountOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingCountOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$$_SaySomethingCountOrderByAggregateInputToJson(
        _$_SaySomethingCountOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
    };

_$_SaySomethingAvgOrderByAggregateInput
    _$$_SaySomethingAvgOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingAvgOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
        );

Map<String, dynamic> _$$_SaySomethingAvgOrderByAggregateInputToJson(
        _$_SaySomethingAvgOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
    };

_$_SaySomethingMaxOrderByAggregateInput
    _$$_SaySomethingMaxOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingMaxOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$$_SaySomethingMaxOrderByAggregateInputToJson(
        _$_SaySomethingMaxOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
    };

_$_SaySomethingMinOrderByAggregateInput
    _$$_SaySomethingMinOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingMinOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$$_SaySomethingMinOrderByAggregateInputToJson(
        _$_SaySomethingMinOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
    };

_$_SaySomethingSumOrderByAggregateInput
    _$$_SaySomethingSumOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        _$_SaySomethingSumOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
        );

Map<String, dynamic> _$$_SaySomethingSumOrderByAggregateInputToJson(
        _$_SaySomethingSumOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
    };

_$IntWithAggregatesFilter_not_withInt
    _$$IntWithAggregatesFilter_not_withIntFromJson(Map<String, dynamic> json) =>
        _$IntWithAggregatesFilter_not_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$IntWithAggregatesFilter_not_withIntToJson(
        _$IntWithAggregatesFilter_not_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$IntWithAggregatesFilter_not_withNestedIntWithAggregatesFilter
    _$$IntWithAggregatesFilter_not_withNestedIntWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$IntWithAggregatesFilter_not_withNestedIntWithAggregatesFilter(
          NestedIntWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$IntWithAggregatesFilter_not_withNestedIntWithAggregatesFilterToJson(
            _$IntWithAggregatesFilter_not_withNestedIntWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_IntWithAggregatesFilter _$$_IntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    _$_IntWithAggregatesFilter(
      equals: json['equals'] as int?,
      dart__in: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : IntWithAggregatesFilter_not.fromJson(
              json['not'] as Map<String, dynamic>),
      prisma__count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      prisma__avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      prisma__sum: json['_sum'] == null
          ? null
          : NestedIntFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : NestedIntFilter.fromJson(json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : NestedIntFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_IntWithAggregatesFilterToJson(
        _$_IntWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      '_count': instance.prisma__count,
      '_avg': instance.prisma__avg,
      '_sum': instance.prisma__sum,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
    };

_$DateTimeWithAggregatesFilter_not_withDateTime
    _$$DateTimeWithAggregatesFilter_not_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$DateTimeWithAggregatesFilter_not_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$DateTimeWithAggregatesFilter_not_withDateTimeToJson(
        _$DateTimeWithAggregatesFilter_not_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$DateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilter
    _$$DateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$DateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilter(
          NestedDateTimeWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$DateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilterToJson(
            _$DateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_DateTimeWithAggregatesFilter _$$_DateTimeWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    _$_DateTimeWithAggregatesFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      dart__in: (json['in'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      lt: json['lt'] == null ? null : DateTime.parse(json['lt'] as String),
      lte: json['lte'] == null ? null : DateTime.parse(json['lte'] as String),
      gt: json['gt'] == null ? null : DateTime.parse(json['gt'] as String),
      gte: json['gte'] == null ? null : DateTime.parse(json['gte'] as String),
      not: json['not'] == null
          ? null
          : DateTimeWithAggregatesFilter_not.fromJson(
              json['not'] as Map<String, dynamic>),
      prisma__count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DateTimeWithAggregatesFilterToJson(
        _$_DateTimeWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.dart__in?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not,
      '_count': instance.prisma__count,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
    };

_$StringWithAggregatesFilter_not_withString
    _$$StringWithAggregatesFilter_not_withStringFromJson(
            Map<String, dynamic> json) =>
        _$StringWithAggregatesFilter_not_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$StringWithAggregatesFilter_not_withStringToJson(
        _$StringWithAggregatesFilter_not_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$StringWithAggregatesFilter_not_withNestedStringWithAggregatesFilter
    _$$StringWithAggregatesFilter_not_withNestedStringWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$StringWithAggregatesFilter_not_withNestedStringWithAggregatesFilter(
          NestedStringWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$StringWithAggregatesFilter_not_withNestedStringWithAggregatesFilterToJson(
            _$StringWithAggregatesFilter_not_withNestedStringWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_StringWithAggregatesFilter _$$_StringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    _$_StringWithAggregatesFilter(
      equals: json['equals'] as String?,
      dart__in:
          (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lt: json['lt'] as String?,
      lte: json['lte'] as String?,
      gt: json['gt'] as String?,
      gte: json['gte'] as String?,
      contains: json['contains'] as String?,
      startsWith: json['startsWith'] as String?,
      endsWith: json['endsWith'] as String?,
      not: json['not'] == null
          ? null
          : StringWithAggregatesFilter_not.fromJson(
              json['not'] as Map<String, dynamic>),
      prisma__count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : NestedStringFilter.fromJson(json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : NestedStringFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_StringWithAggregatesFilterToJson(
        _$_StringWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not,
      '_count': instance.prisma__count,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
    };

_$_DateTimeFieldUpdateOperationsInput
    _$$_DateTimeFieldUpdateOperationsInputFromJson(Map<String, dynamic> json) =>
        _$_DateTimeFieldUpdateOperationsInput(
          dart__set: json['set'] == null
              ? null
              : DateTime.parse(json['set'] as String),
        );

Map<String, dynamic> _$$_DateTimeFieldUpdateOperationsInputToJson(
        _$_DateTimeFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.dart__set?.toIso8601String(),
    };

_$_StringFieldUpdateOperationsInput
    _$$_StringFieldUpdateOperationsInputFromJson(Map<String, dynamic> json) =>
        _$_StringFieldUpdateOperationsInput(
          dart__set: json['set'] as String?,
        );

Map<String, dynamic> _$$_StringFieldUpdateOperationsInputToJson(
        _$_StringFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.dart__set,
    };

_$_IntFieldUpdateOperationsInput _$$_IntFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    _$_IntFieldUpdateOperationsInput(
      dart__set: json['set'] as int?,
      increment: json['increment'] as int?,
      decrement: json['decrement'] as int?,
      multiply: json['multiply'] as int?,
      divide: json['divide'] as int?,
    );

Map<String, dynamic> _$$_IntFieldUpdateOperationsInputToJson(
        _$_IntFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.dart__set,
      'increment': instance.increment,
      'decrement': instance.decrement,
      'multiply': instance.multiply,
      'divide': instance.divide,
    };

_$NestedIntFilter_not_withInt _$$NestedIntFilter_not_withIntFromJson(
        Map<String, dynamic> json) =>
    _$NestedIntFilter_not_withInt(
      json['value'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NestedIntFilter_not_withIntToJson(
        _$NestedIntFilter_not_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$NestedIntFilter_not_withNestedIntFilter
    _$$NestedIntFilter_not_withNestedIntFilterFromJson(
            Map<String, dynamic> json) =>
        _$NestedIntFilter_not_withNestedIntFilter(
          NestedIntFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedIntFilter_not_withNestedIntFilterToJson(
        _$NestedIntFilter_not_withNestedIntFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_NestedIntFilter _$$_NestedIntFilterFromJson(Map<String, dynamic> json) =>
    _$_NestedIntFilter(
      equals: json['equals'] as int?,
      dart__in: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntFilter_not.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NestedIntFilterToJson(_$_NestedIntFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

_$NestedDateTimeFilter_not_withDateTime
    _$$NestedDateTimeFilter_not_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$NestedDateTimeFilter_not_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedDateTimeFilter_not_withDateTimeToJson(
        _$NestedDateTimeFilter_not_withDateTime instance) =>
    <String, dynamic>{
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$NestedDateTimeFilter_not_withNestedDateTimeFilter
    _$$NestedDateTimeFilter_not_withNestedDateTimeFilterFromJson(
            Map<String, dynamic> json) =>
        _$NestedDateTimeFilter_not_withNestedDateTimeFilter(
          NestedDateTimeFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedDateTimeFilter_not_withNestedDateTimeFilterToJson(
        _$NestedDateTimeFilter_not_withNestedDateTimeFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_NestedDateTimeFilter _$$_NestedDateTimeFilterFromJson(
        Map<String, dynamic> json) =>
    _$_NestedDateTimeFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      dart__in: (json['in'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      lt: json['lt'] == null ? null : DateTime.parse(json['lt'] as String),
      lte: json['lte'] == null ? null : DateTime.parse(json['lte'] as String),
      gt: json['gt'] == null ? null : DateTime.parse(json['gt'] as String),
      gte: json['gte'] == null ? null : DateTime.parse(json['gte'] as String),
      not: json['not'] == null
          ? null
          : NestedDateTimeFilter_not.fromJson(
              json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NestedDateTimeFilterToJson(
        _$_NestedDateTimeFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.dart__in?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not,
    };

_$NestedStringFilter_not_withString
    _$$NestedStringFilter_not_withStringFromJson(Map<String, dynamic> json) =>
        _$NestedStringFilter_not_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedStringFilter_not_withStringToJson(
        _$NestedStringFilter_not_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$NestedStringFilter_not_withNestedStringFilter
    _$$NestedStringFilter_not_withNestedStringFilterFromJson(
            Map<String, dynamic> json) =>
        _$NestedStringFilter_not_withNestedStringFilter(
          NestedStringFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedStringFilter_not_withNestedStringFilterToJson(
        _$NestedStringFilter_not_withNestedStringFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_NestedStringFilter _$$_NestedStringFilterFromJson(
        Map<String, dynamic> json) =>
    _$_NestedStringFilter(
      equals: json['equals'] as String?,
      dart__in:
          (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lt: json['lt'] as String?,
      lte: json['lte'] as String?,
      gt: json['gt'] as String?,
      gte: json['gte'] as String?,
      contains: json['contains'] as String?,
      startsWith: json['startsWith'] as String?,
      endsWith: json['endsWith'] as String?,
      not: json['not'] == null
          ? null
          : NestedStringFilter_not.fromJson(
              json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NestedStringFilterToJson(
        _$_NestedStringFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not,
    };

_$NestedIntWithAggregatesFilter_not_withInt
    _$$NestedIntWithAggregatesFilter_not_withIntFromJson(
            Map<String, dynamic> json) =>
        _$NestedIntWithAggregatesFilter_not_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedIntWithAggregatesFilter_not_withIntToJson(
        _$NestedIntWithAggregatesFilter_not_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$NestedIntWithAggregatesFilter_not_withNestedIntWithAggregatesFilter
    _$$NestedIntWithAggregatesFilter_not_withNestedIntWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$NestedIntWithAggregatesFilter_not_withNestedIntWithAggregatesFilter(
          NestedIntWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$NestedIntWithAggregatesFilter_not_withNestedIntWithAggregatesFilterToJson(
            _$NestedIntWithAggregatesFilter_not_withNestedIntWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_NestedIntWithAggregatesFilter _$$_NestedIntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    _$_NestedIntWithAggregatesFilter(
      equals: json['equals'] as int?,
      dart__in: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntWithAggregatesFilter_not.fromJson(
              json['not'] as Map<String, dynamic>),
      prisma__count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      prisma__avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      prisma__sum: json['_sum'] == null
          ? null
          : NestedIntFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : NestedIntFilter.fromJson(json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : NestedIntFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NestedIntWithAggregatesFilterToJson(
        _$_NestedIntWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      '_count': instance.prisma__count,
      '_avg': instance.prisma__avg,
      '_sum': instance.prisma__sum,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
    };

_$NestedFloatFilter_not_withFloat _$$NestedFloatFilter_not_withFloatFromJson(
        Map<String, dynamic> json) =>
    _$NestedFloatFilter_not_withFloat(
      (json['value'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NestedFloatFilter_not_withFloatToJson(
        _$NestedFloatFilter_not_withFloat instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$NestedFloatFilter_not_withNestedFloatFilter
    _$$NestedFloatFilter_not_withNestedFloatFilterFromJson(
            Map<String, dynamic> json) =>
        _$NestedFloatFilter_not_withNestedFloatFilter(
          NestedFloatFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedFloatFilter_not_withNestedFloatFilterToJson(
        _$NestedFloatFilter_not_withNestedFloatFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_NestedFloatFilter _$$_NestedFloatFilterFromJson(Map<String, dynamic> json) =>
    _$_NestedFloatFilter(
      equals: (json['equals'] as num?)?.toDouble(),
      dart__in: (json['in'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      lt: (json['lt'] as num?)?.toDouble(),
      lte: (json['lte'] as num?)?.toDouble(),
      gt: (json['gt'] as num?)?.toDouble(),
      gte: (json['gte'] as num?)?.toDouble(),
      not: json['not'] == null
          ? null
          : NestedFloatFilter_not.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NestedFloatFilterToJson(
        _$_NestedFloatFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

_$NestedDateTimeWithAggregatesFilter_not_withDateTime
    _$$NestedDateTimeWithAggregatesFilter_not_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$NestedDateTimeWithAggregatesFilter_not_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$NestedDateTimeWithAggregatesFilter_not_withDateTimeToJson(
            _$NestedDateTimeWithAggregatesFilter_not_withDateTime instance) =>
        <String, dynamic>{
          'value': instance.value.toIso8601String(),
          'runtimeType': instance.$type,
        };

_$NestedDateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilter
    _$$NestedDateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$NestedDateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilter(
          NestedDateTimeWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$NestedDateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilterToJson(
            _$NestedDateTimeWithAggregatesFilter_not_withNestedDateTimeWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_NestedDateTimeWithAggregatesFilter
    _$$_NestedDateTimeWithAggregatesFilterFromJson(Map<String, dynamic> json) =>
        _$_NestedDateTimeWithAggregatesFilter(
          equals: json['equals'] == null
              ? null
              : DateTime.parse(json['equals'] as String),
          dart__in: (json['in'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList(),
          notIn: (json['notIn'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList(),
          lt: json['lt'] == null ? null : DateTime.parse(json['lt'] as String),
          lte: json['lte'] == null
              ? null
              : DateTime.parse(json['lte'] as String),
          gt: json['gt'] == null ? null : DateTime.parse(json['gt'] as String),
          gte: json['gte'] == null
              ? null
              : DateTime.parse(json['gte'] as String),
          not: json['not'] == null
              ? null
              : NestedDateTimeWithAggregatesFilter_not.fromJson(
                  json['not'] as Map<String, dynamic>),
          prisma__count: json['_count'] == null
              ? null
              : NestedIntFilter.fromJson(
                  json['_count'] as Map<String, dynamic>),
          prisma__min: json['_min'] == null
              ? null
              : NestedDateTimeFilter.fromJson(
                  json['_min'] as Map<String, dynamic>),
          prisma__max: json['_max'] == null
              ? null
              : NestedDateTimeFilter.fromJson(
                  json['_max'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_NestedDateTimeWithAggregatesFilterToJson(
        _$_NestedDateTimeWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.dart__in?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not,
      '_count': instance.prisma__count,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
    };

_$NestedStringWithAggregatesFilter_not_withString
    _$$NestedStringWithAggregatesFilter_not_withStringFromJson(
            Map<String, dynamic> json) =>
        _$NestedStringWithAggregatesFilter_not_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$NestedStringWithAggregatesFilter_not_withStringToJson(
        _$NestedStringWithAggregatesFilter_not_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$NestedStringWithAggregatesFilter_not_withNestedStringWithAggregatesFilter
    _$$NestedStringWithAggregatesFilter_not_withNestedStringWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$NestedStringWithAggregatesFilter_not_withNestedStringWithAggregatesFilter(
          NestedStringWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$NestedStringWithAggregatesFilter_not_withNestedStringWithAggregatesFilterToJson(
            _$NestedStringWithAggregatesFilter_not_withNestedStringWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_NestedStringWithAggregatesFilter
    _$$_NestedStringWithAggregatesFilterFromJson(Map<String, dynamic> json) =>
        _$_NestedStringWithAggregatesFilter(
          equals: json['equals'] as String?,
          dart__in:
              (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
          notIn: (json['notIn'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          lt: json['lt'] as String?,
          lte: json['lte'] as String?,
          gt: json['gt'] as String?,
          gte: json['gte'] as String?,
          contains: json['contains'] as String?,
          startsWith: json['startsWith'] as String?,
          endsWith: json['endsWith'] as String?,
          not: json['not'] == null
              ? null
              : NestedStringWithAggregatesFilter_not.fromJson(
                  json['not'] as Map<String, dynamic>),
          prisma__count: json['_count'] == null
              ? null
              : NestedIntFilter.fromJson(
                  json['_count'] as Map<String, dynamic>),
          prisma__min: json['_min'] == null
              ? null
              : NestedStringFilter.fromJson(
                  json['_min'] as Map<String, dynamic>),
          prisma__max: json['_max'] == null
              ? null
              : NestedStringFilter.fromJson(
                  json['_max'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_NestedStringWithAggregatesFilterToJson(
        _$_NestedStringWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.dart__in,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not,
      '_count': instance.prisma__count,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
    };

_$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInputList
    _$$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => SaySomethingOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInputListToJson(
            _$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInput
    _$$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInput(
          SaySomethingOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInputToJson(
            _$_FindFirstSaySomethingOrderByWithSaySomethingOrderByWithRelationInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInputList
    _$$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => SaySomethingOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInputListToJson(
            _$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInput
    _$$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInput(
          SaySomethingOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInputToJson(
            _$_FindFirstSaySomethingOrThrowOrderByWithSaySomethingOrderByWithRelationInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInputList
    _$$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => SaySomethingOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInputListToJson(
            _$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInput
    _$$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInput(
          SaySomethingOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInputToJson(
            _$_FindManySaySomethingOrderByWithSaySomethingOrderByWithRelationInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_CreateOneSaySomethingDataWithSaySomethingCreateInput
    _$$_CreateOneSaySomethingDataWithSaySomethingCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_CreateOneSaySomethingDataWithSaySomethingCreateInput(
          SaySomethingCreateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_CreateOneSaySomethingDataWithSaySomethingCreateInputToJson(
            _$_CreateOneSaySomethingDataWithSaySomethingCreateInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_CreateOneSaySomethingDataWithSaySomethingUncheckedCreateInput
    _$$_CreateOneSaySomethingDataWithSaySomethingUncheckedCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_CreateOneSaySomethingDataWithSaySomethingUncheckedCreateInput(
          SaySomethingUncheckedCreateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_CreateOneSaySomethingDataWithSaySomethingUncheckedCreateInputToJson(
            _$_CreateOneSaySomethingDataWithSaySomethingUncheckedCreateInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpdateOneSaySomethingDataWithSaySomethingUpdateInput
    _$$_UpdateOneSaySomethingDataWithSaySomethingUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateOneSaySomethingDataWithSaySomethingUpdateInput(
          SaySomethingUpdateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpdateOneSaySomethingDataWithSaySomethingUpdateInputToJson(
            _$_UpdateOneSaySomethingDataWithSaySomethingUpdateInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpdateOneSaySomethingDataWithSaySomethingUncheckedUpdateInput
    _$$_UpdateOneSaySomethingDataWithSaySomethingUncheckedUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateOneSaySomethingDataWithSaySomethingUncheckedUpdateInput(
          SaySomethingUncheckedUpdateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpdateOneSaySomethingDataWithSaySomethingUncheckedUpdateInputToJson(
            _$_UpdateOneSaySomethingDataWithSaySomethingUncheckedUpdateInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpdateManySaySomethingDataWithSaySomethingUpdateManyMutationInput
    _$$_UpdateManySaySomethingDataWithSaySomethingUpdateManyMutationInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateManySaySomethingDataWithSaySomethingUpdateManyMutationInput(
          SaySomethingUpdateManyMutationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpdateManySaySomethingDataWithSaySomethingUpdateManyMutationInputToJson(
            _$_UpdateManySaySomethingDataWithSaySomethingUpdateManyMutationInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpdateManySaySomethingDataWithSaySomethingUncheckedUpdateManyInput
    _$$_UpdateManySaySomethingDataWithSaySomethingUncheckedUpdateManyInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateManySaySomethingDataWithSaySomethingUncheckedUpdateManyInput(
          SaySomethingUncheckedUpdateManyInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpdateManySaySomethingDataWithSaySomethingUncheckedUpdateManyInputToJson(
            _$_UpdateManySaySomethingDataWithSaySomethingUncheckedUpdateManyInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpsertOneSaySomethingCreateWithSaySomethingCreateInput
    _$$_UpsertOneSaySomethingCreateWithSaySomethingCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneSaySomethingCreateWithSaySomethingCreateInput(
          SaySomethingCreateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$_UpsertOneSaySomethingCreateWithSaySomethingCreateInputToJson(
        _$_UpsertOneSaySomethingCreateWithSaySomethingCreateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpsertOneSaySomethingCreateWithSaySomethingUncheckedCreateInput
    _$$_UpsertOneSaySomethingCreateWithSaySomethingUncheckedCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneSaySomethingCreateWithSaySomethingUncheckedCreateInput(
          SaySomethingUncheckedCreateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpsertOneSaySomethingCreateWithSaySomethingUncheckedCreateInputToJson(
            _$_UpsertOneSaySomethingCreateWithSaySomethingUncheckedCreateInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpsertOneSaySomethingUpdateWithSaySomethingUpdateInput
    _$$_UpsertOneSaySomethingUpdateWithSaySomethingUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneSaySomethingUpdateWithSaySomethingUpdateInput(
          SaySomethingUpdateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$_UpsertOneSaySomethingUpdateWithSaySomethingUpdateInputToJson(
        _$_UpsertOneSaySomethingUpdateWithSaySomethingUpdateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpsertOneSaySomethingUpdateWithSaySomethingUncheckedUpdateInput
    _$$_UpsertOneSaySomethingUpdateWithSaySomethingUncheckedUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneSaySomethingUpdateWithSaySomethingUncheckedUpdateInput(
          SaySomethingUncheckedUpdateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpsertOneSaySomethingUpdateWithSaySomethingUncheckedUpdateInputToJson(
            _$_UpsertOneSaySomethingUpdateWithSaySomethingUncheckedUpdateInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInputList
    _$$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => SaySomethingOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInputListToJson(
            _$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInput
    _$$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInput(
          SaySomethingOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInputToJson(
            _$_AggregateSaySomethingOrderByWithSaySomethingOrderByWithRelationInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInputList
    _$$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => SaySomethingOrderByWithAggregationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInputListToJson(
            _$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInput
    _$$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInputFromJson(
            Map<String, dynamic> json) =>
        _$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInput(
          SaySomethingOrderByWithAggregationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInputToJson(
            _$_GroupBySaySomethingOrderByWithSaySomethingOrderByWithAggregationInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_GroupBySaySomethingByWithSaySomethingScalarFieldEnumList
    _$$_GroupBySaySomethingByWithSaySomethingScalarFieldEnumListFromJson(
            Map<String, dynamic> json) =>
        _$_GroupBySaySomethingByWithSaySomethingScalarFieldEnumList(
          (json['value'] as List<dynamic>)
              .map((e) => $enumDecode(_$SaySomethingScalarFieldEnumEnumMap, e))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$_GroupBySaySomethingByWithSaySomethingScalarFieldEnumListToJson(
        _$_GroupBySaySomethingByWithSaySomethingScalarFieldEnumList instance) =>
    <String, dynamic>{
      'value': instance.value
          .map((e) => _$SaySomethingScalarFieldEnumEnumMap[e]!)
          .toList(),
      'runtimeType': instance.$type,
    };

const _$SaySomethingScalarFieldEnumEnumMap = {
  SaySomethingScalarFieldEnum.id: 'id',
  SaySomethingScalarFieldEnum.createdAt: 'createdAt',
  SaySomethingScalarFieldEnum.updatedAt: 'updatedAt',
  SaySomethingScalarFieldEnum.text: 'text',
};

_$_GroupBySaySomethingByWithSaySomethingScalarFieldEnum
    _$$_GroupBySaySomethingByWithSaySomethingScalarFieldEnumFromJson(
            Map<String, dynamic> json) =>
        _$_GroupBySaySomethingByWithSaySomethingScalarFieldEnum(
          $enumDecode(_$SaySomethingScalarFieldEnumEnumMap, json['value']),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_GroupBySaySomethingByWithSaySomethingScalarFieldEnumToJson(
            _$_GroupBySaySomethingByWithSaySomethingScalarFieldEnum instance) =>
        <String, dynamic>{
          'value': _$SaySomethingScalarFieldEnumEnumMap[instance.value]!,
          'runtimeType': instance.$type,
        };
