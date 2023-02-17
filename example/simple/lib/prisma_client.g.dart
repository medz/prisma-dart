// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaySomethingWhereInput _$SaySomethingWhereInputFromJson(
        Map<String, dynamic> json) =>
    SaySomethingWhereInput(
      AND: (json['AND'] as List<dynamic>?)?.map(
          (e) => SaySomethingWhereInput.fromJson(e as Map<String, dynamic>)),
      OR: (json['OR'] as List<dynamic>?)?.map(
          (e) => SaySomethingWhereInput.fromJson(e as Map<String, dynamic>)),
      NOT: (json['NOT'] as List<dynamic>?)?.map(
          (e) => SaySomethingWhereInput.fromJson(e as Map<String, dynamic>)),
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
    SaySomethingWhereInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id?.toJson());
  writeNotNull('createdAt', instance.createdAt?.toJson());
  writeNotNull('updatedAt', instance.updatedAt?.toJson());
  writeNotNull('text', instance.text?.toJson());
  return val;
}

SaySomethingOrderByWithRelationInput
    _$SaySomethingOrderByWithRelationInputFromJson(Map<String, dynamic> json) =>
        SaySomethingOrderByWithRelationInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$SaySomethingOrderByWithRelationInputToJson(
    SaySomethingOrderByWithRelationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('createdAt', _$SortOrderEnumMap[instance.createdAt]);
  writeNotNull('updatedAt', _$SortOrderEnumMap[instance.updatedAt]);
  writeNotNull('text', _$SortOrderEnumMap[instance.text]);
  return val;
}

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
    SaySomethingWhereUniqueInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}

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
    SaySomethingOrderByWithAggregationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('createdAt', _$SortOrderEnumMap[instance.createdAt]);
  writeNotNull('updatedAt', _$SortOrderEnumMap[instance.updatedAt]);
  writeNotNull('text', _$SortOrderEnumMap[instance.text]);
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  return val;
}

SaySomethingScalarWhereWithAggregatesInput
    _$SaySomethingScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        SaySomethingScalarWhereWithAggregatesInput(
          AND: (json['AND'] as List<dynamic>?)?.map((e) =>
              SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          OR: (json['OR'] as List<dynamic>?)?.map((e) =>
              SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          NOT: (json['NOT'] as List<dynamic>?)?.map((e) =>
              SaySomethingScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
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
    SaySomethingScalarWhereWithAggregatesInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id?.toJson());
  writeNotNull('createdAt', instance.createdAt?.toJson());
  writeNotNull('updatedAt', instance.updatedAt?.toJson());
  writeNotNull('text', instance.text?.toJson());
  return val;
}

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
    SaySomethingCreateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  val['text'] = instance.text;
  return val;
}

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
    SaySomethingUncheckedCreateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  val['text'] = instance.text;
  return val;
}

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
    SaySomethingUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt?.toJson());
  writeNotNull('updatedAt', instance.updatedAt?.toJson());
  writeNotNull('text', instance.text?.toJson());
  return val;
}

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
    SaySomethingUncheckedUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id?.toJson());
  writeNotNull('createdAt', instance.createdAt?.toJson());
  writeNotNull('updatedAt', instance.updatedAt?.toJson());
  writeNotNull('text', instance.text?.toJson());
  return val;
}

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
    SaySomethingUpdateManyMutationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt?.toJson());
  writeNotNull('updatedAt', instance.updatedAt?.toJson());
  writeNotNull('text', instance.text?.toJson());
  return val;
}

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
    SaySomethingUncheckedUpdateManyInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id?.toJson());
  writeNotNull('createdAt', instance.createdAt?.toJson());
  writeNotNull('updatedAt', instance.updatedAt?.toJson());
  writeNotNull('text', instance.text?.toJson());
  return val;
}

