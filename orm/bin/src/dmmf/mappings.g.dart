// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mappings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mappings _$MappingsFromJson(Map<String, dynamic> json) => Mappings(
      modelOperations: (json['modelOperations'] as List<dynamic>)
          .map((e) => ModelOperation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ModelOperation _$ModelOperationFromJson(Map<String, dynamic> json) =>
    ModelOperation(
      model: json['model'] as String,
      aggregate: json['aggregate'] as String,
      createMany: json['createMany'] as String,
      createOne: json['createOne'] as String,
      deleteMany: json['deleteMany'] as String,
      deleteOne: json['deleteOne'] as String,
      findFirst: json['findFirst'] as String,
      findMany: json['findMany'] as String,
      findUnique: json['findUnique'] as String,
      groupBy: json['groupBy'] as String,
      updateMany: json['updateMany'] as String,
      updateOne: json['updateOne'] as String,
      upsertOne: json['upsertOne'] as String,
    );
