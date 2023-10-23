import 'package:json_annotation/json_annotation.dart';
export 'package:json_annotation/json_annotation.dart';

abstract interface class JsonConvertible<T> {
  const JsonConvertible();

  /// Returns a JSON representation of the object.
  T toJson();

  /// JSON Serializable annotation.
  ///
  /// This annotation is used for JSON serialization configuration of
  /// public builds.
  static const JsonSerializable serializable = JsonSerializable(
    anyMap: true,
    checked: true,
    createFactory: true,
    createToJson: true,
    explicitToJson: true,
    includeIfNull: false,
  );
}
