import 'package:json_annotation/json_annotation.dart';

import 'enum_types.dart';
import 'input_object_types.dart';
import 'output_object_types.dart';

part 'schema.g.dart';

@JsonSerializable(createToJson: false)
class Schema {
  final EnumTypesNamespace enumTypes;
  final InputObjectTypesNamespace inputObjectTypes;
  // final OutputObjectTypesNamespace outputObjectTypes;

  const Schema({
    required this.enumTypes,
    required this.inputObjectTypes,
    // required this.outputObjectTypes,
  });

  factory Schema.fromJson(Map<String, dynamic> json) => _$SchemaFromJson(json);
}
