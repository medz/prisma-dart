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

  static serialize(dynamic value) {
    return switch (value) {
      JsonConvertible value => value.toJson(),
      Iterable values => values.map((e) => serialize(e)).toList(),
      Map values => values.map((key, value) => MapEntry(key, serialize(value))),
      _ => value,
    };
  }
}

/// An abstract interface class for converting a map to JSON and vice versa.
///
/// This interface extends the `JsonConvertible` class and is used to define
/// the conversion behavior for maps with keys of type `K` and values of type `V`.
///
/// Example usage:
/// ```dart
/// class MyMap implements MapJsonConvertible<String, int> {
///   // implementation code...
/// }
/// ```
abstract interface class MapJsonConvertible<K, V>
    extends JsonConvertible<Map<K, V>> {}

/// An abstract interface class for converting an array of objects to JSON and vice versa.
///
/// This interface extends the `JsonConvertible` interface and is specifically designed for arrays of type `T`.
/// Implementing this interface allows objects of type `T` to be converted to JSON and vice versa.
abstract interface class ArrayJsonConvertible<T>
    extends JsonConvertible<Iterable<T>> {}
