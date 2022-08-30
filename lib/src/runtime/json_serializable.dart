import 'dart:convert';

abstract class JsonSerializable {
  /// Returns a map representation of this object.
  Map<String, dynamic> toJson();

  @override
  String toString() => json.encode(toJson());
}
