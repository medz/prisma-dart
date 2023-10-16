/// JSON serializable
abstract interface class JsonSerializable {
  /// serializes the object to JSON
  Map<String, dynamic> toJson();
}
