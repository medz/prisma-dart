import 'package:prisma_common/prisma_common.dart';
import 'package:prisma_engines_platform/prisma_engines_platform.dart';

import 'prisma_binary_type.dart';

/// Default download binaries mirror.
const String _defaultBinariesMirror = r'https://binaries.prisma.sh';

/// Get download url.
Uri getDownloadUrl({
  required String version,
  required PrismaEnginesPlatform platform,
  required PrismaBinaryType binary,
}) {
  // Resolve binaries mirror.
  final String binariesMirror =
      prismaConfig('binaries_mirror') ?? _defaultBinariesMirror;

  // extension.
  final String extension =
      platform == PrismaEnginesPlatform.windows ? '.exe.gz' : '.gz';

  return Uri.parse(binariesMirror).replace(pathSegments: [
    'all_commits',
    version,
    platform.value,
    '${binary.value}$extension',
  ]);
}
