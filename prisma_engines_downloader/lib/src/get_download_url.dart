import 'dart:io';

import 'package:prisma_engines_platform/prisma_engines_platform.dart';

import 'binary_type.dart';

/// Default download binaries mirror.
const String defaultDownloadBinariesMirror = r'https://binaries.prisma.sh';

/// Get download url.
Uri getDownloadUrl({
  required String channel,
  required String version,
  required PrismaEnginesPlatform platform,
  required BinaryType binary,
  String extension = '.gz',
}) {
  // Resolve binaries mirror.
  final String binariesMirror =
      Platform.environment['PRISMA_BINARIES_MIRROR'] ??
          Platform.environment['PRISMA_ENGINES_MIRROR'] ??
          defaultDownloadBinariesMirror;

  // Resolve extension.
  final String resolvedExtension =
      platform == PrismaEnginesPlatform.windows ? '.exe$extension' : extension;

  return Uri.parse(binariesMirror).replace(pathSegments: [
    channel,
    version,
    platform.value,
    '${binary.value}$resolvedExtension',
  ]);
}
