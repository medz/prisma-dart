/// JSON serializable.
abstract class JsonSerializable {
  /// serializes the object to JSON
  toJson();
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