IntFilter _$IntFilterFromJson(Map<String, dynamic> json) => IntFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntFilterToJson(IntFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

DateTimeFilter _$DateTimeFilterFromJson(Map<String, dynamic> json) =>
    DateTimeFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      $in: (json['in'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
      lt: json['lt'] == null ? null : DateTime.parse(json['lt'] as String),
      lte: json['lte'] == null ? null : DateTime.parse(json['lte'] as String),
      gt: json['gt'] == null ? null : DateTime.parse(json['gt'] as String),
      gte: json['gte'] == null ? null : DateTime.parse(json['gte'] as String),
      not: json['not'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DateTimeFilterToJson(DateTimeFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals?.toIso8601String());
  writeNotNull('in', instance.$in?.map((e) => e.toIso8601String()).toList());
  writeNotNull(
      'notIn', instance.notIn?.map((e) => e.toIso8601String()).toList());
  writeNotNull('lt', instance.lt?.toIso8601String());
  writeNotNull('lte', instance.lte?.toIso8601String());
  writeNotNull('gt', instance.gt?.toIso8601String());
  writeNotNull('gte', instance.gte?.toIso8601String());
  writeNotNull('not', instance.not?.toJson());
  return val;
}

StringFilter _$StringFilterFromJson(Map<String, dynamic> json) => StringFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
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

Map<String, dynamic> _$StringFilterToJson(StringFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

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
    SaySomethingCountOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('createdAt', _$SortOrderEnumMap[instance.createdAt]);
  writeNotNull('updatedAt', _$SortOrderEnumMap[instance.updatedAt]);
  writeNotNull('text', _$SortOrderEnumMap[instance.text]);
  return val;
}

SaySomethingAvgOrderByAggregateInput
    _$SaySomethingAvgOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingAvgOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
        );

Map<String, dynamic> _$SaySomethingAvgOrderByAggregateInputToJson(
    SaySomethingAvgOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  return val;
}

SaySomethingMaxOrderByAggregateInput
    _$SaySomethingMaxOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingMaxOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$SaySomethingMaxOrderByAggregateInputToJson(
    SaySomethingMaxOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('createdAt', _$SortOrderEnumMap[instance.createdAt]);
  writeNotNull('updatedAt', _$SortOrderEnumMap[instance.updatedAt]);
  writeNotNull('text', _$SortOrderEnumMap[instance.text]);
  return val;
}

SaySomethingMinOrderByAggregateInput
    _$SaySomethingMinOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingMinOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
          updatedAt: $enumDecodeNullable(_$SortOrderEnumMap, json['updatedAt']),
          text: $enumDecodeNullable(_$SortOrderEnumMap, json['text']),
        );

Map<String, dynamic> _$SaySomethingMinOrderByAggregateInputToJson(
    SaySomethingMinOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('createdAt', _$SortOrderEnumMap[instance.createdAt]);
  writeNotNull('updatedAt', _$SortOrderEnumMap[instance.updatedAt]);
  writeNotNull('text', _$SortOrderEnumMap[instance.text]);
  return val;
}

SaySomethingSumOrderByAggregateInput
    _$SaySomethingSumOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        SaySomethingSumOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
        );

Map<String, dynamic> _$SaySomethingSumOrderByAggregateInputToJson(
    SaySomethingSumOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  return val;
}

IntWithAggregatesFilter _$IntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    IntWithAggregatesFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
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
    IntWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

DateTimeWithAggregatesFilter _$DateTimeWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    DateTimeWithAggregatesFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      $in: (json['in'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
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
    DateTimeWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals?.toIso8601String());
  writeNotNull('in', instance.$in?.map((e) => e.toIso8601String()).toList());
  writeNotNull(
      'notIn', instance.notIn?.map((e) => e.toIso8601String()).toList());
  writeNotNull('lt', instance.lt?.toIso8601String());
  writeNotNull('lte', instance.lte?.toIso8601String());
  writeNotNull('gt', instance.gt?.toIso8601String());
  writeNotNull('gte', instance.gte?.toIso8601String());
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

StringWithAggregatesFilter _$StringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    StringWithAggregatesFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
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
    StringWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

DateTimeFieldUpdateOperationsInput _$DateTimeFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    DateTimeFieldUpdateOperationsInput(
      set: json['set'] == null ? null : DateTime.parse(json['set'] as String),
    );

Map<String, dynamic> _$DateTimeFieldUpdateOperationsInputToJson(
    DateTimeFieldUpdateOperationsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set?.toIso8601String());
  return val;
}

StringFieldUpdateOperationsInput _$StringFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    StringFieldUpdateOperationsInput(
      set: json['set'] as String?,
    );

Map<String, dynamic> _$StringFieldUpdateOperationsInputToJson(
    StringFieldUpdateOperationsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set);
  return val;
}

