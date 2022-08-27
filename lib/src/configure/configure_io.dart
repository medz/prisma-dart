import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import 'configure.dart';

class _IO$Configure extends Configure {
  /// Create IO configure.
  _IO$Configure() {
    _load();
  }

  /// Loaded document.
  late final Map<String, dynamic> _document;

  @override
  Map<String, dynamic> get all => _document;

  /// Load `prisma.yaml` file.
  void _load() {
    // Get current directory.
    final Directory currentDirectory = Directory.current;

    // Build path to `prisma.yaml`.
    final String configFilePath =
        path.join(currentDirectory.path, 'prisma.yaml');

    // Create prisma config file.
    final File configFile = File(configFilePath);

    // If file does not exist.
    if (!configFile.existsSync()) {
      _document = const <String, dynamic>{};
      return;
    }

    // Load YAML.
    final Map yaml =
        loadYaml(configFile.readAsStringSync(), sourceUrl: configFile.uri);

    // Parse YAML to Map.
    _parseYamlToMap(yaml, root: true);
  }

  /// Parse YAML to Map.
  void _parseYamlToMap(Map yaml, {bool root = false}) {
    _document = <String, dynamic>{};
    for (final MapEntry<dynamic, dynamic> entity in yaml.entries) {
      if (entity.key == 'environment' && root) {
        _document['environment'] = _mergeEnvironment(entity.value);
        continue;
      }

      _document[entity.key.toString().toLowerCase()] =
          _parseMapItem(entity.value);
    }
  }

  /// Merge Environment.
  Map<String, String> _mergeEnvironment(dynamic environment) {
    if (environment is! Map) return Platform.environment;
    final Map<String, String> result = <String, String>{};
    for (final MapEntry<dynamic, dynamic> entity in environment.entries) {
      if (entity.value != null) {
        if (entity.value is String) {
          result[entity.key.toString().toUpperCase()] = entity.value;
        }

        result[entity.key.toString().toUpperCase()] = entity.value.toString();
      }
    }

    return {
      ...Platform.environment,
      ...result,
    };
  }

  /// Parse Map item.
  dynamic _parseMapItem(dynamic item) {
    if (item is Map) {
      return _parseYamlToMap(item);
    }

    if (item is List) {
      return item.map((dynamic i) => _parseMapItem(i)).toList();
    }

    return item;
  }
}

/// Create IO configure instance.
Configure get configure => _IO$Configure();
