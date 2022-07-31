import 'package:prisma_config/prisma_config.dart';
import 'package:prisma_engines_platform/prisma_engines_platform.dart';

import 'prisma_binary_type.dart';

/// Default download binaries mirror.
const String _defaultBinariesMirror = r'https://binaries.prisma.sh';

/// Get download url.
Uri getDownloadUrl({
  required String version,
  required PrismaEnginesPlatform platform,
  required PrismaBinaryType binary,
  String extension = '.gz',
}) {
  // Resolve binaries mirror.
  final String binariesMirror =
      PrismaConfig.find('binaries_mirror') ?? _defaultBinariesMirror;

  // Resolve extension.
  final String resolvedExtension =
      platform == PrismaEnginesPlatform.windows ? '.exe$extension' : extension;

  return Uri.parse(binariesMirror).replace(pathSegments: [
    'all_commits',
    version,
    platform.value,
    '${binary.value}$resolvedExtension',
  ]);
}
