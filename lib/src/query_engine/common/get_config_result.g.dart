// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_config_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfigResult _$GetConfigResultFromJson(Map<String, dynamic> json) =>
    GetConfigResult(
      datasources: (json['datasources'] as List<dynamic>)
          .map((e) => DataSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      generators: (json['generators'] as List<dynamic>)
          .map((e) => GeneratorConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConfigResultToJson(GetConfigResult instance) =>
    <String, dynamic>{
      'datasources': instance.datasources,
      'generators': instance.generators,
    };
