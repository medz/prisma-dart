// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfigResponse _$GetConfigResponseFromJson(Map<String, dynamic> json) =>
    GetConfigResponse(
      (json['generators'] as List<dynamic>)
          .map((e) => GeneratorConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConfigResponseToJson(GetConfigResponse instance) =>
    <String, dynamic>{
      'generators': instance.generators.map((e) => e.toJson()).toList(),
    };

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) =>
    GeneratorConfig(
      name: json['name'] as String,
      provider:
          GeneratorProvider.fromJson(json['provider'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneratorConfigToJson(GeneratorConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'provider': instance.provider.toJson(),
    };

GeneratorProvider _$GeneratorProviderFromJson(Map<String, dynamic> json) =>
    GeneratorProvider(
      value: json['value'] as String?,
    );

Map<String, dynamic> _$GeneratorProviderToJson(GeneratorProvider instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
