/// Prisma event types.
enum Event {
  /// Logging an all queries run.
  query,

  /// Info message.
  info,

  /// Warning message.
  warn,

  /// Error message.
  error,
}
