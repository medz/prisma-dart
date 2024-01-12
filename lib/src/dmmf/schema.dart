// Copy from: https://github.com/prisma/prisma-engines/blob/main/query-engine/dmmf/src/serialization_ast/schema_ast.rs

class Schema {
  final SchemaTypes<InputType> inputTypes;
  final SchemaTypes<OutputType> outputTypes;
  final SchemaTypes<Enum> enumTypes;
  final SchemaTypes<FieldRefType> fieldRefTypes;

  const Schema({
    required this.inputTypes,
    required this.outputTypes,
    required this.enumTypes,
    required this.fieldRefTypes,
  });

  factory Schema.fromJson(Map json) {
    return Schema(
      inputTypes:
          SchemaTypes.fromJson(json['inputObjectTypes'], InputType.fromJson),
      outputTypes:
          SchemaTypes.fromJson(json['outputObjectTypes'], OutputType.fromJson),
      enumTypes: SchemaTypes.fromJson(json['enumTypes'], Enum.fromJson),
      fieldRefTypes:
          SchemaTypes.fromJson(json['fieldRefTypes'], FieldRefType.fromJson),
    );
  }
}

class SchemaTypes<T> {
  final List<T> model;
  final List<T> prisma;

  const SchemaTypes({
    required this.model,
    required this.prisma,
  });

  factory SchemaTypes.fromJson(Map json, T Function(Map json) factory) {
    return SchemaTypes(
      model: json['model'] == null
          ? []
          : (json['model'] as Iterable).cast<Map>().map(factory).toList(),
      prisma: json['prisma'] == null
          ? []
          : (json['prisma'] as Iterable).cast<Map>().map(factory).toList(),
    );
  }
}

class InputType {
  final String name;
  final InputTypeConstraints constraints;
  final InputTypeMeta? meta;
  final List<InputField> fields;

  const InputType({
    required this.name,
    required this.constraints,
    this.meta,
    required this.fields,
  });

  factory InputType.fromJson(Map json) {
    return InputType(
      name: json['name'],
      constraints: InputTypeConstraints.fromJson(json['constraints']),
      meta: json['meta'] == null ? null : InputTypeMeta.fromJson(json['meta']),
      fields: (json['fields'] as Iterable)
          .map((e) => InputField.fromJson(e))
          .toList(),
    );
  }
}

class InputTypeConstraints {
  final int? maxNumFields;
  final int? minNumFields;
  final Iterable<String>? fields;

  const InputTypeConstraints({
    this.maxNumFields,
    this.minNumFields,
    this.fields,
  });

  factory InputTypeConstraints.fromJson(Map json) {
    return InputTypeConstraints(
      maxNumFields: json['maxNumFields'],
      minNumFields: json['minNumFields'],
      fields: json['fields'] == null
          ? null
          : (json['fields'] as Iterable).cast<String>(),
    );
  }
}

class InputTypeMeta {
  final String? source;

  const InputTypeMeta({
    this.source,
  });

  factory InputTypeMeta.fromJson(Map json) {
    return InputTypeMeta(
      source: json['source'],
    );
  }
}

class InputField {
  final String name;
  final bool isNullable;
  final bool isRequired;
  final List<TypeReference> inputTypes;
  final Deprecation? deprecation;

  const InputField({
    required this.name,
    required this.isNullable,
    required this.isRequired,
    required this.inputTypes,
    this.deprecation,
  });

  factory InputField.fromJson(Map json) {
    return InputField(
      name: json['name'],
      isNullable: json['isNullable'],
      isRequired: json['isRequired'],
      inputTypes: (json['inputTypes'] as Iterable)
          .map((e) => TypeReference.fromJson(e))
          .toList(),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation.fromJson(json['deprecation']),
    );
  }
}

class Enum {
  final String name;
  final Iterable<String> values;

  const Enum({
    required this.name,
    required this.values,
  });

  factory Enum.fromJson(Map json) {
    return Enum(
      name: json['name'],
      values: (json['values'] as Iterable).cast(),
    );
  }
}

class FieldRefType {
  final String name;
  final Iterable<TypeReference> allowTypes;
  final Iterable<InputField> fields;

  const FieldRefType({
    required this.name,
    required this.allowTypes,
    required this.fields,
  });

  factory FieldRefType.fromJson(Map json) {
    return FieldRefType(
      name: json['name'],
      allowTypes: (json['allowTypes'] as Iterable)
          .map((e) => TypeReference.fromJson(e)),
      fields: (json['fields'] as Iterable).map((e) => InputField.fromJson(e)),
    );
  }
}

class Deprecation {
  final String sinceVersion;
  final String reason;
  final String? plannedRemovalVersion;

  const Deprecation({
    required this.sinceVersion,
    required this.reason,
    this.plannedRemovalVersion,
  });

  factory Deprecation.fromJson(Map json) {
    return Deprecation(
      sinceVersion: json['sinceVersion'],
      reason: json['reason'],
      plannedRemovalVersion: json['plannedRemovalVersion'],
    );
  }
}

class TypeReference {
  final String type;
  final bool isList;
  final TypeLocation location;
  final TypeNamespace? namespace;

  const TypeReference({
    required this.type,
    required this.isList,
    required this.location,
    required this.namespace,
  });

  factory TypeReference.fromJson(Map json) {
    return TypeReference(
      type: json['type'],
      isList: json['isList'],
      location: TypeLocation.values.firstWhere(
        (e) => e.name == json['location'],
      ),
      namespace: TypeNamespace.values
          .where((e) => e.name == json['namespace'])
          .firstOrNull,
    );
  }
}

enum TypeLocation {
  scalar,
  inputObjectTypes,
  outputObjectTypes,
  enumTypes,
  fieldRefTypes,
}

enum TypeNamespace {
  model,
  prisma,
}

class OutputType {
  final String name;
  final List<OutputField> fields;

  const OutputType({
    required this.name,
    required this.fields,
  });

  factory OutputType.fromJson(Map json) {
    return OutputType(
      name: json['name'],
      fields: (json['fields'] as Iterable)
          .map((e) => OutputField.fromJson(e))
          .toList(),
    );
  }
}

class OutputField {
  final String name;
  final List<InputField> args;
  final bool isNullable;
  final TypeReference outputType;
  final Deprecation? deprecation;

  const OutputField({
    required this.name,
    required this.args,
    required this.isNullable,
    required this.outputType,
    this.deprecation,
  });

  factory OutputField.fromJson(Map json) {
    return OutputField(
      name: json['name'],
      args: (json['args'] as Iterable)
          .map((e) => InputField.fromJson(e))
          .toList(),
      isNullable: json['isNullable'],
      outputType: TypeReference.fromJson(json['outputType']),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation.fromJson(json['deprecation']),
    );
  }
}
