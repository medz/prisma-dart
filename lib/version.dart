library prisma.version;

const String version = '4.0.0';

class PrismaVersion {
  /// The Dart client version.
  String get client => version;

  /// The Prisma CLI engine version
  final String cli;

  /// The engine version.
  final String engine;

  const PrismaVersion(this.cli, this.engine);
}
