import 'package:json_annotation/json_annotation.dart';

import '../base_object.dart';
import 'input_object_types.dart' show InputObjectTypeField;
import 'input_output_type.dart';

part 'output_object_types.g.dart';

@JsonSerializable(createToJson: false)
class OutputObjectType extends BaseNamedObject {
  final List<OutputObjectTypeField> fields;
  final List<InputObjectTypeField> args;
  final InputOutputType outputType;

  const OutputObjectType({
    required super.name,
    required this.fields,
    required this.args,
    required this.outputType,
  });

  factory OutputObjectType.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypeFromJson(json);
}

@JsonSerializable(createToJson: false)
class OutputObjectTypesNamespace {
  final List<OutputObjectType> prisma;

  const OutputObjectTypesNamespace(this.prisma);

  factory OutputObjectTypesNamespace.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypesNamespaceFromJson(json);
}

@JsonSerializable(createToJson: false)
class OutputObjectTypeField extends BaseNamedObject {
  final bool isNullable;

  const OutputObjectTypeField({
    required super.name,
    required this.isNullable,
  });

  factory OutputObjectTypeField.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypeFieldFromJson(json);
}
