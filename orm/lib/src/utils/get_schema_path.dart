import 'dart:io';

import 'package:path/path.dart';

import '../configure.dart';
import 'get_project_directory.dart';

/// Get `schema.prisma` file path.
getSchemaPath([String? path]) {
  if (path != null && path.isNotEmpty) return path;

  // Get configred schema path.
  final String configredSchemaPath =
      join(getProjectDirectory(), configured('schema'));
  if (File(configredSchemaPath).existsSync()) {
    return configredSchemaPath;
  }

  // Get path from current 'prisma/schema.prisma'.
  final String currentPrismaDirectorySchemaPath =
      join(Directory.current.path, 'prisma', 'schema.prisma');
  if (File(currentPrismaDirectorySchemaPath).existsSync()) {
    return currentPrismaDirectorySchemaPath;
  }

  // Get path from current 'schema.prisma'.
  final String currentDirectorySchemaPath =
      join(Directory.current.path, 'schema.prisma');
  if (File(currentDirectorySchemaPath).existsSync()) {
    return currentDirectorySchemaPath;
  }

  // Otherwise, throw an exception.
  throw Exception('Not found a schema file.');
}
