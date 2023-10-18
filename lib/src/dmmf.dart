// DMMF copy of https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts

import 'runtime/json_convertible.dart';

part 'dmmf.g.dart';

@JsonConvertible.serializable
class Document implements JsonConvertible<Map<String, dynamic>> {
  final Datamodel datamodel;
  // final Schema schema;
  // final Mappings mappings;

  const Document({
    required this.datamodel,
    // required this.schema,
    // required this.mappings,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}

@JsonConvertible.serializable
class Datamodel implements JsonConvertible<Map<String, dynamic>> {
  final List<Model> models;
  final List<DatamodelEnum> enums;
  final List<Model> types;

  const Datamodel({
    required this.models,
    required this.enums,
    required this.types,
  });

  factory Datamodel.fromJson(Map<String, dynamic> json) =>
      _$DatamodelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DatamodelToJson(this);
}

@JsonConvertible.serializable
class Model implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final String? dbName;
  final List<Field> fields;
  final List<List<String>> uniqueFields;
  final List<UniqueIndex> uniqueIndexes;
  final String? documentation;
  final PrimaryKey? primaryKey;
  final bool isGenerated;

  const Model({
    required this.name,
    this.dbName,
    required this.fields,
    required this.uniqueFields,
    required this.uniqueIndexes,
    this.documentation,
    this.primaryKey,
    this.isGenerated = false,
  });

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}

@JsonConvertible.serializable
class Field implements JsonConvertible<Map<String, dynamic>> {
  final FieldKind kind;
  final String name;
  final bool isRequired;
  final bool isList;
  final bool isUnique;
  final bool isId;
  final bool isReadOnly;
  final bool? isGenerated; // does not exist on 'type' but does on 'model'
  final bool? isUpdatedAt; // does not exist on 'type' but does on 'model'
  final String type;
  final String? dbName;
  final bool hasDefaultValue;

  @JsonKey(name: 'default')
  final dynamic default_;

  final List<String>? relationFromFields;
  final List? relationToFields;
  final String? relationOnDelete;
  final String? relationName;
  final String? documentation;

  const Field({
    required this.kind,
    required this.name,
    required this.isRequired,
    required this.isList,
    required this.isUnique,
    required this.isId,
    required this.isReadOnly,
    this.isGenerated,
    this.isUpdatedAt,
    required this.type,
    this.dbName,
    required this.hasDefaultValue,
    this.default_,
    this.relationFromFields,
    this.relationToFields,
    this.relationOnDelete,
    this.relationName,
    this.documentation,
  });

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

enum FieldKind {
  scalar,
  object,
  @JsonValue('enum')
  enum_,
  unsupported,
}

@JsonConvertible.serializable
class UniqueIndex implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final List<String> fields;

  const UniqueIndex({required this.name, required this.fields});
  factory UniqueIndex.fromJson(Map<String, dynamic> json) =>
      _$UniqueIndexFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UniqueIndexToJson(this);
}

@JsonConvertible.serializable
class PrimaryKey implements JsonConvertible<Map<String, dynamic>> {
  final String? name;
  final List<String> fields;

  const PrimaryKey({this.name, required this.fields});
  factory PrimaryKey.fromJson(Map<String, dynamic> json) =>
      _$PrimaryKeyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PrimaryKeyToJson(this);
}

@JsonConvertible.serializable
class DatamodelEnum implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final List<EnumValue> values;
  final String? dbName;
  final String? documentation;

  const DatamodelEnum({
    required this.name,
    required this.values,
    this.dbName,
    this.documentation,
  });

  factory DatamodelEnum.fromJson(Map<String, dynamic> json) =>
      _$DatamodelEnumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DatamodelEnumToJson(this);
}

@JsonConvertible.serializable
class EnumValue implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final String? dbName;

  const EnumValue({required this.name, this.dbName});
  factory EnumValue.fromJson(Map<String, dynamic> json) =>
      _$EnumValueFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EnumValueToJson(this);
}

@JsonConvertible.serializable
class Schema implements JsonConvertible<Map<String, dynamic>> {
  final String? rootQueryType;
  final String? rootMutationType;
  final InputObjectTypes inputObjectTypes;
  final OutputObjectTypes outputObjectTypes;
  // final EnumTypes enumTypes;
  // final FieldRefTypes fieldRefTypes;

