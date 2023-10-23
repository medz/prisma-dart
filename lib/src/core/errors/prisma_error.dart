abstract class PrismaError implements Exception {
  final String message;

  const PrismaError(this.message);
}
