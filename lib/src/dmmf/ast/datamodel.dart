class DataModel {
  final Iterable<Model> models;
  final Iterable<DatamodelEnum> enums;

  /// composite types
  final Iterable<Model> types;

  const DataModel({
    required this.models,
    required this.enums,
    required this.types,
  });

  factory DataModel.fromJson(Map json) {
    return DataModel(
      models: (json['models'] as Iterable).map((e) => Model.fromJson(e)),
      enums: (json['enums'] as Iterable).map((e) => DatamodelEnum.fromJson(e)),
      types: (json['types'] as Iterable).map((e) => Model.fromJson(e)),
    );
  }
}

class Model {
  final String name;
  final String? dbName;
  final Iterable<Field> fields;
  final Iterable<UniqueIndex> uniqueIndexes;
  final String? documentation;
  final PrimaryKey? primaryKey;
  final bool isGenerated;

  const Model({
    required this.name,
    this.dbName,
    required this.fields,
    required this.uniqueIndexes,
    this.documentation,
    this.primaryKey,
    required this.isGenerated,
  });

  factory Model.fromJson(Map json) {
    return Model(
      name: json['name'],
      dbName: json['dbName'],
      fields: (json['fields'] as Iterable).map((e) => Field.fromJson(e)),
      uniqueIndexes: (json['uniqueIndexes'] as Iterable)
          .map((e) => UniqueIndex.fromJson(e)),
      documentation: json['documentation'],
      primaryKey: json['primaryKey'] == null
          ? null
          : PrimaryKey.fromJson(json['primaryKey']),
      isGenerated: switch (json['isGenerated']) {
        bool value => value,
        _ => false,
      },
    );
  }
}

class DatamodelEnum {
  final String name;
  final Iterable<EnumValue> values;
  final String? dbName;
  final String? documentation;

  const DatamodelEnum({
    required this.name,
    required this.values,
    this.dbName,
    this.documentation,
  });

  factory DatamodelEnum.fromJson(Map json) {
    return DatamodelEnum(
      name: json['name'],
      values: (json['values'] as Iterable).map((e) => EnumValue.fromJson(e)),
      dbName: json['dbName'],
      documentation: json['documentation'],
    );
  }
}

class EnumValue {
  final String name;
  final String? dbName;

  const EnumValue({
    required this.name,
    this.dbName,
  });

  factory EnumValue.fromJson(Map json) {
    return EnumValue(
      name: json['name'],
      dbName: json['dbName'],
    );
  }
}

class PrimaryKey {
  final String? name;
  final Iterable<String> fields;

  const PrimaryKey({
    this.name,
    required this.fields,
  });

  factory PrimaryKey.fromJson(Map json) {
    return PrimaryKey(
      name: json['name'],
      fields: (json['fields'] as Iterable).cast(),
    );
  }
}

class UniqueIndex {
  final String name;
  final Iterable<String> fields;

  const UniqueIndex({
    required this.name,
    required this.fields,
  });

  factory UniqueIndex.fromJson(Map json) {
    return UniqueIndex(
      name: json['name'],
      fields: (json['fields'] as Iterable).cast(),
    );
  }
}

class Field {
  final FieldKind kind;
  final String name;
  final bool isRequired;
  final bool isList;
  final bool isUnique;
  final bool isId;
  final bool isReadOnly;
  final bool isGenerated;
  final bool isUpdatedAt;
  final String type;
  final String? dbName;
  final bool hasDefaultValue;
  final dynamic $default;
  final Iterable<String>? relationFromFields;
  final Iterable<String>? relationToFields;
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
    required this.isGenerated,
    required this.isUpdatedAt,
    required this.type,
    this.dbName,
    required this.hasDefaultValue,
    this.$default,
    this.relationFromFields,
    this.relationToFields,
    this.relationOnDelete,
    this.relationName,
    this.documentation,
  });

  factory Field.fromJson(Map json) {
    return Field(
      kind: switch (json['kind']) {
        'scalar' => FieldKind.scalar,
        'relation' => FieldKind.relation,
        'enum' => FieldKind.$enum,
        _ => FieldKind.unsupported,
      },
      name: json['name'],
      isRequired: switch (json['isRequired']) {
        bool value => value,
        _ => false,
      },
      isList: switch (json['isList']) {
        bool value => value,
        _ => false,
      },
      isUnique: switch (json['isUnique']) {
        bool value => value,
        _ => false,
      },
      isId: switch (json['isId']) {
        bool value => value,
        _ => false,
      },
      isReadOnly: switch (json['isReadOnly']) {
        bool value => value,
        _ => false,
      },
      isGenerated: switch (json['isGenerated']) {
        bool value => value,
        _ => false,
      },
      isUpdatedAt: switch (json['isUpdatedAt']) {
        bool value => value,
        _ => false,
      },
      type: json['type'],
      dbName: json['dbName'],
      hasDefaultValue: switch (json['hasDefaultValue']) {
        bool value => value,
        _ => false,
      },
      $default: json['default'],
      relationFromFields: json['relationFromFields'] == null
          ? null
          : (json['relationFromFields'] as Iterable).cast(),
      relationToFields: json['relationToFields'] == null
          ? null
          : (json['relationToFields'] as Iterable).cast(),
      relationOnDelete: json['relationOnDelete'],
      relationName: json['relationName'],
      documentation: json['documentation'],
    );
  }
}

enum FieldKind {
  scalar,
  relation,
  $enum,
  unsupported,
}
