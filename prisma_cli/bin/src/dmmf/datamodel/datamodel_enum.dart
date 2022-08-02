import 'package:json_annotation/json_annotation.dart';

import 'base_db_name_object.dart';

part 'datamodel_enum.g.dart';

@JsonSerializable(createToJson: false)
class DatamodelEnum extends BaseDbNameObject {
  final List<BaseDbNameObject> values;

  const DatamodelEnum({
    required super.name,
    required this.values,
    super.dbName,
  });

  factory DatamodelEnum.fromJson(Map<String, dynamic> json) =>
      _$DatamodelEnumFromJson(json);
}
