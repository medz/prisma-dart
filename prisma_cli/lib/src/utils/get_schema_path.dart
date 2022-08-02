import 'dart:io';

import 'package:path/path.dart';

import '../configure.dart';
import 'get_project_directory.dart';

/// Get `schema.prisma` file.
File getSchemaFile([String? path]) {
  final String schemaPath = getSchemaPath(path);
  final File schema = File(schemaPath);

  if (!schema.existsSync()) {
    throw Exception('Schema file does not exist: ${relative(schemaPath)}');
  }

  return schema;
}

/// Get schema path.
String getSchemaPath([String? path]) {
  if (path != null && path.isNotEmpty) return path;

  final String? configedSchemaPath = configured('schema');
  if (configedSchemaPath != null && configedSchemaPath.isNotEmpty) {
    return join(getProjectDirectory(), configedSchemaPath);
  }

  return join(getProjectDirectory(), 'prisma', 'schema.prisma');
}
