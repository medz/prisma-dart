abstract interface class JsonConvertible<T> {
  const JsonConvertible();

  /// Returns a JSON representation of the object.
  T toJson();
}
