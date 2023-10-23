// DMMF copy of https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts

import 'core/json_convertible.dart';

part 'dmmf.g.dart';

@JsonConvertible.serializable
class Document implements JsonConvertible<Map<String, dynamic>> {
  final Datamodel datamodel;
  final Schema schema;
  final Mappings mappings;

  const Document({
    required this.datamodel,
    required this.schema,
    required this.mappings,
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
  final EnumTypes enumTypes;
  final FieldRefTypes fieldRefTypes;

  const Schema({
    this.rootQueryType,
    this.rootMutationType,
    required this.inputObjectTypes,
    required this.outputObjectTypes,
    required this.enumTypes,
    required this.fieldRefTypes,
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
  final List<TypeRef> inputTypes;
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

enum FieldLocation {
  scalar,
  inputObjectTypes,
  outputObjectTypes,
  enumTypes,
  fieldRefTypes,
}

@JsonConvertible.serializable
class TypeRef implements JsonConvertible<Map<String, dynamic>> {
  final bool isList;
  final String type;
  final FieldLocation location;
  final FieldNamespace? namespace;

  const TypeRef({
    required this.isList,
    required this.type,
    required this.location,
    this.namespace,
  });

  factory TypeRef.fromJson(Map<String, dynamic> json) =>
      _$TypeRefFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TypeRefToJson(this);
}

enum FieldNamespace { model, prisma }

@JsonConvertible.serializable
class Deprecation implements JsonConvertible<Map<String, String>> {
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
  Map<String, String> toJson() => _$DeprecationToJson(this).cast();
}

@JsonConvertible.serializable
class OutputObjectTypes implements JsonConvertible<Map<String, dynamic>> {
  final List<OutputType> model;
  final List<OutputType> prisma;

  const OutputObjectTypes({required this.model, required this.prisma});
  factory OutputObjectTypes.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypesFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OutputObjectTypesToJson(this);
}

@JsonConvertible.serializable
class OutputType implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final List<SchemaField> fields;

  const OutputType({required this.name, required this.fields});
  factory OutputType.fromJson(Map<String, dynamic> json) =>
      _$OutputTypeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OutputTypeToJson(this);
}

@JsonConvertible.serializable
class SchemaField implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final bool isNullable;
  final TypeRef outputType;
  final List<SchemaArg> args;
  final Deprecation? deprecation;
  final String? documentation;

  const SchemaField({
    required this.name,
    this.isNullable = false,
    required this.outputType,
    required this.args,
    this.deprecation,
    this.documentation,
  });

  factory SchemaField.fromJson(Map<String, dynamic> json) =>
      _$SchemaFieldFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SchemaFieldToJson(this);
}

enum OutputTypeRefAllowedLocations { scalar, outputObjectTypes, enumTypes }

@JsonConvertible.serializable
class EnumTypes implements JsonConvertible<Map<String, dynamic>> {
  final List<SchemaEnum>? model;
  final List<SchemaEnum> prisma;

  const EnumTypes({this.model, required this.prisma});

  factory EnumTypes.fromJson(Map<String, dynamic> json) =>
      _$EnumTypesFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EnumTypesToJson(this);
}

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

@JsonConvertible.serializable
class FieldRefTypes implements JsonConvertible<Map<String, dynamic>> {
  final List<FieldRefType>? prisma;

  const FieldRefTypes({required this.prisma});
  factory FieldRefTypes.fromJson(Map<String, dynamic> json) =>
      _$FieldRefTypesFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FieldRefTypesToJson(this);
}

@JsonConvertible.serializable
class FieldRefType implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final List<TypeRef> allowTypes;
  final List<SchemaArg> fields;

  const FieldRefType({
    required this.name,
    required this.allowTypes,
    required this.fields,
  });

  factory FieldRefType.fromJson(Map<String, dynamic> json) =>
      _$FieldRefTypeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FieldRefTypeToJson(this);
}

@JsonConvertible.serializable
class Mappings implements JsonConvertible<Map<String, dynamic>> {
  final List<ModelMapping> modelOperations;
  final OtherOperations otherOperations;

  const Mappings({
    required this.modelOperations,
    required this.otherOperations,
  });

  factory Mappings.fromJson(Map<String, dynamic> json) =>
      _$MappingsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MappingsToJson(this);
}

@JsonConvertible.serializable
class OtherOperations implements JsonConvertible<Map<String, List<String>>> {
  final List<String> read;
  final List<String> write;

  const OtherOperations({required this.read, required this.write});

  factory OtherOperations.fromJson(Map<String, dynamic> json) =>
      _$OtherOperationsFromJson(json);

  @override
  Map<String, List<String>> toJson() => _$OtherOperationsToJson(this).cast();
}

@JsonConvertible.serializable
class ModelMapping implements JsonConvertible<Map<String, String>> {
  final String model;
  final String? plural;
  final String? findUnique;
  final String? findUniqueOrThrow;
  final String? findFirst;
  final String? findMany;
  final String? create;
  final String? createMany;
  final String? update;
  final String? updateMany;
  final String? upsert;
  final String? delete;
  final String? deleteMany;
  final String? aggregate;
  final String? groupBy;
  final String? count;
  final String? findRaw;
  final String? aggregateRaw;

  const ModelMapping({
    required this.model,
    this.plural,
    @JsonKey(readValue: _readModelMappingValue) this.findUnique,
    @JsonKey(readValue: _readModelMappingValue) this.findUniqueOrThrow,
    @JsonKey(readValue: _readModelMappingValue) this.findFirst,
    @JsonKey(readValue: _readModelMappingValue) this.findMany,
    @JsonKey(readValue: _readModelMappingValue) this.create,
    @JsonKey(readValue: _readModelMappingValue) this.createMany,
    @JsonKey(readValue: _readModelMappingValue) this.update,
    @JsonKey(readValue: _readModelMappingValue) this.updateMany,
    @JsonKey(readValue: _readModelMappingValue) this.upsert,
    @JsonKey(readValue: _readModelMappingValue) this.delete,
    @JsonKey(readValue: _readModelMappingValue) this.deleteMany,
    @JsonKey(readValue: _readModelMappingValue) this.aggregate,
    @JsonKey(readValue: _readModelMappingValue) this.groupBy,
    @JsonKey(readValue: _readModelMappingValue) this.count,
    @JsonKey(readValue: _readModelMappingValue) this.findRaw,
    @JsonKey(readValue: _readModelMappingValue) this.aggregateRaw,
  });

  factory ModelMapping.fromJson(Map<String, dynamic> json) =>
      _$ModelMappingFromJson(json);

  @override
  Map<String, String> toJson() => _$ModelMappingToJson(this).cast();
}

Object? _readModelMappingValue(Map json, String key) {
  if (json.containsKey(key)) return json[key];

  final withOneKey = '${key}One';
  if (json.containsKey(withOneKey)) return json[withOneKey];

  if (key.length > 3 && key.endsWith('One')) {
    final withoutOneKey = key.substring(0, key.length - 3);
    if (json.containsKey(withoutOneKey)) return json[withoutOneKey];
  }

  return null;
}
