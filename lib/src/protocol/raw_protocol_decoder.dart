import 'dart:convert';

import 'package:decimal/decimal.dart';

class RawProtocolDecoder extends Converter {
  const RawProtocolDecoder();

  @override
  convert(input) {
    return switch (input) {
      {'prisma__type': 'bigint', 'prisma__value': final String value} =>
        BigInt.parse(value),
      {'prisma__type': 'bytes', 'prisma__value': final String value} =>
        base64.decode(value).buffer,
      {'prisma__type': 'decimal', 'prisma__value': final String value} =>
        Decimal.parse(value),
      {'prisma__type': 'datetime', 'prisma__value': final String value} =>
        DateTime.parse(value),
      {'prisma__type': 'date', 'prisma__value': final String value} =>
        DateTime.parse(value),
      {'prisma__type': 'time', 'prisma__value': final String value} =>
        DateTime.parse('1970-01-01T${value}Z'),
      Iterable iterable => iterable.map(convert).toList(),
      Map object => object.map((key, value) => MapEntry(key, convert(value))),
      _ => input,
    };
  }
}
