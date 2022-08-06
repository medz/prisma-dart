// See: https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'dmmf.g.dart';

/// Prisma DMMF document.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class Document {
  /// Create a new DMMF document.
  const Document({
    required this.datamodel,
    required this.schema,
    required this.mappings,
  });

  /// Prisma DMMF datamodel field.
  final Datamodel datamodel;

  /// Prisma DMMF scehma field.
  final Schema schema;

  /// Prisma DMMF mappings field.
  final Mappings mappings;

  /// Document from JSON factory constructor.
  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  /// Document as JSON map.
  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  /// Document as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Prisma DMMF mapping.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class Mappings {
  /// Create a new DMMF mapping.
  const Mappings({
    required this.modelOperations,
    required this.otherOperations,
  });

  /// Model operation mappings
  final List<ModelMapping> modelOperations;

  /// Mappings other operation mapping
  final OtherOperationMappings otherOperations;

  /// Mappings from JSON factory constructor.
  factory Mappings.fromJson(Map<String, dynamic> json) =>
      _$MappingsFromJson(json);

  /// Mappings as JSON map.
  Map<String, dynamic> toJson() => _$MappingsToJson(this);

  /// Mappings as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Other operation mapping.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class OtherOperationMappings {
  /// Read operations
  final List<String> read;

  /// Write operations
  final List<String> write;

  /// Create a new other operation mapping.
  const OtherOperationMappings({
    required this.read,
    required this.write,
  });

  /// Other operation mapping from JSON factory constructor.
  factory OtherOperationMappings.fromJson(Map<String, dynamic> json) =>
      _$OtherOperationMappingsFromJson(json);

  /// Other operation mapping as JSON map.
  Map<String, dynamic> toJson() => _$OtherOperationMappingsToJson(this);

  /// Other operation mapping as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Model operation mapping.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class ModelMapping {
  /// Model name
  final String model;

  /// Plural name
  final String plural;

  /// Find unique operation
  final String? findUnique;

  /// Find first operation
  final String? findFirst;

  /// Find many operation
  final String? findMany;

  /// Create operation
  final String? create;

  /// Create many operation
  final String? createMany;

  /// Update operation
  final String? update;

  /// Update many operation
  final String? updateMany;

  /// Upsert operation
  final String? upsert;

  /// Delete operation
  final String? delete;

  /// Delete many operation
  final String? deleteMany;

  /// Aggregate operation
  final String? aggregate;

  /// Group by operation
  final String? groupBy;

  /// Count operation
  final String? count;

  /// Find raw operation
  final String? findRaw;

  /// Aggregate raw operation
  final String? aggregateRaw;

  /// Create a new model operation mapping.
  const ModelMapping({
    required this.model,
    required this.plural,
    this.findUnique,
    this.findFirst,
    this.findMany,
    this.create,
    this.createMany,
    this.update,
    this.updateMany,
    this.upsert,
    this.delete,
    this.deleteMany,
    this.aggregate,
    this.groupBy,
    this.count,
    this.findRaw,
    this.aggregateRaw,
  });

  /// Model operation mapping from JSON factory constructor.
  factory ModelMapping.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$ModelMappingFromJson(json);
  }

  /// Model operation mapping as JSON map.
  Map<String, dynamic> toJson() => _$ModelMappingToJson(this);

  /// Model operation mapping as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Datemodel.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class Datamodel {
  /// Models.
  final List<Model> models;

  /// Datamodel enums.
  final List<DatamodelEnum> enums;

  /// types
  final List<Model> types;

  /// Create a new datamodel.
  const Datamodel({
    required this.models,
    required this.enums,
    required this.types,
  });

  /// Datemodel from JSON factory constructor.
  factory Datamodel.fromJson(Map<String, dynamic> json) =>
      _$DatamodelFromJson(json);

  /// Datemodel as JSON map.
  Map<String, dynamic> toJson() => _$DatamodelToJson(this);

  /// Datemodel as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Model Document.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class Model {
  /// Model name.
  final String name;

  /// Database name.
  final String? dbName;

  /// Model fields.
  final List<Field> fields;

  /// Field map.
  final Map<String, Field>? fieldsMap;

  /// Unique fields.
  final List<List<String>> uniqueFields;

  /// Unique indexes.
  final List<UniqueIndex> uniqueIndexes;

  /// documentation.
  final String? documentation;

  /// Primary key.
  final PrimaryKey? primaryKey;

  /// safe net for additional new props
  Map<String, dynamic>? extra;

  /// Create a new model.
  Model({
    required this.name,
    this.dbName,
    required this.fields,
    this.fieldsMap,
    required this.uniqueFields,
    required this.uniqueIndexes,
    this.documentation,
    this.primaryKey,
  }) : extra = {};

  /// Model from JSON factory constructor.
  factory Model.fromJson(Map<String, dynamic> json) =>
      _$ModelFromJson(json)..extra = json;

  /// Model as JSON map.
  Map<String, dynamic> toJson() =>
      <String, dynamic>{...extra ?? {}, ..._$ModelToJson(this)};

  /// Model as JSON string.
  @override
  String toString() => jsonEncode(toJson());

  /// [] operator.
  dynamic operator [](String key) => extra?[key];
}

