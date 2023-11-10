import 'prisma_error.dart';

class PrismaValidationError extends PrismaError {
  final List<String> selectionPath;
  final List<String> argumentPath;
  final String action;

  PrismaValidationError({
    required this.selectionPath,
    required this.argumentPath,
    required this.action,
    super.message = 'Validation error',
  });
}
