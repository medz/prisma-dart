// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dmmf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      datamodel: Datamodel.fromJson(json['datamodel'] as Map<String, dynamic>),
      schema: Schema.fromJson(json['schema'] as Map<String, dynamic>),
      mappings: Mappings.fromJson(json['mappings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'datamodel': instance.datamodel.toJson(),
      'schema': instance.schema.toJson(),
      'mappings': instance.mappings.toJson(),
    };

Mappings _$MappingsFromJson(Map<String, dynamic> json) => Mappings(
      modelOperations: (json['modelOperations'] as List<dynamic>)
          .map((e) => ModelMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherOperations: OtherOperationMappings.fromJson(
          json['otherOperations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MappingsToJson(Mappings instance) => <String, dynamic>{
      'modelOperations':
          instance.modelOperations.map((e) => e.toJson()).toList(),
      'otherOperations': instance.otherOperations.toJson(),
    };

OtherOperationMappings _$OtherOperationMappingsFromJson(
        Map<String, dynamic> json) =>
    OtherOperationMappings(
      read: (json['read'] as List<dynamic>).map((e) => e as String).toList(),
      write: (json['write'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OtherOperationMappingsToJson(
        OtherOperationMappings instance) =>
    <String, dynamic>{
      'read': instance.read,
      'write': instance.write,
    };

ModelMapping _$ModelMappingFromJson(Map<String, dynamic> json) => ModelMapping(
      model: json['model'] as String,
      plural: json['plural'] as String?,
      findUnique: json['findUnique'] as String?,
      findFirst: json['findFirst'] as String?,
      findMany: json['findMany'] as String?,
      create: json['create'] as String?,
      createMany: json['createMany'] as String?,
      update: json['update'] as String?,
      updateMany: json['updateMany'] as String?,
      upsert: json['upsert'] as String?,
      delete: json['delete'] as String?,
      deleteMany: json['deleteMany'] as String?,
      aggregate: json['aggregate'] as String?,
      groupBy: json['groupBy'] as String?,
      count: json['count'] as String?,
      findRaw: json['findRaw'] as String?,
      aggregateRaw: json['aggregateRaw'] as String?,
    );

Map<String, dynamic> _$ModelMappingToJson(ModelMapping instance) =>
    <String, dynamic>{
      'model': instance.model,
      'plural': instance.plural,
      'findUnique': instance.findUnique,
      'findFirst': instance.findFirst,
      'findMany': instance.findMany,
      'create': instance.create,
      'createMany': instance.createMany,
      'update': instance.update,
      'updateMany': instance.updateMany,
      'upsert': instance.upsert,
      'delete': instance.delete,
      'deleteMany': instance.deleteMany,
      'aggregate': instance.aggregate,
      'groupBy': instance.groupBy,
      'count': instance.count,
      'findRaw': instance.findRaw,
      'aggregateRaw': instance.aggregateRaw,
    };

Datamodel _$DatamodelFromJson(Map<String, dynamic> json) => Datamodel(
      models: (json['models'] as List<dynamic>)
          .map((e) => Model.fromJson(e as Map<String, dynamic>))
          .toList(),
      enums: (json['enums'] as List<dynamic>)
          .map((e) => DatamodelEnum.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((e) => Model.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatamodelToJson(Datamodel instance) => <String, dynamic>{
      'models': instance.models.map((e) => e.toJson()).toList(),
      'enums': instance.enums.map((e) => e.toJson()).toList(),
      'types': instance.types.map((e) => e.toJson()).toList(),
    };

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      name: json['name'] as String,
      dbName: json['dbName'] as String?,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldsMap: (json['fieldsMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Field.fromJson(e as Map<String, dynamic>)),
      ),
      uniqueFields: (json['uniqueFields'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      uniqueIndexes: (json['uniqueIndexes'] as List<dynamic>)
          .map((e) => UniqueIndex.fromJson(e as Map<String, dynamic>))
          .toList(),
      documentation: json['documentation'] as String?,
      primaryKey: json['primaryKey'] == null
          ? null
          : PrimaryKey.fromJson(json['primaryKey'] as Map<String, dynamic>),
    )..extra = json['extra'] as Map<String, dynamic>?;

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'name': instance.name,
      'dbName': instance.dbName,
      'fields': instance.fields.map((e) => e.toJson()).toList(),
      'fieldsMap': instance.fieldsMap?.map((k, e) => MapEntry(k, e.toJson())),
      'uniqueFields': instance.uniqueFields,
      'uniqueIndexes': instance.uniqueIndexes.map((e) => e.toJson()).toList(),
      'documentation': instance.documentation,
      'primaryKey': instance.primaryKey?.toJson(),
      'extra': instance.extra,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      kind: $enumDecode(_$FieldKindEnumMap, json['kind']),
      name: json['name'] as String,
      isRequired: json['isRequired'] as bool,
      isList: json['isList'] as bool,
      isUnique: json['isUnique'] as bool,
      isId: json['isId'] as bool,
      isReadOnly: json['isReadOnly'] as bool,
      isGenerated: json['isGenerated'] as bool?,
      isUpdatedAt: json['isUpdatedAt'] as bool,
      type: json['type'] as String,
      dbNames:
          (json['dbNames'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hasDefaultValue: json['hasDefaultValue'] as bool,
      $default: json['default'],
      relationFromFields: (json['relationFromFields'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relationToFields: json['relationToFields'] as List<dynamic>?,
      relationOnDelete: json['relationOnDelete'] as String?,
      relationName: json['relationName'] as String?,
      documentation: json['documentation'] as String?,
    )..additionalProperties =
        json['additionalProperties'] as Map<String, dynamic>?;

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'kind': _$FieldKindEnumMap[instance.kind]!,
      'name': instance.name,
      'isRequired': instance.isRequired,
      'isList': instance.isList,
      'isUnique': instance.isUnique,
      'isId': instance.isId,
      'isReadOnly': instance.isReadOnly,
      'isGenerated': instance.isGenerated,
      'isUpdatedAt': instance.isUpdatedAt,
      'type': instance.type,
      'dbNames': instance.dbNames,
      'hasDefaultValue': instance.hasDefaultValue,
      'default': instance.$default,
      'relationFromFields': instance.relationFromFields,
      'relationToFields': instance.relationToFields,
      'relationOnDelete': instance.relationOnDelete,
      'relationName': instance.relationName,
      'documentation': instance.documentation,
      'additionalProperties': instance.additionalProperties,
    };

const _$FieldKindEnumMap = {
  FieldKind.scalar: 'scalar',
  FieldKind.object: 'object',
  FieldKind.$enum: 'enum',
  FieldKind.unsupported: 'unsupported',
};

PrimaryKey _$PrimaryKeyFromJson(Map<String, dynamic> json) => PrimaryKey(
      name: json['name'] as String?,
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PrimaryKeyToJson(PrimaryKey instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
    };

UniqueIndex _$UniqueIndexFromJson(Map<String, dynamic> json) => UniqueIndex(
      name: json['name'] as String,
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UniqueIndexToJson(UniqueIndex instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
    };

DatamodelEnum _$DatamodelEnumFromJson(Map<String, dynamic> json) =>
    DatamodelEnum(
      name: json['name'] as String,
      values: (json['values'] as List<dynamic>)
          .map((e) => EnumValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      dbName: json['dbName'] as String?,
      documentation: json['documentation'] as String?,
    );

Map<String, dynamic> _$DatamodelEnumToJson(DatamodelEnum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'values': instance.values.map((e) => e.toJson()).toList(),
      'dbName': instance.dbName,
      'documentation': instance.documentation,
    };

EnumValue _$EnumValueFromJson(Map<String, dynamic> json) => EnumValue(
      name: json['name'] as String,
      dbName: json['dbName'] as String?,
    );

Map<String, dynamic> _$EnumValueToJson(EnumValue instance) => <String, dynamic>{
      'name': instance.name,
      'dbName': instance.dbName,
    };

Schema _$SchemaFromJson(Map<String, dynamic> json) => Schema(
      rootQueryType: json['rootQueryType'] as String?,
      rootMutationType: json['rootMutationType'] as String?,
      inputObjectTypes: InputObjectTypes.fromJson(
          json['inputObjectTypes'] as Map<String, dynamic>),
      outputObjectTypes: OutputObjectTypes.fromJson(
          json['outputObjectTypes'] as Map<String, dynamic>),
      enumTypes: EnumTypes.fromJson(json['enumTypes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchemaToJson(Schema instance) => <String, dynamic>{
      'rootQueryType': instance.rootQueryType,
      'rootMutationType': instance.rootMutationType,
      'inputObjectTypes': instance.inputObjectTypes.toJson(),
      'outputObjectTypes': instance.outputObjectTypes.toJson(),
      'enumTypes': instance.enumTypes.toJson(),
    };

InputObjectTypes _$InputObjectTypesFromJson(Map<String, dynamic> json) =>
    InputObjectTypes(
      model: (json['model'] as List<dynamic>?)
          ?.map((e) => InputType.fromJson(e as Map<String, dynamic>))
          .toList(),
      prisma: (json['prisma'] as List<dynamic>)
          .map((e) => InputType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InputObjectTypesToJson(InputObjectTypes instance) =>
    <String, dynamic>{
      'model': instance.model?.map((e) => e.toJson()).toList(),
      'prisma': instance.prisma.map((e) => e.toJson()).toList(),
    };

InputType _$InputTypeFromJson(Map<String, dynamic> json) => InputType(
      name: json['name'] as String,
      constraints: json['constraints'] == null
          ? null
          : InputConstraints.fromJson(
              json['constraints'] as Map<String, dynamic>),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SchemaArg.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldMap: (json['fieldMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, SchemaArg.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$InputTypeToJson(InputType instance) => <String, dynamic>{
      'name': instance.name,
      'constraints': instance.constraints?.toJson(),
      'fields': instance.fields.map((e) => e.toJson()).toList(),
      'fieldMap': instance.fieldMap?.map((k, e) => MapEntry(k, e.toJson())),
    };

InputConstraints _$InputConstraintsFromJson(Map<String, dynamic> json) =>
    InputConstraints(
      maxNumFields: json['maxNumFields'] as int?,
      minNumFields: json['minNumFields'] as int?,
    );

Map<String, dynamic> _$InputConstraintsToJson(InputConstraints instance) =>
    <String, dynamic>{
      'maxNumFields': instance.maxNumFields,
      'minNumFields': instance.minNumFields,
    };

OutputObjectTypes _$OutputObjectTypesFromJson(Map<String, dynamic> json) =>
    OutputObjectTypes(
      model: (json['model'] as List<dynamic>)
          .map((e) => OutputType.fromJson(e as Map<String, dynamic>))
          .toList(),
      prisma: (json['prisma'] as List<dynamic>)
          .map((e) => OutputType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutputObjectTypesToJson(OutputObjectTypes instance) =>
    <String, dynamic>{
      'model': instance.model.map((e) => e.toJson()).toList(),
      'prisma': instance.prisma.map((e) => e.toJson()).toList(),
    };

OutputType _$OutputTypeFromJson(Map<String, dynamic> json) => OutputType(
      name: json['name'] as String,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SchemaField.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldMap: (json['fieldMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, SchemaField.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$OutputTypeToJson(OutputType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields.map((e) => e.toJson()).toList(),
      'fieldMap': instance.fieldMap?.map((k, e) => MapEntry(k, e.toJson())),
    };

EnumTypes _$EnumTypesFromJson(Map<String, dynamic> json) => EnumTypes(
      model: (json['model'] as List<dynamic>?)
          ?.map((e) => SchemaEnum.fromJson(e as Map<String, dynamic>))
          .toList(),
      prisma: (json['prisma'] as List<dynamic>)
          .map((e) => SchemaEnum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EnumTypesToJson(EnumTypes instance) => <String, dynamic>{
      'model': instance.model?.map((e) => e.toJson()).toList(),
      'prisma': instance.prisma.map((e) => e.toJson()).toList(),
    };

SchemaEnum _$SchemaEnumFromJson(Map<String, dynamic> json) => SchemaEnum(
      name: json['name'] as String,
      values:
          (json['values'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SchemaEnumToJson(SchemaEnum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
    };

SchemaArg _$SchemaArgFromJson(Map<String, dynamic> json) => SchemaArg(
      name: json['name'] as String,
      comment: json['comment'] as String?,
      isNullable: json['isNullable'] as bool,
      isRequired: json['isRequired'] as bool,
      inputTypes: (json['inputTypes'] as List<dynamic>)
          .map((e) => SchemaType<dynamic>.fromJson(e as Map<String, dynamic>))
          .toList(),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation.fromJson(json['deprecation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchemaArgToJson(SchemaArg instance) => <String, dynamic>{
      'name': instance.name,
      'comment': instance.comment,
      'isNullable': instance.isNullable,
      'isRequired': instance.isRequired,
      'inputTypes': instance.inputTypes.map((e) => e.toJson()).toList(),
      'deprecation': instance.deprecation?.toJson(),
    };

SchemaType<T> _$SchemaTypeFromJson<T>(Map<String, dynamic> json) =>
    SchemaType<T>(
      isList: json['isList'] as bool,
      type: _ArgTypeConverter<T>().fromJson(json['type']),
      location: $enumDecode(_$FieldLocationEnumMap, json['location']),
      namespace:
          $enumDecodeNullable(_$FieldNamespaceEnumMap, json['namespace']),
    );

Map<String, dynamic> _$SchemaTypeToJson<T>(SchemaType<T> instance) =>
    <String, dynamic>{
      'isList': instance.isList,
      'type': _ArgTypeConverter<T>().toJson(instance.type),
      'location': _$FieldLocationEnumMap[instance.location]!,
      'namespace': _$FieldNamespaceEnumMap[instance.namespace],
    };

const _$FieldLocationEnumMap = {
  FieldLocation.scalar: 'scalar',
  FieldLocation.inputObjectTypes: 'inputObjectTypes',
  FieldLocation.outputObjectTypes: 'outputObjectTypes',
  FieldLocation.enumTypes: 'enumTypes',
};

const _$FieldNamespaceEnumMap = {
  FieldNamespace.model: 'model',
  FieldNamespace.prisma: 'prisma',
};

Deprecation _$DeprecationFromJson(Map<String, dynamic> json) => Deprecation(
      sinceVersion: json['sinceVersion'] as String,
      reason: json['reason'] as String,
      plannedRemovalVersion: json['plannedRemovalVersion'] as String?,
    );

Map<String, dynamic> _$DeprecationToJson(Deprecation instance) =>
    <String, dynamic>{
      'sinceVersion': instance.sinceVersion,
      'reason': instance.reason,
      'plannedRemovalVersion': instance.plannedRemovalVersion,
    };

SchemaField _$SchemaFieldFromJson(Map<String, dynamic> json) => SchemaField(
      name: json['name'] as String,
      isNullable: json['isNullable'] as bool?,
      outputType: SchemaType<dynamic>.fromJson(
          json['outputType'] as Map<String, dynamic>),
      args: (json['args'] as List<dynamic>)
          .map((e) => SchemaArg.fromJson(e as Map<String, dynamic>))
          .toList(),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation.fromJson(json['deprecation'] as Map<String, dynamic>),
      documentation: json['documentation'] as String?,
    );

Map<String, dynamic> _$SchemaFieldToJson(SchemaField instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isNullable': instance.isNullable,
      'outputType': instance.outputType.toJson(),
      'args': instance.args.map((e) => e.toJson()).toList(),
      'deprecation': instance.deprecation?.toJson(),
      'documentation': instance.documentation,
    };
