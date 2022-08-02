import 'package:json_annotation/json_annotation.dart';

part 'mappings.g.dart';

@JsonSerializable(createToJson: false)
class Mappings {
  final List<ModelOperation> modelOperations;

  const Mappings({
    required this.modelOperations,
  });

  factory Mappings.fromJson(Map<String, dynamic> json) =>
      _$MappingsFromJson(json);
}

@JsonSerializable(createToJson: false)
class ModelOperation {
  final String model;
  final String aggregate;
  final String createMany;
  final String createOne;
  final String deleteMany;
  final String deleteOne;
  final String findFirst;
  final String findMany;
  final String findUnique;
  final String groupBy;
  final String updateMany;
  final String updateOne;
  final String upsertOne;

  const ModelOperation({
    required this.model,
    required this.aggregate,
    required this.createMany,
    required this.createOne,
    required this.deleteMany,
    required this.deleteOne,
    required this.findFirst,
    required this.findMany,
    required this.findUnique,
    required this.groupBy,
    required this.updateMany,
    required this.updateOne,
    required this.upsertOne,
  });

  factory ModelOperation.fromJson(Map<String, dynamic> json) =>
      _$ModelOperationFromJson(json);
}
