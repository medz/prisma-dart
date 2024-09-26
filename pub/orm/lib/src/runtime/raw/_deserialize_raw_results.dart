import 'dart:convert';

import '../decimal.dart';

extension type _TypedRawResult._(Map _) {
  Iterable<String> get columns => (_['columns'] as Iterable).cast<String>();
  Iterable<String> get types => (_['types'] as Iterable).cast<String>();
  Iterable<Iterable> get rows => (_['rows'] as Iterable).cast<Iterable>();
}

List<Map<String, Object?>> deserializeRawResult(Map result) {
  final _TypedRawResult(:columns, :types, :rows) = _TypedRawResult._(result);
  final deserialized = <Map<String, Object?>>[];

  for (final row in rows) {
    final mapped = <String, Object?>{};
    for (final (index, value) in row.indexed) {
      mapped[columns.elementAt(index)] = _decode(types.elementAt(index), value);
    }

    deserialized.add(mapped);
  }

  return deserialized;
}

Object? _decode(String type, Object? value) {
  if (value == null) return null;
  return switch (type) {
    'bigint' => BigInt.parse(value.toString()),
    'bytes' => base64.decode(value.toString()),
    'decimal' => Decimal.parse(value.toString()),
    'datetime' || 'date' => DateTime.parse(value.toString()),
    'time' => DateTime.parse('1970-01-01T${value}Z'),
    'bigint-array' => _decodeIterable('bigint', value as Iterable),
    'bytes-array' => _decodeIterable('bytes', value as Iterable),
    'decimal-array' => _decodeIterable('decimal', value as Iterable),
    'datetime-array' => _decodeIterable('datetime', value as Iterable),
    'date-array' => _decodeIterable('date', value as Iterable),
    'time-array' => _decodeIterable('time', value as Iterable),
    _ => value,
  };
}

List _decodeIterable(String type, Iterable values) {
  return values.map((value) => _decode(type, value)).toList(growable: false);
}
