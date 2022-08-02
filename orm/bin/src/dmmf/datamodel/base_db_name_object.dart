import 'package:json_annotation/json_annotation.dart';

import '../base_object.dart';

part 'base_db_name_object.g.dart';

@JsonSerializable(createToJson: false)
class BaseDbNameObject extends BaseNamedObject {
  final String? dbName;
  const BaseDbNameObject({
    required super.name,
    this.dbName,
  });
  factory BaseDbNameObject.fromJson(Map<String, dynamic> json) =>
      _$BaseDbNameObjectFromJson(json);
}
