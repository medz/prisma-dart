import 'dart:convert';
import 'dart:typed_data';

import 'package:decimal/decimal.dart';

import '../prisma_null.dart';

/// Raw protocol encoding converter.
class RawProtocolEncoder extends Converter {
  const RawProtocolEncoder();

  @override
  convert(dynamic input) {
    return switch (input) {
      BigInt(toString: final toString) => _tagged('bigint', toString()),
      DateTime datetime =>
        _tagged('datetime', datetime.toUtc().toIso8601String()),
      Decimal decimal => _tagged('decimal', decimal.toString()),
      ByteBuffer buffer =>
        _tagged('bytes', base64.encode(buffer.asUint8List())),
      PrismaNull _ => null,
      Iterable(withoutNull: final iterable) => iterable.map(convert).toList(),
      Map(withoutNull: final map) =>
        map.map((key, value) => MapEntry(key, convert(value))),
      _ => input,
    };
  }

  /// Create prisma tagged value.
  Map<String, dynamic> _tagged(String type, value) => {
        'prisma__type': type,
        'prisma__value': value,
      };
}

extension<T> on Iterable<T> {
  /// Without null values.
  Iterable<T> get withoutNull => where((element) => element != null);
}

extension<K, V> on Map<K, V> {
  /// Without null values.
  Map<K, V> get withoutNull {
    final entries = this.entries.where((element) => element.value != null);

    return Map.fromEntries(entries);
  }
}

/// Prisma raw protocol decoder.
class RawProtocolDecoder extends Converter {
  const RawProtocolDecoder();

  @override
  convert(input) {
    return switch (input) {
      Map map => _convertMap(map),
      Iterable iterable => iterable.map(convert).toList(),
      _ => input,
    };
  }

  /// Convert map.
  _convertMap(Map input) {
    final tagged = _tagged(input);
    if (tagged != null) {
      return _convertTagged(tagged.$1, tagged.$2);
    }

    return input.map((key, value) => MapEntry(key, convert(value)));
  }

  /// Convert tagged type and value.
  _convertTagged(String type, String value) {
    return switch (type) {
      'bigint' => BigInt.parse(value),
      'bytes' => base64.decode(value).buffer,
      'decimal' => Decimal.parse(value),
      'datetime' => DateTime.parse(value),
      'date' => DateTime.parse(value),
      'time' => DateTime.parse('1970-01-01T${value}Z'),
      _ => value,
    };
  }

  /// Returns tagged type and value.
  (String, String)? _tagged(dynamic input) {
    final type = input['prisma__type'];
    final value = input['prisma__value'];

    if (type is String && value is String) {
      return (type, value);
    }

    return null;
  }
}

class RawProtocolCodec extends Codec {
  const RawProtocolCodec();

  @override
  Converter get decoder => const RawProtocolDecoder();

  @override
  Converter get encoder => const RawProtocolEncoder();
}