IntFieldUpdateOperationsInput _$IntFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    IntFieldUpdateOperationsInput(
      set: json['set'] as int?,
      increment: json['increment'] as int?,
      decrement: json['decrement'] as int?,
      multiply: json['multiply'] as int?,
      divide: json['divide'] as int?,
    );

Map<String, dynamic> _$IntFieldUpdateOperationsInputToJson(
    IntFieldUpdateOperationsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set);
  writeNotNull('increment', instance.increment);
  writeNotNull('decrement', instance.decrement);
  writeNotNull('multiply', instance.multiply);
  writeNotNull('divide', instance.divide);
  return val;
}

NestedIntFilter _$NestedIntFilterFromJson(Map<String, dynamic> json) =>
    NestedIntFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedIntFilterToJson(NestedIntFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedDateTimeFilter _$NestedDateTimeFilterFromJson(
        Map<String, dynamic> json) =>
    NestedDateTimeFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      $in: (json['in'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
      lt: json['lt'] == null ? null : DateTime.parse(json['lt'] as String),
      lte: json['lte'] == null ? null : DateTime.parse(json['lte'] as String),
      gt: json['gt'] == null ? null : DateTime.parse(json['gt'] as String),
      gte: json['gte'] == null ? null : DateTime.parse(json['gte'] as String),
      not: json['not'] == null
          ? null
          : NestedDateTimeFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedDateTimeFilterToJson(
    NestedDateTimeFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals?.toIso8601String());
  writeNotNull('in', instance.$in?.map((e) => e.toIso8601String()).toList());
  writeNotNull(
      'notIn', instance.notIn?.map((e) => e.toIso8601String()).toList());
  writeNotNull('lt', instance.lt?.toIso8601String());
  writeNotNull('lte', instance.lte?.toIso8601String());
  writeNotNull('gt', instance.gt?.toIso8601String());
  writeNotNull('gte', instance.gte?.toIso8601String());
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedStringFilter _$NestedStringFilterFromJson(Map<String, dynamic> json) =>
    NestedStringFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
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

Map<String, dynamic> _$NestedStringFilterToJson(NestedStringFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedIntWithAggregatesFilter _$NestedIntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedIntWithAggregatesFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
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
    NestedIntWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

NestedFloatFilter _$NestedFloatFilterFromJson(Map<String, dynamic> json) =>
    NestedFloatFilter(
      equals: (json['equals'] as num?)?.toDouble(),
      $in: (json['in'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      lt: (json['lt'] as num?)?.toDouble(),
      lte: (json['lte'] as num?)?.toDouble(),
      gt: (json['gt'] as num?)?.toDouble(),
      gte: (json['gte'] as num?)?.toDouble(),
      not: json['not'] == null
          ? null
          : NestedFloatFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedFloatFilterToJson(NestedFloatFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedDateTimeWithAggregatesFilter _$NestedDateTimeWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedDateTimeWithAggregatesFilter(
      equals: json['equals'] == null
          ? null
          : DateTime.parse(json['equals'] as String),
      $in: (json['in'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
      notIn: (json['notIn'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String)),
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
    NestedDateTimeWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals?.toIso8601String());
  writeNotNull('in', instance.$in?.map((e) => e.toIso8601String()).toList());
  writeNotNull(
      'notIn', instance.notIn?.map((e) => e.toIso8601String()).toList());
  writeNotNull('lt', instance.lt?.toIso8601String());
  writeNotNull('lte', instance.lte?.toIso8601String());
  writeNotNull('gt', instance.gt?.toIso8601String());
  writeNotNull('gte', instance.gte?.toIso8601String());
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

NestedStringWithAggregatesFilter _$NestedStringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedStringWithAggregatesFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
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
    NestedStringWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

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

SaySomethingGroupByOutputType _$SaySomethingGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    SaySomethingGroupByOutputType(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$SaySomethingGroupByOutputTypeToJson(
    SaySomethingGroupByOutputType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('text', instance.text);
  return val;
}

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int?,
    );

Map<String, dynamic> _$AffectedRowsOutputToJson(AffectedRowsOutput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  return val;
}

Map<String, dynamic> _$DatasourcesToJson(Datasources instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('db', instance.db);
  return val;
}
