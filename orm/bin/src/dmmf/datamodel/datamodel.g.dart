// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datamodel _$DatamodelFromJson(Map<String, dynamic> json) => Datamodel(
      enums: (json['enums'] as List<dynamic>)
          .map((e) => DatamodelEnum.fromJson(e as Map<String, dynamic>))
          .toList(),
      models: (json['models'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