/// Field document.
/// @See https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L88
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class Field {
  /// Field kind.
  final FieldKind kind;

  /// Field name.
  final String name;

  /// Is required.
  final bool isRequired;

  /// The Field is a list.
  final bool isList;

  /// The field is unique.
  final bool isUnique;

  /// The field is Identifier.
  final bool isId;

  /// The field is readonly.
  final bool isReadOnly;

  /// Is a generated field.
  ///
  /// ⚠️ does not exist on 'type' but does on 'model'
  final bool? isGenerated;

  /// Is updated at, Auto update [DateTime] field.
  ///
  /// ⚠️ does not exist on 'type' but does on 'model'
  final bool isUpdatedAt;

  /// Describes the data type in the same the way is is defined
  /// in the Prisma schema:
  ///
  /// BigInt, Boolean, Bytes, DateTime, Decimal, Float, Int, JSON, String, $ModelName
  final String type;

  /// Database names
  final List<String>? dbNames;

  /// Has default value.
  final bool hasDefaultValue;

  /// default value.
  @JsonKey(name: 'default')
  final dynamic $default;

  /// Relation from fields
  final List<String>? relationFromFields;

  /// Relation to fields
  final List<dynamic>? relationToFields;

  /// Relation on delete
  final String? relationOnDelete;

  /// relation name
  final String? relationName;

  /// documentation
  final String? documentation;

  /// Safe net for additional new props
  Map<String, dynamic>? additionalProperties;

  /// Create a new field.
  Field({
    required this.kind,
    required this.name,
    required this.isRequired,
    required this.isList,
    required this.isUnique,
    required this.isId,
    required this.isReadOnly,
    this.isGenerated,
    required this.isUpdatedAt,
    required this.type,
    this.dbNames,
    required this.hasDefaultValue,
    this.$default,
    this.relationFromFields,
    this.relationToFields,
    this.relationOnDelete,
    this.relationName,
    this.documentation,
  }) : additionalProperties = {};

  /// Field from JSON factory constructor.
  factory Field.fromJson(Map<String, dynamic> json) =>
      _$FieldFromJson(json)..additionalProperties = json;

  /// Field as JSON map.
  Map<String, dynamic> toJson() =>
      <String, dynamic>{...additionalProperties ?? {}, ..._$FieldToJson(this)};

  /// Field as JSON string.
  @override
  String toString() => jsonEncode(toJson());

  /// [] operator.
  dynamic operator [](String key) => additionalProperties?[key];
}

/// Field kind.
enum FieldKind {
  scalar,
  object,
  @JsonValue('enum')
  $enum,
  unsupported,
}

