import 'package:json_annotation/json_annotation.dart';

part 'prisma_client_unknown_request_error.g.dart';

/// Prisma Client throws a [PrismaClientUnknownRequestError] exception if the query engine returns an error related to a request that does not have an error code.
/// See https://www.prisma.io/docs/reference/api-reference/error-reference#prismaclientunknownrequesterror
@JsonSerializable(createFactory: true, createToJson: false)
class PrismaClientUnknownRequestError implements Exception {
  const PrismaClientUnknownRequestError(this.message,
      {required this.clientVersion});

  factory PrismaClientUnknownRequestError.fromJson(Map<String, dynamic> json) =>
      _$PrismaClientUnknownRequestErrorFromJson(json);

  /// Error message associated with [error code](https://www.prisma.io/docs/reference/api-reference/error-reference#error-codes).
  final String message;

  /// Version of Prisma Client (for example, 2.19.0)
  final String clientVersion;

  @override
  String toString() => 'PrismaClientUnknownRequestError: \n$message';
}
