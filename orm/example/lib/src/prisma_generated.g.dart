// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisma_generated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String,
      published: json['published'] as bool,
      desc: json['desc'] as String?,
      userId: json['userId'] as int?,
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

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int,
    );

PostCountAggregateOutputType _$PostCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostCountAggregateOutputType(
      id: json['id'] as int,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
      title: json['title'] as int,
      published: json['published'] as int,
      desc: json['desc'] as int,
      userId: json['userId'] as int,
      $all: json['_all'] as int,
    );

PostAvgAggregateOutputType _$PostAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostAvgAggregateOutputType(
      userId: (json['userId'] as num?)?.toDouble(),
    );

PostSumAggregateOutputType _$PostSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostSumAggregateOutputType(
      userId: json['userId'] as int?,
    );

PostMinAggregateOutputType _$PostMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostMinAggregateOutputType(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String?,
      published: json['published'] as bool?,
      desc: json['desc'] as String?,
      userId: json['userId'] as int?,
    );

PostMaxAggregateOutputType _$PostMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostMaxAggregateOutputType(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String?,
      published: json['published'] as bool?,
      desc: json['desc'] as String?,
      userId: json['userId'] as int?,
    );

UserCountOutputType _$UserCountOutputTypeFromJson(Map<String, dynamic> json) =>
    UserCountOutputType(
      posts: json['posts'] as int,
    );

UserCountAggregateOutputType _$UserCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserCountAggregateOutputType(
      id: json['id'] as int,
      userName: json['userName'] as int,
      name: json['name'] as int,
      password: json['password'] as int,
      resturantId: json['resturantId'] as int,
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

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String,
      published: json['published'] as bool,
      desc: json['desc'] as String?,
      user: json['User'] == null
          ? null
          : User.fromJson(json['User'] as Map<String, dynamic>),
      userId: json['userId'] as int?,
    );

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      userName: json['userName'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      resturantId: json['resturantId'] as int?,
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      $count:
          UserCountOutputType.fromJson(json['_count'] as Map<String, dynamic>),
    );
