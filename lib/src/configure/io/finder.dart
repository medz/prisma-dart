import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

class FindPrismaConfigurationResult {
  const FindPrismaConfigurationResult({
    this.prismarc,
    this.dotenv,
    this.schema,
  });

  /// The prisma runtime configuration file path.
  final String? prismarc;

  /// The dotenv file path.
  final String? dotenv;

  /// Custom schema path.
  final String? schema;
}

/// Get search paths.
List<String> get _searchPaths => <String>{
      ..._buildSearchPaths(Directory.current.path),
      ..._buildSearchPaths(path.dirname(Platform.script.path)),
      ..._buildSearchPaths(path.dirname(Platform.resolvedExecutable)),
      ..._buildSearchPaths(path.dirname(Platform.executable)),
    }.toList();

/// Build search paths for [base].
List<String> _buildSearchPaths(String base) => <String>[
      base,
      path.join(base, 'prisma'),
      path.join(base, '.dart_tool', 'prisma'),
    ];

/// Find a file in [searchPaths].
File? _findFile(String filename) {
  for (final String searchPath in _searchPaths) {
    final File file = File(path.join(searchPath, filename));
    if (file.existsSync()) {
      return file;
    }
  }

  return null;
}

/// Read `pubspec.yaml` in [searchPaths].
Map<String, dynamic>? readPubspec(File? pubspec) {
  if (pubspec == null) return null;

  final dynamic yaml = loadYaml(
    pubspec.readAsStringSync(),
    sourceUrl: pubspec.uri,
  );

  if (yaml is YamlMap) {
    return yaml
        .map((key, value) => MapEntry<String, dynamic>(key.toString(), value));
  }

  return null;
}

/// Relative a [path] by [directory], default using find in [searchPaths].
File? _relativeOrFind({
  required String filename,
  String? directory,
  String? name,
}) {
  if (name != null) {
    assert(directory == null, 'Cannot use both directory and path');

    final File file = File(path.join(directory!, name));
    if (file.existsSync()) return file;
  }

  final File? file = _findFile(filename);
  if (file != null) return file;

  return null;
}

// Find prisma configuration result.
FindPrismaConfigurationResult _findResult() {
  final File? pubspec = _findFile('pubspec.yaml');
  final Map<String, dynamic>? pubspecDocument = readPubspec(pubspec);

  final File? prismarc = _relativeOrFind(
    name: pubspecDocument?['prisma']?['prismarc']?.toString(),
    directory: pubspec?.parent.path,
    filename: '.prismarc',
  );
  final File? dotenv = _relativeOrFind(
    name: pubspecDocument?['prisma']?['env']?.toString(),
    directory: pubspec?.parent.path,
    filename: '.env',
  );
  final File? schema = _relativeOrFind(
    name: pubspecDocument?['prisma']?['schema']?.toString(),
    directory: pubspec?.parent.path,
    filename: 'schema.prisma',
  );

  return FindPrismaConfigurationResult(
    prismarc: prismarc?.path,
    dotenv: dotenv?.path,
    schema: schema?.path ?? path.join('prisma', 'schema.prisma'),
  );
}

/// Find prisma configuration result.
final FindPrismaConfigurationResult prismaConifgurationResult = _findResult();
