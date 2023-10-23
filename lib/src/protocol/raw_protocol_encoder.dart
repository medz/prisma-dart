import 'dart:convert';
import 'dart:typed_data';

import 'package:decimal/decimal.dart';

import '../core/json_convertible.dart';
import '../core/prisma_null.dart';

class RawProtocolEncoder extends Converter {
  const RawProtocolEncoder();

  @override
  dynamic convert(input) {
    return switch (input) {
      BigInt value => _createPrismaTaggedValue('bigint', value.toString()),
      DateTime value => _createPrismaTaggedValue(
          'date', json.encode(value.toUtc().toIso8601String())),
      Decimal decimal =>
        _createPrismaTaggedValue('decimal', json.encode(decimal.toString())),
      ByteBuffer buffer =>
        _createPrismaTaggedValue('bytes', base64.encode(buffer.asUint8List())),
      TypedData data => convert(data.buffer),
      PrismaNull _ => null,
      Iterable iterable => iterable.map(convert).toList(),
      Map map => map.map((key, value) => MapEntry(key, convert(value))),
      JsonConvertible(toJson: final toJson) => toJson(),
      _ => input,
    };
  }

  /// Create prisma tagged value [Map]
  Map<String, dynamic> _createPrismaTaggedValue(
          final String type, final value) =>
      {
        'prisma__type': type,
        'prisma__value': value,
      };
}
