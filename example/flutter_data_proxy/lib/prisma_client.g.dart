// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregateUser _$AggregateUserFromJson(Map<String, dynamic> json) =>
    AggregateUser(
      prisma__count: json['_count'] == null
          ? null
          : UserCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      prisma__avg: json['_avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      prisma__sum: json['_sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateUserToJson(AggregateUser instance) =>
    <String, dynamic>{
      '_count': instance.prisma__count?.toJson(),
      '_avg': instance.prisma__avg?.toJson(),
      '_sum': instance.prisma__sum?.toJson(),
      '_min': instance.prisma__min?.toJson(),
      '_max': instance.prisma__max?.toJson(),
    };

UserGroupByOutputType _$UserGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserGroupByOutputType(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      prisma__count: json['_count'] == null
          ? null
          : UserCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      prisma__avg: json['_avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      prisma__sum: json['_sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserGroupByOutputTypeToJson(
        UserGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': dateTimeToJson(instance.createdAt),
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

UserCountAggregateOutputType _$UserCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserCountAggregateOutputType(
      id: json['id'] as int,
      name: json['name'] as int,
      createdAt: json['createdAt'] as int,
      prisma__all: json['_all'] as int,
    );

Map<String, dynamic> _$UserCountAggregateOutputTypeToJson(
        UserCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      '_all': instance.prisma__all,
    };

UserAvgAggregateOutputType _$UserAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserAvgAggregateOutputType(
      id: (json['id'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserAvgAggregateOutputTypeToJson(
        UserAvgAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserSumAggregateOutputType _$UserSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserSumAggregateOutputType(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$UserSumAggregateOutputTypeToJson(
        UserSumAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserMinAggregateOutputType _$UserMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMinAggregateOutputType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserMinAggregateOutputTypeToJson(
        UserMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': dateTimeToJson(instance.createdAt),
    };

UserMaxAggregateOutputType _$UserMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMaxAggregateOutputType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserMaxAggregateOutputTypeToJson(
        UserMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': dateTimeToJson(instance.createdAt),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': dateTimeToJson(instance.createdAt),
    };

_$UserWhereInput_AND_withUserWhereInput
    _$$UserWhereInput_AND_withUserWhereInputFromJson(
            Map<String, dynamic> json) =>
        _$UserWhereInput_AND_withUserWhereInput(
          UserWhereInput.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserWhereInput_AND_withUserWhereInputToJson(
        _$UserWhereInput_AND_withUserWhereInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_AND_withUserWhereInputList
    _$$UserWhereInput_AND_withUserWhereInputListFromJson(
            Map<String, dynamic> json) =>
        _$UserWhereInput_AND_withUserWhereInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserWhereInput.fromJson(e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserWhereInput_AND_withUserWhereInputListToJson(
        _$UserWhereInput_AND_withUserWhereInputList instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_NOT_withUserWhereInput
    _$$UserWhereInput_NOT_withUserWhereInputFromJson(
            Map<String, dynamic> json) =>
        _$UserWhereInput_NOT_withUserWhereInput(
          UserWhereInput.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserWhereInput_NOT_withUserWhereInputToJson(
        _$UserWhereInput_NOT_withUserWhereInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_NOT_withUserWhereInputList
    _$$UserWhereInput_NOT_withUserWhereInputListFromJson(
            Map<String, dynamic> json) =>
        _$UserWhereInput_NOT_withUserWhereInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserWhereInput.fromJson(e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserWhereInput_NOT_withUserWhereInputListToJson(
        _$UserWhereInput_NOT_withUserWhereInputList instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_id_withIntFilter _$$UserWhereInput_id_withIntFilterFromJson(
        Map<String, dynamic> json) =>
    _$UserWhereInput_id_withIntFilter(
      IntFilter.fromJson(json['value'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserWhereInput_id_withIntFilterToJson(
        _$UserWhereInput_id_withIntFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_id_withInt _$$UserWhereInput_id_withIntFromJson(
        Map<String, dynamic> json) =>
    _$UserWhereInput_id_withInt(
      json['value'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserWhereInput_id_withIntToJson(
        _$UserWhereInput_id_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_name_withStringFilter
    _$$UserWhereInput_name_withStringFilterFromJson(
            Map<String, dynamic> json) =>
        _$UserWhereInput_name_withStringFilter(
          StringFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserWhereInput_name_withStringFilterToJson(
        _$UserWhereInput_name_withStringFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_name_withString _$$UserWhereInput_name_withStringFromJson(
        Map<String, dynamic> json) =>
    _$UserWhereInput_name_withString(
      json['value'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserWhereInput_name_withStringToJson(
        _$UserWhereInput_name_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_createdAt_withDateTimeFilter
    _$$UserWhereInput_createdAt_withDateTimeFilterFromJson(
            Map<String, dynamic> json) =>
        _$UserWhereInput_createdAt_withDateTimeFilter(
          DateTimeFilter.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserWhereInput_createdAt_withDateTimeFilterToJson(
        _$UserWhereInput_createdAt_withDateTimeFilter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserWhereInput_createdAt_withDateTime
    _$$UserWhereInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$UserWhereInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserWhereInput_createdAt_withDateTimeToJson(
        _$UserWhereInput_createdAt_withDateTime instance) =>
    <String, dynamic>{
      'value': dateTimeToJson(instance.value),
      'runtimeType': instance.$type,
    };

_$_UserWhereInput _$$_UserWhereInputFromJson(Map<String, dynamic> json) =>
    _$_UserWhereInput(
      AND: json['AND'] == null
          ? null
          : UserWhereInput_AND.fromJson(json['AND'] as Map<String, dynamic>),
      OR: (json['OR'] as List<dynamic>?)
          ?.map((e) => UserWhereInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      NOT: json['NOT'] == null
          ? null
          : UserWhereInput_NOT.fromJson(json['NOT'] as Map<String, dynamic>),
      id: json['id'] == null
          ? null
          : UserWhereInput_id.fromJson(json['id'] as Map<String, dynamic>),
      name: json['name'] == null
          ? null
          : UserWhereInput_name.fromJson(json['name'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : UserWhereInput_createdAt.fromJson(
              json['createdAt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserWhereInputToJson(_$_UserWhereInput instance) =>
    <String, dynamic>{
      'AND': instance.AND,
      'OR': instance.OR,
      'NOT': instance.NOT,
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
    };

_$_UserOrderByWithRelationInput _$$_UserOrderByWithRelationInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserOrderByWithRelationInput(
      id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
      name: $enumDecodeNullable(_$SortOrderEnumMap, json['name']),
      createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
    );

Map<String, dynamic> _$$_UserOrderByWithRelationInputToJson(
        _$_UserOrderByWithRelationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
    };

const _$SortOrderEnumMap = {
  SortOrder.asc: 'asc',
  SortOrder.desc: 'desc',
};

_$_UserWhereUniqueInput _$$_UserWhereUniqueInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserWhereUniqueInput(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$_UserWhereUniqueInputToJson(
        _$_UserWhereUniqueInput instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$_UserOrderByWithAggregationInput _$$_UserOrderByWithAggregationInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserOrderByWithAggregationInput(
      id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
      name: $enumDecodeNullable(_$SortOrderEnumMap, json['name']),
      createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
      prisma__count: json['_count'] == null
          ? null
          : UserCountOrderByAggregateInput.fromJson(
              json['_count'] as Map<String, dynamic>),
      prisma__avg: json['_avg'] == null
          ? null
          : UserAvgOrderByAggregateInput.fromJson(
              json['_avg'] as Map<String, dynamic>),
      prisma__max: json['_max'] == null
          ? null
          : UserMaxOrderByAggregateInput.fromJson(
              json['_max'] as Map<String, dynamic>),
      prisma__min: json['_min'] == null
          ? null
          : UserMinOrderByAggregateInput.fromJson(
              json['_min'] as Map<String, dynamic>),
      prisma__sum: json['_sum'] == null
          ? null
          : UserSumOrderByAggregateInput.fromJson(
              json['_sum'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserOrderByWithAggregationInputToJson(
        _$_UserOrderByWithAggregationInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
      '_count': instance.prisma__count,
      '_avg': instance.prisma__avg,
      '_max': instance.prisma__max,
      '_min': instance.prisma__min,
      '_sum': instance.prisma__sum,
    };

_$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInput
    _$$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInput(
          UserScalarWhereWithAggregatesInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInputToJson(
            _$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInputList
    _$$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInputListFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInputListToJson(
            _$UserScalarWhereWithAggregatesInput_AND_withUserScalarWhereWithAggregatesInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInput
    _$$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInput(
          UserScalarWhereWithAggregatesInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInputToJson(
            _$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInputList
    _$$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInputListFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInputListToJson(
            _$UserScalarWhereWithAggregatesInput_NOT_withUserScalarWhereWithAggregatesInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilter
    _$$UserScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilter(
          IntWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilterToJson(
            _$UserScalarWhereWithAggregatesInput_id_withIntWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_id_withInt
    _$$UserScalarWhereWithAggregatesInput_id_withIntFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_id_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserScalarWhereWithAggregatesInput_id_withIntToJson(
        _$UserScalarWhereWithAggregatesInput_id_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserScalarWhereWithAggregatesInput_name_withStringWithAggregatesFilter
    _$$UserScalarWhereWithAggregatesInput_name_withStringWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_name_withStringWithAggregatesFilter(
          StringWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_name_withStringWithAggregatesFilterToJson(
            _$UserScalarWhereWithAggregatesInput_name_withStringWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_name_withString
    _$$UserScalarWhereWithAggregatesInput_name_withStringFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_name_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_name_withStringToJson(
            _$UserScalarWhereWithAggregatesInput_name_withString instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilter
    _$$UserScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilterFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilter(
          DateTimeWithAggregatesFilter.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilterToJson(
            _$UserScalarWhereWithAggregatesInput_createdAt_withDateTimeWithAggregatesFilter
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserScalarWhereWithAggregatesInput_createdAt_withDateTime
    _$$UserScalarWhereWithAggregatesInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$UserScalarWhereWithAggregatesInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$UserScalarWhereWithAggregatesInput_createdAt_withDateTimeToJson(
        _$UserScalarWhereWithAggregatesInput_createdAt_withDateTime instance) =>
    <String, dynamic>{
      'value': dateTimeToJson(instance.value),
      'runtimeType': instance.$type,
    };

_$_UserScalarWhereWithAggregatesInput
    _$$_UserScalarWhereWithAggregatesInputFromJson(Map<String, dynamic> json) =>
        _$_UserScalarWhereWithAggregatesInput(
          AND: json['AND'] == null
              ? null
              : UserScalarWhereWithAggregatesInput_AND.fromJson(
                  json['AND'] as Map<String, dynamic>),
          OR: (json['OR'] as List<dynamic>?)
              ?.map((e) => UserScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          NOT: json['NOT'] == null
              ? null
              : UserScalarWhereWithAggregatesInput_NOT.fromJson(
                  json['NOT'] as Map<String, dynamic>),
          id: json['id'] == null
              ? null
              : UserScalarWhereWithAggregatesInput_id.fromJson(
                  json['id'] as Map<String, dynamic>),
          name: json['name'] == null
              ? null
              : UserScalarWhereWithAggregatesInput_name.fromJson(
                  json['name'] as Map<String, dynamic>),
          createdAt: json['createdAt'] == null
              ? null
              : UserScalarWhereWithAggregatesInput_createdAt.fromJson(
                  json['createdAt'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_UserScalarWhereWithAggregatesInputToJson(
        _$_UserScalarWhereWithAggregatesInput instance) =>
    <String, dynamic>{
      'AND': instance.AND,
      'OR': instance.OR,
      'NOT': instance.NOT,
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
    };

_$_UserCreateInput _$$_UserCreateInputFromJson(Map<String, dynamic> json) =>
    _$_UserCreateInput(
      name: json['name'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_UserCreateInputToJson(_$_UserCreateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdAt': dateTimeToJson(instance.createdAt),
    };

_$_UserUncheckedCreateInput _$$_UserUncheckedCreateInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserUncheckedCreateInput(
      id: json['id'] as int?,
      name: json['name'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_UserUncheckedCreateInputToJson(
        _$_UserUncheckedCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': dateTimeToJson(instance.createdAt),
    };

_$UserUpdateInput_name_withString _$$UserUpdateInput_name_withStringFromJson(
        Map<String, dynamic> json) =>
    _$UserUpdateInput_name_withString(
      json['value'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserUpdateInput_name_withStringToJson(
        _$UserUpdateInput_name_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserUpdateInput_name_withStringFieldUpdateOperationsInput
    _$$UserUpdateInput_name_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUpdateInput_name_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$UserUpdateInput_name_withStringFieldUpdateOperationsInputToJson(
        _$UserUpdateInput_name_withStringFieldUpdateOperationsInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserUpdateInput_createdAt_withDateTime
    _$$UserUpdateInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$UserUpdateInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserUpdateInput_createdAt_withDateTimeToJson(
        _$UserUpdateInput_createdAt_withDateTime instance) =>
    <String, dynamic>{
      'value': dateTimeToJson(instance.value),
      'runtimeType': instance.$type,
    };

_$UserUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$UserUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$UserUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UserUpdateInput _$$_UserUpdateInputFromJson(Map<String, dynamic> json) =>
    _$_UserUpdateInput(
      name: json['name'] == null
          ? null
          : UserUpdateInput_name.fromJson(json['name'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : UserUpdateInput_createdAt.fromJson(
              json['createdAt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserUpdateInputToJson(_$_UserUpdateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdAt': instance.createdAt,
    };

_$UserUncheckedUpdateInput_id_withInt
    _$$UserUncheckedUpdateInput_id_withIntFromJson(Map<String, dynamic> json) =>
        _$UserUncheckedUpdateInput_id_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserUncheckedUpdateInput_id_withIntToJson(
        _$UserUncheckedUpdateInput_id_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserUncheckedUpdateInput_id_withIntFieldUpdateOperationsInput
    _$$UserUncheckedUpdateInput_id_withIntFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateInput_id_withIntFieldUpdateOperationsInput(
          IntFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUncheckedUpdateInput_id_withIntFieldUpdateOperationsInputToJson(
            _$UserUncheckedUpdateInput_id_withIntFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserUncheckedUpdateInput_name_withString
    _$$UserUncheckedUpdateInput_name_withStringFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateInput_name_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserUncheckedUpdateInput_name_withStringToJson(
        _$UserUncheckedUpdateInput_name_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserUncheckedUpdateInput_name_withStringFieldUpdateOperationsInput
    _$$UserUncheckedUpdateInput_name_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateInput_name_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUncheckedUpdateInput_name_withStringFieldUpdateOperationsInputToJson(
            _$UserUncheckedUpdateInput_name_withStringFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserUncheckedUpdateInput_createdAt_withDateTime
    _$$UserUncheckedUpdateInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserUncheckedUpdateInput_createdAt_withDateTimeToJson(
        _$UserUncheckedUpdateInput_createdAt_withDateTime instance) =>
    <String, dynamic>{
      'value': dateTimeToJson(instance.value),
      'runtimeType': instance.$type,
    };

_$UserUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$UserUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$UserUncheckedUpdateInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UserUncheckedUpdateInput _$$_UserUncheckedUpdateInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserUncheckedUpdateInput(
      id: json['id'] == null
          ? null
          : UserUncheckedUpdateInput_id.fromJson(
              json['id'] as Map<String, dynamic>),
      name: json['name'] == null
          ? null
          : UserUncheckedUpdateInput_name.fromJson(
              json['name'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : UserUncheckedUpdateInput_createdAt.fromJson(
              json['createdAt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserUncheckedUpdateInputToJson(
        _$_UserUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
    };

_$_UserCreateManyInput _$$_UserCreateManyInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserCreateManyInput(
      id: json['id'] as int?,
      name: json['name'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_UserCreateManyInputToJson(
        _$_UserCreateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': dateTimeToJson(instance.createdAt),
    };

_$UserUpdateManyMutationInput_name_withString
    _$$UserUpdateManyMutationInput_name_withStringFromJson(
            Map<String, dynamic> json) =>
        _$UserUpdateManyMutationInput_name_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserUpdateManyMutationInput_name_withStringToJson(
        _$UserUpdateManyMutationInput_name_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserUpdateManyMutationInput_name_withStringFieldUpdateOperationsInput
    _$$UserUpdateManyMutationInput_name_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUpdateManyMutationInput_name_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUpdateManyMutationInput_name_withStringFieldUpdateOperationsInputToJson(
            _$UserUpdateManyMutationInput_name_withStringFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserUpdateManyMutationInput_createdAt_withDateTime
    _$$UserUpdateManyMutationInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$UserUpdateManyMutationInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUpdateManyMutationInput_createdAt_withDateTimeToJson(
            _$UserUpdateManyMutationInput_createdAt_withDateTime instance) =>
        <String, dynamic>{
          'value': dateTimeToJson(instance.value),
          'runtimeType': instance.$type,
        };

_$UserUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$UserUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$UserUpdateManyMutationInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UserUpdateManyMutationInput _$$_UserUpdateManyMutationInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserUpdateManyMutationInput(
      name: json['name'] == null
          ? null
          : UserUpdateManyMutationInput_name.fromJson(
              json['name'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : UserUpdateManyMutationInput_createdAt.fromJson(
              json['createdAt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserUpdateManyMutationInputToJson(
        _$_UserUpdateManyMutationInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdAt': instance.createdAt,
    };

_$UserUncheckedUpdateManyInput_id_withInt
    _$$UserUncheckedUpdateManyInput_id_withIntFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateManyInput_id_withInt(
          json['value'] as int,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserUncheckedUpdateManyInput_id_withIntToJson(
        _$UserUncheckedUpdateManyInput_id_withInt instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInput
    _$$UserUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInput(
          IntFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInputToJson(
            _$UserUncheckedUpdateManyInput_id_withIntFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserUncheckedUpdateManyInput_name_withString
    _$$UserUncheckedUpdateManyInput_name_withStringFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateManyInput_name_withString(
          json['value'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$UserUncheckedUpdateManyInput_name_withStringToJson(
        _$UserUncheckedUpdateManyInput_name_withString instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$UserUncheckedUpdateManyInput_name_withStringFieldUpdateOperationsInput
    _$$UserUncheckedUpdateManyInput_name_withStringFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateManyInput_name_withStringFieldUpdateOperationsInput(
          StringFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUncheckedUpdateManyInput_name_withStringFieldUpdateOperationsInputToJson(
            _$UserUncheckedUpdateManyInput_name_withStringFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$UserUncheckedUpdateManyInput_createdAt_withDateTime
    _$$UserUncheckedUpdateManyInput_createdAt_withDateTimeFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateManyInput_createdAt_withDateTime(
          DateTime.parse(json['value'] as String),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUncheckedUpdateManyInput_createdAt_withDateTimeToJson(
            _$UserUncheckedUpdateManyInput_createdAt_withDateTime instance) =>
        <String, dynamic>{
          'value': dateTimeToJson(instance.value),
          'runtimeType': instance.$type,
        };

_$UserUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInput
    _$$UserUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInputFromJson(
            Map<String, dynamic> json) =>
        _$UserUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInput(
          DateTimeFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$UserUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInputToJson(
            _$UserUncheckedUpdateManyInput_createdAt_withDateTimeFieldUpdateOperationsInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UserUncheckedUpdateManyInput _$$_UserUncheckedUpdateManyInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserUncheckedUpdateManyInput(
      id: json['id'] == null
          ? null
          : UserUncheckedUpdateManyInput_id.fromJson(
              json['id'] as Map<String, dynamic>),
      name: json['name'] == null
          ? null
          : UserUncheckedUpdateManyInput_name.fromJson(
              json['name'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : UserUncheckedUpdateManyInput_createdAt.fromJson(
              json['createdAt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserUncheckedUpdateManyInputToJson(
        _$_UserUncheckedUpdateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
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
      mode: $enumDecodeNullable(_$QueryModeEnumMap, json['mode']),
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
      'mode': _$QueryModeEnumMap[instance.mode],
      'not': instance.not,
    };

const _$QueryModeEnumMap = {
  QueryMode.dart__default: 'default',
  QueryMode.insensitive: 'insensitive',
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
      'value': dateTimeToJson(instance.value),
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
      'equals': dateTimeToJson(instance.equals),
      'in': dateTimeToJson(instance.dart__in),
      'notIn': dateTimeToJson(instance.notIn),
      'lt': dateTimeToJson(instance.lt),
      'lte': dateTimeToJson(instance.lte),
      'gt': dateTimeToJson(instance.gt),
      'gte': dateTimeToJson(instance.gte),
      'not': instance.not,
    };

_$_UserCountOrderByAggregateInput _$$_UserCountOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserCountOrderByAggregateInput(
      id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
      name: $enumDecodeNullable(_$SortOrderEnumMap, json['name']),
      createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
    );

Map<String, dynamic> _$$_UserCountOrderByAggregateInputToJson(
        _$_UserCountOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
    };

_$_UserAvgOrderByAggregateInput _$$_UserAvgOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserAvgOrderByAggregateInput(
      id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
    );

Map<String, dynamic> _$$_UserAvgOrderByAggregateInputToJson(
        _$_UserAvgOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
    };

_$_UserMaxOrderByAggregateInput _$$_UserMaxOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserMaxOrderByAggregateInput(
      id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
      name: $enumDecodeNullable(_$SortOrderEnumMap, json['name']),
      createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
    );

Map<String, dynamic> _$$_UserMaxOrderByAggregateInputToJson(
        _$_UserMaxOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
    };

_$_UserMinOrderByAggregateInput _$$_UserMinOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserMinOrderByAggregateInput(
      id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
      name: $enumDecodeNullable(_$SortOrderEnumMap, json['name']),
      createdAt: $enumDecodeNullable(_$SortOrderEnumMap, json['createdAt']),
    );

Map<String, dynamic> _$$_UserMinOrderByAggregateInputToJson(
        _$_UserMinOrderByAggregateInput instance) =>
    <String, dynamic>{
      'id': _$SortOrderEnumMap[instance.id],
      'name': _$SortOrderEnumMap[instance.name],
      'createdAt': _$SortOrderEnumMap[instance.createdAt],
    };

_$_UserSumOrderByAggregateInput _$$_UserSumOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    _$_UserSumOrderByAggregateInput(
      id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
    );

Map<String, dynamic> _$$_UserSumOrderByAggregateInputToJson(
        _$_UserSumOrderByAggregateInput instance) =>
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
      mode: $enumDecodeNullable(_$QueryModeEnumMap, json['mode']),
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
      'mode': _$QueryModeEnumMap[instance.mode],
      'not': instance.not,
      '_count': instance.prisma__count,
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
      'value': dateTimeToJson(instance.value),
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
      'equals': dateTimeToJson(instance.equals),
      'in': dateTimeToJson(instance.dart__in),
      'notIn': dateTimeToJson(instance.notIn),
      'lt': dateTimeToJson(instance.lt),
      'lte': dateTimeToJson(instance.lte),
      'gt': dateTimeToJson(instance.gt),
      'gte': dateTimeToJson(instance.gte),
      'not': instance.not,
      '_count': instance.prisma__count,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
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
      'set': dateTimeToJson(instance.dart__set),
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
      'value': dateTimeToJson(instance.value),
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
      'equals': dateTimeToJson(instance.equals),
      'in': dateTimeToJson(instance.dart__in),
      'notIn': dateTimeToJson(instance.notIn),
      'lt': dateTimeToJson(instance.lt),
      'lte': dateTimeToJson(instance.lte),
      'gt': dateTimeToJson(instance.gt),
      'gte': dateTimeToJson(instance.gte),
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
          'value': dateTimeToJson(instance.value),
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
      'equals': dateTimeToJson(instance.equals),
      'in': dateTimeToJson(instance.dart__in),
      'notIn': dateTimeToJson(instance.notIn),
      'lt': dateTimeToJson(instance.lt),
      'lte': dateTimeToJson(instance.lte),
      'gt': dateTimeToJson(instance.gt),
      'gte': dateTimeToJson(instance.gte),
      'not': instance.not,
      '_count': instance.prisma__count,
      '_min': instance.prisma__min,
      '_max': instance.prisma__max,
    };

_$_FindFirstUserOrderByWithUserOrderByWithRelationInputList
    _$$_FindFirstUserOrderByWithUserOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstUserOrderByWithUserOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$_FindFirstUserOrderByWithUserOrderByWithRelationInputListToJson(
        _$_FindFirstUserOrderByWithUserOrderByWithRelationInputList instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_FindFirstUserOrderByWithUserOrderByWithRelationInput
    _$$_FindFirstUserOrderByWithUserOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstUserOrderByWithUserOrderByWithRelationInput(
          UserOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindFirstUserOrderByWithUserOrderByWithRelationInputToJson(
            _$_FindFirstUserOrderByWithUserOrderByWithRelationInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInputList
    _$$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInputListToJson(
            _$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInput
    _$$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInput(
          UserOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInputToJson(
            _$_FindFirstUserOrThrowOrderByWithUserOrderByWithRelationInput
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_FindManyUserOrderByWithUserOrderByWithRelationInputList
    _$$_FindManyUserOrderByWithUserOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_FindManyUserOrderByWithUserOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$_FindManyUserOrderByWithUserOrderByWithRelationInputListToJson(
        _$_FindManyUserOrderByWithUserOrderByWithRelationInputList instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_FindManyUserOrderByWithUserOrderByWithRelationInput
    _$$_FindManyUserOrderByWithUserOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_FindManyUserOrderByWithUserOrderByWithRelationInput(
          UserOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_FindManyUserOrderByWithUserOrderByWithRelationInputToJson(
            _$_FindManyUserOrderByWithUserOrderByWithRelationInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_CreateOneUserDataWithUserCreateInput
    _$$_CreateOneUserDataWithUserCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_CreateOneUserDataWithUserCreateInput(
          UserCreateInput.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_CreateOneUserDataWithUserCreateInputToJson(
        _$_CreateOneUserDataWithUserCreateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_CreateOneUserDataWithUserUncheckedCreateInput
    _$$_CreateOneUserDataWithUserUncheckedCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_CreateOneUserDataWithUserUncheckedCreateInput(
          UserUncheckedCreateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_CreateOneUserDataWithUserUncheckedCreateInputToJson(
        _$_CreateOneUserDataWithUserUncheckedCreateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpdateOneUserDataWithUserUpdateInput
    _$$_UpdateOneUserDataWithUserUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateOneUserDataWithUserUpdateInput(
          UserUpdateInput.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_UpdateOneUserDataWithUserUpdateInputToJson(
        _$_UpdateOneUserDataWithUserUpdateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpdateOneUserDataWithUserUncheckedUpdateInput
    _$$_UpdateOneUserDataWithUserUncheckedUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateOneUserDataWithUserUncheckedUpdateInput(
          UserUncheckedUpdateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_UpdateOneUserDataWithUserUncheckedUpdateInputToJson(
        _$_UpdateOneUserDataWithUserUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpdateManyUserDataWithUserUpdateManyMutationInput
    _$$_UpdateManyUserDataWithUserUpdateManyMutationInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateManyUserDataWithUserUpdateManyMutationInput(
          UserUpdateManyMutationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpdateManyUserDataWithUserUpdateManyMutationInputToJson(
            _$_UpdateManyUserDataWithUserUpdateManyMutationInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpdateManyUserDataWithUserUncheckedUpdateManyInput
    _$$_UpdateManyUserDataWithUserUncheckedUpdateManyInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpdateManyUserDataWithUserUncheckedUpdateManyInput(
          UserUncheckedUpdateManyInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_UpdateManyUserDataWithUserUncheckedUpdateManyInputToJson(
            _$_UpdateManyUserDataWithUserUncheckedUpdateManyInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_UpsertOneUserCreateWithUserCreateInput
    _$$_UpsertOneUserCreateWithUserCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneUserCreateWithUserCreateInput(
          UserCreateInput.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_UpsertOneUserCreateWithUserCreateInputToJson(
        _$_UpsertOneUserCreateWithUserCreateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpsertOneUserCreateWithUserUncheckedCreateInput
    _$$_UpsertOneUserCreateWithUserUncheckedCreateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneUserCreateWithUserUncheckedCreateInput(
          UserUncheckedCreateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_UpsertOneUserCreateWithUserUncheckedCreateInputToJson(
        _$_UpsertOneUserCreateWithUserUncheckedCreateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpsertOneUserUpdateWithUserUpdateInput
    _$$_UpsertOneUserUpdateWithUserUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneUserUpdateWithUserUpdateInput(
          UserUpdateInput.fromJson(json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_UpsertOneUserUpdateWithUserUpdateInputToJson(
        _$_UpsertOneUserUpdateWithUserUpdateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_UpsertOneUserUpdateWithUserUncheckedUpdateInput
    _$$_UpsertOneUserUpdateWithUserUncheckedUpdateInputFromJson(
            Map<String, dynamic> json) =>
        _$_UpsertOneUserUpdateWithUserUncheckedUpdateInput(
          UserUncheckedUpdateInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_UpsertOneUserUpdateWithUserUncheckedUpdateInputToJson(
        _$_UpsertOneUserUpdateWithUserUncheckedUpdateInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_AggregateUserOrderByWithUserOrderByWithRelationInputList
    _$$_AggregateUserOrderByWithUserOrderByWithRelationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_AggregateUserOrderByWithUserOrderByWithRelationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserOrderByWithRelationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$_AggregateUserOrderByWithUserOrderByWithRelationInputListToJson(
        _$_AggregateUserOrderByWithUserOrderByWithRelationInputList instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_AggregateUserOrderByWithUserOrderByWithRelationInput
    _$$_AggregateUserOrderByWithUserOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        _$_AggregateUserOrderByWithUserOrderByWithRelationInput(
          UserOrderByWithRelationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_AggregateUserOrderByWithUserOrderByWithRelationInputToJson(
            _$_AggregateUserOrderByWithUserOrderByWithRelationInput instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_GroupByUserOrderByWithUserOrderByWithAggregationInputList
    _$$_GroupByUserOrderByWithUserOrderByWithAggregationInputListFromJson(
            Map<String, dynamic> json) =>
        _$_GroupByUserOrderByWithUserOrderByWithAggregationInputList(
          (json['value'] as List<dynamic>)
              .map((e) => UserOrderByWithAggregationInput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic>
    _$$_GroupByUserOrderByWithUserOrderByWithAggregationInputListToJson(
            _$_GroupByUserOrderByWithUserOrderByWithAggregationInputList
                instance) =>
        <String, dynamic>{
          'value': instance.value,
          'runtimeType': instance.$type,
        };

_$_GroupByUserOrderByWithUserOrderByWithAggregationInput
    _$$_GroupByUserOrderByWithUserOrderByWithAggregationInputFromJson(
            Map<String, dynamic> json) =>
        _$_GroupByUserOrderByWithUserOrderByWithAggregationInput(
          UserOrderByWithAggregationInput.fromJson(
              json['value'] as Map<String, dynamic>),
          $type: json['runtimeType'] as String?,
        );

Map<String,
    dynamic> _$$_GroupByUserOrderByWithUserOrderByWithAggregationInputToJson(
        _$_GroupByUserOrderByWithUserOrderByWithAggregationInput instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_GroupByUserByWithUserScalarFieldEnumList
    _$$_GroupByUserByWithUserScalarFieldEnumListFromJson(
            Map<String, dynamic> json) =>
        _$_GroupByUserByWithUserScalarFieldEnumList(
          (json['value'] as List<dynamic>)
              .map((e) => $enumDecode(_$UserScalarFieldEnumEnumMap, e))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_GroupByUserByWithUserScalarFieldEnumListToJson(
        _$_GroupByUserByWithUserScalarFieldEnumList instance) =>
    <String, dynamic>{
      'value':
          instance.value.map((e) => _$UserScalarFieldEnumEnumMap[e]!).toList(),
      'runtimeType': instance.$type,
    };

const _$UserScalarFieldEnumEnumMap = {
  UserScalarFieldEnum.id: 'id',
  UserScalarFieldEnum.name: 'name',
  UserScalarFieldEnum.createdAt: 'createdAt',
};

_$_GroupByUserByWithUserScalarFieldEnum
    _$$_GroupByUserByWithUserScalarFieldEnumFromJson(
            Map<String, dynamic> json) =>
        _$_GroupByUserByWithUserScalarFieldEnum(
          $enumDecode(_$UserScalarFieldEnumEnumMap, json['value']),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$_GroupByUserByWithUserScalarFieldEnumToJson(
        _$_GroupByUserByWithUserScalarFieldEnum instance) =>
    <String, dynamic>{
      'value': _$UserScalarFieldEnumEnumMap[instance.value]!,
      'runtimeType': instance.$type,
    };
