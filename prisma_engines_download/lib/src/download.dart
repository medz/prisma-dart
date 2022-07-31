import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:prisma_engines_platform/prisma_engines_platform.dart';

import 'cache.dart';
import 'prisma_binary_type.dart';

/// Get cached binary path.
String? getCachedBinaryPath({
  required String version,
  required PrismaEnginesPlatform platform,
  required PrismaBinaryType binary,
}) {
  // Get cache directory.
  final Directory cacheDirectory = getCacheDirectory(
    version: version,
    platform: platform,
  );

  // Get binary path.
  final String binaryPath = join(
    cacheDirectory.path,
    binary.value,
  );

  return File(binaryPath).existsSync() ? binaryPath : null;
}
