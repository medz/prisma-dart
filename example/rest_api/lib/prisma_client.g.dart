// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWhereInput _$UserWhereInputFromJson(Map<String, dynamic> json) =>
    UserWhereInput(
      AND: json['AND'],
      OR: json['OR'],
      NOT: json['NOT'],
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserWhereInputToJson(UserWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.AND,
      'OR': instance.OR,
      'NOT': instance.NOT,
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserOrderByWithRelationInput _$UserOrderByWithRelationInputFromJson(
        Map<String, dynamic> json) =>
    UserOrderByWithRelationInput(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserOrderByWithRelationInputToJson(
        UserOrderByWithRelationInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserWhereUniqueInput _$UserWhereUniqueInputFromJson(
        Map<String, dynamic> json) =>
    UserWhereUniqueInput(
      id: json['id'],
      name: json['name'],
    );

Map<String, dynamic> _$UserWhereUniqueInputToJson(
        UserWhereUniqueInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

UserOrderByWithAggregationInput _$UserOrderByWithAggregationInputFromJson(
        Map<String, dynamic> json) =>
    UserOrderByWithAggregationInput(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      $count: json['_count'],
      $avg: json['_avg'],
      $max: json['_max'],
      $min: json['_min'],
      $sum: json['_sum'],
    );

Map<String, dynamic> _$UserOrderByWithAggregationInputToJson(
        UserOrderByWithAggregationInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '_count': instance.$count,
      '_avg': instance.$avg,
      '_max': instance.$max,
      '_min': instance.$min,
      '_sum': instance.$sum,
    };

UserScalarWhereWithAggregatesInput _$UserScalarWhereWithAggregatesInputFromJson(
        Map<String, dynamic> json) =>
    UserScalarWhereWithAggregatesInput(
      AND: json['AND'],
      OR: json['OR'],
      NOT: json['NOT'],
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserScalarWhereWithAggregatesInputToJson(
        UserScalarWhereWithAggregatesInput instance) =>
    <String, dynamic>{
      'AND': instance.AND,
      'OR': instance.OR,
      'NOT': instance.NOT,
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserCreateInput _$UserCreateInputFromJson(Map<String, dynamic> json) =>
    UserCreateInput(
      name: json['name'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserCreateInputToJson(UserCreateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserUncheckedCreateInput _$UserUncheckedCreateInputFromJson(
        Map<String, dynamic> json) =>
    UserUncheckedCreateInput(
      id: json['id'],
      name: json['name'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserUncheckedCreateInputToJson(
        UserUncheckedCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserUpdateInput _$UserUpdateInputFromJson(Map<String, dynamic> json) =>
    UserUpdateInput(
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserUpdateInputToJson(UserUpdateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserUncheckedUpdateInput _$UserUncheckedUpdateInputFromJson(
        Map<String, dynamic> json) =>
    UserUncheckedUpdateInput(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserUncheckedUpdateInputToJson(
        UserUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserUpdateManyMutationInput _$UserUpdateManyMutationInputFromJson(
        Map<String, dynamic> json) =>
    UserUpdateManyMutationInput(
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserUpdateManyMutationInputToJson(
        UserUpdateManyMutationInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserUncheckedUpdateManyInput _$UserUncheckedUpdateManyInputFromJson(
        Map<String, dynamic> json) =>
    UserUncheckedUpdateManyInput(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserUncheckedUpdateManyInputToJson(
        UserUncheckedUpdateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

IntFilter _$IntFilterFromJson(Map<String, dynamic> json) => IntFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
    );

Map<String, dynamic> _$IntFilterToJson(IntFilter instance) => <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

StringFilter _$StringFilterFromJson(Map<String, dynamic> json) => StringFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      contains: json['contains'],
      startsWith: json['startsWith'],
      endsWith: json['endsWith'],
      not: json['not'],
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
      'not': instance.not,
    };

DateTimeFilter _$DateTimeFilterFromJson(Map<String, dynamic> json) =>
    DateTimeFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
    );

Map<String, dynamic> _$DateTimeFilterToJson(DateTimeFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

UserCountOrderByAggregateInput _$UserCountOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    UserCountOrderByAggregateInput(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserCountOrderByAggregateInputToJson(
        UserCountOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserAvgOrderByAggregateInput _$UserAvgOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    UserAvgOrderByAggregateInput(
      id: json['id'],
    );

Map<String, dynamic> _$UserAvgOrderByAggregateInputToJson(
        UserAvgOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserMaxOrderByAggregateInput _$UserMaxOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    UserMaxOrderByAggregateInput(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserMaxOrderByAggregateInputToJson(
        UserMaxOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserMinOrderByAggregateInput _$UserMinOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    UserMinOrderByAggregateInput(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserMinOrderByAggregateInputToJson(
        UserMinOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserSumOrderByAggregateInput _$UserSumOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    UserSumOrderByAggregateInput(
      id: json['id'],
    );

Map<String, dynamic> _$UserSumOrderByAggregateInputToJson(
        UserSumOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

IntWithAggregatesFilter _$IntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    IntWithAggregatesFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
      $count: json['_count'],
      $avg: json['_avg'],
      $sum: json['_sum'],
      $min: json['_min'],
      $max: json['_max'],
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
      'not': instance.not,
      '_count': instance.$count,
      '_avg': instance.$avg,
      '_sum': instance.$sum,
      '_min': instance.$min,
      '_max': instance.$max,
    };

StringWithAggregatesFilter _$StringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    StringWithAggregatesFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      contains: json['contains'],
      startsWith: json['startsWith'],
      endsWith: json['endsWith'],
      not: json['not'],
      $count: json['_count'],
      $min: json['_min'],
      $max: json['_max'],
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
      'not': instance.not,
      '_count': instance.$count,
      '_min': instance.$min,
      '_max': instance.$max,
    };

DateTimeWithAggregatesFilter _$DateTimeWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    DateTimeWithAggregatesFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
      $count: json['_count'],
      $min: json['_min'],
      $max: json['_max'],
    );

Map<String, dynamic> _$DateTimeWithAggregatesFilterToJson(
        DateTimeWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      '_count': instance.$count,
      '_min': instance.$min,
      '_max': instance.$max,
    };

StringFieldUpdateOperationsInput _$StringFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    StringFieldUpdateOperationsInput(
      set$: json['set'],
    );

Map<String, dynamic> _$StringFieldUpdateOperationsInputToJson(
        StringFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$,
    };

DateTimeFieldUpdateOperationsInput _$DateTimeFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    DateTimeFieldUpdateOperationsInput(
      set$: json['set'],
    );

Map<String, dynamic> _$DateTimeFieldUpdateOperationsInputToJson(
        DateTimeFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$,
    };

IntFieldUpdateOperationsInput _$IntFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    IntFieldUpdateOperationsInput(
      set$: json['set'],
      increment: json['increment'],
      decrement: json['decrement'],
      multiply: json['multiply'],
      divide: json['divide'],
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
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
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
      'not': instance.not,
    };

NestedStringFilter _$NestedStringFilterFromJson(Map<String, dynamic> json) =>
    NestedStringFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      contains: json['contains'],
      startsWith: json['startsWith'],
      endsWith: json['endsWith'],
      not: json['not'],
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
      'not': instance.not,
    };

NestedDateTimeFilter _$NestedDateTimeFilterFromJson(
        Map<String, dynamic> json) =>
    NestedDateTimeFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
    );

Map<String, dynamic> _$NestedDateTimeFilterToJson(
        NestedDateTimeFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

NestedIntWithAggregatesFilter _$NestedIntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedIntWithAggregatesFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
      $count: json['_count'],
      $avg: json['_avg'],
      $sum: json['_sum'],
      $min: json['_min'],
      $max: json['_max'],
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
      'not': instance.not,
      '_count': instance.$count,
      '_avg': instance.$avg,
      '_sum': instance.$sum,
      '_min': instance.$min,
      '_max': instance.$max,
    };

NestedFloatFilter _$NestedFloatFilterFromJson(Map<String, dynamic> json) =>
    NestedFloatFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
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
      'not': instance.not,
    };

NestedStringWithAggregatesFilter _$NestedStringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedStringWithAggregatesFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      contains: json['contains'],
      startsWith: json['startsWith'],
      endsWith: json['endsWith'],
      not: json['not'],
      $count: json['_count'],
      $min: json['_min'],
      $max: json['_max'],
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
      'not': instance.not,
      '_count': instance.$count,
      '_min': instance.$min,
      '_max': instance.$max,
    };

NestedDateTimeWithAggregatesFilter _$NestedDateTimeWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedDateTimeWithAggregatesFilter(
      equals: json['equals'],
      in$: json['in'],
      notIn: json['notIn'],
      lt: json['lt'],
      lte: json['lte'],
      gt: json['gt'],
      gte: json['gte'],
      not: json['not'],
      $count: json['_count'],
      $min: json['_min'],
      $max: json['_max'],
    );

Map<String, dynamic> _$NestedDateTimeWithAggregatesFilterToJson(
        NestedDateTimeWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      '_count': instance.$count,
      '_min': instance.$min,
      '_max': instance.$max,
    };

AggregateUser _$AggregateUserFromJson(Map<String, dynamic> json) =>
    AggregateUser(
      $count: json['_count'],
      $avg: json['_avg'],
      $sum: json['_sum'],
      $min: json['_min'],
      $max: json['_max'],
    );

Map<String, dynamic> _$AggregateUserToJson(AggregateUser instance) =>
    <String, dynamic>{
      '_count': instance.$count,
      '_avg': instance.$avg,
      '_sum': instance.$sum,
      '_min': instance.$min,
      '_max': instance.$max,
    };

UserGroupByOutputType _$UserGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserGroupByOutputType(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      $count: json['_count'],
      $avg: json['_avg'],
      $sum: json['_sum'],
      $min: json['_min'],
      $max: json['_max'],
    );

Map<String, dynamic> _$UserGroupByOutputTypeToJson(
        UserGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '_count': instance.$count,
      '_avg': instance.$avg,
      '_sum': instance.$sum,
      '_min': instance.$min,
      '_max': instance.$max,
    };

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int,
    );

Map<String, dynamic> _$AffectedRowsOutputToJson(AffectedRowsOutput instance) =>
    <String, dynamic>{
      'count': instance.count,
    };

UserCountAggregateOutputType _$UserCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserCountAggregateOutputType(
      id: json['id'] as int,
      name: json['name'] as int,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
      $all: json['_all'] as int,
    );

Map<String, dynamic> _$UserCountAggregateOutputTypeToJson(
        UserCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '_all': instance.$all,
    };

UserAvgAggregateOutputType _$UserAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserAvgAggregateOutputType(
      id: json['id'],
    );

Map<String, dynamic> _$UserAvgAggregateOutputTypeToJson(
        UserAvgAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserSumAggregateOutputType _$UserSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserSumAggregateOutputType(
      id: json['id'],
    );

Map<String, dynamic> _$UserSumAggregateOutputTypeToJson(
        UserSumAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserMinAggregateOutputType _$UserMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMinAggregateOutputType(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserMinAggregateOutputTypeToJson(
        UserMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserMaxAggregateOutputType _$UserMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMaxAggregateOutputType(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserMaxAggregateOutputTypeToJson(
        UserMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
