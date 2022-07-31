import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:path/path.dart' show join;

import 'find_project_directory.dart';

/// Load Prisma config.
Map loadPrismaConfig([String? configFilePath]) {
  // Resolve config file path.
  final String? path = _resolveConfigFilePath(configFilePath);

  // Load config file.
  if (path != null && File(path).existsSync()) {
    return _mapConvert(
      loadYaml(
        File(path).readAsStringSync(),
        sourceUrl: Uri.file(path),
      ),
    );
  }

  return {};
}

/// Resolve config file path.
String? _resolveConfigFilePath(String? configFilePath) {
  // If config file path is null, using project directory.
  if (configFilePath == null || configFilePath.isEmpty) {
    return join(findProjectDirectory().path, 'prisma.yaml');
  }

  return configFilePath;
}

/// Map convertor.
Map _mapConvert(Map source) =>
    source.map<String, dynamic>((dynamic key, dynamic value) => MapEntry(
          key is String ? key.toLowerCase() : key,
          (value is YamlMap || value is Map) ? _mapConvert(value) : value,
        ));
