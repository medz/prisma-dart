// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dmmf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      datamodel: Datamodel.fromJson(json['datamodel'] as Map<String, dynamic>),
      schema: Schema.fromJson(json['schema'] as Map<String, dynamic>),
      mappings: Mappings.fromJson(json['mappings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'datamodel': instance.datamodel,
      'schema': instance.schema,
      'mappings': instance.mappings,
    };

_$DatamodelImpl _$$DatamodelImplFromJson(Map<String, dynamic> json) =>
    _$DatamodelImpl(
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

Map<String, dynamic> _$$DatamodelImplToJson(_$DatamodelImpl instance) =>
    <String, dynamic>{
      'models': instance.models,
      'enums': instance.enums,
      'types': instance.types,
    };

_$ModelImpl _$$ModelImplFromJson(Map<String, dynamic> json) => _$ModelImpl(
      name: json['name'] as String,
      dbName: json['dbName'] as String?,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      isGenerated: json['isGenerated'] as bool?,
    );

Map<String, dynamic> _$$ModelImplToJson(_$ModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dbName': instance.dbName,
      'fields': instance.fields,
      'uniqueFields': instance.uniqueFields,
      'uniqueIndexes': instance.uniqueIndexes,
      'documentation': instance.documentation,
      'primaryKey': instance.primaryKey,
      'isGenerated': instance.isGenerated,
    };

_$FieldImpl _$$FieldImplFromJson(Map<String, dynamic> json) => _$FieldImpl(
      kind: $enumDecode(_$FieldKindEnumMap, json['kind']),
      name: json['name'] as String,
      isRequired: json['isRequired'] as bool,
      isList: json['isList'] as bool,
      isUnique: json['isUnique'] as bool,
      isId: json['isId'] as bool,
      isReadOnly: json['isReadOnly'] as bool,
      isGenerated: json['isGenerated'] as bool?,
      isUpdatedAt: json['isUpdatedAt'] as bool?,
      type: json['type'] as String,
      dbName: json['dbName'] as String?,
      hasDefaultValue: json['hasDefaultValue'] as bool,
      default$: json[r'default$'],
      relationFromFields: (json['relationFromFields'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relationToFields: json['relationToFields'] as List<dynamic>?,
      relationOnDelete: json['relationOnDelete'] as String?,
      relationName: json['relationName'] as String?,
      documentation: json['documentation'] as String?,
    );

Map<String, dynamic> _$$FieldImplToJson(_$FieldImpl instance) =>
    <String, dynamic>{
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
      'dbName': instance.dbName,
      'hasDefaultValue': instance.hasDefaultValue,
      r'default$': instance.default$,
      'relationFromFields': instance.relationFromFields,
      'relationToFields': instance.relationToFields,
      'relationOnDelete': instance.relationOnDelete,
      'relationName': instance.relationName,
      'documentation': instance.documentation,
    };

const _$FieldKindEnumMap = {
  FieldKind.scalar: 'scalar',
  FieldKind.object: 'object',
  FieldKind.enum$: 'enum',
  FieldKind.unsupported: 'unsupported',
};

_$UniqueIndexImpl _$$UniqueIndexImplFromJson(Map<String, dynamic> json) =>
    _$UniqueIndexImpl(
      name: json['name'] as String?,
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$UniqueIndexImplToJson(_$UniqueIndexImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
    };

_$PrimaryKeyImpl _$$PrimaryKeyImplFromJson(Map<String, dynamic> json) =>
    _$PrimaryKeyImpl(
      name: json['name'] as String?,
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PrimaryKeyImplToJson(_$PrimaryKeyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
    };

_$DatamodelEnumImpl _$$DatamodelEnumImplFromJson(Map<String, dynamic> json) =>
    _$DatamodelEnumImpl(
      name: json['name'] as String,
      values: (json['values'] as List<dynamic>)
          .map((e) => EnumValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      dbName: json['dbName'] as String?,
      documentation: json['documentation'] as String?,
    );

Map<String, dynamic> _$$DatamodelEnumImplToJson(_$DatamodelEnumImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
      'dbName': instance.dbName,
      'documentation': instance.documentation,
    };

_$EnumValueImpl _$$EnumValueImplFromJson(Map<String, dynamic> json) =>
    _$EnumValueImpl(
      name: json['name'] as String,
      dbName: json['dbName'] as String?,
    );

Map<String, dynamic> _$$EnumValueImplToJson(_$EnumValueImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dbName': instance.dbName,
    };

_$MappingsImpl _$$MappingsImplFromJson(Map<String, dynamic> json) =>
    _$MappingsImpl(
      modelOperations: (json['modelOperations'] as List<dynamic>)
          .map((e) => ModelMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherOperations: OtherOperations.fromJson(
          json['otherOperations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MappingsImplToJson(_$MappingsImpl instance) =>
    <String, dynamic>{
      'modelOperations': instance.modelOperations,
      'otherOperations': instance.otherOperations,
    };

_$OtherOperationsImpl _$$OtherOperationsImplFromJson(
        Map<String, dynamic> json) =>
    _$OtherOperationsImpl(
      read: (json['read'] as List<dynamic>).map((e) => e as String).toList(),
      write: (json['write'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$OtherOperationsImplToJson(
        _$OtherOperationsImpl instance) =>
    <String, dynamic>{
      'read': instance.read,
      'write': instance.write,
    };

_$SchemaImpl _$$SchemaImplFromJson(Map<String, dynamic> json) => _$SchemaImpl(
      rootQueryType: json['rootQueryType'] as String?,
      rootMutationType: json['rootMutationType'] as String?,
      inputObjectTypes: InputObjectTypes.fromJson(
          json['inputObjectTypes'] as Map<String, dynamic>),
      outputObjectTypes: OutputObjectTypes.fromJson(
          json['outputObjectTypes'] as Map<String, dynamic>),
      enumTypes: EnumTypes.fromJson(json['enumTypes'] as Map<String, dynamic>),
      fieldRefTypes:
          FieldRefTypes.fromJson(json['fieldRefTypes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SchemaImplToJson(_$SchemaImpl instance) =>
    <String, dynamic>{
      'rootQueryType': instance.rootQueryType,
      'rootMutationType': instance.rootMutationType,
      'inputObjectTypes': instance.inputObjectTypes,
      'outputObjectTypes': instance.outputObjectTypes,
      'enumTypes': instance.enumTypes,
      'fieldRefTypes': instance.fieldRefTypes,
    };

_$InputObjectTypesImpl _$$InputObjectTypesImplFromJson(
        Map<String, dynamic> json) =>
    _$InputObjectTypesImpl(
      model: (json['model'] as List<dynamic>?)
          ?.map((e) => InputType.fromJson(e as Map<String, dynamic>))
          .toList(),
      prisma: (json['prisma'] as List<dynamic>)
          .map((e) => InputType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$InputObjectTypesImplToJson(
        _$InputObjectTypesImpl instance) =>
    <String, dynamic>{
      'model': instance.model,
      'prisma': instance.prisma,
    };

_$InputTypeImpl _$$InputTypeImplFromJson(Map<String, dynamic> json) =>
    _$InputTypeImpl(
      name: json['name'] as String,
      constraints:
          Constraints.fromJson(json['constraints'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SchemaArg.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldsMap: (json['fieldsMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, SchemaArg.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$InputTypeImplToJson(_$InputTypeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'constraints': instance.constraints,
      'meta': instance.meta,
      'fields': instance.fields,
      'fieldsMap': instance.fieldsMap,
    };

_$ConstraintsImpl _$$ConstraintsImplFromJson(Map<String, dynamic> json) =>
    _$ConstraintsImpl(
      maxNumFields: json['maxNumFields'] as int?,
      minNumFields: json['minNumFields'] as int?,
      fields:
          (json['fields'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ConstraintsImplToJson(_$ConstraintsImpl instance) =>
    <String, dynamic>{
      'maxNumFields': instance.maxNumFields,
      'minNumFields': instance.minNumFields,
      'fields': instance.fields,
    };

_$MetaImpl _$$MetaImplFromJson(Map<String, dynamic> json) => _$MetaImpl(
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$MetaImplToJson(_$MetaImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
    };

_$SchemaArgImpl _$$SchemaArgImplFromJson(Map<String, dynamic> json) =>
    _$SchemaArgImpl(
      name: json['name'] as String,
      comment: json['comment'] as String?,
      isNullable: json['isNullable'] as bool,
      isRequired: json['isRequired'] as bool,
      inputTypes: (json['inputTypes'] as List<dynamic>)
          .map((e) => SchemaArgInputType.fromJson(e as Map<String, dynamic>))
          .toList(),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation.fromJson(json['deprecation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SchemaArgImplToJson(_$SchemaArgImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'comment': instance.comment,
      'isNullable': instance.isNullable,
      'isRequired': instance.isRequired,
      'inputTypes': instance.inputTypes,
      'deprecation': instance.deprecation,
    };

_$DeprecationImpl _$$DeprecationImplFromJson(Map<String, dynamic> json) =>
    _$DeprecationImpl(
      sinceVersion: json['sinceVersion'] as String,
      reason: json['reason'] as String,
      plannedRemovalVersion: json['plannedRemovalVersion'] as String?,
    );

Map<String, dynamic> _$$DeprecationImplToJson(_$DeprecationImpl instance) =>
    <String, dynamic>{
      'sinceVersion': instance.sinceVersion,
      'reason': instance.reason,
      'plannedRemovalVersion': instance.plannedRemovalVersion,
    };

_$SchemaArgInputTypeImpl _$$SchemaArgInputTypeImplFromJson(
        Map<String, dynamic> json) =>
    _$SchemaArgInputTypeImpl(
      isList: json['isList'] as bool,
      type: const _ArgTypeConverter().fromJson(json['type'] as Object),
      location: $enumDecode(_$FieldLocationEnumMap, json['location']),
      namespace:
          $enumDecodeNullable(_$FieldNamespaceEnumMap, json['namespace']),
    );

Map<String, dynamic> _$$SchemaArgInputTypeImplToJson(
        _$SchemaArgInputTypeImpl instance) =>
    <String, dynamic>{
      'isList': instance.isList,
      'type': const _ArgTypeConverter().toJson(instance.type),
      'location': _$FieldLocationEnumMap[instance.location]!,
      'namespace': _$FieldNamespaceEnumMap[instance.namespace],
    };

const _$FieldLocationEnumMap = {
  FieldLocation.scalar: 'scalar',
  FieldLocation.inputObjectTypes: 'inputObjectTypes',
  FieldLocation.outputObjectTypes: 'outputObjectTypes',
  FieldLocation.enumTypes: 'enumTypes',
  FieldLocation.fieldRefTypes: 'fieldRefTypes',
};

const _$FieldNamespaceEnumMap = {
  FieldNamespace.model: 'model',
  FieldNamespace.prisma: 'prisma',
};

_$StringArgTypeImpl _$$StringArgTypeImplFromJson(Map<String, dynamic> json) =>
    _$StringArgTypeImpl(
      json['value'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StringArgTypeImplToJson(_$StringArgTypeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$ObjectArgTypeImpl _$$ObjectArgTypeImplFromJson(Map<String, dynamic> json) =>
    _$ObjectArgTypeImpl(
      InputType.fromJson(json['value'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ObjectArgTypeImplToJson(_$ObjectArgTypeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$EnumArgTypeImpl _$$EnumArgTypeImplFromJson(Map<String, dynamic> json) =>
    _$EnumArgTypeImpl(
      SchemaEnum.fromJson(json['value'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EnumArgTypeImplToJson(_$EnumArgTypeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$SchemaEnumImpl _$$SchemaEnumImplFromJson(Map<String, dynamic> json) =>
    _$SchemaEnumImpl(
      name: json['name'] as String,
      values:
          (json['values'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SchemaEnumImplToJson(_$SchemaEnumImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
    };

_$OutputObjectTypesImpl _$$OutputObjectTypesImplFromJson(
        Map<String, dynamic> json) =>
    _$OutputObjectTypesImpl(
      model: (json['model'] as List<dynamic>)
          .map((e) => OutputType.fromJson(e as Map<String, dynamic>))
          .toList(),
      prisma: (json['prisma'] as List<dynamic>)
          .map((e) => OutputType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OutputObjectTypesImplToJson(
        _$OutputObjectTypesImpl instance) =>
    <String, dynamic>{
      'model': instance.model,
      'prisma': instance.prisma,
    };

_$OutputTypeImpl _$$OutputTypeImplFromJson(Map<String, dynamic> json) =>
    _$OutputTypeImpl(
      name: json['name'] as String,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SchemaField.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldsMap: (json['fieldsMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, SchemaField.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$OutputTypeImplToJson(_$OutputTypeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
      'fieldsMap': instance.fieldsMap,
    };

_$SchemaFieldImpl _$$SchemaFieldImplFromJson(Map<String, dynamic> json) =>
    _$SchemaFieldImpl(
      name: json['name'] as String,
      isNullable: json['isNullable'] as bool?,
      outputType:
          OutputTypeRef.fromJson(json['outputType'] as Map<String, dynamic>),
      args: (json['args'] as List<dynamic>)
          .map((e) => SchemaArg.fromJson(e as Map<String, dynamic>))
          .toList(),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation.fromJson(json['deprecation'] as Map<String, dynamic>),
      documentation: json['documentation'] as String?,
    );

Map<String, dynamic> _$$SchemaFieldImplToJson(_$SchemaFieldImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isNullable': instance.isNullable,
      'outputType': instance.outputType,
      'args': instance.args,
      'deprecation': instance.deprecation,
      'documentation': instance.documentation,
    };

_$OutputTypeRefImpl _$$OutputTypeRefImplFromJson(Map<String, dynamic> json) =>
    _$OutputTypeRefImpl(
      isList: json['isList'] as bool,
      namespace:
          $enumDecodeNullable(_$FieldNamespaceEnumMap, json['namespace']),
      location: $enumDecode(_$FieldLocationEnumMap, json['location']),
      type:
          const _OutputTypeRefTypeConverter().fromJson(json['type'] as Object),
    );

Map<String, dynamic> _$$OutputTypeRefImplToJson(_$OutputTypeRefImpl instance) =>
    <String, dynamic>{
      'isList': instance.isList,
      'namespace': _$FieldNamespaceEnumMap[instance.namespace],
      'location': _$FieldLocationEnumMap[instance.location]!,
      'type': const _OutputTypeRefTypeConverter().toJson(instance.type),
    };

_$StringOutputTypeRefTypeImpl _$$StringOutputTypeRefTypeImplFromJson(
        Map<String, dynamic> json) =>
    _$StringOutputTypeRefTypeImpl(
      json['value'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StringOutputTypeRefTypeImplToJson(
        _$StringOutputTypeRefTypeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$ObjectOutputTypeRefTypeImpl _$$ObjectOutputTypeRefTypeImplFromJson(
        Map<String, dynamic> json) =>
    _$ObjectOutputTypeRefTypeImpl(
      OutputType.fromJson(json['value'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ObjectOutputTypeRefTypeImplToJson(
        _$ObjectOutputTypeRefTypeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$EnumOutputTypeRefTypeImpl _$$EnumOutputTypeRefTypeImplFromJson(
        Map<String, dynamic> json) =>
    _$EnumOutputTypeRefTypeImpl(
      SchemaEnum.fromJson(json['value'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EnumOutputTypeRefTypeImplToJson(
        _$EnumOutputTypeRefTypeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$EnumTypesImpl _$$EnumTypesImplFromJson(Map<String, dynamic> json) =>
    _$EnumTypesImpl(
      model: (json['model'] as List<dynamic>?)
          ?.map((e) => SchemaEnum.fromJson(e as Map<String, dynamic>))
          .toList(),
      prisma: (json['prisma'] as List<dynamic>)
          .map((e) => SchemaEnum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EnumTypesImplToJson(_$EnumTypesImpl instance) =>
    <String, dynamic>{
      'model': instance.model,
      'prisma': instance.prisma,
    };

_$FieldRefTypesImpl _$$FieldRefTypesImplFromJson(Map<String, dynamic> json) =>
    _$FieldRefTypesImpl(
      prisma: (json['prisma'] as List<dynamic>?)
          ?.map((e) => FieldRefType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FieldRefTypesImplToJson(_$FieldRefTypesImpl instance) =>
    <String, dynamic>{
      'prisma': instance.prisma,
    };

_$FieldRefTypeImpl _$$FieldRefTypeImplFromJson(Map<String, dynamic> json) =>
    _$FieldRefTypeImpl(
      name: json['name'] as String,
      allowTypes: (json['allowTypes'] as List<dynamic>)
          .map((e) => OutputTypeRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SchemaArg.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FieldRefTypeImplToJson(_$FieldRefTypeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'allowTypes': instance.allowTypes,
      'fields': instance.fields,
    };

_$ModelMappingImpl _$$ModelMappingImplFromJson(Map<String, dynamic> json) =>
    _$ModelMappingImpl(
      model: json['model'] as String,
      plural: json['plural'] as String?,
      findUnique: _modelMappingActionValueReader(json, 'findUnique') as String?,
      findUniqueOrThrow:
          _modelMappingActionValueReader(json, 'findUniqueOrThrow') as String?,
      findFirst: _modelMappingActionValueReader(json, 'findFirst') as String?,
      findFirstOrThrow:
          _modelMappingActionValueReader(json, 'findFirstOrThrow') as String?,
      findMany: _modelMappingActionValueReader(json, 'findMany') as String?,
      create: _modelMappingActionValueReader(json, 'create') as String?,
      createMany: _modelMappingActionValueReader(json, 'createMany') as String?,
      update: _modelMappingActionValueReader(json, 'update') as String?,
      updateMany: _modelMappingActionValueReader(json, 'updateMany') as String?,
      upsert: _modelMappingActionValueReader(json, 'upsert') as String?,
      delete: _modelMappingActionValueReader(json, 'delete') as String?,
      deleteMany: _modelMappingActionValueReader(json, 'deleteMany') as String?,
      aggregate: _modelMappingActionValueReader(json, 'aggregate') as String?,
      groupBy: _modelMappingActionValueReader(json, 'groupBy') as String?,
      count: _modelMappingActionValueReader(json, 'count') as String?,
      findRaw: _modelMappingActionValueReader(json, 'findRaw') as String?,
      aggregateRaw:
          _modelMappingActionValueReader(json, 'aggregateRaw') as String?,
    );

Map<String, dynamic> _$$ModelMappingImplToJson(_$ModelMappingImpl instance) =>
    <String, dynamic>{
      'model': instance.model,
      'plural': instance.plural,
      'findUnique': instance.findUnique,
      'findUniqueOrThrow': instance.findUniqueOrThrow,
      'findFirst': instance.findFirst,
      'findFirstOrThrow': instance.findFirstOrThrow,
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
