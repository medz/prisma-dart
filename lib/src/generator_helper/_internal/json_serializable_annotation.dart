import 'package:freezed_annotation/freezed_annotation.dart';
export 'package:freezed_annotation/freezed_annotation.dart';

const jsonSerializable = Freezed(
  copyWith: false,
  equal: false,
  toStringOverride: false,
  fromJson: true,
  toJson: false,
  when: FreezedWhenOptions.none,
);
