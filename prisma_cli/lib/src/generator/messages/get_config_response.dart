import 'package:json_annotation/json_annotation.dart';

part 'get_config_response.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: true, createToJson: true)
class GetConfigResponse {
  final List<GeneratorConfig> generators;

  const GetConfigResponse(this.generators);

  factory GetConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$GetConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetConfigResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GeneratorConfig {
  final String name;
  final GeneratorProvider provider;
  const GeneratorConfig({
    required this.name,
    required this.provider,
  });

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorConfigToJson(this);
}

@JsonSerializable()
class GeneratorProvider {
  final String? value;

  const GeneratorProvider({
    this.value,
  });

  factory GeneratorProvider.fromJson(Map<String, dynamic> json) =>
      _$GeneratorProviderFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorProviderToJson(this);
}
