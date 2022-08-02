import 'package:json_annotation/json_annotation.dart';

import 'datamodel/datamodel.dart';
import 'mappings.dart';
import 'schema/schema.dart';

part 'dmmf.g.dart';

@JsonSerializable(createToJson: false)
class DMMF {
  final Datamodel datamodel;
  final Schema schema;
  final Mappings mappings;

  DMMF({
    required this.datamodel,
    required this.schema,
    required this.mappings,
  });

  factory DMMF.fromJson(Map<String, dynamic> json) => _$DMMFFromJson(json);
}