  const Schema({
    this.rootQueryType,
    this.rootMutationType,
    required this.inputObjectTypes,
    required this.outputObjectTypes,
    // required this.enumTypes,
    // required this.fieldRefTypes,
  });

  factory Schema.fromJson(Map<String, dynamic> json) => _$SchemaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SchemaToJson(this);
}

@JsonConvertible.serializable
class InputObjectTypes implements JsonConvertible<Map<String, dynamic>> {
  final List<InputType>? model;
  final List<InputType>? prisma;

  const InputObjectTypes({this.model, this.prisma});
  factory InputObjectTypes.fromJson(Map<String, dynamic> json) =>
      _$InputObjectTypesFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InputObjectTypesToJson(this);
}

@JsonConvertible.serializable
class InputType implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final Constraints constraints;
  final Meta? meta;
  final List<SchemaArg> fields;

  const InputType({
    required this.name,
    required this.constraints,
    this.meta,
    required this.fields,
  });

  factory InputType.fromJson(Map<String, dynamic> json) =>
      _$InputTypeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InputTypeToJson(this);
}

@JsonConvertible.serializable
class Constraints implements JsonConvertible<Map<String, dynamic>> {
  final int? maxNumFields;
  final int? minNumFields;
  final List<String>? fields;

  const Constraints({this.maxNumFields, this.minNumFields, this.fields});
  factory Constraints.fromJson(Map<String, dynamic> json) =>
      _$ConstraintsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ConstraintsToJson(this);
}

@JsonConvertible.serializable
class Meta implements JsonConvertible<Map<String, dynamic>> {
  final String? source;

  const Meta({this.source});
  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonConvertible.serializable
class SchemaArg implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final String? comment;
  final bool isNullable;
  final bool isRequired;
  final List<InputTypeRef> inputTypes;
  final Deprecation? deprecation;

  const SchemaArg({
    required this.name,
    this.comment,
    required this.isNullable,
    required this.isRequired,
    required this.inputTypes,
    this.deprecation,
  });

  factory SchemaArg.fromJson(Map<String, dynamic> json) =>
      _$SchemaArgFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SchemaArgToJson(this);
}

abstract class TypeRef<T extends Enum>
    implements JsonConvertible<Map<String, dynamic>> {
  final bool isList;
  final String type;
  final FieldNamespace namespace;

  const TypeRef({
    required this.isList,
    required this.type,
    required this.namespace,
  });

  abstract final T location;
}

enum FieldNamespace { model, prisma }

enum InputTypeRefAllowedLocations {
  scalar,
  inputObjectTypes,
  enumTypes,
  fieldRefTypes,
}

@JsonConvertible.serializable
class InputTypeRef extends TypeRef<InputTypeRefAllowedLocations> {
  @override
  final InputTypeRefAllowedLocations location;

  const InputTypeRef({
    required this.location,
    required super.isList,
    required super.type,
    required super.namespace,
  });

  factory InputTypeRef.fromJson(Map<String, dynamic> json) =>
      _$InputTypeRefFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InputTypeRefToJson(this);
}

@JsonConvertible.serializable
class Deprecation implements JsonConvertible<Map<String, dynamic>> {
  final String sinceVersion;
  final String reason;
  final String? plannedRemovalVersion;

  const Deprecation({
    required this.sinceVersion,
    required this.reason,
    this.plannedRemovalVersion,
  });

  factory Deprecation.fromJson(Map<String, dynamic> json) =>
      _$DeprecationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeprecationToJson(this);
}

@JsonConvertible.serializable
class OutputObjectTypes implements JsonConvertible<Map<String, dynamic>> {}

// ---------------------
@JsonConvertible.serializable
class SchemaEnum implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final List<String> values;

  const SchemaEnum({required this.name, required this.values});
  factory SchemaEnum.fromJson(Map<String, dynamic> json) =>
      _$SchemaEnumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SchemaEnumToJson(this);
}

// enum FieldLocation {
//   scalar,
//   inputObjectTypes,
//   outputObjectTypes,
//   enumTypes,
//   fieldRefTypes,
// }
