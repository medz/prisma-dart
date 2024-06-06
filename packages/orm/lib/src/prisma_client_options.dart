import 'logging.dart';

/// Error format
enum ErrorFormat {
  ///Enables pretty error formatting.
  pretty,

  ///Enables colorless error formatting.
  colorless,

  /// Enables minimal error formatting.
  minimal
}

class PrismaClientOptions {
  /// Overwrites the primary datasource url from your schema.prisma file
  final String? datasourceUrl;

  /// Overwrites the datasource url from your schema.prisma file
  ///
  /// Example:
  /// ```dart
  /// final prisma = PrismaClient(
  ///   datasources: {'db': 'file:./dev.db'}
  /// );
  /// ```
  final Map<String, String>? datasources;

  /// Determines the level and formatting of errors returned by Prisma Client.
  final ErrorFormat errorFormat;

  /// Log emitter.
  LogEmitter logEmitter;

  /// Create Prisma client options
  PrismaClientOptions({
    this.datasourceUrl,
    this.datasources,
    required this.errorFormat,
    required this.logEmitter,
  }) : assert(!(datasourceUrl != null && datasources != null),
            'DatasourceUrl and datasources cannot be used together');
}
