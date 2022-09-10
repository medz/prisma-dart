class StatusRetryException implements Exception {
  final bool status;

  const StatusRetryException(this.status);
}
