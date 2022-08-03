import 'package:json_annotation/json_annotation.dart';

import '../base_object.dart';

part 'enum_types.g.dart';

@JsonSerializable(createToJson: false)
class EnumType extends BaseNamedObject {
  final List<String> values;

  const EnumType({
    required super.name,
    required this.values,
  });

  factory EnumType.fromJson(Map<String, dynamic> json) =>
      _$EnumTypeFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnumTypesNamespace {
  final List<EnumType> prisma;

  const EnumTypesNamespace(this.prisma);

  factory EnumTypesNamespace.fromJson(Map<String, dynamic> json) =>
      _$EnumTypesNamespaceFromJson(json);
}
