import 'package:json_annotation/json_annotation.dart';

import '../../generator_helper/types.dart';

part 'get_config_result.g.dart';

@JsonSerializable(createFactory: true, createToJson: true, explicitToJson: true)
class GetConfigResult {
  final List<DataSource> datasources;
  final List<GeneratorConfig> generators;
  final List<dynamic>? warnings;

  const GetConfigResult({
    required this.datasources,
    required this.generators,
    this.warnings,
  });

  factory GetConfigResult.fromJson(Map<String, dynamic> json) =>
      _$GetConfigResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetConfigResultToJson(this);
}
