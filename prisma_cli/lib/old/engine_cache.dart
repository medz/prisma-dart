import 'dart:io';

import 'package:cli_util/cli_util.dart';
import 'package:path/path.dart';

import 'configure.dart';
import 'engine_options.dart';
import 'utils/fixed_platform_binary_ext.dart';
import 'utils/get_project_directory.dart';

class EngineCache {
  const EngineCache(this.options);

  /// Engine options.
  final EngineOptions options;

  /// Get cached binary path.
  String get cachedBinaryPath {
    // If custom binary path is set, return it.
    if (options.customBinaryPath != null &&
        options.customBinaryPath!.isNotEmpty) {
      return fixedPlatformBinaryExt(options.customBinaryPath!);
    }

    return joinAll([
      root,
      options.version,
      options.platform.value,
      fixedPlatformBinaryExt(options.binary.value),
    ]);
  }

  /// Get cached binary file.
  File get cachedBinaryFile => File(cachedBinaryPath);

  /// Root cache directory.
  static String get root {
    final String? configredCacheDirectoryPath = configured('cache');
    if (configredCacheDirectoryPath != null &&
        configredCacheDirectoryPath.isNotEmpty) {
      return configredCacheDirectoryPath;
    }

    try {
      // If the config is not set, use the default cache directory on project.
      return joinAll([getProjectDirectory(), 'prisma', '.cache']);
    } catch (e) {
      // If the project is not found, use the default cache directory.
      return applicationConfigHome('Prisma ORM');
    }
  }

  /// cached binary exists.
  bool get exists => cachedBinaryFile.existsSync();

  /// Override cached binary.
  void override() async {
    // Delete cached binary.
    if (exists) {
      cachedBinaryFile.deleteSync();
    }
  }
}
