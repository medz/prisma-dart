import '../error_format.dart';
import '../errors/validation_error.dart';

Never throwValidationError({
  final Iterable<ValidationError> errors,
  final Map<String, dynamic>? args,
  final String originalMethod,
  final ErrorFormat errorFormat,
  final String clientVersion,
}) {}
