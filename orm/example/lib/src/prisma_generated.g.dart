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

Query _$QueryFromJson(Map<String, dynamic> json) => Query(
      findFirstUser: json['findFirstUser'] == null
          ? null
          : User.fromJson(json['findFirstUser'] as Map<String, dynamic>),
      findManyUser: (json['findManyUser'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      aggregateUser:
          AggregateUser.fromJson(json['aggregateUser'] as Map<String, dynamic>),
      groupByUser: (json['groupByUser'] as List<dynamic>)
          .map((e) => UserGroupByOutputType.fromJson(e as Map<String, dynamic>))
          .toList(),
      findUniqueUser: json['findUniqueUser'] == null
          ? null
          : User.fromJson(json['findUniqueUser'] as Map<String, dynamic>),
    );

Mutation _$MutationFromJson(Map<String, dynamic> json) => Mutation(
      createOneUser:
          User.fromJson(json['createOneUser'] as Map<String, dynamic>),
      upsertOneUser:
          User.fromJson(json['upsertOneUser'] as Map<String, dynamic>),
      createManyUser: AffectedRowsOutput.fromJson(
          json['createManyUser'] as Map<String, dynamic>),
      deleteOneUser: json['deleteOneUser'] == null
          ? null
          : User.fromJson(json['deleteOneUser'] as Map<String, dynamic>),
      updateOneUser: json['updateOneUser'] == null
          ? null
          : User.fromJson(json['updateOneUser'] as Map<String, dynamic>),
      updateManyUser: AffectedRowsOutput.fromJson(
          json['updateManyUser'] as Map<String, dynamic>),
      deleteManyUser: AffectedRowsOutput.fromJson(
          json['deleteManyUser'] as Map<String, dynamic>),
    );

AggregateUser _$AggregateUserFromJson(Map<String, dynamic> json) =>
    AggregateUser(
      $count: json[r'$count'] == null
          ? null
          : UserCountAggregateOutputType.fromJson(
              json[r'$count'] as Map<String, dynamic>),
      $avg: json[r'$avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json[r'$avg'] as Map<String, dynamic>),
      $sum: json[r'$sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json[r'$sum'] as Map<String, dynamic>),
      $min: json[r'$min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json[r'$min'] as Map<String, dynamic>),
      $max: json[r'$max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json[r'$max'] as Map<String, dynamic>),
    );

UserGroupByOutputType _$UserGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserGroupByOutputType(
      id: json['id'] as int,
      userName: json['userName'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      resturantId: json['resturantId'] as int?,
      $count: json[r'$count'] == null
          ? null
          : UserCountAggregateOutputType.fromJson(
              json[r'$count'] as Map<String, dynamic>),
      $avg: json[r'$avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json[r'$avg'] as Map<String, dynamic>),
      $sum: json[r'$sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json[r'$sum'] as Map<String, dynamic>),
      $min: json[r'$min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json[r'$min'] as Map<String, dynamic>),
      $max: json[r'$max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json[r'$max'] as Map<String, dynamic>),
    );

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int,
    );

UserCountAggregateOutputType _$UserCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserCountAggregateOutputType(
      id: json['id'] as int,
      userName: json['userName'] as int,
      name: json['name'] as int,
      password: json['password'] as int,
      resturantId: json['resturantId'] as int,
      $all: json[r'$all'] as int,
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

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      userName: json['userName'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      resturantId: json['resturantId'] as int?,
    );
