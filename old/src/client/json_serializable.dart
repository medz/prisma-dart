import 'package:json_annotation/json_annotation.dart' as json_annotation;

/// JSON serializable.
abstract class JsonSerializable {
  /// serializes the object to JSON
  Map<String, dynamic> toJson();
}

class DateTimeJsonConverter
    implements json_annotation.JsonConverter<DateTime, String> {
  const DateTimeJsonConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.isUtc
        ? object.toIso8601String()
        : object.toUtc().toIso8601String();
  }
}

const jsonSerializable = json_annotation.JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
  converters: [
    DateTimeJsonConverter(),
  ],
);
