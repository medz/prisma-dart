// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

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

Map<String, dynamic> _$AggregatePostToJson(AggregatePost instance) =>
    <String, dynamic>{
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

PostGroupByOutputType _$PostGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostGroupByOutputType(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      published: json['published'] as bool,
      authorId: json['authorId'] as int?,
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

Map<String, dynamic> _$PostGroupByOutputTypeToJson(
        PostGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'published': instance.published,
      'authorId': instance.authorId,
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
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

Map<String, dynamic> _$AggregateUserToJson(AggregateUser instance) =>
    <String, dynamic>{
      '_count': instance.$count?.toJson(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

UserGroupByOutputType _$UserGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserGroupByOutputType(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String?,
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

Map<String, dynamic> _$UserGroupByOutputTypeToJson(
        UserGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
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

PostCountAggregateOutputType _$PostCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostCountAggregateOutputType(
      id: json['id'] as int,
      title: json['title'] as int,
      content: json['content'] as int,
      published: json['published'] as int,
      authorId: json['authorId'] as int,
      $all: json['_all'] as int,
    );

Map<String, dynamic> _$PostCountAggregateOutputTypeToJson(
        PostCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'published': instance.published,
      'authorId': instance.authorId,
      '_all': instance.$all,
    };

PostAvgAggregateOutputType _$PostAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostAvgAggregateOutputType(
      id: (json['id'] as num?)?.toDouble(),
      authorId: (json['authorId'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PostAvgAggregateOutputTypeToJson(
        PostAvgAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
    };

PostSumAggregateOutputType _$PostSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostSumAggregateOutputType(
      id: json['id'] as int?,
      authorId: json['authorId'] as int?,
    );

Map<String, dynamic> _$PostSumAggregateOutputTypeToJson(
        PostSumAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
    };

PostMinAggregateOutputType _$PostMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostMinAggregateOutputType(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      published: json['published'] as bool?,
      authorId: json['authorId'] as int?,
    );

Map<String, dynamic> _$PostMinAggregateOutputTypeToJson(
        PostMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'published': instance.published,
      'authorId': instance.authorId,
    };

PostMaxAggregateOutputType _$PostMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PostMaxAggregateOutputType(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      published: json['published'] as bool?,
      authorId: json['authorId'] as int?,
    );

Map<String, dynamic> _$PostMaxAggregateOutputTypeToJson(
        PostMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'published': instance.published,
      'authorId': instance.authorId,
    };

UserCountOutputType _$UserCountOutputTypeFromJson(Map<String, dynamic> json) =>
    UserCountOutputType(
      posts: json['posts'] as int,
    );

Map<String, dynamic> _$UserCountOutputTypeToJson(
        UserCountOutputType instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };

UserCountAggregateOutputType _$UserCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserCountAggregateOutputType(
      id: json['id'] as int,
      email: json['email'] as int,
      name: json['name'] as int,
      $all: json['_all'] as int,
    );

Map<String, dynamic> _$UserCountAggregateOutputTypeToJson(
        UserCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      '_all': instance.$all,
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
      email: json['email'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserMinAggregateOutputTypeToJson(
        UserMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
    };

UserMaxAggregateOutputType _$UserMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMaxAggregateOutputType(
      id: json['id'] as int?,
      email: json['email'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserMaxAggregateOutputTypeToJson(
        UserMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      published: json['published'] as bool,
      authorId: json['authorId'] as int?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'published': instance.published,
      'authorId': instance.authorId,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
    };
