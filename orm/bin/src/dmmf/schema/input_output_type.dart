import 'package:json_annotation/json_annotation.dart';

part 'input_output_type.g.dart';

@JsonSerializable(createToJson: false)
class InputOutputType {
  final String? namespace;
  final String location;
  final bool isList;
  final String type;

  const InputOutputType({
    this.namespace,
    required this.location,
    required this.isList,
    required this.type,
  });

  factory InputOutputType.fromJson(Map<String, dynamic> json) {
    return _$InputOutputTypeFromJson(json);
  }
}
