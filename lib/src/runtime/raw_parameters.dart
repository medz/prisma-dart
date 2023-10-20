import 'dart:convert';

import '../protocol/raw_protocol.dart';

class RawParameters {
  final Iterable _origin;

  const RawParameters(Iterable values) : _origin = values;

  String get values => json.encode(rawProtocol.encode(_origin));
}
