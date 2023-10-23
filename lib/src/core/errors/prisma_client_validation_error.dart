import 'prisma_error.dart';

class PrismaClientValidationError extends PrismaError {
  String get name => 'PrismaClientValidationError';
  final String clientVersion;

  const PrismaClientValidationError(
    super.message, {
    required this.clientVersion,
  });
}
