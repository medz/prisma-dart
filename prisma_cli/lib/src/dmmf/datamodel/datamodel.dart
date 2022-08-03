import 'package:json_annotation/json_annotation.dart';

import 'datamodel_enum.dart';
import 'user_model.dart';

part 'datamodel.g.dart';

@JsonSerializable(createToJson: false)
class Datamodel {
  final List<DatamodelEnum> enums;
  final List<UserModel> models;

  const Datamodel({
    required this.enums,
    required this.models,
  });

  factory Datamodel.fromJson(Map<String, dynamic> json) =>
      _$DatamodelFromJson(json);
}
