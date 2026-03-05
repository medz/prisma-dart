import 'dart:io';

final class GeneratorConfigSnapshot {
  final File configFile;
  final String? provider;
  final String outputPath;
  final String? schemaPath;

  const GeneratorConfigSnapshot({
    required this.configFile,
    required this.provider,
    required this.outputPath,
    required this.schemaPath,
  });
}

final class SchemaFieldDefinition {
  final String name;
  final String typeSource;
  final bool isId;
  final SchemaRelationAnnotationDefinition? relation;

  const SchemaFieldDefinition({
    required this.name,
    required this.typeSource,
    this.isId = false,
    this.relation,
  });
}

final class SchemaRelationAnnotationDefinition {
  final Set<String>? fields;
  final Set<String>? references;
  final String? name;

  const SchemaRelationAnnotationDefinition({
    this.fields,
    this.references,
    this.name,
  });
}

final class SchemaModelDefinition {
  final String name;
  final List<SchemaFieldDefinition> fields;

  const SchemaModelDefinition({required this.name, required this.fields});
}

final class SchemaSnapshot {
  final File schemaFile;
  final List<SchemaModelDefinition> models;

  const SchemaSnapshot({required this.schemaFile, required this.models});
}
