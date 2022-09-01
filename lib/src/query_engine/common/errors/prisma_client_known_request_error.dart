class PrismaClientKnownRequestError implements Exception {
  final String message;

  const PrismaClientKnownRequestError(this.message);
}
