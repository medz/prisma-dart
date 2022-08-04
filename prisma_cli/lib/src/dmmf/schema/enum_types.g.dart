// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumType _$EnumTypeFromJson(Map<String, dynamic> json) => EnumType(
      name: json['name'] as String,
      values:
          (json['values'] as List<dynamic>).map((e) => e as String).toList(),
    );

EnumTypesNamespace _$EnumTypesNamespaceFromJson(Map<String, dynamic> json) =>
    EnumTypesNamespace(
      prisma: (json['prisma'] as List<dynamic>?)
              ?.map((e) => EnumType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      model: (json['model'] as List<dynamic>?)
              ?.map((e) => EnumType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
