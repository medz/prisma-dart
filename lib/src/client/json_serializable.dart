import 'package:freezed_annotation/freezed_annotation.dart'
    as freezed_annotation;

/// JSON serializable.
abstract class JsonSerializable {
  /// serializes the object to JSON
  Map<String, dynamic> toJson();
}

/// Date time toJson serializer.
dynamic dateTimeToJson(dynamic value) {
  if (value is DateTime) {
    return value.isUtc
        ? value.toIso8601String()
        : value.toUtc().toIso8601String();
  } else if (value is Iterable) {
    return value.map(dateTimeToJson);
  } else if (value is Map) {
    return value.map((k, v) => MapEntry(k, dateTimeToJson(v)));
  }

  return value;
}

const freezed = freezed_annotation.Freezed(
  copyWith: false,
  equal: false,
  fromJson: true,
  toJson: true,
  toStringOverride: false,
  makeCollectionsUnmodifiable: false,
  genericArgumentFactories: false,
);

const jsonSerializable = freezed_annotation.JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
);
