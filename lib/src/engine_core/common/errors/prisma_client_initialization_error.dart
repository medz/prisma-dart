import 'package:json_annotation/json_annotation.dart';

part 'prisma_client_initialization_error.g.dart';

/// Prisma Client throws a [PrismaClientInitializationError] exception if something goes wrong when the query engine is started and the connection to the database is created. This happens either:
/// - When prisma.$connect() is called OR
/// - When the first query is executed
///
/// Errors that can occur include:
/// - The provided credentials for the database are invalid
/// - There is no database server running under the provided hostname and port
/// - The port that the query engine HTTP server wants to bind to is already taken
/// - A missing or inaccessible environment variable
/// - The query engine binary for the current platform could not be found (generator block)
@JsonSerializable(createFactory: true, createToJson: false)
class PrismaClientInitializationError implements Exception {
  const PrismaClientInitializationError(
    this.message, {
    required this.clientVersion,
    this.errorCode,
  });

  factory PrismaClientInitializationError.fromJson(Map<String, dynamic> json) =>
      _$PrismaClientInitializationErrorFromJson(json);

  /// Error message associated with [error code](https://www.prisma.io/docs/reference/api-reference/error-reference#error-codes).
  final String message;

  /// A Prisma-specific error code.
  final String? errorCode;

  /// Version of Prisma Client (for example, 2.19.0)
  final String clientVersion;

  @override
  String toString() => '''
PrismaClientInitializationError:
  message: $message
  errorCode: $errorCode
  clientVersion: $clientVersion
''';
}
