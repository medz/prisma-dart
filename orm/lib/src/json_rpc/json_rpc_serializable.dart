import 'dart:convert';

abstract class JsonRpcSerializable<T extends Object> {
  T toJson();

  String toJsonString() => json.encode(toJson());

  // to json bytes.
  List<int> toJsonBytes() => utf8.encode(toJsonString());
}

abstract class JsonRpcDeserializable {
  void fromJson(Map<String, dynamic> json);

  void fromJsonString(String jsonString) => fromJson(json.decode(jsonString));

  // from json bytes.
  void fromJsonBytes(List<int> jsonBytes) =>
      fromJsonString(utf8.decode(jsonBytes));
}
