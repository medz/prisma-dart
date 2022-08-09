// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisma_generated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UserWhereInputToJson(UserWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.aND?.map((e) => e.toJson()).toList(),
      'OR': instance.oR?.map((e) => e.toJson()).toList(),
      'NOT': instance.nOT?.map((e) => e.toJson()).toList(),
      'id': instance.id?.toJson(),
      'userName': instance.userName?.toJson(),
      'name': instance.name?.toJson(),
      'password': instance.password?.toJson(),
      'resturantId': instance.resturantId?.toJson(),
      'Post': instance.post?.toJson(),
      'extra': instance.extra?.toJson(),
    };

Map<String, dynamic> _$UserOrderByWithRelationInputToJson(
        UserOrderByWithRelationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userName': _$SortOrderEnumMap[instance.userName],
      'name': _$SortOrderEnumMap[instance.name],
      'password': _$SortOrderEnumMap[instance.password],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
      'Post': instance.post?.toJson(),
      'extra': _$SortOrderEnumMap[instance.extra],
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
      'extra': _$SortOrderEnumMap[instance.extra],
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_max': instance.$max?.toJson(),
      '_min': instance.$min?.toJson(),
      '_sum': instance.$sum?.toJson(),
    };

Map<String, dynamic> _$UserScalarWhereWithAggregatesInputToJson(
        UserScalarWhereWithAggregatesInput instance) =>
    <String, dynamic>{
      'AND': instance.aND?.map((e) => e.toJson()).toList(),
      'OR': instance.oR?.map((e) => e.toJson()).toList(),
      'NOT': instance.nOT?.map((e) => e.toJson()).toList(),
      'id': instance.id?.toJson(),
      'userName': instance.userName?.toJson(),
      'name': instance.name?.toJson(),
      'password': instance.password?.toJson(),
      'resturantId': instance.resturantId?.toJson(),
      'extra': instance.extra?.toJson(),
    };

Map<String, dynamic> _$PostWhereInputToJson(PostWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.aND?.map((e) => e.toJson()).toList(),
      'OR': instance.oR?.map((e) => e.toJson()).toList(),
      'NOT': instance.nOT?.map((e) => e.toJson()).toList(),
      'id': instance.id?.toJson(),
      'name': instance.name?.toJson(),
      'desc': instance.desc?.toJson(),
      'userId': instance.userId?.toJson(),
      'user': instance.user?.toJson(),
    };

Map<String, dynamic> _$PostOrderByWithRelationInputToJson(
        PostOrderByWithRelationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'desc': _$SortOrderEnumMap[instance.desc],
      'userId': _$SortOrderEnumMap[instance.userId],
      'user': instance.user?.toJson(),
    };

