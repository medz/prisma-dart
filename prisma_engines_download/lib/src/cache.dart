import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:prisma_config/prisma_config.dart';
import 'package:prisma_engines_platform/prisma_engines_platform.dart';

/// Get root cache directory.
Directory getRootCacheDirectory() {
  /// Find the cache directory for config.
  final String? configredCacheDirectoryPath = PrismaConfig.find('cache');

  // If the config is not set, use the default cache directory.
  if (configredCacheDirectoryPath == null ||
      configredCacheDirectoryPath.isEmpty) {
    return Directory.systemTemp.createTempSync('.prisma');
  }

  return Directory(join(Directory.current.path, configredCacheDirectoryPath));
}

///cache directory.
Directory getCacheDirectory({
  required String channel,
  required String version,
  required PrismaEnginesPlatform platform,
}) {
  final Directory directory = Directory(join(
    getRootCacheDirectory().path,
    channel,
    version,
    platform.value,
  ));

  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  return directory;
}
