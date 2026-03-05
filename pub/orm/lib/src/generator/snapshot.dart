import 'dart:io';

final class GeneratorConfigSnapshot {
  final File configFile;
  final String outputPath;
  final String? schemaPath;

  const GeneratorConfigSnapshot({
    required this.configFile,
    required this.outputPath,
    required this.schemaPath,
  });
}

final class SchemaFieldDefinition {
  final String name;
  final String typeSource;

  const SchemaFieldDefinition({required this.name, required this.typeSource});
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
