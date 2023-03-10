import '../engine_core.dart';

/// Prisma basic exception.
class PrismaException implements Exception {
  /// The exception message.
  final String message;

  /// Current thrown the exception engine.
  final Engine? engine;

  const PrismaException({
    required this.message,
    this.engine,
  });

  @override
  String toString() => '$runtimeType: $message';
}

/// Prisma initialization exception.
class PrismaInitializationException extends PrismaException {
  /// Create a new instance of [PrismaInitializationException].
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
    required super.message,
    super.engine,
    this.code,
  });
}

/// Multiple Prisma request exception.
class MultiplePrismaRequestException extends PrismaException {
  /// A list of [PrismaRequestException]s.
  final Iterable<PrismaRequestException> exceptions;

  /// Create a new instance of [MultiplePrismaRequestException].
  const MultiplePrismaRequestException({
    required super.message,
    required this.exceptions,
    super.engine,
  });
}

/// Prisma unknown exception.
class PrismaUnknownException extends PrismaException {
  /// Create a new instance of [PrismaUnknownException].
  const PrismaUnknownException([Engine? engine])
      : super(message: 'Unknown error', engine: engine);
}
