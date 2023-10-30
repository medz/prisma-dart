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
          schema: $checkedConvert('schema',
              (v) => Schema.fromJson(Map<String, dynamic>.from(v as Map))),
          mappings: $checkedConvert('mappings',
              (v) => Mappings.fromJson(Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'datamodel': instance.datamodel.toJson(),
      'schema': instance.schema.toJson(),
      'mappings': instance.mappings.toJson(),
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
              'outputObjectTypes',
              (v) => OutputObjectTypes.fromJson(
                  Map<String, dynamic>.from(v as Map))),
          enumTypes: $checkedConvert('enumTypes',
              (v) => EnumTypes.fromJson(Map<String, dynamic>.from(v as Map))),
          fieldRefTypes: $checkedConvert(
              'fieldRefTypes',
              (v) =>
                  FieldRefTypes.fromJson(Map<String, dynamic>.from(v as Map))),
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
  val['enumTypes'] = instance.enumTypes.toJson();
  val['fieldRefTypes'] = instance.fieldRefTypes.toJson();
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
                  .map((e) =>
                      TypeRef.fromJson(Map<String, dynamic>.from(e as Map)))
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

TypeRef _$TypeRefFromJson(Map json) => $checkedCreate(
      'TypeRef',
      json,
      ($checkedConvert) {
        final val = TypeRef(
          isList: $checkedConvert('isList', (v) => v as bool),
          type: $checkedConvert('type', (v) => v as String),
          location: $checkedConvert(
              'location', (v) => $enumDecode(_$FieldLocationEnumMap, v)),
          namespace: $checkedConvert('namespace',
              (v) => $enumDecodeNullable(_$FieldNamespaceEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$TypeRefToJson(TypeRef instance) {
  final val = <String, dynamic>{
    'isList': instance.isList,
    'type': instance.type,
    'location': _$FieldLocationEnumMap[instance.location]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('namespace', _$FieldNamespaceEnumMap[instance.namespace]);
  return val;
}

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
        final val = OutputObjectTypes(
          model: $checkedConvert(
              'model',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      OutputType.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          prisma: $checkedConvert(
              'prisma',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      OutputType.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$OutputObjectTypesToJson(OutputObjectTypes instance) =>
    <String, dynamic>{
      'model': instance.model.map((e) => e.toJson()).toList(),
      'prisma': instance.prisma.map((e) => e.toJson()).toList(),
    };

OutputType _$OutputTypeFromJson(Map json) => $checkedCreate(
      'OutputType',
      json,
      ($checkedConvert) {
        final val = OutputType(
          name: $checkedConvert('name', (v) => v as String),
          fields: $checkedConvert(
              'fields',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SchemaField.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$OutputTypeToJson(OutputType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields.map((e) => e.toJson()).toList(),
    };

SchemaField _$SchemaFieldFromJson(Map json) => $checkedCreate(
      'SchemaField',
      json,
      ($checkedConvert) {
        final val = SchemaField(
          name: $checkedConvert('name', (v) => v as String),
          isNullable: $checkedConvert('isNullable', (v) => v as bool? ?? false),
          outputType: $checkedConvert('outputType',
              (v) => TypeRef.fromJson(Map<String, dynamic>.from(v as Map))),
          args: $checkedConvert(
              'args',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SchemaArg.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          deprecation: $checkedConvert(
              'deprecation',
              (v) => v == null
                  ? null
                  : Deprecation.fromJson(Map<String, dynamic>.from(v as Map))),
          documentation: $checkedConvert('documentation', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$SchemaFieldToJson(SchemaField instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'isNullable': instance.isNullable,
    'outputType': instance.outputType.toJson(),
    'args': instance.args.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deprecation', instance.deprecation?.toJson());
  writeNotNull('documentation', instance.documentation);
  return val;
}

EnumTypes _$EnumTypesFromJson(Map json) => $checkedCreate(
      'EnumTypes',
      json,
      ($checkedConvert) {
        final val = EnumTypes(
          model: $checkedConvert(
              'model',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      SchemaEnum.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          prisma: $checkedConvert(
              'prisma',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SchemaEnum.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$EnumTypesToJson(EnumTypes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('model', instance.model?.map((e) => e.toJson()).toList());
  val['prisma'] = instance.prisma.map((e) => e.toJson()).toList();
  return val;
}

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

FieldRefTypes _$FieldRefTypesFromJson(Map json) => $checkedCreate(
      'FieldRefTypes',
      json,
      ($checkedConvert) {
        final val = FieldRefTypes(
          prisma: $checkedConvert(
              'prisma',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => FieldRefType.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$FieldRefTypesToJson(FieldRefTypes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('prisma', instance.prisma?.map((e) => e.toJson()).toList());
  return val;
}

FieldRefType _$FieldRefTypeFromJson(Map json) => $checkedCreate(
      'FieldRefType',
      json,
      ($checkedConvert) {
        final val = FieldRefType(
          name: $checkedConvert('name', (v) => v as String),
          allowTypes: $checkedConvert(
              'allowTypes',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TypeRef.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
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

Map<String, dynamic> _$FieldRefTypeToJson(FieldRefType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'allowTypes': instance.allowTypes.map((e) => e.toJson()).toList(),
      'fields': instance.fields.map((e) => e.toJson()).toList(),
    };

Mappings _$MappingsFromJson(Map json) => $checkedCreate(
      'Mappings',
      json,
      ($checkedConvert) {
        final val = Mappings(
          modelOperations: $checkedConvert(
              'modelOperations',
              (v) => (v as List<dynamic>)
                  .map((e) => ModelMapping.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
          otherOperations: $checkedConvert(
              'otherOperations',
              (v) => OtherOperations.fromJson(
                  Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$MappingsToJson(Mappings instance) => <String, dynamic>{
      'modelOperations':
          instance.modelOperations.map((e) => e.toJson()).toList(),
      'otherOperations': instance.otherOperations.toJson(),
    };

OtherOperations _$OtherOperationsFromJson(Map json) => $checkedCreate(
      'OtherOperations',
      json,
      ($checkedConvert) {
        final val = OtherOperations(
          read: $checkedConvert('read',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          write: $checkedConvert('write',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$OtherOperationsToJson(OtherOperations instance) =>
    <String, dynamic>{
      'read': instance.read,
      'write': instance.write,
    };

ModelMapping _$ModelMappingFromJson(Map json) => $checkedCreate(
      'ModelMapping',
      json,
      ($checkedConvert) {
        final val = ModelMapping(
          model: $checkedConvert('model', (v) => v as String),
          plural: $checkedConvert('plural', (v) => v as String?),
          findUnique: $checkedConvert(
            'findUnique',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          findUniqueOrThrow: $checkedConvert(
            'findUniqueOrThrow',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          findFirst: $checkedConvert(
            'findFirst',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          findMany: $checkedConvert(
            'findMany',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          create: $checkedConvert(
            'create',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          createMany: $checkedConvert(
            'createMany',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          update: $checkedConvert(
            'update',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          updateMany: $checkedConvert(
            'updateMany',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          upsert: $checkedConvert(
            'upsert',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          delete: $checkedConvert(
            'delete',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          deleteMany: $checkedConvert(
            'deleteMany',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          aggregate: $checkedConvert(
            'aggregate',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          groupBy: $checkedConvert(
            'groupBy',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          count: $checkedConvert(
            'count',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          findRaw: $checkedConvert(
            'findRaw',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
          aggregateRaw: $checkedConvert(
            'aggregateRaw',
            (v) => v as String?,
            readValue: _readModelMappingValue,
          ),
        );
        return val;
      },
    );

Map<String, dynamic> _$ModelMappingToJson(ModelMapping instance) {
  final val = <String, dynamic>{
    'model': instance.model,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('plural', instance.plural);
  writeNotNull('findUnique', instance.findUnique);
  writeNotNull('findUniqueOrThrow', instance.findUniqueOrThrow);
  writeNotNull('findFirst', instance.findFirst);
  writeNotNull('findMany', instance.findMany);
  writeNotNull('create', instance.create);
  writeNotNull('createMany', instance.createMany);
  writeNotNull('update', instance.update);
  writeNotNull('updateMany', instance.updateMany);
  writeNotNull('upsert', instance.upsert);
  writeNotNull('delete', instance.delete);
  writeNotNull('deleteMany', instance.deleteMany);
  writeNotNull('aggregate', instance.aggregate);
  writeNotNull('groupBy', instance.groupBy);
  writeNotNull('count', instance.count);
  writeNotNull('findRaw', instance.findRaw);
  writeNotNull('aggregateRaw', instance.aggregateRaw);
  return val;
}
