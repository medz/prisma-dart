import 'package:json_annotation/json_annotation.dart';

part 'base_object.g.dart';

@JsonSerializable(createToJson: false)
class BaseNamedObject {
  final String name;

  const BaseNamedObject({required this.name});
  factory BaseNamedObject.fromJson(Map<String, dynamic> json) =>
      _$BaseNamedObjectFromJson(json);
}

@JsonSerializable(createToJson: false)
class BaseNameNullableObject {
  final String? name;

  const BaseNameNullableObject({this.name});
  factory BaseNameNullableObject.fromJson(Map<String, dynamic> json) =>
      _$BaseNameNullableObjectFromJson(json);
}
