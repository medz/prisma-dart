abstract class PrismaError extends Error {
  final String message;

  PrismaError({
    required this.message,
  });
}
