/// Prisma Environtment
abstract class PrismaEnv {
  /// Debug mode
  static const String debug = String.fromEnvironment('DEBUG');

  /// No Color
  static const bool noColor =
      bool.fromEnvironment('NO_COLOR', defaultValue: false);

  /// Generate Data Proxy
  static const bool generateDataProxy =
      bool.fromEnvironment('PRISMA_GENERATE_DATAPROXY', defaultValue: false);

  /// PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION
  static final String? clientDataProxyClientVersion =
      String.fromEnvironment('PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION')
              .isNotEmpty
          ? String.fromEnvironment('PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION')
          : null;

  /// Prisma Engines Mirror
  static final Uri enginesMirror = Uri.parse(String.fromEnvironment(
      'PRISMA_ENGINES_MIRROR',
      defaultValue: 'https://binaries.prisma.sh'));

  /// Prisma Binary Query Engine
  static final String? queryEngineBinary =
      String.fromEnvironment('PRISMA_QUERY_ENGINE_BINARY').isNotEmpty
          ? String.fromEnvironment('PRISMA_QUERY_ENGINE_BINARY')
          : null;

  /// PRISMA_MIGRATION_ENGINE_BINARY
  static final String? migrationEngineBinary =
      String.fromEnvironment('PRISMA_MIGRATION_ENGINE_BINARY').isNotEmpty
          ? String.fromEnvironment('PRISMA_MIGRATION_ENGINE_BINARY')
          : null;

  /// PRISMA_INTROSPECTION_ENGINE_BINARY
  static final String? introspectionEngineBinary =
      String.fromEnvironment('PRISMA_INTROSPECTION_ENGINE_BINARY').isNotEmpty
          ? String.fromEnvironment('PRISMA_INTROSPECTION_ENGINE_BINARY')
          : null;

  /// PRISMA_FMT_BINARY
  static final String? fmtBinary =
      String.fromEnvironment('PRISMA_FMT_BINARY').isNotEmpty
          ? String.fromEnvironment('PRISMA_FMT_BINARY')
          : null;
}
