// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dmmf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map json) => $checkedCreate(
      'Document',
      json,
      ($checkedConvert) {
        final val = Document(
          datamodel: $checkedConvert('datamodel',
              (v) => Datamodel.fromJson(Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'datamodel': instance.datamodel.toJson(),
    };

Datamodel _$DatamodelFromJson(Map json) => $checkedCreate(
      'Datamodel',
      json,
      ($checkedConvert) {
        final val = Datamodel(
          models: $checkedConvert(
              'models',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      Model.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          enums: $checkedConvert(
              'enums',
              (v) => (v as List<dynamic>)
                  .map((e) => DatamodelEnum.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
          types: $checkedConvert(
              'types',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      Model.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$DatamodelToJson(Datamodel instance) => <String, dynamic>{
      'models': instance.models.map((e) => e.toJson()).toList(),
      'enums': instance.enums.map((e) => e.toJson()).toList(),
      'types': instance.types.map((e) => e.toJson()).toList(),
    };

Model _$ModelFromJson(Map json) => $checkedCreate(
      'Model',
      json,
      ($checkedConvert) {
        final val = Model(
          name: $checkedConvert('name', (v) => v as String),
          dbName: $checkedConvert('dbName', (v) => v as String?),
          fields: $checkedConvert(
              'fields',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      Field.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          uniqueFields: $checkedConvert(
              'uniqueFields',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      (e as List<dynamic>).map((e) => e as String).toList())
                  .toList()),
          uniqueIndexes: $checkedConvert(
              'uniqueIndexes',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      UniqueIndex.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          documentation: $checkedConvert('documentation', (v) => v as String?),
          primaryKey: $checkedConvert(
              'primaryKey',
              (v) => v == null
                  ? null
                  : PrimaryKey.fromJson(Map<String, dynamic>.from(v as Map))),
          isGenerated:
              $checkedConvert('isGenerated', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$ModelToJson(Model instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dbName', instance.dbName);
  val['fields'] = instance.fields.map((e) => e.toJson()).toList();
  val['uniqueFields'] = instance.uniqueFields;
  val['uniqueIndexes'] = instance.uniqueIndexes.map((e) => e.toJson()).toList();
  writeNotNull('documentation', instance.documentation);
  writeNotNull('primaryKey', instance.primaryKey?.toJson());
  val['isGenerated'] = instance.isGenerated;
  return val;
}

Field _$FieldFromJson(Map json) => $checkedCreate(
      'Field',
      json,
      ($checkedConvert) {
        final val = Field(
          kind: $checkedConvert(
              'kind', (v) => $enumDecode(_$FieldKindEnumMap, v)),
          name: $checkedConvert('name', (v) => v as String),
          isRequired: $checkedConvert('isRequired', (v) => v as bool),
          isList: $checkedConvert('isList', (v) => v as bool),
          isUnique: $checkedConvert('isUnique', (v) => v as bool),
          isId: $checkedConvert('isId', (v) => v as bool),
          isReadOnly: $checkedConvert('isReadOnly', (v) => v as bool),
          isGenerated: $checkedConvert('isGenerated', (v) => v as bool?),
          isUpdatedAt: $checkedConvert('isUpdatedAt', (v) => v as bool?),
          type: $checkedConvert('type', (v) => v as String),
          dbName: $checkedConvert('dbName', (v) => v as String?),
          hasDefaultValue: $checkedConvert('hasDefaultValue', (v) => v as bool),
          default_: $checkedConvert('default', (v) => v),
          relationFromFields: $checkedConvert('relationFromFields',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          relationToFields:
              $checkedConvert('relationToFields', (v) => v as List<dynamic>?),
          relationOnDelete:
              $checkedConvert('relationOnDelete', (v) => v as String?),
          relationName: $checkedConvert('relationName', (v) => v as String?),
          documentation: $checkedConvert('documentation', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'default_': 'default'},
    );

Map<String, dynamic> _$FieldToJson(Field instance) {
  final val = <String, dynamic>{
    'kind': _$FieldKindEnumMap[instance.kind]!,
    'name': instance.name,
    'isRequired': instance.isRequired,
    'isList': instance.isList,
    'isUnique': instance.isUnique,
    'isId': instance.isId,
    'isReadOnly': instance.isReadOnly,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isGenerated', instance.isGenerated);
  writeNotNull('isUpdatedAt', instance.isUpdatedAt);
  val['type'] = instance.type;
  writeNotNull('dbName', instance.dbName);
  val['hasDefaultValue'] = instance.hasDefaultValue;
  writeNotNull('default', instance.default_);
  writeNotNull('relationFromFields', instance.relationFromFields);
  writeNotNull('relationToFields', instance.relationToFields);
  writeNotNull('relationOnDelete', instance.relationOnDelete);
  writeNotNull('relationName', instance.relationName);
  writeNotNull('documentation', instance.documentation);
  return val;
}

const _$FieldKindEnumMap = {
  FieldKind.scalar: 'scalar',
  FieldKind.object: 'object',
  FieldKind.enum_: 'enum',
  FieldKind.unsupported: 'unsupported',
};

UniqueIndex _$UniqueIndexFromJson(Map json) => $checkedCreate(
      'UniqueIndex',
      json,
      ($checkedConvert) {
        final val = UniqueIndex(
          name: $checkedConvert('name', (v) => v as String),
          fields: $checkedConvert('fields',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$UniqueIndexToJson(UniqueIndex instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
    };

PrimaryKey _$PrimaryKeyFromJson(Map json) => $checkedCreate(
      'PrimaryKey',
      json,
      ($checkedConvert) {
        final val = PrimaryKey(
          name: $checkedConvert('name', (v) => v as String?),
          fields: $checkedConvert('fields',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PrimaryKeyToJson(PrimaryKey instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['fields'] = instance.fields;
  return val;
}

DatamodelEnum _$DatamodelEnumFromJson(Map json) => $checkedCreate(
      'DatamodelEnum',
      json,
      ($checkedConvert) {
        final val = DatamodelEnum(
          name: $checkedConvert('name', (v) => v as String),
          values: $checkedConvert(
              'values',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      EnumValue.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          dbName: $checkedConvert('dbName', (v) => v as String?),
          documentation: $checkedConvert('documentation', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$DatamodelEnumToJson(DatamodelEnum instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'values': instance.values.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dbName', instance.dbName);
  writeNotNull('documentation', instance.documentation);
  return val;
}

EnumValue _$EnumValueFromJson(Map json) => $checkedCreate(
      'EnumValue',
      json,
      ($checkedConvert) {
        final val = EnumValue(
          name: $checkedConvert('name', (v) => v as String),
          dbName: $checkedConvert('dbName', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$EnumValueToJson(EnumValue instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dbName', instance.dbName);
  return val;
}

Schema _$SchemaFromJson(Map json) => $checkedCreate(
      'Schema',
      json,
      ($checkedConvert) {
        final val = Schema(
          rootQueryType: $checkedConvert('rootQueryType', (v) => v as String?),
          rootMutationType:
              $checkedConvert('rootMutationType', (v) => v as String?),
          inputObjectTypes: $checkedConvert(
              'inputObjectTypes',
              (v) => InputObjectTypes.fromJson(
                  Map<String, dynamic>.from(v as Map))),
          outputObjectTypes: $checkedConvert(
              'outputObjectTypes', (v) => OutputObjectTypes.fromJson(v as Map)),
        );
        return val;
      },
    );

Map<String, dynamic> _$SchemaToJson(Schema instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rootQueryType', instance.rootQueryType);
  writeNotNull('rootMutationType', instance.rootMutationType);
  val['inputObjectTypes'] = instance.inputObjectTypes.toJson();
  val['outputObjectTypes'] = instance.outputObjectTypes.toJson();
  return val;
}

InputObjectTypes _$InputObjectTypesFromJson(Map json) => $checkedCreate(
      'InputObjectTypes',
      json,
      ($checkedConvert) {
        final val = InputObjectTypes(
          model: $checkedConvert(
              'model',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      InputType.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          prisma: $checkedConvert(
              'prisma',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      InputType.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$InputObjectTypesToJson(InputObjectTypes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('model', instance.model?.map((e) => e.toJson()).toList());
  writeNotNull('prisma', instance.prisma?.map((e) => e.toJson()).toList());
  return val;
}

InputType _$InputTypeFromJson(Map json) => $checkedCreate(
      'InputType',
      json,
      ($checkedConvert) {
        final val = InputType(
          name: $checkedConvert('name', (v) => v as String),
          constraints: $checkedConvert('constraints',
              (v) => Constraints.fromJson(Map<String, dynamic>.from(v as Map))),
          meta: $checkedConvert(
              'meta',
              (v) => v == null
                  ? null
                  : Meta.fromJson(Map<String, dynamic>.from(v as Map))),
          fields: $checkedConvert(
              'fields',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SchemaArg.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$InputTypeToJson(InputType instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'constraints': instance.constraints.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('meta', instance.meta?.toJson());
  val['fields'] = instance.fields.map((e) => e.toJson()).toList();
  return val;
}

Constraints _$ConstraintsFromJson(Map json) => $checkedCreate(
      'Constraints',
      json,
      ($checkedConvert) {
        final val = Constraints(
          maxNumFields: $checkedConvert('maxNumFields', (v) => v as int?),
          minNumFields: $checkedConvert('minNumFields', (v) => v as int?),
          fields: $checkedConvert('fields',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConstraintsToJson(Constraints instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxNumFields', instance.maxNumFields);
  writeNotNull('minNumFields', instance.minNumFields);
  writeNotNull('fields', instance.fields);
  return val;
}

Meta _$MetaFromJson(Map json) => $checkedCreate(
      'Meta',
      json,
      ($checkedConvert) {
        final val = Meta(
          source: $checkedConvert('source', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$MetaToJson(Meta instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source);
  return val;
}

SchemaArg _$SchemaArgFromJson(Map json) => $checkedCreate(
      'SchemaArg',
      json,
      ($checkedConvert) {
        final val = SchemaArg(
          name: $checkedConvert('name', (v) => v as String),
          comment: $checkedConvert('comment', (v) => v as String?),
          isNullable: $checkedConvert('isNullable', (v) => v as bool),
          isRequired: $checkedConvert('isRequired', (v) => v as bool),
          inputTypes: $checkedConvert(
              'inputTypes',
              (v) => (v as List<dynamic>)
                  .map((e) => InputTypeRef.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
          deprecation: $checkedConvert(
              'deprecation',
              (v) => v == null
                  ? null
                  : Deprecation.fromJson(Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$SchemaArgToJson(SchemaArg instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('comment', instance.comment);
  val['isNullable'] = instance.isNullable;
  val['isRequired'] = instance.isRequired;
  val['inputTypes'] = instance.inputTypes.map((e) => e.toJson()).toList();
  writeNotNull('deprecation', instance.deprecation?.toJson());
  return val;
}

InputTypeRef _$InputTypeRefFromJson(Map json) => $checkedCreate(
      'InputTypeRef',
      json,
      ($checkedConvert) {
        final val = InputTypeRef(
          location: $checkedConvert('location',
              (v) => $enumDecode(_$InputTypeRefAllowedLocationsEnumMap, v)),
          isList: $checkedConvert('isList', (v) => v as bool),
          type: $checkedConvert('type', (v) => v as String),
          namespace: $checkedConvert(
              'namespace', (v) => $enumDecode(_$FieldNamespaceEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$InputTypeRefToJson(InputTypeRef instance) =>
    <String, dynamic>{
      'isList': instance.isList,
      'type': instance.type,
      'namespace': _$FieldNamespaceEnumMap[instance.namespace]!,
      'location': _$InputTypeRefAllowedLocationsEnumMap[instance.location]!,
    };

const _$InputTypeRefAllowedLocationsEnumMap = {
  InputTypeRefAllowedLocations.scalar: 'scalar',
  InputTypeRefAllowedLocations.inputObjectTypes: 'inputObjectTypes',
  InputTypeRefAllowedLocations.enumTypes: 'enumTypes',
  InputTypeRefAllowedLocations.fieldRefTypes: 'fieldRefTypes',
};

const _$FieldNamespaceEnumMap = {
  FieldNamespace.model: 'model',
  FieldNamespace.prisma: 'prisma',
};

Deprecation _$DeprecationFromJson(Map json) => $checkedCreate(
      'Deprecation',
      json,
      ($checkedConvert) {
        final val = Deprecation(
          sinceVersion: $checkedConvert('sinceVersion', (v) => v as String),
          reason: $checkedConvert('reason', (v) => v as String),
          plannedRemovalVersion:
              $checkedConvert('plannedRemovalVersion', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$DeprecationToJson(Deprecation instance) {
  final val = <String, dynamic>{
    'sinceVersion': instance.sinceVersion,
    'reason': instance.reason,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('plannedRemovalVersion', instance.plannedRemovalVersion);
  return val;
}

OutputObjectTypes _$OutputObjectTypesFromJson(Map json) => $checkedCreate(
      'OutputObjectTypes',
      json,
      ($checkedConvert) {
        final val = OutputObjectTypes();
        return val;
      },
    );

Map<String, dynamic> _$OutputObjectTypesToJson(OutputObjectTypes instance) =>
    <String, dynamic>{};

SchemaEnum _$SchemaEnumFromJson(Map json) => $checkedCreate(
      'SchemaEnum',
      json,
      ($checkedConvert) {
        final val = SchemaEnum(
          name: $checkedConvert('name', (v) => v as String),
          values: $checkedConvert('values',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SchemaEnumToJson(SchemaEnum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
    };
