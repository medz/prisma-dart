// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prisma_null.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PrismaNull _$PrismaNullFromJson(Map<String, dynamic> json) {
  return _PrismaNull.fromJson(json);
}

/// @nodoc
mixin _$PrismaNull {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_PrismaNull implements _PrismaNull {
  const _$_PrismaNull();

  factory _$_PrismaNull.fromJson(Map<String, dynamic> json) =>
      _$$_PrismaNullFromJson(json);

  @override
  String toString() {
    return 'PrismaNull()';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_PrismaNullToJson(
      this,
    );
  }
}

abstract class _PrismaNull implements PrismaNull {
  const factory _PrismaNull() = _$_PrismaNull;

  factory _PrismaNull.fromJson(Map<String, dynamic> json) =
      _$_PrismaNull.fromJson;
}
