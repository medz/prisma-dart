import 'dart:io';
import 'dart:convert' as convert;

class PrismaInfo {
  /// Prisma version
  final String version;

  /// Current platform
  final String platform;

  const PrismaInfo._(this.version, this.platform);

  /// Lookup the Prisma version and platform.
  factory PrismaInfo.lookup(String packageManager) {
    final result = Process.runSync(
      packageManager,
      [
        'exec',
        if (packageManager == 'npm') '--',
        'prisma',
        'version',
        '--json'
      ],
      stdoutEncoding: convert.utf8,
    );
    final json = convert.json.decode(result.stdout);

    return PrismaInfo._(json['prisma'], json['current-platform']);
  }
}
