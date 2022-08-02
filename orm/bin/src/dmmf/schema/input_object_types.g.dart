// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_object_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputObjectType _$InputObjectTypeFromJson(Map<String, dynamic> json) =>
    InputObjectType(
      name: json['name'] as String,
      constraints: InputObjectTypeConstraints.fromJson(
          json['constraints'] as Map<String, dynamic>),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => InputObjectTypeField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

InputObjectTypesNamespace _$InputObjectTypesNamespaceFromJson(
        Map<String, dynamic> json) =>
    InputObjectTypesNamespace(
      (json['prisma'] as List<dynamic>)
          .map((e) => InputObjectType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

InputObjectTypeConstraints _$InputObjectTypeConstraintsFromJson(
        Map<String, dynamic> json) =>
    InputObjectTypeConstraints(
      maxNumFields: json['maxNumFields'] as int?,
      minNumFields: json['minNumFields'] as int?,
    );

InputObjectTypeField _$InputObjectTypeFieldFromJson(
        Map<String, dynamic> json) =>
    InputObjectTypeField(
      name: json['name'] as String,
      isRequired: json['isRequired'] as bool,
      isNullable: json['isNullable'] as bool,
      inputTypes: (json['inputTypes'] as List<dynamic>)
          .map((e) => InputOutputType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
