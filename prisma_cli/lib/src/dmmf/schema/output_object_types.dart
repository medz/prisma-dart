import 'package:json_annotation/json_annotation.dart';

import '../base_object.dart';
import 'input_object_types.dart';
import 'input_output_type.dart';

part 'output_object_types.g.dart';

@JsonSerializable(createToJson: false)
class OutputObjectType extends BaseNamedObject {
  final List<OutputObjectTypeField> fields;

  const OutputObjectType({
    required super.name,
    required this.fields,
  });

  factory OutputObjectType.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypeFromJson(json);
}

@JsonSerializable(createToJson: false)
class OutputObjectTypesNamespace {
  final List<OutputObjectType> prisma;
  final List<OutputObjectType> model;

  const OutputObjectTypesNamespace({
    this.prisma = const [],
    this.model = const [],
  });

  factory OutputObjectTypesNamespace.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypesNamespaceFromJson(json);
}

@JsonSerializable(createToJson: false)
class OutputObjectTypeField extends BaseNamedObject {
  final bool isNullable;
  final InputOutputType outputType;
  final List<InputObjectTypeField> args;

  const OutputObjectTypeField({
    required super.name,
    required this.isNullable,
    required this.outputType,
    required this.args,
  });

  factory OutputObjectTypeField.fromJson(Map<String, dynamic> json) =>
      _$OutputObjectTypeFieldFromJson(json);
}
