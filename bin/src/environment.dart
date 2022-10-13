import 'dart:io';

import 'package:orm/configure.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

/// Create a Prisma environment for CLI.
final PrismaEnvironment environment = PrismaEnvironment(
  includePlatformEnvironment: true,
);

/// CLI environment extension.
extension PrismaEnvironmentExtension on PrismaEnvironment {
  /// Returns `pubspec.yaml` file.
  File get pubspec {
    final String path = join(Directory.current.path, 'pubspec.yaml');
    final File pubspec = File(path);

    if (pubspec.existsSync()) return pubspec;

    throw Exception('pubspec.yaml not found in ${dirname(path)}');
  }

  /// Returns project root directory path.
  ///
  /// Resolve in current directory.
  String get projectRoot => dirname(pubspec.path);

  /// Returns `pubspec.yaml` file content.
  Map<String, dynamic> get _document =>
      (loadYaml(pubspec.readAsStringSync()) as Map).cast();

  /// Returns Prisma schema file.
  File get schema {
    final String? configed =
        _document['prisma']?['schema']?.toString().toString();
    if (configed?.isNotEmpty == true) return File(configed!);

    final Iterable<String> searchSchemaPaths = [
      join(projectRoot, 'schema.prisma'),
      join(projectRoot, 'prisma', 'schema.prisma'),
    ];

    for (final String path in searchSchemaPaths) {
      final File schema = File(path);

      if (schema.existsSync()) return schema;
    }

    return File(join(projectRoot, 'prisma', 'schema.prisma'));
  }

  /// Returns Prisma environment production function name.
  String get productionFunctionName => 'configurePrisma';

  /// Returns production dart file.
  File get production {
    final String? configed =
        _document['prisma']?['production']?.toString().trim();
    if (configed?.isNotEmpty == true) return File(join(projectRoot, configed));

    return File(join(projectRoot, 'lib', 'prisma_configurator.dart'));
  }

  /// Returns default development dart file.
  File get development {
    final String? configed =
        _document['prisma']?['development']?.toString().trim();
    if (configed?.isNotEmpty == true) return File(join(projectRoot, configed));

    return File(join(projectRoot, 'prisma', 'development.dart'));
  }

  /// Returns development information.
  Object? get _development {
    final Object? configed = _document['prisma']?['development'];

    // If configed is Map or String, return it.
    if (configed is Map || configed is String) return configed;

    // If development dart file exists, return generated development information.
    if (development.existsSync()) {
      return {
        'executable': 'dart',
        'arguments': [
          'run',
          development.path,
        ],
      };
    }

    return null;
  }

  /// Returns development executable.
  String? get developmentExecutable {
    // If development information is null or String, return it.
    if (_development is String) {
      final String? path = _development?.toString().trim();
      if (path?.isNotEmpty == true) return 'dart';
    } else if (_development is Map) {
      final String? executable =
          (_development as Map)['executable']?.toString().trim();
      if (executable?.isNotEmpty == true) return executable;
    }

    return null;
  }

  /// Returns development executable arguments.
  Iterable<String> get developmentArguments {
    // If development information is null or String, return it.
    if (_development is String) {
      final String? path = _development?.toString().trim();
      if (path?.isNotEmpty == true) return ['run', path!];
    } else if (_development is Map) {
      final Iterable<String>? arguments =
          (_development as Map)['arguments']?.cast<String>();
      if (arguments?.isNotEmpty == true) return arguments!;
    }

    return [];
  }
}
