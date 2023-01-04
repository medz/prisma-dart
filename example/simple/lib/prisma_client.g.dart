// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaySomethingWhereInput _$SaySomethingWhereInputFromJson(
        Map<String, dynamic> json) =>
    SaySomethingWhereInput(
      AND: json['AND'] == null
          ? null
          : SaySomethingWhereInput.fromJson(
              json['AND'] as Map<String, dynamic>),
      OR: (json['OR'] as List<dynamic>?)
          ?.map(
              (e) => SaySomethingWhereInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      NOT: json['NOT'] == null
          ? null
          : SaySomethingWhereInput.fromJson(
              json['NOT'] as Map<String, dynamic>),
      id: json['id'] == null
          ? null
          : IntFilter.fromJson(json['id'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTimeFilter.fromJson(json['createdAt'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTimeFilter.fromJson(json['updatedAt'] as Map<String, dynamic>),
      text: json['text'] == null
          ? null
          : StringFilter.fromJson(json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaySomethingWhereInputToJson(
        SaySomethingWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.AND?.toJson(),
      'OR': instance.OR?.map((e) => e.toJson()).toList(),
      'NOT': instance.NOT?.toJson(),
      'id': instance.id?.toJson(),
      'createdAt': instance.createdAt?.toJson(),
      'updatedAt': instance.updatedAt?.toJson(),
      'text': instance.text?.toJson(),
    };

SaySomethingOrderByWithRelationInput
    _$SaySomethingOrderByWithRelationInputFromJson(Map<String, dynamic> json) =>
        SaySomethingOrderByWithRelationInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$SaySomethingOrderByWithRelationInputToJson(
        SaySomethingOrderByWithRelationInput instance) =>
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

SaySomethingWhereUniqueInput _$SaySomethingWhereUniqueInputFromJson(
        Map<String, dynamic> json) =>
    SaySomethingWhereUniqueInput(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SaySomethingWhereUniqueInputToJson(
        SaySomethingWhereUniqueInput instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SaySomethingOrderByWithAggregationInput
    _$SaySomethingOrderByWithAggregationInputFromJson(
            Map<String, dynamic> json) =>
        SaySomethingOrderByWithAggregationInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
          $count: json['_count'] == null
              ? null
              : SaySomethingCountOrderByAggregateInput.fromJson(
                  json['_count'] as Map<String, dynamic>),
          $avg: json['_avg'] == null
              ? null
              : SaySomethingAvgOrderByAggregateInput.fromJson(
                  json['_avg'] as Map<String, dynamic>),
          $max: json['_max'] == null
              ? null
              : SaySomethingMaxOrderByAggregateInput.fromJson(
                  json['_max'] as Map<String, dynamic>),
          $min: json['_min'] == null
              ? null
              : SaySomethingMinOrderByAggregateInput.fromJson(
                  json['_min'] as Map<String, dynamic>),
          $sum: json['_sum'] == null
              ? null
              : SaySomethingSumOrderByAggregateInput.fromJson(
                  json['_sum'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SaySomethingOrderByWithAggregationInputToJson(
        SaySomethingOrderByWithAggregationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_max': instance.$max?.toJson(),
      '_min': instance.$min?.toJson(),
      '_sum': instance.$sum?.toJson(),
    };

SaySomethingScalarWhereWithAggregatesInput
    _$SaySomethingScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        SaySomethingScalarWhereWithAggregatesInput(
          AND: json['AND'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  json['AND'] as Map<String, dynamic>),
          OR: (json['OR'] as List<dynamic>?)
              ?.map((e) => SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          NOT: json['NOT'] == null
              ? null
              : SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  json['NOT'] as Map<String, dynamic>),
          id: json['id'] == null
              ? null
              : IntWithAggregatesFilter.fromJson(
                  json['id'] as Map<String, dynamic>),
          createdAt: json['createdAt'] == null
              ? null
              : DateTimeWithAggregatesFilter.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
          updatedAt: json['updatedAt'] == null
              ? null
              : DateTimeWithAggregatesFilter.fromJson(
                  json['updatedAt'] as Map<String, dynamic>),
          text: json['text'] == null
              ? null
              : StringWithAggregatesFilter.fromJson(
                  json['text'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SaySomethingScalarWhereWithAggregatesInputToJson(
        SaySomethingScalarWhereWithAggregatesInput instance) =>
    <String, dynamic>{
      'AND': instance.AND?.toJson(),
      'OR': instance.OR?.map((e) => e.toJson()).toList(),
      'NOT': instance.NOT?.toJson(),
      'id': instance.id?.toJson(),
      'createdAt': instance.createdAt?.toJson(),
      'updatedAt': instance.updatedAt?.toJson(),
      'text': instance.text?.toJson(),
    };

SaySomethingCreateInput _$SaySomethingCreateInputFromJson(
        Map<String, dynamic> json) =>
    SaySomethingCreateInput(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$SaySomethingCreateInputToJson(
        SaySomethingCreateInput instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'text': instance.text,
    };

SaySomethingUncheckedCreateInput _$SaySomethingUncheckedCreateInputFromJson(
        Map<String, dynamic> json) =>
    SaySomethingUncheckedCreateInput(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$SaySomethingUncheckedCreateInputToJson(
        SaySomethingUncheckedCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'text': instance.text,
    };

SaySomethingUpdateInput _$SaySomethingUpdateInputFromJson(
        Map<String, dynamic> json) =>
    SaySomethingUpdateInput(
      createdAt: json['createdAt'] == null
          ? null
          : DateTimeFieldUpdateOperationsInput.fromJson(
              json['createdAt'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTimeFieldUpdateOperationsInput.fromJson(
              json['updatedAt'] as Map<String, dynamic>),
      text: json['text'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaySomethingUpdateInputToJson(
        SaySomethingUpdateInput instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toJson(),
      'updatedAt': instance.updatedAt?.toJson(),
      'text': instance.text?.toJson(),
    };

SaySomethingUncheckedUpdateInput _$SaySomethingUncheckedUpdateInputFromJson(
        Map<String, dynamic> json) =>
    SaySomethingUncheckedUpdateInput(
      id: json['id'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['id'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTimeFieldUpdateOperationsInput.fromJson(
              json['createdAt'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTimeFieldUpdateOperationsInput.fromJson(
              json['updatedAt'] as Map<String, dynamic>),
      text: json['text'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaySomethingUncheckedUpdateInputToJson(
        SaySomethingUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'createdAt': instance.createdAt?.toJson(),
      'updatedAt': instance.updatedAt?.toJson(),
      'text': instance.text?.toJson(),
    };

SaySomethingUpdateManyMutationInput
    _$SaySomethingUpdateManyMutationInputFromJson(Map<String, dynamic> json) =>
        SaySomethingUpdateManyMutationInput(
          createdAt: json['createdAt'] == null
              ? null
              : DateTimeFieldUpdateOperationsInput.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
          updatedAt: json['updatedAt'] == null
              ? null
              : DateTimeFieldUpdateOperationsInput.fromJson(
                  json['updatedAt'] as Map<String, dynamic>),
          text: json['text'] == null
              ? null
              : StringFieldUpdateOperationsInput.fromJson(
                  json['text'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SaySomethingUpdateManyMutationInputToJson(
        SaySomethingUpdateManyMutationInput instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toJson(),
      'updatedAt': instance.updatedAt?.toJson(),
      'text': instance.text?.toJson(),
    };

SaySomethingUncheckedUpdateManyInput
    _$SaySomethingUncheckedUpdateManyInputFromJson(Map<String, dynamic> json) =>
        SaySomethingUncheckedUpdateManyInput(
          id: json['id'] == null
              ? null
              : IntFieldUpdateOperationsInput.fromJson(
                  json['id'] as Map<String, dynamic>),
          createdAt: json['createdAt'] == null
              ? null
              : DateTimeFieldUpdateOperationsInput.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
          updatedAt: json['updatedAt'] == null
              ? null
              : DateTimeFieldUpdateOperationsInput.fromJson(
                  json['updatedAt'] as Map<String, dynamic>),
          text: json['text'] == null
              ? null
              : StringFieldUpdateOperationsInput.fromJson(
                  json['text'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SaySomethingUncheckedUpdateManyInputToJson(
        SaySomethingUncheckedUpdateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'createdAt': instance.createdAt?.toJson(),
      'updatedAt': instance.updatedAt?.toJson(),
      'text': instance.text?.toJson(),
    };

IntFilter _$IntFilterFromJson(Map<String, dynamic> json) => IntFilter(
      equals: json['equals'] as int?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntFilterToJson(IntFilter instance) => <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not?.toJson(),
    };

DateTimeFilter _$DateTimeFilterFromJson(Map<String, dynamic> json) =>
    DateTimeFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      in$: (json['in'] as List<dynamic>?)
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
          : NestedDateTimeFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DateTimeFilterToJson(DateTimeFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.in$?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not?.toJson(),
    };

StringFilter _$StringFilterFromJson(Map<String, dynamic> json) => StringFilter(
      equals: json['equals'] as String?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
          : NestedStringFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StringFilterToJson(StringFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not?.toJson(),
    };

SaySomethingCountOrderByAggregateInput
    _$SaySomethingCountOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        SaySomethingCountOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$SaySomethingCountOrderByAggregateInputToJson(
        SaySomethingCountOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
    };

SaySomethingAvgOrderByAggregateInput
    _$SaySomethingAvgOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingAvgOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
        );

Map<String, dynamic> _$SaySomethingAvgOrderByAggregateInputToJson(
        SaySomethingAvgOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
    };

SaySomethingMaxOrderByAggregateInput
    _$SaySomethingMaxOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingMaxOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$SaySomethingMaxOrderByAggregateInputToJson(
        SaySomethingMaxOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
    };

SaySomethingMinOrderByAggregateInput
    _$SaySomethingMinOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingMinOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$SaySomethingMinOrderByAggregateInputToJson(
        SaySomethingMinOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      'updatedAt': _$SortOrderEnumMap[instance.updatedAt],
      'text': _$SortOrderEnumMap[instance.text],
    };

SaySomethingSumOrderByAggregateInput
    _$SaySomethingSumOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingSumOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
        );

Map<String, dynamic> _$SaySomethingSumOrderByAggregateInputToJson(
        SaySomethingSumOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
    };

IntWithAggregatesFilter _$IntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    IntWithAggregatesFilter(
      equals: json['equals'] as int?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : NestedIntFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedIntFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedIntFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntWithAggregatesFilterToJson(
        IntWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not?.toJson(),
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

DateTimeWithAggregatesFilter _$DateTimeWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    DateTimeWithAggregatesFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      in$: (json['in'] as List<dynamic>?)
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
          : NestedDateTimeWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DateTimeWithAggregatesFilterToJson(
        DateTimeWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.in$?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not?.toJson(),
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

StringWithAggregatesFilter _$StringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    StringWithAggregatesFilter(
      equals: json['equals'] as String?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
          : NestedStringWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedStringFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedStringFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StringWithAggregatesFilterToJson(
        StringWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not?.toJson(),
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

DateTimeFieldUpdateOperationsInput _$DateTimeFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    DateTimeFieldUpdateOperationsInput(
      set$: json['set'] == null ? null : DateTime.parse(json['set'] as String),
    );

Map<String, dynamic> _$DateTimeFieldUpdateOperationsInputToJson(
        DateTimeFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$?.toIso8601String(),
    };

StringFieldUpdateOperationsInput _$StringFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    StringFieldUpdateOperationsInput(
      set$: json['set'] as String?,
    );

Map<String, dynamic> _$StringFieldUpdateOperationsInputToJson(
        StringFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$,
    };

IntFieldUpdateOperationsInput _$IntFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    IntFieldUpdateOperationsInput(
      set$: json['set'] as int?,
      increment: json['increment'] as int?,
      decrement: json['decrement'] as int?,
      multiply: json['multiply'] as int?,
      divide: json['divide'] as int?,
    );

Map<String, dynamic> _$IntFieldUpdateOperationsInputToJson(
        IntFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$,
      'increment': instance.increment,
      'decrement': instance.decrement,
      'multiply': instance.multiply,
      'divide': instance.divide,
    };

NestedIntFilter _$NestedIntFilterFromJson(Map<String, dynamic> json) =>
    NestedIntFilter(
      equals: json['equals'] as int?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedIntFilterToJson(NestedIntFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not?.toJson(),
    };

NestedDateTimeFilter _$NestedDateTimeFilterFromJson(
        Map<String, dynamic> json) =>
    NestedDateTimeFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      in$: (json['in'] as List<dynamic>?)
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
          : NestedDateTimeFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedDateTimeFilterToJson(
        NestedDateTimeFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.in$?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not?.toJson(),
    };

NestedStringFilter _$NestedStringFilterFromJson(Map<String, dynamic> json) =>
    NestedStringFilter(
      equals: json['equals'] as String?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
          : NestedStringFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedStringFilterToJson(NestedStringFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not?.toJson(),
    };

NestedIntWithAggregatesFilter _$NestedIntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedIntWithAggregatesFilter(
      equals: json['equals'] as int?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as int).toList(),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : NestedIntFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedIntFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedIntFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedIntWithAggregatesFilterToJson(
        NestedIntWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not?.toJson(),
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

NestedFloatFilter _$NestedFloatFilterFromJson(Map<String, dynamic> json) =>
    NestedFloatFilter(
      equals: (json['equals'] as num?)?.toDouble(),
      in$: (json['in'] as List<dynamic>?)
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
          : NestedFloatFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedFloatFilterToJson(NestedFloatFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not?.toJson(),
    };

NestedDateTimeWithAggregatesFilter _$NestedDateTimeWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedDateTimeWithAggregatesFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      in$: (json['in'] as List<dynamic>?)
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
          : NestedDateTimeWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedDateTimeWithAggregatesFilterToJson(
        NestedDateTimeWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals?.toIso8601String(),
      'in': instance.in$?.map((e) => e.toIso8601String()).toList(),
      'notIn': instance.notIn?.map((e) => e.toIso8601String()).toList(),
      'lt': instance.lt?.toIso8601String(),
      'lte': instance.lte?.toIso8601String(),
      'gt': instance.gt?.toIso8601String(),
      'gte': instance.gte?.toIso8601String(),
      'not': instance.not?.toJson(),
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

NestedStringWithAggregatesFilter _$NestedStringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedStringWithAggregatesFilter(
      equals: json['equals'] as String?,
      in$: (json['in'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
          : NestedStringWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedStringFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedStringFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedStringWithAggregatesFilterToJson(
        NestedStringWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not?.toJson(),
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

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
