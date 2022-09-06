import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import 'configure.dart';
import 'parser_env.dart';

class _IO$Configure extends Configure {
  /// Create IO configure.
  _IO$Configure() {
    _load();
  }

  /// Loaded document.
  final Map<String, dynamic> _document = <String, dynamic>{
    'environment': <String, String>{},
  };

  @override
  Map<String, dynamic> get all => _document;

  /// Load `prisma.yaml` or `.env` file.
  void _load() {
    // get system envs
    _document['environment']?.addAll(Platform.environment);

    // Get current directory.
    final currentDirectory = Directory.current;

    // Build path to `prisma.yaml`.
    final configFilePath = path.join(currentDirectory.path, 'prisma.yaml');

    // Create prisma config file.
    final configFile = File(configFilePath);

    // If file exist.
    if (configFile.existsSync()) {
      _buildPrismaYaml(configFile);
    }

    // Build path to `.env`.
    final configEnvFilePath = path.join(currentDirectory.path, '.env');

    // Create `.env` file.
    final configEnvFile = File(configEnvFilePath);

    // If file exist.
    if (configEnvFile.existsSync()) {
      _buildEnvFile(configEnvFile);
    }
  }

  void _buildPrismaYaml(File configFile) {
    // Load YAML.
    final Map yaml =
        loadYaml(configFile.readAsStringSync(), sourceUrl: configFile.uri);

    // Parse YAML to Map.
    _parseYamlToMap(yaml, root: true);
  }

  void _buildEnvFile(File configEnvFile) {
    // get env vars
    final envs = ParserEnv().getVars(configEnvFile);
    _document['environment']?.addAll(envs);
  }

  /// Parse YAML to Map.
  void _parseYamlToMap(Map yaml, {bool root = false}) {
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
    if (environment is! Map) return {};
    final Map<String, String> result = <String, String>{};
    for (final MapEntry<dynamic, dynamic> entity in environment.entries) {
      if (entity.value != null) {
        if (entity.value is String) {
          result[entity.key.toString().toUpperCase()] = entity.value;
        }

        result[entity.key.toString().toUpperCase()] = entity.value.toString();
      }
    }

    return result;
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
