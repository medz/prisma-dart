import '../../engines/common/errors/engine_validation_error.dart';

abstract class ValidationError implements Exception {
  const ValidationError();
}

/// `include` and `select` are used at the same time
class IncludeAndSelectError extends ValidationError {
  String get kind => 'IncludeAndSelect';

  final List<String> selectionPath;

  const IncludeAndSelectError({required this.selectionPath});
}

/// Scalar value is mentioned in `include` block (only relations are supposed to be used here)
class IncludeOnScalarError extends ValidationError {
  String get kind => 'IncludeOnScalar';

  final List<String> selectionPath;
  final OutputTypeDescription? outputType;

  const IncludeOnScalarError({required this.selectionPath, this.outputType});
}
