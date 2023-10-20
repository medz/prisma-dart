import 'dart:convert';

class RawParameters {
  final Iterable _origin;

  const RawParameters(Iterable values) : _origin = values;

  String get values => json.encode(_origin);
}
