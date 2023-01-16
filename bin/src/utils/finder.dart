import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

/// Find Dart/Flutter project root directory.
String findProjectRoot() {
  final String? root = _findPubspecFileDirectory(Directory.current.path);
  if (root == null) {
    throw Exception('Dart/Flutter project root not found.');
  }

  return relative(root);
}

/// Find `pubspec.yaml` file directory.
String? _findPubspecFileDirectory(String path) {
  final String pubspecPath = join(path, 'pubspec.yaml');
  final File pubspec = File(pubspecPath);

  if (pubspec.existsSync()) return dirname(pubspecPath);

  final String parentPath = dirname(path);
  if (parentPath == path) return null;

  return _findPubspecFileDirectory(parentPath);
}

/// Returns defined prisma schema file.
File findPrismaSchemaFile() {
  final String projectRoot = findProjectRoot();
  final File pubspecFile = File(join(projectRoot, 'pubspec.yaml'));
  final Map<String, dynamic> pubspec =
      (loadYaml(pubspecFile.readAsStringSync()) as Map).cast();
  final prisma = pubspec['prisma'];

  if (prisma is String && prisma.isNotEmpty) {
    return File(join(projectRoot, prisma));
  } else if (prisma is Map && prisma.containsKey('schema')) {
    final schema = prisma['schema'];
    if (schema is String && schema.isNotEmpty) {
      return File(join(projectRoot, schema));
    }
  }

  final Iterable<String> searchSchemaPaths = [
    join(projectRoot, 'schema.prisma'),
    join(projectRoot, 'prisma', 'schema.prisma'),
  ];

  return searchSchemaPaths.map((path) => File(path)).firstWhere(
    (file) => file.existsSync(),
    orElse: () {
      return File(join(projectRoot, 'prisma', 'schema.prisma'));
    },
  );
}
