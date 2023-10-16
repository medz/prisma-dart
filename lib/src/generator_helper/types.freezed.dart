// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EnvValue _$EnvValueFromJson(Map<String, dynamic> json) {
  return _EnvValue.fromJson(json);
}

/// @nodoc
mixin _$EnvValue {
  String? get fromEnvVar => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _$EnvValueImpl implements _EnvValue {
  const _$EnvValueImpl({this.fromEnvVar, this.value});

  factory _$EnvValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnvValueImplFromJson(json);

  @override
  final String? fromEnvVar;
  @override
  final String? value;
}

abstract class _EnvValue implements EnvValue {
  const factory _EnvValue({final String? fromEnvVar, final String? value}) =
      _$EnvValueImpl;

  factory _EnvValue.fromJson(Map<String, dynamic> json) =
      _$EnvValueImpl.fromJson;

  @override
  String? get fromEnvVar;
  @override
  String? get value;
}

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) {
  return _GeneratorConfig.fromJson(json);
}

/// @nodoc
mixin _$GeneratorConfig {
  String get name => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _$GeneratorConfigImpl implements _GeneratorConfig {
  const _$GeneratorConfigImpl({required this.name});

  factory _$GeneratorConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratorConfigImplFromJson(json);

  @override
  final String name;
}

abstract class _GeneratorConfig implements GeneratorConfig {
  const factory _GeneratorConfig({required final String name}) =
      _$GeneratorConfigImpl;

  factory _GeneratorConfig.fromJson(Map<String, dynamic> json) =
      _$GeneratorConfigImpl.fromJson;

  @override
  String get name;
}
