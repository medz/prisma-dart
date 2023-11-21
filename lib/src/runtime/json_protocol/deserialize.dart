import 'dart:convert';

import '../types/decimal.dart';

dynamic deserializeJsonResponse(dynamic result) => switch (result) {
      Iterable iterable => iterable.map(deserializeJsonResponse),
      Map object => _deserializeJsonObject(object),
      _ => result,
    };

dynamic _deserializeJsonObject(Map object) {
  if (object.containsKey(r'$type')) {
    return _deserializeTaggedValue(object);
  }

  return object.map(
    (key, value) => MapEntry(key, deserializeJsonResponse(value)),
  );
}

dynamic _deserializeTaggedValue(Map object) => switch (object) {
      {r'$type': 'BigInt', 'value': final String value} => BigInt.parse(value),
      {r'$type': 'Bytes', 'value': final String value} => base64.decode(value),
      {r'$type': 'DateTime', 'value': final String value} =>
        DateTime.parse(value),
      {r'$type': 'Decimal', 'value': final String value} =>
        Decimal.parse(value),
      {r'$type': 'Json', 'value': final String value} => json.decode(value),
      _ => throw Exception('Unknown tagged value: $object'),
    };
