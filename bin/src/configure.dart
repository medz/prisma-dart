import 'dart:io';

import 'package:orm/configure.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

/// CLI configuration.
class Configure extends PrismaEnvironmentOperator {
  Configure._internal();

  /// Project root directory.
  String get root {
    final Directory root = Directory.current;

    // Check current directory is a dart project.
    final File pubspec = File(join(root.path, 'pubspec.yaml'));
    if (!pubspec.existsSync()) {
      throw Exception(
          'Current directory (${root.path}) is not a dart project.');
    }

    return relative(root.path);
  }

  /// Returns [pubspec.yaml] file Map.
  YamlMap get pubspec {
    final File pubspec = File(join(root, 'pubspec.yaml'));
    if (!pubspec.existsSync()) {
      throw Exception('Missing pubspec.yaml file.');
    }

    return loadYaml(pubspec.readAsStringSync()) as YamlMap;
  }

  /// Returns [schema.prisma] file.
  File get schema {
    final String? configPath = pubspec['prisma']?['schema'] as String?;
    if (configPath != null) {
      final File schema = File(join(root, configPath));
      if (schema.existsSync()) {
        return schema;
      }
    }

    final List<String> searchPaths = [
      join(root, 'schema.prisma'),
      join(root, 'prisma', 'schema.prisma'),
    ];
    for (final String path in searchPaths) {
      final File schema = File(path);
      if (schema.existsSync()) {
        return schema;
      }
    }

    throw Exception('''
Missing schema.prisma file.

You can specify the path to the schema.prisma file in the pubspec.yaml file.

Example:
prisma:
  schema: path/to/schema.prisma

Or you can put the schema.prisma file in the root directory or in the prisma directory.

Or run the `init` command to create:
    \$ dart run orm init

''');
  }

  /// Returns production dart file.
  File get production {
    final String configPath = pubspec['prisma']?['production']?.toString() ??
        join('lib', 'prisma_config.dart');

    return File(join(root, configPath));
  }

  /// Returns development information.
  dynamic get development {
    final value = pubspec['prisma']?['development'];
    if (value is Map || value is YamlMap || value is String) {
      return value;
    }

    return join(root, 'prisma', 'development.dart');
  }

  /// Returns development executable
  String? get developmentExecutable {
    if (development is String) {
      return 'dart';
    }

    return development?['executable'] as String?;
  }

  /// Returns development arguments.
  Iterable<String> get developmentArguments {
    if (development is String) {
      return ['run', development];
    } else if (development is! Map || development is! YamlMap) {
      return [];
    }

    dynamic arguments = development?['arguments'];
    if (arguments is String) {
      arguments = [arguments];
    }
    if (arguments is! Iterable) {
      return [];
    }

    return arguments.cast<String>();
  }
}

/// CLI configuration instance.
final Configure configure = Configure._internal();
