import 'package:json_annotation/json_annotation.dart' as json_annotation;

import 'json_serializable.dart' as internal;

part 'prisma_null.g.dart';

@internal.jsonSerializable
class PrismaNull implements internal.JsonSerializable {
  const PrismaNull(this.$type);

  @json_annotation.JsonKey(name: '__typename')
  final String $type;

  factory PrismaNull.fromJson(Map<String, dynamic> json) =>
      _$PrismaNullFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PrismaNullToJson(this);
}
