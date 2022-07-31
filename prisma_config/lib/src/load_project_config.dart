import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:path/path.dart' show join;

import 'find_project_directory.dart';

/// Load Prisma config.
YamlMap loadPrismaConfig([String? configFilePath]) {
  // Resolve config file path.
  final String? path = _resolveConfigFilePath(configFilePath);

  // Load config file.
  if (path != null && File(path).existsSync()) {
    return loadYaml(File(path).readAsStringSync());
  }

  return YamlMap();
}

/// Resolve config file path.
String? _resolveConfigFilePath(String? configFilePath) {
  // If config file path is null, using project directory.
  if (configFilePath == null || configFilePath.isEmpty) {
    return join(findProjectDirectory().path, 'prisma.yaml');
  }

  return configFilePath;
}
