import 'dart:convert';
import 'dart:typed_data';

import '../decimal.dart';
import '../json_convertible.dart';
import '../prisma_null.dart';

/// Serialize RAW params.
String serializeRawParams(Iterable<Object?> params) {
  return json.encode(
    params.map(_encode).toList(growable: false),
  );
}

Object? _encode(Object? value) {
  return switch (value) {
    PrismaNull() => null,
    BigInt value => _createTypedValue('bigint', value.toString()),
    DateTime value =>
      _createTypedValue('date', value.toUtc().toIso8601String()),
    Decimal value => _createTypedValue('decimal', value.toString()),
    Uint8List bytes => _createTypedValue('bytes', base64.encode(bytes)),
    TypedData typedData => _encode(typedData.buffer),
    ByteBuffer byteBuffer => _encode(byteBuffer.asUint8List()),
    JsonConvertible value => _createTypedValue('json', value.toJson()),
    Iterable iterable => iterable.map(_encode).toList(growable: false),
    Map value =>
      value.map((key, value) => MapEntry(key.toString(), _encode(value))),
    _ => value,
  };
}

Map<String, Object> _createTypedValue(String type, Object value) {
  return {
    'prisma__type': type,
    'prisma__value': value,
  };
}
