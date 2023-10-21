import 'validation_error.dart';

class OutputTypeDescription {
  final String name;
  final List<OutputTypeDescriptionField> fields;

  const OutputTypeDescription({
    required this.name,
    required this.fields,
  });
}

class OutputTypeDescriptionField {
  final String name;
  final String typeName;
  final bool isRelation;

  const OutputTypeDescriptionField({
    required this.name,
    required this.typeName,
    required this.isRelation,
  });
}

abstract class EngineValidationError extends ValidationError {
  const EngineValidationError();
}

class InvalidArgumentValueError extends EngineValidationError {
  String get kind => 'InvalidArgumentValue';
  final List<String> selectionPath;
  final List<String> argumentPath;
  final ArgumentDescription argument;
  final String? underlyingError;

  const InvalidArgumentValueError({
    required this.selectionPath,
    required this.argumentPath,
    required this.argument,
    this.underlyingError,
  });
}

class ArgumentDescription {
  final String name;
  final List<String> typeNames;

  const ArgumentDescription({
    required this.name,
    required this.typeNames,
  });
}
