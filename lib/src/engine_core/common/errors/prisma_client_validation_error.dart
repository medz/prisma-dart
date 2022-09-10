import 'package:json_annotation/json_annotation.dart';

part 'prisma_client_validation_error.g.dart';

/// Prisma Client throws a [PrismaClientValidationError] exception if validation fails.
/// See https://www.prisma.io/docs/reference/api-reference/error-reference#prismaclientvalidationerror
@JsonSerializable(createFactory: true, createToJson: false)
class PrismaClientValidationError implements Exception {
  const PrismaClientValidationError(this.message);

  factory PrismaClientValidationError.fromJson(Map<String, dynamic> json) =>
      _$PrismaClientValidationErrorFromJson(json);

  /// Error message
  final String message;
}
