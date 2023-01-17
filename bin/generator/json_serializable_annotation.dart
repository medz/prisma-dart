import 'package:freezed_annotation/freezed_annotation.dart';

const freezed = Freezed(
  copyWith: false,
  equal: false,
  fromJson: true,
  toJson: true,
  toStringOverride: false,
  makeCollectionsUnmodifiable: false,
  genericArgumentFactories: false,
);

const jsonSerializable = JsonSerializable(
  explicitToJson: true,
);
