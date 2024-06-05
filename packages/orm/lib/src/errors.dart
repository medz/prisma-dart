import '../../version.dart';

/// Prisma client abstract error.
abstract class PrismaClientError extends Error {
  /// Error message associated with [error code](https://www.prisma.io/docs/orm/reference/error-reference#error-codes)
  final String message;

  /// Version of Prisma client (for example, `4.4.0`)
  final String clientVersion;

  /// Creates a new Prisma client error.
  PrismaClientError({required this.message, this.clientVersion = version});
}

/// Prisma Client throws a [PrismaClientValidationError] exception if validation fails - for example:
///
/// * Missing field - for example, an empty `data: {}` property when creating a new record
/// * Incorrect field type provided (for example, setting a [bool] field to `"Hello, I like cheese and gold!"`)
class PrismaClientValidationError extends PrismaClientError {
  /// Create s a new [PrismaClientValidationError].
  PrismaClientValidationError({required super.message, super.clientVersion});
}

/// Prisma Client throws a [PrismaClientUnknownRequestError] exception if the query engine returns an error related to a request that does not have an error code.
class PrismaClientUnknownRequestError extends PrismaClientError {
  PrismaClientUnknownRequestError(
      {required super.message, super.clientVersion});
}

/// Prisma Client throws a [PrismaClientRustPanicError] exception if the underlying engine crashes and exits with a non-zero exit code. In this case, Prisma Client or the whole Node process must be restarted.
class PrismaClientRustPanicError extends PrismaClientError {
  PrismaClientRustPanicError({required super.message, super.clientVersion});
}

/// Prisma Client throws a [PrismaClientInitializationError] exception if something goes wrong when the query engine is started and the connection to the database is created. This happens either:
///
/// * When `prisma.$connect()`` is called OR
/// * When the first query is executed
///
/// Errors that can occur include:
///
/// * The provided credentials for the database are invalid
/// * There is no database server running under the provided hostname and port
/// * The port that the query engine HTTP server wants to bind to is already taken
/// * missing or inaccessible environment variable
/// * The query engine binary for the current platform could not be found (`generator` block)
class PrismaClientInitializationError extends PrismaClientError {
  /// A Prisma-specific error code.
  final String errorCode;

  PrismaClientInitializationError(
      {required this.errorCode, required super.message, super.clientVersion});
}

/// Prisma Client throws a [PrismaClientKnownRequestError] exception if the query engine returns a known error related to the request - for example, a unique constraint violation.
class PrismaClientKnownRequestError extends PrismaClientError {
  /// A Prisma-specific [error code](https://www.prisma.io/docs/orm/reference/error-reference#error-codes).
  final String code;

  /// Additional information about the error
  /// for example, the field that caused the error:
  ///
  /// ```json
  /// { target: [ 'email' ] }
  /// ```
  final Map<String, dynamic>? meta;

  PrismaClientKnownRequestError(
      {required this.code,
      required super.message,
      super.clientVersion,
      this.meta});
}
