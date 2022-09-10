import 'package:json_annotation/json_annotation.dart';

part 'prisma_client_rust_panic_error.g.dart';

/// Prisma Client throws a [PrismaClientRustPanicError] exception if the underlying engine crashes and exits with a non-zero exit code. In this case, the Prisma Client or the whole Node process must be restarted.
/// See https://www.prisma.io/docs/reference/api-reference/error-reference#prismaclientrustpanicerror
@JsonSerializable(createFactory: true, createToJson: false)
class PrismaClientRustPanicError implements Exception {
  const PrismaClientRustPanicError(this.message, {required this.clientVersion});

  factory PrismaClientRustPanicError.fromJson(Map<String, dynamic> json) =>
      _$PrismaClientRustPanicErrorFromJson(json);

  /// Error message associated with [error code](https://www.prisma.io/docs/reference/api-reference/error-reference#error-codes).
  final String message;

  /// Version of Prisma Client (for example, 2.19.0)
  final String clientVersion;
}
