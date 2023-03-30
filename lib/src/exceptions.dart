import '../engine_core.dart';

/// Prisma basic exception.
///
/// This exception is thrown when an error occurs
/// in any of the prisma engines.
class PrismaException implements Exception {
  /// The exception message.
  ///
  /// The message describes the error that occured.
  final String message;

  /// Engine that threw the exception.
  ///
  /// The engine that threw the exception.
  final Engine? engine;

  const PrismaException({
    required this.message,
    this.engine,
  });

  @override
  String toString() => '$runtimeType: $message';
}

/// Prisma initialization exception.
///
/// Thrown when an error occurs while initializing prisma.
class PrismaInitializationException extends PrismaException {
  /// Create a new instance of [PrismaInitializationException].
  ///
  /// [message] is the error message.
  /// [engine] is the prisma engine.
  const PrismaInitializationException({
    required super.message,
    super.engine,
  });
}

/// Prisma request exception.
class PrismaRequestException extends PrismaException {
  /// A Prisma-specific error code.
  final String? code;

  /// Create a new instance of [PrismaRequestException].
  const PrismaRequestException({
    /// A human-readable error message.
    required super.message,

    /// The underlying exception that caused this error.
    super.engine,

    /// A Prisma-specific error code.
    this.code,
  });
}

/// Multiple Prisma request exception.
class MultiplePrismaRequestException extends PrismaException {
  /// A list of [PrismaRequestException]s.
  final Iterable<PrismaRequestException> exceptions;

  /// Create a new instance of [MultiplePrismaRequestException].
  const MultiplePrismaRequestException({
    /// The error message to display.
    required super.message,

    /// The list of [PrismaRequestException]s.
    required this.exceptions,

    /// The Prisma engine that caused the error.
    super.engine,
  });
}

/// Prisma unknown exception.
///
/// This is a fallback exception when the error code is not recognized.
class PrismaUnknownException extends PrismaException {
  /// Create a new instance of [PrismaUnknownException].
  const PrismaUnknownException([Engine? engine])
      : super(message: 'Unknown error', engine: engine);
}
