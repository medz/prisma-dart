import 'package:json_annotation/json_annotation.dart';

import '../../generator_helper/types.dart';

part 'get_config_result.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class GetConfigResult {
  final List<DataSource> datasources;
  final List<GeneratorConfig> generators;

  const GetConfigResult({
    required this.datasources,
    required this.generators,
  });

  factory GetConfigResult.fromJson(Map<String, dynamic> json) =>
      _$GetConfigResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetConfigResultToJson(this);
}