Map<String, dynamic> _$PostWhereUniqueInputToJson(
        PostWhereUniqueInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Map<String, dynamic> _$PostOrderByWithAggregationInputToJson(
        PostOrderByWithAggregationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'desc': _$SortOrderEnumMap[instance.desc],
      'userId': _$SortOrderEnumMap[instance.userId],
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_max': instance.$max?.toJson(),
      '_min': instance.$min?.toJson(),
      '_sum': instance.$sum?.toJson(),
    };

Map<String, dynamic> _$PostScalarWhereWithAggregatesInputToJson(
        PostScalarWhereWithAggregatesInput instance) =>
    <String, dynamic>{
      'AND': instance.aND?.map((e) => e.toJson()).toList(),
      'OR': instance.oR?.map((e) => e.toJson()).toList(),
      'NOT': instance.nOT?.map((e) => e.toJson()).toList(),
      'id': instance.id?.toJson(),
      'name': instance.name?.toJson(),
      'desc': instance.desc?.toJson(),
      'userId': instance.userId?.toJson(),
    };

Map<String, dynamic> _$UserUpdateInputToJson(UserUpdateInput instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
      'Post': instance.post?.toJson(),
      'extra': _$JsonNullValueInputEnumMap[instance.extra],
    };

const _$JsonNullValueInputEnumMap = {
  JsonNullValueInput.jsonNull: 'jsonNull',
};

Map<String, dynamic> _$UserUncheckedUpdateInputToJson(
        UserUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
      'Post': instance.post?.toJson(),
      'extra': _$JsonNullValueInputEnumMap[instance.extra],
    };

Map<String, dynamic> _$UserUpdateManyMutationInputToJson(
        UserUpdateManyMutationInput instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
      'extra': _$JsonNullValueInputEnumMap[instance.extra],
    };

Map<String, dynamic> _$UserUncheckedUpdateManyInputToJson(
        UserUncheckedUpdateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
      'extra': _$JsonNullValueInputEnumMap[instance.extra],
    };

Map<String, dynamic> _$PostCreateInputToJson(PostCreateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
      'user': instance.user.toJson(),
    };

Map<String, dynamic> _$PostUncheckedCreateInputToJson(
        PostUncheckedCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'userId': instance.userId,
    };

Map<String, dynamic> _$PostUpdateInputToJson(PostUpdateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
      'user': instance.user?.toJson(),
    };

Map<String, dynamic> _$PostUncheckedUpdateInputToJson(
        PostUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'userId': instance.userId,
    };

Map<String, dynamic> _$PostCreateManyInputToJson(
        PostCreateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'userId': instance.userId,
    };

Map<String, dynamic> _$PostUpdateManyMutationInputToJson(
        PostUpdateManyMutationInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
    };

Map<String, dynamic> _$PostUncheckedUpdateManyInputToJson(
        PostUncheckedUpdateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'userId': instance.userId,
    };

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
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
    };

Map<String, dynamic> _$PostListRelationFilterToJson(
        PostListRelationFilter instance) =>
    <String, dynamic>{
      'every': instance.every?.toJson(),
      'some': instance.some?.toJson(),
      'none': instance.none?.toJson(),
    };

Map<String, dynamic> _$JsonFilterToJson(JsonFilter instance) =>
    <String, dynamic>{
      'equals': _$JsonNullValueFilterEnumMap[instance.equals],
      'path': instance.path,
      'string_contains': instance.string_contains,
      'string_starts_with': instance.string_starts_with,
      'string_ends_with': instance.string_ends_with,
      'array_contains': instance.array_contains,
      'array_starts_with': instance.array_starts_with,
      'array_ends_with': instance.array_ends_with,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': _$JsonNullValueFilterEnumMap[instance.not],
    };

const _$JsonNullValueFilterEnumMap = {
  JsonNullValueFilter.dbNull: 'dbNull',
  JsonNullValueFilter.jsonNull: 'jsonNull',
  JsonNullValueFilter.anyNull: 'anyNull',
};

Map<String, dynamic> _$PostOrderByRelationAggregateInputToJson(
        PostOrderByRelationAggregateInput instance) =>
    <String, dynamic>{
      '_count': _$SortOrderEnumMap[instance.$count],
    };