/// Field primary key.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class PrimaryKey {
  /// Prisma key name.
  final String? name;

  /// Primary key fields.
  final List<String> fields;

  /// Create a new primary key.
  const PrimaryKey({
    this.name,
    required this.fields,
  });

  /// Primary key from JSON factory constructor.
  factory PrimaryKey.fromJson(Map<String, dynamic> json) =>
      _$PrimaryKeyFromJson(json);

  /// Primary key as JSON map.
  Map<String, dynamic> toJson() => _$PrimaryKeyToJson(this);

  /// Primary key as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Unique Index
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class UniqueIndex {
  /// Unique index name.
  final String name;

  /// Unique index fields.
  final List<String> fields;

  /// Create a new unique index.
  const UniqueIndex({
    required this.name,
    required this.fields,
  });

  /// Unique index from JSON factory constructor.
  factory UniqueIndex.fromJson(Map<String, dynamic> json) =>
      _$UniqueIndexFromJson(json);

  /// Unique index as JSON map.
  Map<String, dynamic> toJson() => _$UniqueIndexToJson(this);

  /// Unique index as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Datamodel enum.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class DatamodelEnum {
  /// Enum name.
  final String name;

  /// enum values.
  final List<EnumValue> values;

  /// Database name.
  final String? dbName;

  /// Documentation.
  final String? documentation;

  /// Create a new datamodel enum.
  const DatamodelEnum({
    required this.name,
    required this.values,
    this.dbName,
    this.documentation,
  });

  /// Datamodel enum from JSON factory constructor.
  factory DatamodelEnum.fromJson(Map<String, dynamic> json) =>
      _$DatamodelEnumFromJson(json);

  /// Datamodel enum as JSON map.
  Map<String, dynamic> toJson() => _$DatamodelEnumToJson(this);

  /// Datamodel enum as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Enum value.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class EnumValue {
  /// Enum value name.
  final String name;

  /// Enum value database name.
  final String? dbName;

  /// Create a new enum value.
  const EnumValue({
    required this.name,
    this.dbName,
  });

  /// Enum value from JSON factory constructor.
  factory EnumValue.fromJson(Map<String, dynamic> json) =>
      _$EnumValueFromJson(json);

  /// Enum value as JSON map.
  Map<String, dynamic> toJson() => _$EnumValueToJson(this);

  /// Enum value as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Schema Document.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class Schema {
  /// Root query type.
  final String? rootQueryType;

  /// Root mutation type.
  final String? rootMutationType;

  /// Input object types.
  final InputObjectTypes inputObjectTypes;

  /// Output object types.
  final OutputObjectTypes outputObjectTypes;

  /// Enum types.
  final EnumTypes enumTypes;

  /// Create a new schema.
  const Schema({
    this.rootQueryType,
    this.rootMutationType,
    required this.inputObjectTypes,
    required this.outputObjectTypes,
    required this.enumTypes,
  });

  /// Schema from JSON factory constructor.
  factory Schema.fromJson(Map<String, dynamic> json) => _$SchemaFromJson(json);

  /// Schema as JSON map.
  Map<String, dynamic> toJson() => _$SchemaToJson(this);

  /// Schema as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Input object types.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class InputObjectTypes {
  /// For now there are no `model` [InputType].
  final List<InputType>? model;

  /// For prisma namespace [InputType].
  final List<InputType> prisma;

  /// Create a new input object types.
  const InputObjectTypes({
    this.model,
    required this.prisma,
  });

  /// Input object types from JSON factory constructor.
  factory InputObjectTypes.fromJson(Map<String, dynamic> json) =>
      _$InputObjectTypesFromJson(json);

  /// Input object types as JSON map.
  Map<String, dynamic> toJson() => _$InputObjectTypesToJson(this);

  /// Input object types as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Input type.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class InputType {
  /// Type name
  final String name;

  /// Type constraints.
  final InputConstraints? constraints;

  /// Schema args for fields.
  final List<SchemaArg> fields;

  /// Field map for schema args.
  final Map<String, SchemaArg>? fieldMap;

  /// Create a new input type.
  const InputType({
    required this.name,
    this.constraints,
    required this.fields,
    this.fieldMap,
  });

  /// Input type from JSON factory constructor.
  factory InputType.fromJson(Map<String, dynamic> json) =>
      _$InputTypeFromJson(json);

  /// Input type as JSON map.
  Map<String, dynamic> toJson() => _$InputTypeToJson(this);

  /// Input type as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Input constraints.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class InputConstraints {
  /// Max field number.
  final int? maxNumFields;

  /// Min field number.
  final int? minNumFields;

  /// Create a new input constraints.
  const InputConstraints({
    this.maxNumFields,
    this.minNumFields,
  });

  /// Input constraints from JSON factory constructor.
  factory InputConstraints.fromJson(Map<String, dynamic> json) =>
      _$InputConstraintsFromJson(json);

  /// Input constraints as JSON map.
  Map<String, dynamic> toJson() => _$InputConstraintsToJson(this);

  /// Input constraints as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Output object types.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class OutputObjectTypes {
  /// For mode namespace output types.
  final List<OutputType> model;

  /// For prisma namespace output types.
  final List<OutputType> prisma;

  /// Create a new output object types.
  const OutputObjectTypes({
    required this.model,
    required this.prisma,
  });

  /// Output object types from JSON factory constructor.
  factory OutputObjectTypes.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypesFromJson(json);

  /// Output object types as JSON map.
  Map<String, dynamic> toJson() => _$OutputObjectTypesToJson(this);

  /// Output object types as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Output type.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class OutputType {
  /// Type name.
  final String name;

  /// Output type fields, type is [SchemaField]
  final List<SchemaField> fields;

  /// Field map for output type fields.
  final Map<String, SchemaField>? fieldMap;

  /// Create a new output type.
  const OutputType({
    required this.name,
    required this.fields,
    this.fieldMap,
  });

  /// Output type from JSON factory constructor.
  factory OutputType.fromJson(Map<String, dynamic> json) =>
      _$OutputTypeFromJson(json);

  /// Output type as JSON map.
  Map<String, dynamic> toJson() => _$OutputTypeToJson(this);

  /// Output type as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Enum types.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class EnumTypes {
  /// For mode namespace enum types.
  final List<SchemaEnum>? model;

  /// For prisma namespace enum types.
  final List<SchemaEnum> prisma;

  /// Create a new enum types.
  const EnumTypes({
    this.model,
    required this.prisma,
  });

  /// Enum types from JSON factory constructor.
  factory EnumTypes.fromJson(Map<String, dynamic> json) =>
      _$EnumTypesFromJson(json);

  /// Enum types as JSON map.
  Map<String, dynamic> toJson() => _$EnumTypesToJson(this);

  /// Enum types as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Schema enum.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class SchemaEnum {
  /// Enum name.
  final String name;

  /// Enum values.
  final List<String> values;

  /// Create a new schema enum.
  const SchemaEnum({
    required this.name,
    required this.values,
  });

  /// Schema enum from JSON factory constructor.
  factory SchemaEnum.fromJson(Map<String, dynamic> json) =>
      _$SchemaEnumFromJson(json);

  /// Schema enum as JSON map.
  Map<String, dynamic> toJson() => _$SchemaEnumToJson(this);

  /// Schema enum as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Schema arg.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class SchemaArg {
  /// Arg name.
  final String name;

  /// Arg comment.
  final String? comment;

  /// Arg is nullable.
  final bool isNullable;

  /// Arg is required.
  final bool isRequired;

  /// Arg input types.
  final List<SchemaType> inputTypes;

  /// Arg deprecation.
  final Deprecation? deprecation;

  /// Create a new schema arg.
  const SchemaArg({
    required this.name,
    this.comment,
    required this.isNullable,
    required this.isRequired,
    required this.inputTypes,
    this.deprecation,
  });

  /// Schema arg from JSON factory constructor.
  factory SchemaArg.fromJson(Map<String, dynamic> json) =>
      _$SchemaArgFromJson(json);

  /// Schema arg as JSON map.
  Map<String, dynamic> toJson() => _$SchemaArgToJson(this);

  /// Schema arg as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Schema arg input type.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class SchemaType<T> {
  /// Input type is a list.
  final bool isList;

  /// Arg type.
  ///
  /// Type of [String]/[InputType]/[SchemaEnum]
  @_ArgTypeConverter<dynamic>()
  final T type;

  /// field location.
  final FieldLocation location;

  /// Field namespace.
  final FieldNamespace? namespace;

  /// Create a new schema arg input type.
  const SchemaType({
    required this.isList,
    required this.type,
    required this.location,
    this.namespace,
  });

  /// Schema arg input type from JSON factory constructor.
  factory SchemaType.fromJson(Map<String, dynamic> json) {
    return _$SchemaTypeFromJson<T>(json);
  }

  /// Schema arg input type as JSON map.
  Map<String, dynamic> toJson() => _$SchemaTypeToJson<T>(this);

  /// Schema arg input type as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Field location.
enum FieldNamespace {
  /// Field is a model field.
  model,

  /// Field is a prisma field.
  prisma,
}

/// Field namespace.
enum FieldLocation {
  /// Field namespace is scalar.
  scalar,

  /// Field namespace is input object types.
  inputObjectTypes,

  /// Field namespace is output object types.
  outputObjectTypes,

  /// Field namespace is enum types.
  enumTypes,
}

/// Deprecation info.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class Deprecation {
  /// Since version.
  final String sinceVersion;

  /// Reason.
  final String reason;

  /// Planned removal version.
  final String? plannedRemovalVersion;

  /// Create a new deprecation info.
  const Deprecation({
    required this.sinceVersion,
    required this.reason,
    this.plannedRemovalVersion,
  });

  /// Deprecation info from JSON factory constructor.
  factory Deprecation.fromJson(Map<String, dynamic> json) =>
      _$DeprecationFromJson(json);

  /// Deprecation info as JSON map.
  Map<String, dynamic> toJson() => _$DeprecationToJson(this);

  /// Deprecation info as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

/// Schema field.
@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class SchemaField {
  /// Field name.
  final String name;

  /// Field is nullable.
  final bool? isNullable;

  /// Field output type.
  final SchemaType outputType;

  /// Field args.
  final List<SchemaArg> args;

  /// Deprecation info.
  final Deprecation? deprecation;

  /// Documentation.
  final String? documentation;

  /// Create a new schema field.
  const SchemaField({
    required this.name,
    this.isNullable,
    required this.outputType,
    required this.args,
    this.deprecation,
    this.documentation,
  });

  /// Schema field from JSON factory constructor.
  factory SchemaField.fromJson(Map<String, dynamic> json) =>
      _$SchemaFieldFromJson(json);

  /// Schema field as JSON map.
  Map<String, dynamic> toJson() => _$SchemaFieldToJson(this);

  /// Schema field as JSON string.
  @override
  String toString() => jsonEncode(toJson());
}

//******************************************************************* */
//* Converters                                                        */
//******************************************************************* */

/// Arg type converter.
class _ArgTypeConverter<T> implements JsonConverter<T, dynamic> {
  const _ArgTypeConverter();

  @override
  T fromJson(dynamic json) {
    if (json is String) {
      return json as T;
    } else if (json is Map<String, dynamic>) {
      if (json['fields'] is List) {
        return InputType.fromJson(json) as T;
      }

      if (json['values'] is List) {
        return SchemaEnum.fromJson(json) as T;
      }
    }

    throw ArgumentError('Invalid type: $json');
  }

  @override
  dynamic toJson(T object) {
    if (object is String) {
      return object;
    } else if (object is InputType) {
      return object.toJson();
    } else if (object is SchemaEnum) {
      return object.toJson();
    }

    throw ArgumentError('Unknown type $object');
  }
}
