import 'dart:io';

import 'package:yaml/yaml.dart';

class Configure {
  Configure._();
  late final Map<String, dynamic> _document;

  Map<String, dynamic> get all => _document;

  /// Load Prisma config file.
  void _load() {
    final File configFile = File('prisma.yaml');
    // If config file does not exist
    if (!configFile.existsSync()) {
      _document = const <String, dynamic>{};
      return;
    }

    final Map yaml =
        loadYaml(configFile.readAsStringSync(), sourceUrl: configFile.uri);
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

  /// Call getter.
  dynamic call(String name) {
    return all[name.toLowerCase()];
  }

  operator [](String name) => call(name);

  /// Environment.
  Map<String, String> get environment => call('environment');
}

/// Prisma ORM configuration.
Configure get configure => Configure._().._load();
