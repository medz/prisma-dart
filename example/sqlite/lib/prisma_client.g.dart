// GENERATED CODE - DO NOT MODIFY BY HAND

part of prisma.client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregateTask _$AggregateTaskFromJson(Map<String, dynamic> json) =>
    AggregateTask(
      $count: json['_count'] == null
          ? null
          : TaskCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : TaskMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : TaskMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateTaskToJson(AggregateTask instance) =>
    <String, dynamic>{
      '_count': instance.$count?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

TaskGroupByOutputType _$TaskGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    TaskGroupByOutputType(
      id: json['id'] as String,
      task: json['task'] as String,
      done: json['done'] as bool,
      due: DateTime.parse(json['due'] as String),
      $count: json['_count'] == null
          ? null
          : TaskCountAggregateOutputType.fromJson(
              json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : TaskMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : TaskMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskGroupByOutputTypeToJson(
        TaskGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'done': instance.done,
      'due': instance.due.toIso8601String(),
      '_count': instance.$count?.toJson(),
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

TaskCountAggregateOutputType _$TaskCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    TaskCountAggregateOutputType(
      id: json['id'] as int,
      task: json['task'] as int,
      done: json['done'] as int,
      due: json['due'] as int,
      $all: json['_all'] as int,
    );

Map<String, dynamic> _$TaskCountAggregateOutputTypeToJson(
        TaskCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'done': instance.done,
      'due': instance.due,
      '_all': instance.$all,
    };

TaskMinAggregateOutputType _$TaskMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    TaskMinAggregateOutputType(
      id: json['id'] as String?,
      task: json['task'] as String?,
      done: json['done'] as bool?,
      due: json['due'] == null ? null : DateTime.parse(json['due'] as String),
    );

Map<String, dynamic> _$TaskMinAggregateOutputTypeToJson(
        TaskMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'done': instance.done,
      'due': instance.due?.toIso8601String(),
    };

TaskMaxAggregateOutputType _$TaskMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    TaskMaxAggregateOutputType(
      id: json['id'] as String?,
      task: json['task'] as String?,
      done: json['done'] as bool?,
      due: json['due'] == null ? null : DateTime.parse(json['due'] as String),
    );

Map<String, dynamic> _$TaskMaxAggregateOutputTypeToJson(
        TaskMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'done': instance.done,
      'due': instance.due?.toIso8601String(),
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      task: json['task'] as String,
      done: json['done'] as bool,
      due: DateTime.parse(json['due'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'done': instance.done,
      'due': instance.due.toIso8601String(),
    };
