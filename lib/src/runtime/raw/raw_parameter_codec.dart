import 'dart:convert';
import 'dart:typed_data';

import '../json_convertible.dart';
import '../decimal.dart';
import '../prisma_null.dart';

/// A codec for encoding and decoding Prisma raw parameters.
///
/// This codec is used to encode and decode raw parameters in the Prisma Dart runtime.
/// It is used to convert Dart objects into their raw representation that can be sent
/// over the network or stored in a database.
const Codec rawParameter = _RawParameterCodec();

class _RawParameterCodec extends Codec {
  const _RawParameterCodec();

  @override
  Converter get decoder => const _RawParameterDecoder();

  @override
  Converter get encoder => const _RawParameterEncoder();
}

class _RawParameterDecoder extends Converter {
  const _RawParameterDecoder();

  @override
  convert(input) {
    return switch (input) {
      {
        'prisma__type': final String type,
        'prisma__value': final String value,
      } =>
        deserialize(type, value),
      Iterable value => value.map(convert),
      Map value => value.map((key, value) => MapEntry(key, convert(value))),
      _ => input,
    };
  }

  deserialize(String type, String value) {
    return switch (type) {
      'date' || 'datatime' => DateTime.parse(value),
      'time' => DateTime.parse('1970-01-01T${value}Z'),
      'bigint' => BigInt.parse(value),
      'decimal' => Decimal.parse(value),
      'bytes' => base64.decode(value),
      _ => throw UnsupportedError(
          'Prisma RAW parameter type "$type" is not supported.'),
    };
  }
}

class _RawParameterEncoder extends Converter {
  const _RawParameterEncoder();

  @override
  convert(input) {
    return switch (input) {
      String() || int() || double() || bool() || null => input,
      PrismaNull() => null,
      BigInt value => typed('bigint', value.toString()),
      DateTime value => typed('date', value.toUtc().toIso8601String()),
      Decimal value => typed('decimal', value.toString()),
      Uint8List bytes => typed('bytes', base64.encode(bytes)),
      JsonConvertible value => typed('json', value.toJson()),

      // If the input is a iterable, convert each item in the iterable.
      Iterable value => value.map(convert).toList(),

      // If the input is a map, convert each value in the map.
      Map value => value.map((key, value) => MapEntry(key, convert(value))),

      // Otherwise, encode the input as JSON.
      _ => typed('json', json.encode(input)),
    };
  }

  Map<String, String> typed(String type, String value) {
    return {
      'prisma__type': type,
      'prisma__value': value,
    };
  }
}
