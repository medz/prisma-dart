import 'package:json_annotation/json_annotation.dart';

part 'prisma_client_known_request_error.g.dart';

/// Prisma Client throws a [PrismaClientKnownRequestError] exception if the query engine returns a known error related to the request - for example, a unique constraint violation.
/// See https://www.prisma.io/docs/reference/api-reference/error-reference#prismaclientknownrequesterror
@JsonSerializable(createFactory: true, createToJson: false)
class PrismaClientKnownRequestError implements Exception {
  const PrismaClientKnownRequestError(
    this.message, {
    required this.code,
    required this.meta,
    required this.clientVersion,
  });

  factory PrismaClientKnownRequestError.fromJson(Map<String, dynamic> json) =>
      _$PrismaClientKnownRequestErrorFromJson(json);

  /// A Prisma-specific [error code](https://www.prisma.io/docs/reference/api-reference/error-reference#error-codes).
  final String code;

  /// Additional information about the error - for example,
  /// the field that caused the error:
  /// ```json
  /// { target: [ 'email' ] }
  /// ```
  final Map<String, dynamic> meta;

  /// Error message associated with [error code](https://www.prisma.io/docs/reference/api-reference/error-reference#error-codes).
  final String message;

  /// Version of Prisma Client (for example, 2.19.0)
  final String clientVersion;
}
