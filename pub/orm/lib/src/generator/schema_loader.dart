import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'error.dart';
import 'snapshot.dart';

SchemaSnapshot loadSchema({
  required Directory cwd,
  required GeneratorConfigSnapshot config,
}) {
  final schemaFile = _resolveSchemaFile(cwd: cwd, config: config);
  if (!schemaFile.existsSync()) {
    throw GeneratorException(
      'Cannot find schema file.',
      path: schemaFile.path,
      hint: config.schemaPath == null
          ? "Set config.schema in orm.config.dart or create 'orm.schema.dart'."
          : 'Check config.schema path in orm.config.dart.',
    );
  }

  final source = schemaFile.readAsStringSync();
  final parsed = parseString(
    content: source,
    path: schemaFile.path,
    throwIfDiagnostics: false,
  );

  if (parsed.errors.isNotEmpty) {
    final diagnostic = parsed.errors.first;
    final location = parsed.lineInfo.getLocation(diagnostic.offset);
    throw GeneratorException(
      'Schema file has invalid Dart syntax.',
      path: schemaFile.path,
      line: location.lineNumber,
      column: location.columnNumber,
      hint: diagnostic.message,
    );
  }

  final models = _readModels(parsed.unit, schemaFile: schemaFile);
  if (models.isEmpty) {
    throw GeneratorException(
      'Schema does not declare any @model typedef.',
      path: schemaFile.path,
      hint: 'Add at least one @model typedef using a named record type.',
    );
  }

  return SchemaSnapshot(schemaFile: schemaFile, models: models);
}

File _resolveSchemaFile({
  required Directory cwd,
  required GeneratorConfigSnapshot config,
}) {
  final configured = config.schemaPath;
  if (configured == null || configured.trim().isEmpty) {
    return File(_join(cwd.path, 'orm.schema.dart'));
  }

  final configuredFile = File(configured);
  if (configuredFile.isAbsolute) {
    return configuredFile;
  }

  return File(_join(cwd.path, configured));
}

List<SchemaModelDefinition> _readModels(
  CompilationUnit unit, {
  required File schemaFile,
}) {
  final names = <String>{};
  final models = <SchemaModelDefinition>[];

  for (final declaration in unit.declarations) {
    if (declaration is! GenericTypeAlias) {
      continue;
    }

    if (!_hasAnnotation(declaration.metadata, 'model')) {
      continue;
    }

    final modelName = declaration.name.lexeme;
    if (!names.add(modelName)) {
      throw GeneratorException(
        'Duplicate model name: $modelName.',
        path: schemaFile.path,
        hint: 'Use unique names for each @model typedef.',
      );
    }

    if (declaration.typeParameters != null) {
      throw GeneratorException(
        'Model $modelName cannot declare type parameters.',
        path: schemaFile.path,
        hint: 'Use a non-generic typedef for @model declarations.',
      );
    }

    final type = declaration.type;
    if (type is! RecordTypeAnnotation) {
      throw GeneratorException(
        'Model $modelName must be a record typedef.',
        path: schemaFile.path,
        hint: 'Example: typedef $modelName = ({String id});',
      );
    }

    if (type.positionalFields.isNotEmpty) {
      throw GeneratorException(
        'Model $modelName must use named record fields.',
        path: schemaFile.path,
        hint: 'Example: typedef $modelName = ({String id, String name});',
      );
    }

    final named = type.namedFields;
    final namedFields =
        named?.fields ?? const <RecordTypeAnnotationNamedField>[];
    if (namedFields.isEmpty) {
      throw GeneratorException(
        'Model $modelName has no fields.',
        path: schemaFile.path,
        hint: 'Define at least one named field in the record typedef.',
      );
    }

    final fields = <SchemaFieldDefinition>[];
    for (final field in namedFields) {
      final fieldName = field.name.lexeme;
      final fieldTypeSource = field.type.toSource().trim();
      final isId = _hasAnnotationIgnoreCase(field.metadata, 'id');
      if (fieldTypeSource.isEmpty) {
        throw GeneratorException(
          'Model $modelName field $fieldName has invalid type.',
          path: schemaFile.path,
          hint: 'Set an explicit field type in the record declaration.',
        );
      }

      fields.add(
        SchemaFieldDefinition(
          name: fieldName,
          typeSource: fieldTypeSource,
          isId: isId,
        ),
      );
    }

    models.add(SchemaModelDefinition(name: modelName, fields: fields));
  }

  return models;
}

bool _hasAnnotation(NodeList<Annotation> metadata, String name) {
  for (final annotation in metadata) {
    if (annotation.name.name == name) {
      return true;
    }
  }
  return false;
}

bool _hasAnnotationIgnoreCase(NodeList<Annotation> metadata, String name) {
  final normalized = name.toLowerCase();
  for (final annotation in metadata) {
    if (annotation.name.name.toLowerCase() == normalized) {
      return true;
    }
  }
  return false;
}

String _join(String base, String child) {
  if (base.endsWith(Platform.pathSeparator)) {
    return '$base$child';
  }
  return '$base${Platform.pathSeparator}$child';
}
