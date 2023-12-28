/// An abstract interface for objects that can be converted to JSON.
///
/// The `JsonConvertible` interface provides a method `toJson()` that converts
/// the object to a JSON representation.
///
/// The type parameter `T` represents the type of the JSON representation.
abstract interface class JsonConvertible<T> {
  /// Converts the object to a JSON representation.
  ///
  /// Returns the JSON representation of the object.
  T toJson();

  /// Serializes a dynamic value into a JSON representation.
  ///
  /// The [value] parameter can be of any type. If the value is an instance of a class that implements the `JsonConvertible` interface,
  /// the `toJson()` method of that class will be called to obtain the JSON representation.
  /// If the value is an iterable, each element in the iterable will be recursively serialized using the `serialize()` function.
  /// If the value is a map, each key-value pair in the map will be recursively serialized using the `serialize()` function.
  /// If the value does not match any of the above cases, it will be returned as is.
  ///
  /// Returns the JSON representation of the value.
  static serialize(dynamic value) {
    return switch (value) {
      JsonConvertible value => serialize(value.toJson()),
      Iterable values => values.map((e) => serialize(e)).toList(),
      Map values => values.map((key, value) => MapEntry(key, serialize(value))),
      _ => value,
    };
  }

  /// Deserializes a JSON representation into a typed object.
  static R? Function(Map json) createBullableFromJson<R>(
    R Function(Map json) factory,
  ) {
    return (Map? json) {
      if (json == null) return null;
      return factory(json);
    };
  }

  static Iterable<R> Function(Iterable<Map> json) createIterableFromJson<R>(
    R Function(Map json) factory,
  ) {
    return (Iterable<Map> json) => json.map((e) => factory(e));
  }
}
