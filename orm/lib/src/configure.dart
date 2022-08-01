import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import 'utils/get_project_directory.dart';

/// ORM configure.
class Configure {
  const Configure._(this._document);
  final Map _document;

  /// Get a value from the config.
  dynamic call(String key) => _document[key.toLowerCase()];

  /// Merge environment variables form [Platform.environment].
  void _mergeEnvironment() {
    final dynamic environment = call('environment');
    final Map<String, String> environmentMap = environment is Map
        ? environment.cast<String, String>()
        : <String, String>{};
    _document['environment'] = <String, String>{
      ...environmentMap,
      ...Platform.environment,
    };
  }

  /// Environment variables.
  Map<String, String> get environment => call('environment');

  /// Get environment variable.
  String? env(String key) => environment[key];
}

/// config helper.
Configure get configured => Configure._(_loadOrmConfig()).._mergeEnvironment();

/// Load ORM config.
Map _loadOrmConfig([String? configFilePath]) {
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
    return join(getProjectDirectory(), 'orm.yaml');
  }

  return configFilePath;
}

/// Map convertor.
Map _mapConvert(Map source) => source.map<String, dynamic>(
      (dynamic key, dynamic value) {
        if (key == 'environment') {
          return MapEntry(
            'environment',
            value is! Map
                ? <String, String>{}
                : value.map(
                    (key, value) =>
                        MapEntry(key.toString(), json.encode(value)),
                  ),
          );
        }

        return MapEntry(
          key is String ? key.toLowerCase() : key,
          (value is YamlMap || value is Map) ? _mapConvert(value) : value,
        );
      },
    );
