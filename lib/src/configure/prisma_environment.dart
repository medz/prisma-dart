// ignore_for_file: non_constant_identifier_names

import 'query_engine_type.dart';

/// See https://www.prisma.io/docs/reference/api-reference/environment-variables-reference
class PrismaEnvironment {
  const PrismaEnvironment({
    this.DATABASE_URL,
    this.DEBUG,
    this.NO_COLOR,
    this.BROWSER,
    this.PRISMA_CLI_QUERY_ENGINE_TYPE = QueryEngineType.binary,
    this.PRISMA_CLIENT_ENGINE_TYPE = QueryEngineType.binary,
    this.PRISMA_ENGINES_MIRROR = r'https://binaries.prisma.sh',
    this.PRISMA_QUERY_ENGINE_BINARY,
    this.PRISMA_QUERY_ENGINE_LIBRARY,
    this.PRISMA_MIGRATION_ENGINE_BINARY,
    this.PRISMA_INTROSPECTION_ENGINE_BINARY,
    this.PRISMA_FMT_BINARY,
  });

  /// Database URL
  final String? DATABASE_URL;

  /// Debugging
  final String? DEBUG;

  /// NO_COLOR
  final String? NO_COLOR;

  /// BROWSER is for Prisma Studio to force which browser it should be open in, if not set it will open in the default browser. It's also used as a flag when starting the studio from the CLI.
  /// BROWSER=firefox prisma studio --port 5555
  final String? BROWSER;

  /// PRISMA_CLI_QUERY_ENGINE_TYPE is used to define the query engine type Prisma CLI downloads and uses. Defaults to library, but can be set to binary
  final QueryEngineType PRISMA_CLI_QUERY_ENGINE_TYPE;

  /// PRISMA_CLIENT_ENGINE_TYPE is used to define the query engine type Prisma Client downloads and uses. Defaults to library, but can be set to binary
  final QueryEngineType PRISMA_CLIENT_ENGINE_TYPE;

  /// PRISMA_ENGINES_MIRROR can be used to specify a custom CDN (or server) endpoint to download the engines files for the CLI/Client. The default value is https://binaries.prisma.sh, where Prisma hosts the engine files
  final String PRISMA_ENGINES_MIRROR;

  /// PRISMA_QUERY_ENGINE_BINARY is used to set a custom location for your own query engine binary.
  final String? PRISMA_QUERY_ENGINE_BINARY;

  /// PRISMA_QUERY_ENGINE_LIBRARY is used to set a custom location for your own query engine library.
  final String? PRISMA_QUERY_ENGINE_LIBRARY;

  /// PRISMA_MIGRATION_ENGINE_BINARY is used to set a custom location for your own migration engine binary.
  final String? PRISMA_MIGRATION_ENGINE_BINARY;

  /// PRISMA_INTROSPECTION_ENGINE_BINARY is used to set a custom location for your own introspection engine binary.
  final String? PRISMA_INTROSPECTION_ENGINE_BINARY;

  /// PRISMA_FMT_BINARY is used to set a custom location for your own format engine binary.
  final String? PRISMA_FMT_BINARY;
}
