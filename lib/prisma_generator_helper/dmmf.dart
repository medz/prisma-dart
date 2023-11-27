/// Prisma DMMF.
///
/// Copy from https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts
///
/// DMMF is the Prisma Data Model Metaformat.
///
/// It is a JSON representation of the Prisma schema.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dmmf.freezed.dart';
part 'dmmf.g.dart';

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L3
@freezed
class Document with _$Document {
  const factory Document({
    required Datamodel datamodel,
    required Schema schema,
    required Mappings mappings,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L39
@freezed
class Datamodel with _$Datamodel {
  const factory Datamodel({
    required List<Model> models,
    required List<DatamodelEnum> enums,
    required List<Model> types,
  }) = _Datamodel;

  factory Datamodel.fromJson(Map<String, dynamic> json) =>
      _$DatamodelFromJson(json);
}

@freezed
class Model with _$Model {
  const factory Model({
    required String name,
    String? dbName,
    required List<Field> fields,
    required List<List<String>> uniqueFields,
    required List<UniqueIndex> uniqueIndexes,
    String? documentation,
    PrimaryKey? primaryKey,
    bool? isGenerated,
  }) = _Model;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
}

@freezed
class Field with _$Field {
  const factory Field({
    required FieldKind kind,
    required String name,
    required bool isRequired,
    required bool isList,
    required bool isUnique,
    required bool isId,
    required bool isReadOnly,
    bool? isGenerated,
    bool? isUpdatedAt,
    required String type,
    String? dbName,
    required bool hasDefaultValue,
    Object? default$,
    List<String>? relationFromFields,
    List<dynamic>? relationToFields,
    String? relationOnDelete,
    String? relationName,
    String? documentation,
  }) = _Field;

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
}

/// Field kind.
enum FieldKind {
  scalar,
  object,

  @JsonValue('enum')
  enum$,

  unsupported,
}

/// Field namespace.
enum FieldNamespace {
  model,
  prisma,
}

/// Field Location.
enum FieldLocation {
  scalar,
  inputObjectTypes,
  outputObjectTypes,
  enumTypes,
  fieldRefTypes,
}

@freezed
class UniqueIndex with _$UniqueIndex {
  const factory UniqueIndex({
    String? name,
    required List<String> fields,
  }) = _UniqueIndex;

  factory UniqueIndex.fromJson(Map<String, dynamic> json) =>
      _$UniqueIndexFromJson(json);
}

@freezed
class PrimaryKey with _$PrimaryKey {
  const factory PrimaryKey({
    String? name,
    required List<String> fields,
  }) = _PrimaryKey;

  factory PrimaryKey.fromJson(Map<String, dynamic> json) =>
      _$PrimaryKeyFromJson(json);
}

@freezed
class DatamodelEnum with _$DatamodelEnum {
  const factory DatamodelEnum({
    required String name,
    required List<EnumValue> values,
    String? dbName,
    String? documentation,
  }) = _DatamodelEnum;

  factory DatamodelEnum.fromJson(Map<String, dynamic> json) =>
      _$DatamodelEnumFromJson(json);
}

@freezed
class EnumValue with _$EnumValue {
  const factory EnumValue({
    required String name,
    String? dbName,
  }) = _EnumValue;

  factory EnumValue.fromJson(Map<String, dynamic> json) =>
      _$EnumValueFromJson(json);
}

@freezed
class Mappings with _$Mappings {
  const factory Mappings({
    required List<ModelMapping> modelOperations,
    required OtherOperations otherOperations,
  }) = _Mappings;

  factory Mappings.fromJson(Map<String, dynamic> json) =>
      _$MappingsFromJson(json);
}

@freezed
class OtherOperations with _$OtherOperations {
  const factory OtherOperations({
    required List<String> read,
    required List<String> write,
  }) = _OtherOperations;

  factory OtherOperations.fromJson(Map<String, dynamic> json) =>
      _$OtherOperationsFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L102
@freezed
class Schema with _$Schema {
  const factory Schema({
    String? rootQueryType,
    String? rootMutationType,
    required InputObjectTypes inputObjectTypes,
    required OutputObjectTypes outputObjectTypes,
    required EnumTypes enumTypes,
    required FieldRefTypes fieldRefTypes,
  }) = _Schema;

  factory Schema.fromJson(Map<String, dynamic> json) => _$SchemaFromJson(json);
}

@freezed
class InputObjectTypes with _$InputObjectTypes {
  const factory InputObjectTypes({
    List<InputType>? model,
    required List<InputType> prisma,
  }) = _InputObjectTypes;

  factory InputObjectTypes.fromJson(Map<String, dynamic> json) =>
      _$InputObjectTypesFromJson(json);
}

@freezed
class InputType with _$InputType {
  const factory InputType({
    required String name,
    required Constraints constraints,
    Meta? meta,
    required List<SchemaArg> fields,
    Map<String, SchemaArg>? fieldsMap,
  }) = _InputType;

  factory InputType.fromJson(Map<String, dynamic> json) =>
      _$InputTypeFromJson(json);
}

@freezed
class Constraints with _$Constraints {
  const factory Constraints({
    int? maxNumFields,
    int? minNumFields,
    List<String>? fields,
  }) = _Constraints;

  factory Constraints.fromJson(Map<String, dynamic> json) =>
      _$ConstraintsFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    String? source,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L145
@freezed
class SchemaArg with _$SchemaArg {
  const factory SchemaArg({
    required String name,
    String? comment,
    required bool isNullable,
    required bool isRequired,
    required List<SchemaArgInputType> inputTypes,
    Deprecation? deprecation,
  }) = _SchemaArg;

  factory SchemaArg.fromJson(Map<String, dynamic> json) =>
      _$SchemaArgFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L191
@freezed
class Deprecation with _$Deprecation {
  const factory Deprecation({
    required String sinceVersion,
    required String reason,
    String? plannedRemovalVersion,
  }) = _Deprecation;

  factory Deprecation.fromJson(Map<String, dynamic> json) =>
      _$DeprecationFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L138
@freezed
class SchemaArgInputType with _$SchemaArgInputType {
  const factory SchemaArgInputType({
    required bool isList,
    @_ArgTypeConverter() required ArgType type,
    required FieldLocation location,
    FieldNamespace? namespace,
  }) = _SchemaArgInputType;

  factory SchemaArgInputType.fromJson(Map<String, dynamic> json) =>
      _$SchemaArgInputTypeFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L136
@freezed
sealed class ArgType with _$ArgType {
  const factory ArgType.string(String value) = StringArgType;
  const factory ArgType.object(InputType value) = ObjectArgType;
  const factory ArgType.enum_(SchemaEnum value) = EnumArgType;

  factory ArgType.fromJson(Map<String, dynamic> json) =>
      _$ArgTypeFromJson(json);
}

class _ArgTypeConverter implements JsonConverter<ArgType, Object> {
  const _ArgTypeConverter();

  String resolveRuntimeType(Object json) {
    if (json is String) {
      return 'string';
    } else if (json case {'constraints': Map}) {
      return 'input';
    } else if (json case {'values': List}) {
      return 'enum_';
    }

    throw Exception('Could not resolve runtime type for $json');
  }

  @override
  ArgType fromJson(Object json) {
    if (json case {'runtimeType': String, 'value': Object?}) {
      return ArgType.fromJson(json.cast());
    }

    return ArgType.fromJson({
      'value': json,
      'runtimeType': resolveRuntimeType(json),
    });
  }

  @override
  Object toJson(ArgType object) {
    return switch (object) {
      StringArgType(value: final value) => value,
      ObjectArgType(value: final input) => input.toJson(),
      EnumArgType(value: final enum_) => enum_.toJson(),
    };
  }
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L29
@freezed
class SchemaEnum with _$SchemaEnum {
  const factory SchemaEnum({
    required String name,
    required List<String> values,
  }) = _SchemaEnum;

  factory SchemaEnum.fromJson(Map<String, dynamic> json) =>
      _$SchemaEnumFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L105
@freezed
class OutputObjectTypes with _$OutputObjectTypes {
  const factory OutputObjectTypes({
    required List<OutputType> model,
    required List<OutputType> prisma,
  }) = _OutputObjectTypes;

  factory OutputObjectTypes.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypesFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L154
@freezed
class OutputType with _$OutputType {
  const factory OutputType({
    required String name,
    required List<SchemaField> fields,
    Map<String, SchemaField>? fieldsMap,
  }) = _OutputType;

  factory OutputType.fromJson(Map<String, dynamic> json) =>
      _$OutputTypeFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L160
@freezed
class SchemaField with _$SchemaField {
  const factory SchemaField({
    required String name,
    bool? isNullable,
    required OutputTypeRef outputType,
    required List<SchemaArg> args,
    Deprecation? deprecation,
    String? documentation,
  }) = _SchemaField;

  factory SchemaField.fromJson(Map<String, dynamic> json) =>
      _$SchemaFieldFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L189
@freezed
class OutputTypeRef with _$OutputTypeRef {
  const factory OutputTypeRef({
    required bool isList,
    FieldNamespace? namespace,
    required FieldLocation location,
    @_OutputTypeRefTypeConverter() required OutputTypeRefType type,
  }) = _OutputTypeRef;

  factory OutputTypeRef.fromJson(Map<String, dynamic> json) =>
      _$OutputTypeRefFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L176
/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L181
/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L186
@freezed
sealed class OutputTypeRefType with _$OutputTypeRefType {
  const factory OutputTypeRefType.string(String value) =
      StringOutputTypeRefType;
  const factory OutputTypeRefType.object(OutputType value) =
      ObjectOutputTypeRefType;
  const factory OutputTypeRefType.enum_(SchemaEnum value) =
      EnumOutputTypeRefType;

  factory OutputTypeRefType.fromJson(Map<String, dynamic> json) =>
      _$OutputTypeRefTypeFromJson(json);
}

class _OutputTypeRefTypeConverter
    implements JsonConverter<OutputTypeRefType, Object> {
  const _OutputTypeRefTypeConverter();

  resolveRuntimeType(Object json) {
    if (json is String) {
      return 'string';
    } else if (json is Map && json.containsKey('name')) {
      if (json.containsKey('fields')) {
        return 'output';
      } else if (json.containsKey('values')) {
        return 'enum_';
      }
    }

    throw Exception('Invalid OutputTypeRefType');
  }

  @override
  OutputTypeRefType fromJson(Object json) {
    if (json case {'runtimeType': String runtimeType, 'value': Object value}) {
      return OutputTypeRefType.fromJson({
        'value': value,
        'runtimeType': runtimeType,
      });
    }

    return OutputTypeRefType.fromJson({
      'value': json,
      'runtimeType': resolveRuntimeType(json),
    });
  }

  @override
  Object toJson(OutputTypeRefType object) {
    return switch (object) {
      StringOutputTypeRefType(value: final value) => value,
      ObjectOutputTypeRefType(value: final outout) => outout.toJson(),
      EnumOutputTypeRefType(value: final enum_) => enum_.toJson(),
    };
  }
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L114
@freezed
class EnumTypes with _$EnumTypes {
  const factory EnumTypes({
    List<SchemaEnum>? model,
    required List<SchemaEnum> prisma,
  }) = _EnumTypes;

  factory EnumTypes.fromJson(Map<String, dynamic> json) =>
      _$EnumTypesFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L118
@freezed
class FieldRefTypes with _$FieldRefTypes {
  const factory FieldRefTypes({
    List<FieldRefType>? prisma,
  }) = _FieldRefTypes;

  factory FieldRefTypes.fromJson(Map<String, dynamic> json) =>
      _$FieldRefTypesFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L211
@freezed
class FieldRefType with _$FieldRefType {
  const factory FieldRefType({
    required String name,
    required List<OutputTypeRef> allowTypes,
    required List<SchemaArg> fields,
  }) = _FieldRefType;

  factory FieldRefType.fromJson(Map<String, dynamic> json) =>
      _$FieldRefTypeFromJson(json);
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L219
@freezed
class ModelMapping with _$ModelMapping {
  const factory ModelMapping({
    required String model,
    String? plural,
    @JsonKey(readValue: _modelMappingActionValueReader) String? findUnique,
    @JsonKey(readValue: _modelMappingActionValueReader)
    String? findUniqueOrThrow,
    @JsonKey(readValue: _modelMappingActionValueReader) String? findFirst,
    @JsonKey(readValue: _modelMappingActionValueReader)
    String? findFirstOrThrow,
    @JsonKey(readValue: _modelMappingActionValueReader) String? findMany,
    @JsonKey(readValue: _modelMappingActionValueReader) String? create,
    @JsonKey(readValue: _modelMappingActionValueReader) String? createMany,
    @JsonKey(readValue: _modelMappingActionValueReader) String? update,
    @JsonKey(readValue: _modelMappingActionValueReader) String? updateMany,
    @JsonKey(readValue: _modelMappingActionValueReader) String? upsert,
    @JsonKey(readValue: _modelMappingActionValueReader) String? delete,
    @JsonKey(readValue: _modelMappingActionValueReader) String? deleteMany,
    @JsonKey(readValue: _modelMappingActionValueReader) String? aggregate,
    @JsonKey(readValue: _modelMappingActionValueReader) String? groupBy,
    @JsonKey(readValue: _modelMappingActionValueReader) String? count,
    @JsonKey(readValue: _modelMappingActionValueReader) String? findRaw,
    @JsonKey(readValue: _modelMappingActionValueReader) String? aggregateRaw,
  }) = _ModelMapping;

  factory ModelMapping.fromJson(Map<String, dynamic> json) =>
      _$ModelMappingFromJson(json);
}

/// Model mapping action `one` suffix value reader.
_modelMappingActionValueReader(Map json, String key) {
  if (json.containsKey(key)) return json[key];

  final keyWithOneSuffix = '${key}One';
  if (json.containsKey(keyWithOneSuffix)) return json[keyWithOneSuffix];

  final suffix = key.substring(key.length - 3).toLowerCase();
  if (suffix == 'one') {
    final keyWithoutOneSuffix = key.substring(0, key.length - 3);

    return _modelMappingActionValueReader(json, keyWithoutOneSuffix);
  }

  return null;
}

/// @see https://github.com/prisma/prisma/blob/main/packages/generator-helper/src/dmmf.ts#L241
/// Model Action
enum ModelAction {
  findUnique,
  findUniqueOrThrow,
  findFirst,
  findFirstOrThrow,
  findMany,
  create,
  createMany,
  update,
  updateMany,
  upsert,
  delete,
  deleteMany,
  groupBy,
  count,
  aggregate,
  findRaw,
  aggregateRaw;

  /// Read model action protocol name.
  String? protocolName(ModelMapping mapping) {
    final json = mapping.toJson();
    final action = json[name];
    if (action is String) return action;

    return null;
  }

  /// Generate model action protocol name map.
  static Map<String, String> protocolNamesMap(ModelMapping mapping) {
    final entries = ModelAction.values
        .map((e) => (e.name, e.protocolName(mapping)))
        .whereType<(String, String)>()
        .map((e) => MapEntry(e.$1, e.$2));

    return Map.fromEntries(entries);
  }
}
