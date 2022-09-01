class PrismaServerError implements Exception {
  final String message;

  const PrismaServerError(this.message);
}
