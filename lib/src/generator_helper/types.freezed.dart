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
  switch (json['runtimeType']) {
    case 'env':
      return FormEnvVar.fromJson(json);
    case 'value':
      return FormEnvValue.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'EnvValue',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$EnvValue {
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FormEnvVar value) env,
    required TResult Function(FormEnvValue value) value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FormEnvVar value)? env,
    TResult? Function(FormEnvValue value)? value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FormEnvVar value)? env,
    TResult Function(FormEnvValue value)? value,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _$FormEnvVarImpl implements FormEnvVar {
  const _$FormEnvVarImpl(this.env, {final String? $type})
      : $type = $type ?? 'env';

  factory _$FormEnvVarImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormEnvVarImplFromJson(json);

  @override
  final String env;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FormEnvVar value) env,
    required TResult Function(FormEnvValue value) value,
  }) {
    return env(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FormEnvVar value)? env,
    TResult? Function(FormEnvValue value)? value,
  }) {
    return env?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FormEnvVar value)? env,
    TResult Function(FormEnvValue value)? value,
    required TResult orElse(),
  }) {
    if (env != null) {
      return env(this);
    }
    return orElse();
  }
}

abstract class FormEnvVar implements EnvValue {
  const factory FormEnvVar(final String env) = _$FormEnvVarImpl;

  factory FormEnvVar.fromJson(Map<String, dynamic> json) =
      _$FormEnvVarImpl.fromJson;

  String get env;
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _$FormEnvValueImpl implements FormEnvValue {
  const _$FormEnvValueImpl(this.value, {final String? $type})
      : $type = $type ?? 'value';

  factory _$FormEnvValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormEnvValueImplFromJson(json);

  @override
  final String value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FormEnvVar value) env,
    required TResult Function(FormEnvValue value) value,
  }) {
    return value(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FormEnvVar value)? env,
    TResult? Function(FormEnvValue value)? value,
  }) {
    return value?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FormEnvVar value)? env,
    TResult Function(FormEnvValue value)? value,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(this);
    }
    return orElse();
  }
}

abstract class FormEnvValue implements EnvValue {
  const factory FormEnvValue(final String value) = _$FormEnvValueImpl;

  factory FormEnvValue.fromJson(Map<String, dynamic> json) =
      _$FormEnvValueImpl.fromJson;

  String get value;
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
