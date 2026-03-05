import 'package:meta/meta.dart';

enum TypedFieldKind { scalar, relation }

enum TypedScalarType { string, integer, floating, boolean, dateTime, json }

extension TypedScalarTypeDartType on TypedScalarType {
  String get dartType {
    return switch (this) {
      TypedScalarType.string => 'String',
      TypedScalarType.integer => 'int',
      TypedScalarType.floating => 'double',
      TypedScalarType.boolean => 'bool',
      TypedScalarType.dateTime => 'DateTime',
      TypedScalarType.json => 'Object',
    };
  }
}

@immutable
final class TypedClientSchema {
  final List<TypedModel> models;

  TypedClientSchema({required List<TypedModel> models})
    : models = List<TypedModel>.unmodifiable(models);
}

@immutable
final class TypedModel {
  final String name;
  final String runtimeName;
  final List<TypedField> fields;

  TypedModel({
    required this.name,
    String? runtimeName,
    required List<TypedField> fields,
  }) : runtimeName = runtimeName ?? name,
       fields = List<TypedField>.unmodifiable(fields);
}

@immutable
final class TypedField {
  final String name;
  final TypedFieldKind kind;
  final TypedScalarType? scalarType;
  final String? relationModel;
  final bool isNullable;
  final bool isList;
  final bool includeInWhere;
  final bool includeInCreate;
  final bool includeInUpdate;

  const TypedField.scalar({
    required this.name,
    required TypedScalarType type,
    this.isNullable = false,
    this.isList = false,
    this.includeInWhere = true,
    this.includeInCreate = true,
    this.includeInUpdate = true,
  }) : kind = TypedFieldKind.scalar,
       scalarType = type,
       relationModel = null;

  const TypedField.relation({
    required this.name,
    required String model,
    this.isNullable = true,
    this.isList = false,
    this.includeInWhere = true,
    this.includeInCreate = true,
    this.includeInUpdate = true,
  }) : kind = TypedFieldKind.relation,
       scalarType = null,
       relationModel = model;

  bool get isScalar => kind == TypedFieldKind.scalar;

  bool get isRelation => kind == TypedFieldKind.relation;
}
