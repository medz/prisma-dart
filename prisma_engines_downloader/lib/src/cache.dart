import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:prisma_config/prisma_config.dart';

Directory getCacheRootDirectory() {
  /// Find the cache directory for config.
  final String? configredCacheDirectoryPath =
      PrismaConfig.find('prisma_cache_directory');

  // If the config is not set, use the default cache directory.
  if (configredCacheDirectoryPath == null ||
      configredCacheDirectoryPath.isEmpty) {
    return Directory.systemTemp.createTempSync('.prisma');
  }

  return Directory(join(Directory.current.path, configredCacheDirectoryPath));
}
