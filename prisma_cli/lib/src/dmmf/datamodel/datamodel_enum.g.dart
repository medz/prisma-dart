// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodel_enum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatamodelEnum _$DatamodelEnumFromJson(Map<String, dynamic> json) =>
    DatamodelEnum(
      name: json['name'] as String,
      values: (json['values'] as List<dynamic>)
          .map((e) => BaseDbNameObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      dbName: json['dbName'] as String?,
    );
