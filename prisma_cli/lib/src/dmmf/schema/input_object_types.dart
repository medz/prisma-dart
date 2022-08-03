import 'package:json_annotation/json_annotation.dart';

import '../base_object.dart';
import 'input_output_type.dart';

part 'input_object_types.g.dart';

@JsonSerializable(createToJson: false)
class InputObjectType extends BaseNamedObject {
  final InputObjectTypeConstraints constraints;
  final List<InputObjectTypeField> fields;

  const InputObjectType({
    required super.name,
    required this.constraints,
    required this.fields,
  });

  factory InputObjectType.fromJson(Map<String, dynamic> json) =>
      _$InputObjectTypeFromJson(json);
}

@JsonSerializable(createToJson: false)
class InputObjectTypesNamespace {
  final List<InputObjectType> prisma;

  const InputObjectTypesNamespace(this.prisma);

  factory InputObjectTypesNamespace.fromJson(Map<String, dynamic> json) =>
      _$InputObjectTypesNamespaceFromJson(json);
}

@JsonSerializable(createToJson: false)
class InputObjectTypeConstraints {
  final int? maxNumFields;
  final int? minNumFields;

  const InputObjectTypeConstraints({
    this.maxNumFields,
    this.minNumFields,
  });

  factory InputObjectTypeConstraints.fromJson(Map<String, dynamic> json) =>
      _$InputObjectTypeConstraintsFromJson(json);
}

@JsonSerializable(createToJson: false)
class InputObjectTypeField extends BaseNamedObject {
  final bool isRequired;
  final bool isNullable;
  final List<InputOutputType> inputTypes;

  const InputObjectTypeField({
    required super.name,
    required this.isRequired,
    required this.isNullable,
    required this.inputTypes,
  });

  factory InputObjectTypeField.fromJson(Map<String, dynamic> json) {
    return _$InputObjectTypeFieldFromJson(json);
  }
}
