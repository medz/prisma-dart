import 'model.dart';
import 'snapshot.dart';
import 'writer.dart';

String emitTypedClient({required SchemaSnapshot schema}) {
  final typedModels = schema.models.map(_toTypedModel).toList(growable: false);
  final typedSchema = TypedClientSchema(models: typedModels);
  return const TypedClientWriter().write(schema: typedSchema);
}

TypedModel _toTypedModel(SchemaModelDefinition model) {
  final typedFields = model.fields.map(_toTypedField).toList(growable: false);
  return TypedModel(name: model.name, fields: typedFields);
}

TypedField _toTypedField(SchemaFieldDefinition field) {
  final parsed = _parseType(field.typeSource);
  if (parsed.isRelation) {
    final relationModel = parsed.relationModel;
    if (relationModel == null) {
      throw StateError('Expected relation model for ${field.name}.');
    }
    return TypedField.relation(
      name: field.name,
      model: relationModel,
      isNullable: parsed.isNullable,
      isList: parsed.isList,
      includeInWhere: false,
      includeInCreate: false,
      includeInUpdate: false,
    );
  }

  final scalarType = parsed.scalarType;
  if (scalarType == null) {
    throw StateError('Expected scalar type for ${field.name}.');
  }
  return TypedField.scalar(
    name: field.name,
    type: scalarType,
    isNullable: parsed.isNullable,
    isList: parsed.isList,
    includeInWhere: !parsed.isList,
    includeInWhereUnique:
        (field.isId || _isConventionalIdFieldName(field.name)) &&
        !parsed.isList,
  );
}

_ParsedType _parseType(String source) {
  final normalizedSource = source.trim();
  var typeSource = normalizedSource;
  var isNullable = false;
  var isList = false;

  if (typeSource.endsWith('?')) {
    isNullable = true;
    typeSource = typeSource.substring(0, typeSource.length - 1).trim();
  }

  final listMatch = RegExp(r'^List<(.+)>$').firstMatch(typeSource);
  if (listMatch != null) {
    isList = true;
    typeSource = listMatch.group(1)!.trim();
    if (typeSource.endsWith('?')) {
      typeSource = typeSource.substring(0, typeSource.length - 1).trim();
    }
  }

  final scalarType = _scalarTypeFor(typeSource);
  if (scalarType != null) {
    return _ParsedType.scalar(
      scalarType: scalarType,
      isNullable: isNullable,
      isList: isList,
    );
  }

  return _ParsedType.relation(
    relationModel: _relationModelName(typeSource),
    isNullable: isNullable,
    isList: isList,
  );
}

TypedScalarType? _scalarTypeFor(String source) {
  final compact = source.replaceAll(RegExp(r'\s+'), '');
  return switch (compact) {
    'String' => TypedScalarType.string,
    'int' => TypedScalarType.integer,
    'double' || 'num' => TypedScalarType.floating,
    'bool' => TypedScalarType.boolean,
    'DateTime' => TypedScalarType.dateTime,
    'Object' || 'dynamic' => TypedScalarType.json,
    _ when compact.startsWith('Map<') => TypedScalarType.json,
    _ => null,
  };
}

String _relationModelName(String source) {
  final compact = source.replaceAll(RegExp(r'\s+'), '');
  final tokens = compact.split('.');
  final last = tokens.last;
  if (last.isEmpty) {
    return source;
  }
  return last;
}

bool _isConventionalIdFieldName(String name) {
  return name.trim().toLowerCase() == 'id';
}

final class _ParsedType {
  final TypedScalarType? scalarType;
  final String? relationModel;
  final bool isNullable;
  final bool isList;

  const _ParsedType.scalar({
    required this.scalarType,
    required this.isNullable,
    required this.isList,
  }) : relationModel = null;

  const _ParsedType.relation({
    required this.relationModel,
    required this.isNullable,
    required this.isList,
  }) : scalarType = null;

  bool get isRelation => relationModel != null;
}
