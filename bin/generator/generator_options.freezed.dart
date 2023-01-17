// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generator_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeneratorOptions _$GeneratorOptionsFromJson(Map<String, dynamic> json) {
  return _GeneratorOptions.fromJson(json);
}

/// @nodoc
mixin _$GeneratorOptions {
  GeneratorConfig get generator => throw _privateConstructorUsedError;
  String get schemaPath => throw _privateConstructorUsedError;
  Document get dmmf => throw _privateConstructorUsedError;
  Iterable<Datasource> get datasources => throw _privateConstructorUsedError;
  String get datamodel => throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get binaryPaths =>
      throw _privateConstructorUsedError;
  bool get dataProxy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc

@jsonSerializable
class _$_GeneratorOptions implements _GeneratorOptions {
  const _$_GeneratorOptions(
      {required this.generator,
      required this.schemaPath,
      required this.dmmf,
      required this.datasources,
      required this.datamodel,
      required this.binaryPaths,
      required this.dataProxy});

  factory _$_GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$$_GeneratorOptionsFromJson(json);

  @override
  final GeneratorConfig generator;
  @override
  final String schemaPath;
  @override
  final Document dmmf;
  @override
  final Iterable<Datasource> datasources;
  @override
  final String datamodel;
  @override
  final Map<String, Map<String, String>> binaryPaths;
  @override
  final bool dataProxy;

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeneratorOptionsToJson(
      this,
    );
  }
}

abstract class _GeneratorOptions implements GeneratorOptions {
  const factory _GeneratorOptions(
      {required final GeneratorConfig generator,
      required final String schemaPath,
      required final Document dmmf,
      required final Iterable<Datasource> datasources,
      required final String datamodel,
      required final Map<String, Map<String, String>> binaryPaths,
      required final bool dataProxy}) = _$_GeneratorOptions;

  factory _GeneratorOptions.fromJson(Map<String, dynamic> json) =
      _$_GeneratorOptions.fromJson;

  @override
  GeneratorConfig get generator;
  @override
  String get schemaPath;
  @override
  Document get dmmf;
  @override
  Iterable<Datasource> get datasources;
  @override
  String get datamodel;
  @override
  Map<String, Map<String, String>> get binaryPaths;
  @override
  bool get dataProxy;
}

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) {
  return _GeneratorConfig.fromJson(json);
}

/// @nodoc
mixin _$GeneratorConfig {
  String get name => throw _privateConstructorUsedError;
  EnvValue? get output => throw _privateConstructorUsedError;
  bool? get isCustomOutput => throw _privateConstructorUsedError;
  EnvValue get provider => throw _privateConstructorUsedError;
  Map<String, String> get config => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc

@jsonSerializable
class _$_GeneratorConfig implements _GeneratorConfig {
  const _$_GeneratorConfig(
      {required this.name,
      this.output,
      this.isCustomOutput,
      required this.provider,
      required this.config});

  factory _$_GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$$_GeneratorConfigFromJson(json);

  @override
  final String name;
  @override
  final EnvValue? output;
  @override
  final bool? isCustomOutput;
  @override
  final EnvValue provider;
  @override
  final Map<String, String> config;

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeneratorConfigToJson(
      this,
    );
  }
}

abstract class _GeneratorConfig implements GeneratorConfig {
  const factory _GeneratorConfig(
      {required final String name,
      final EnvValue? output,
      final bool? isCustomOutput,
      required final EnvValue provider,
      required final Map<String, String> config}) = _$_GeneratorConfig;

  factory _GeneratorConfig.fromJson(Map<String, dynamic> json) =
      _$_GeneratorConfig.fromJson;

  @override
  String get name;
  @override
  EnvValue? get output;
  @override
  bool? get isCustomOutput;
  @override
  EnvValue get provider;
  @override
  Map<String, String> get config;
}

EnvValue _$EnvValueFromJson(Map<String, dynamic> json) {
  return _EnvValue.fromJson(json);
}

/// @nodoc
mixin _$EnvValue {
  String? get fromEnvVar => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc

@jsonSerializable
class _$_EnvValue implements _EnvValue {
  const _$_EnvValue({this.fromEnvVar, this.value});

  factory _$_EnvValue.fromJson(Map<String, dynamic> json) =>
      _$$_EnvValueFromJson(json);

  @override
  final String? fromEnvVar;
  @override
  final String? value;

  @override
  Map<String, dynamic> toJson() {
    return _$$_EnvValueToJson(
      this,
    );
  }
}

abstract class _EnvValue implements EnvValue {
  const factory _EnvValue({final String? fromEnvVar, final String? value}) =
      _$_EnvValue;

  factory _EnvValue.fromJson(Map<String, dynamic> json) = _$_EnvValue.fromJson;

  @override
  String? get fromEnvVar;
  @override
  String? get value;
}

Datasource _$DatasourceFromJson(Map<String, dynamic> json) {
  return _Datasource.fromJson(json);
}

/// @nodoc
mixin _$Datasource {
  String get name => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  String get activeProvider => throw _privateConstructorUsedError;
  EnvValue get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc

@jsonSerializable
class _$_Datasource implements _Datasource {
  const _$_Datasource(
      {required this.name,
      required this.provider,
      required this.activeProvider,
      required this.url});

  factory _$_Datasource.fromJson(Map<String, dynamic> json) =>
      _$$_DatasourceFromJson(json);

  @override
  final String name;
  @override
  final String provider;
  @override
  final String activeProvider;
  @override
  final EnvValue url;

  @override
  Map<String, dynamic> toJson() {
    return _$$_DatasourceToJson(
      this,
    );
  }
}

abstract class _Datasource implements Datasource {
  const factory _Datasource(
      {required final String name,
      required final String provider,
      required final String activeProvider,
      required final EnvValue url}) = _$_Datasource;

  factory _Datasource.fromJson(Map<String, dynamic> json) =
      _$_Datasource.fromJson;

  @override
  String get name;
  @override
  String get provider;
  @override
  String get activeProvider;
  @override
  EnvValue get url;
}