Map<String, dynamic> _$UserCountOrderByAggregateInputToJson(
        UserCountOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userName': _$SortOrderEnumMap[instance.userName],
      'name': _$SortOrderEnumMap[instance.name],
      'password': _$SortOrderEnumMap[instance.password],
      'resturantId': _$SortOrderEnumMap[instance.resturantId],
      'extra': _$SortOrderEnumMap[instance.extra],
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
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

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
      'mode': _$QueryModeEnumMap[instance.mode],
      'not': instance.not,
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$IntNullableWithAggregatesFilterToJson(
        IntNullableWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$JsonWithAggregatesFilterToJson(
        JsonWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': _$JsonNullValueFilterEnumMap[instance.equals],
      'path': instance.path,
      'string_contains': instance.string_contains,
      'string_starts_with': instance.string_starts_with,
      'string_ends_with': instance.string_ends_with,
      'array_contains': instance.array_contains,
      'array_starts_with': instance.array_starts_with,
      'array_ends_with': instance.array_ends_with,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': _$JsonNullValueFilterEnumMap[instance.not],
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$UserRelationFilterToJson(UserRelationFilter instance) =>
    <String, dynamic>{
      'is': instance.is$?.toJson(),
      'isNot': instance.isNot?.toJson(),
    };

Map<String, dynamic> _$PostCountOrderByAggregateInputToJson(
        PostCountOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'desc': _$SortOrderEnumMap[instance.desc],
      'userId': _$SortOrderEnumMap[instance.userId],
    };

Map<String, dynamic> _$PostAvgOrderByAggregateInputToJson(
        PostAvgOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userId': _$SortOrderEnumMap[instance.userId],
    };

Map<String, dynamic> _$PostMaxOrderByAggregateInputToJson(
        PostMaxOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'desc': _$SortOrderEnumMap[instance.desc],
      'userId': _$SortOrderEnumMap[instance.userId],
    };

Map<String, dynamic> _$PostMinOrderByAggregateInputToJson(
        PostMinOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'desc': _$SortOrderEnumMap[instance.desc],
      'userId': _$SortOrderEnumMap[instance.userId],
    };

Map<String, dynamic> _$PostSumOrderByAggregateInputToJson(
        PostSumOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'userId': _$SortOrderEnumMap[instance.userId],
    };

Map<String, dynamic> _$StringFieldUpdateOperationsInputToJson(
        StringFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$,
    };

Map<String, dynamic> _$NullableIntFieldUpdateOperationsInputToJson(
        NullableIntFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$,
      'increment': instance.increment,
      'decrement': instance.decrement,
      'multiply': instance.multiply,
      'divide': instance.divide,
    };

Map<String, dynamic> _$PostUpdateManyWithoutUserNestedInputToJson(
        PostUpdateManyWithoutUserNestedInput instance) =>
    <String, dynamic>{
      'create': instance.create?.map((e) => e.toJson()).toList(),
      'connectOrCreate':
          instance.connectOrCreate?.map((e) => e.toJson()).toList(),
      'upsert': instance.upsert?.map((e) => e.toJson()).toList(),
      'createMany': instance.createMany?.toJson(),
      'set': instance.set$?.map((e) => e.toJson()).toList(),
      'disconnect': instance.disconnect?.map((e) => e.toJson()).toList(),
      'delete': instance.delete?.map((e) => e.toJson()).toList(),
      'connect': instance.connect?.map((e) => e.toJson()).toList(),
      'update': instance.update?.map((e) => e.toJson()).toList(),
      'updateMany': instance.updateMany?.map((e) => e.toJson()).toList(),
      'deleteMany': instance.deleteMany?.map((e) => e.toJson()).toList(),
    };

Map<String, dynamic> _$IntFieldUpdateOperationsInputToJson(
        IntFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'set': instance.set$,
      'increment': instance.increment,
      'decrement': instance.decrement,
      'multiply': instance.multiply,
      'divide': instance.divide,
    };

Map<String, dynamic> _$PostUncheckedUpdateManyWithoutUserNestedInputToJson(
        PostUncheckedUpdateManyWithoutUserNestedInput instance) =>
    <String, dynamic>{
      'create': instance.create?.map((e) => e.toJson()).toList(),
      'connectOrCreate':
          instance.connectOrCreate?.map((e) => e.toJson()).toList(),
      'upsert': instance.upsert?.map((e) => e.toJson()).toList(),
      'createMany': instance.createMany?.toJson(),
      'set': instance.set$?.map((e) => e.toJson()).toList(),
      'disconnect': instance.disconnect?.map((e) => e.toJson()).toList(),
      'delete': instance.delete?.map((e) => e.toJson()).toList(),
      'connect': instance.connect?.map((e) => e.toJson()).toList(),
      'update': instance.update?.map((e) => e.toJson()).toList(),
      'updateMany': instance.updateMany?.map((e) => e.toJson()).toList(),
      'deleteMany': instance.deleteMany?.map((e) => e.toJson()).toList(),
    };

Map<String, dynamic> _$UserCreateNestedOneWithoutPostInputToJson(
        UserCreateNestedOneWithoutPostInput instance) =>
    <String, dynamic>{
      'connect': instance.connect?.toJson(),
    };

Map<String, dynamic> _$UserUpdateOneRequiredWithoutPostNestedInputToJson(
        UserUpdateOneRequiredWithoutPostNestedInput instance) =>
    <String, dynamic>{
      'connect': instance.connect?.toJson(),
      'update': instance.update?.toJson(),
    };

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

Map<String, dynamic> _$NestedIntNullableFilterToJson(
        NestedIntNullableFilter instance) =>
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
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

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
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$NestedIntNullableWithAggregatesFilterToJson(
        NestedIntNullableWithAggregatesFilter instance) =>
    <String, dynamic>{
      'equals': instance.equals,
      'in': instance.in$,
      'notIn': instance.notIn,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': instance.not,
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

Map<String, dynamic> _$NestedFloatNullableFilterToJson(
        NestedFloatNullableFilter instance) =>
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

Map<String, dynamic> _$NestedJsonFilterToJson(NestedJsonFilter instance) =>
    <String, dynamic>{
      'equals': _$JsonNullValueFilterEnumMap[instance.equals],
      'path': instance.path,
      'string_contains': instance.string_contains,
      'string_starts_with': instance.string_starts_with,
      'string_ends_with': instance.string_ends_with,
      'array_contains': instance.array_contains,
      'array_starts_with': instance.array_starts_with,
      'array_ends_with': instance.array_ends_with,
      'lt': instance.lt,
      'lte': instance.lte,
      'gt': instance.gt,
      'gte': instance.gte,
      'not': _$JsonNullValueFilterEnumMap[instance.not],
    };

Map<String, dynamic> _$PostCreateWithoutUserInputToJson(
        PostCreateWithoutUserInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
    };

Map<String, dynamic> _$PostUncheckedCreateWithoutUserInputToJson(
        PostUncheckedCreateWithoutUserInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
    };

Map<String, dynamic> _$PostCreateOrConnectWithoutUserInputToJson(
        PostCreateOrConnectWithoutUserInput instance) =>
    <String, dynamic>{
      'where': instance.where.toJson(),
      'create': instance.create.toJson(),
    };

Map<String, dynamic> _$PostUpsertWithWhereUniqueWithoutUserInputToJson(
        PostUpsertWithWhereUniqueWithoutUserInput instance) =>
    <String, dynamic>{
      'where': instance.where.toJson(),
      'update': instance.update.toJson(),
      'create': instance.create.toJson(),
    };

Map<String, dynamic> _$PostCreateManyUserInputEnvelopeToJson(
        PostCreateManyUserInputEnvelope instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'skipDuplicates': instance.skipDuplicates,
    };

Map<String, dynamic> _$PostUpdateWithWhereUniqueWithoutUserInputToJson(
        PostUpdateWithWhereUniqueWithoutUserInput instance) =>
    <String, dynamic>{
      'where': instance.where.toJson(),
      'data': instance.data.toJson(),
    };

Map<String, dynamic> _$PostUpdateManyWithWhereWithoutUserInputToJson(
        PostUpdateManyWithWhereWithoutUserInput instance) =>
    <String, dynamic>{
      'where': instance.where.toJson(),
      'data': instance.data.toJson(),
    };

Map<String, dynamic> _$PostScalarWhereInputToJson(
        PostScalarWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.aND?.map((e) => e.toJson()).toList(),
      'OR': instance.oR?.map((e) => e.toJson()).toList(),
      'NOT': instance.nOT?.map((e) => e.toJson()).toList(),
      'id': instance.id?.toJson(),
      'name': instance.name?.toJson(),
      'desc': instance.desc?.toJson(),
      'userId': instance.userId?.toJson(),
    };

Map<String, dynamic> _$UserUpdateWithoutPostInputToJson(
        UserUpdateWithoutPostInput instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
      'extra': _$JsonNullValueInputEnumMap[instance.extra],
    };

Map<String, dynamic> _$UserUncheckedUpdateWithoutPostInputToJson(
        UserUncheckedUpdateWithoutPostInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'password': instance.password,
      'resturantId': instance.resturantId,
      'extra': _$JsonNullValueInputEnumMap[instance.extra],
    };

Map<String, dynamic> _$PostUpdateWithoutUserInputToJson(
        PostUpdateWithoutUserInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
    };

Map<String, dynamic> _$PostUncheckedUpdateWithoutUserInputToJson(
        PostUncheckedUpdateWithoutUserInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
    };

Map<String, dynamic> _$PostCreateManyUserInputToJson(
        PostCreateManyUserInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
    };

Map<String, dynamic> _$PostUncheckedUpdateManyWithoutPostInputToJson(
        PostUncheckedUpdateManyWithoutPostInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
    };

AggregateUser _$AggregateUserFromJson(Map<String, dynamic> json) =>
    AggregateUser(
      $count: json['_count'] == null
          ? null
          : UserCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

UserGroupByOutputType _$UserGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserGroupByOutputType(
      id: json['id'] as int,
      userName: json['userName'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      resturantId: json['resturantId'] as int?,
      extra: json['extra'] as Map<String, dynamic>,
      $count: json['_count'] == null
          ? null
          : UserCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

AggregatePost _$AggregatePostFromJson(Map<String, dynamic> json) =>
    AggregatePost(
      $count: json['_count'] == null
          ? null
          : PostCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : PostAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : PostSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : PostMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : PostMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

PostGroupByOutputType _$PostGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostGroupByOutputType(
      id: json['id'] as int,
      name: json['name'] as String,
      desc: json['desc'] as String,
      userId: json['userId'] as int,
      $count: json['_count'] == null
          ? null
          : PostCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : PostAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : PostSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : PostMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : PostMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int,
    );

UserCountOutputType _$UserCountOutputTypeFromJson(Map<String, dynamic> json) =>
    UserCountOutputType(
      post: json['Post'] as int,
    );

UserCountAggregateOutputType _$UserCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserCountAggregateOutputType(
      id: json['id'] as int,
      userName: json['userName'] as int,
      name: json['name'] as int,
      password: json['password'] as int,
      resturantId: json['resturantId'] as int,
      extra: json['extra'] as int,
      $all: json['_all'] as int,
    );

UserAvgAggregateOutputType _$UserAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserAvgAggregateOutputType(
      id: (json['id'] as num?)?.toDouble(),
      resturantId: (json['resturantId'] as num?)?.toDouble(),
    );

UserSumAggregateOutputType _$UserSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserSumAggregateOutputType(
      id: json['id'] as int?,
      resturantId: json['resturantId'] as int?,
    );

UserMinAggregateOutputType _$UserMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMinAggregateOutputType(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      resturantId: json['resturantId'] as int?,
    );

UserMaxAggregateOutputType _$UserMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMaxAggregateOutputType(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      resturantId: json['resturantId'] as int?,
    );

PostCountAggregateOutputType _$PostCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostCountAggregateOutputType(
      id: json['id'] as int,
      name: json['name'] as int,
      desc: json['desc'] as int,
      userId: json['userId'] as int,
      $all: json['_all'] as int,
    );

PostAvgAggregateOutputType _$PostAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostAvgAggregateOutputType(
      id: (json['id'] as num?)?.toDouble(),
      userId: (json['userId'] as num?)?.toDouble(),
    );

PostSumAggregateOutputType _$PostSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostSumAggregateOutputType(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
    );

PostMinAggregateOutputType _$PostMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostMinAggregateOutputType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      userId: json['userId'] as int?,
    );

PostMaxAggregateOutputType _$PostMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostMaxAggregateOutputType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      userId: json['userId'] as int?,
    );

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      userName: json['userName'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      resturantId: json['resturantId'] as int?,
      post: (json['Post'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      extra: json['extra'] as Map<String, dynamic>,
      $count:
          UserCountOutputType.fromJson(json['_count'] as Map<String, dynamic>),
    );

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as int,
      name: json['name'] as String,
      desc: json['desc'] as String,
      userId: json['userId'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
