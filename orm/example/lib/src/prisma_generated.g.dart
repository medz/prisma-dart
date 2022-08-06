// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisma_generated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UserWhereInputToJson(UserWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.AND?.map((e) => e.toJson()).toList(),
      'OR': instance.OR?.map((e) => e.toJson()).toList(),
      'NOT': instance.NOT?.map((e) => e.toJson()).toList(),
      'id': instance.id?.toJson(),
      'userName': instance.userName?.toJson(),
      'name': instance.name?.toJson(),
      'password': instance.password?.toJson(),
      'resturantId': instance.resturantId?.toJson(),
    };

Map<String, dynamic> _$UserOrderByWithRelationInputToJson(
        UserOrderByWithRelationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userName': _$SortOrderEnumMap[instance.userName],
      'name': _$SortOrderEnumMap[instance.name],
      'password': _$SortOrderEnumMap[instance.password],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
    };

const _$SortOrderEnumMap = {
  SortOrder.asc: 'asc',
  SortOrder.desc: 'desc',
};

Map<String, dynamic> _$UserWhereUniqueInputToJson(
        UserWhereUniqueInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
    };

Map<String, dynamic> _$UserOrderByWithAggregationInputToJson(
        UserOrderByWithAggregationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userName': _$SortOrderEnumMap[instance.userName],
      'name': _$SortOrderEnumMap[instance.name],
      'password': _$SortOrderEnumMap[instance.password],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
      r'$count': instance.$count?.toJson(),
      r'$avg': instance.$avg?.toJson(),
      r'$max': instance.$max?.toJson(),
      r'$min': instance.$min?.toJson(),
      r'$sum': instance.$sum?.toJson(),
    };

Map<String, dynamic> _$UserScalarWhereWithAggregatesInputToJson(
        UserScalarWhereWithAggregatesInput instance) =>
    <String, dynamic>{
      'AND': instance.AND?.map((e) => e.toJson()).toList(),
      'OR': instance.OR?.map((e) => e.toJson()).toList(),
      'NOT': instance.NOT?.map((e) => e.toJson()).toList(),
      'id': instance.id?.toJson(),
      'userName': instance.userName?.toJson(),
      'name': instance.name?.toJson(),
      'password': instance.password?.toJson(),
      'resturantId': instance.resturantId?.toJson(),
    };

Map<String, dynamic> _$UserCreateInputToJson(UserCreateInput instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
    };

Map<String, dynamic> _$UserUncheckedCreateInputToJson(
        UserUncheckedCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
    };

Map<String, dynamic> _$UserUpdateInputToJson(UserUpdateInput instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
    };

Map<String, dynamic> _$UserUncheckedUpdateInputToJson(
        UserUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
    };

Map<String, dynamic> _$UserCreateManyInputToJson(
        UserCreateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
    };

Map<String, dynamic> _$UserUpdateManyMutationInputToJson(
        UserUpdateManyMutationInput instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
    };

Map<String, dynamic> _$UserUncheckedUpdateManyInputToJson(
        UserUncheckedUpdateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
    };

Map<String, dynamic> _$IntFilterToJson(IntFilter instance) => <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

Map<String, dynamic> _$StringFilterToJson(StringFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'mode': _$QueryModeEnumMap[instance.mode],
      'not': instance.not,
    };

const _$QueryModeEnumMap = {
  QueryMode.default$: r'default$',
  QueryMode.insensitive: 'insensitive',
};

Map<String, dynamic> _$IntNullableFilterToJson(IntNullableFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

Map<String, dynamic> _$UserCountOrderByAggregateInputToJson(
        UserCountOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userName': _$SortOrderEnumMap[instance.userName],
      'name': _$SortOrderEnumMap[instance.name],
      'password': _$SortOrderEnumMap[instance.password],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
    };

Map<String, dynamic> _$UserAvgOrderByAggregateInputToJson(
        UserAvgOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
    };

Map<String, dynamic> _$UserMaxOrderByAggregateInputToJson(
        UserMaxOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userName': _$SortOrderEnumMap[instance.userName],
      'name': _$SortOrderEnumMap[instance.name],
      'password': _$SortOrderEnumMap[instance.password],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
    };

Map<String, dynamic> _$UserMinOrderByAggregateInputToJson(
        UserMinOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userName': _$SortOrderEnumMap[instance.userName],
      'name': _$SortOrderEnumMap[instance.name],
      'password': _$SortOrderEnumMap[instance.password],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
    };

Map<String, dynamic> _$UserSumOrderByAggregateInputToJson(
        UserSumOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
    };

Map<String, dynamic> _$IntWithAggregatesFilterToJson(
        IntWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      r'$count': instance.$count?.toJson(),
      r'$avg': instance.$avg?.toJson(),
      r'$sum': instance.$sum?.toJson(),
      r'$min': instance.$min?.toJson(),
      r'$max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$StringWithAggregatesFilterToJson(
        StringWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'mode': _$QueryModeEnumMap[instance.mode],
      'not': instance.not,
      r'$count': instance.$count?.toJson(),
      r'$min': instance.$min?.toJson(),
      r'$max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$IntNullableWithAggregatesFilterToJson(
        IntNullableWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      r'$count': instance.$count?.toJson(),
      r'$avg': instance.$avg?.toJson(),
      r'$sum': instance.$sum?.toJson(),
      r'$min': instance.$min?.toJson(),
      r'$max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$StringFieldUpdateOperationsInputToJson(
        StringFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set,
    };

Map<String, dynamic> _$NullableIntFieldUpdateOperationsInputToJson(
        NullableIntFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set,
      'increment': instance.increment,
      'decrement': instance.decrement,
      'multiply': instance.multiply,
      'divide': instance.divide,
    };

Map<String, dynamic> _$IntFieldUpdateOperationsInputToJson(
        IntFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set,
      'increment': instance.increment,
      'decrement': instance.decrement,
      'multiply': instance.multiply,
      'divide': instance.divide,
    };

Map<String, dynamic> _$NestedIntFilterToJson(NestedIntFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

Map<String, dynamic> _$NestedStringFilterToJson(NestedStringFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
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

Map<String, dynamic> _$NestedIntNullableFilterToJson(
        NestedIntNullableFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

Map<String, dynamic> _$NestedIntWithAggregatesFilterToJson(
        NestedIntWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      r'$count': instance.$count?.toJson(),
      r'$avg': instance.$avg?.toJson(),
      r'$sum': instance.$sum?.toJson(),
      r'$min': instance.$min?.toJson(),
      r'$max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$NestedFloatFilterToJson(NestedFloatFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

Map<String, dynamic> _$NestedStringWithAggregatesFilterToJson(
        NestedStringWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'contains': instance.contains,
      'startsWith': instance.startsWith,
      'endsWith': instance.endsWith,
      'not': instance.not,
      r'$count': instance.$count?.toJson(),
      r'$min': instance.$min?.toJson(),
      r'$max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$NestedIntNullableWithAggregatesFilterToJson(
        NestedIntNullableWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      r'$count': instance.$count?.toJson(),
      r'$avg': instance.$avg?.toJson(),
      r'$sum': instance.$sum?.toJson(),
      r'$min': instance.$min?.toJson(),
      r'$max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$NestedFloatNullableFilterToJson(
        NestedFloatNullableFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      r'in$': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };
