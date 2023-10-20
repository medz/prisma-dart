import 'dart:typed_data';

import 'package:decimal/decimal.dart';
import 'package:orm/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('primitives', () {
    expect(deserializeJsonResponse(1), equals(1));
    expect(deserializeJsonResponse('foo'), equals('foo'));
    expect(deserializeJsonResponse(true), isTrue);
    expect(deserializeJsonResponse(null), isNull);
  });

  test('DateTime', () {
    final value = deserializeJsonResponse({
      r'$type': 'DateTime',
      'value': '1992-11-08T00:00:00.000Z',
    });

    expect(value, isA<DateTime>());
    expect(value, DateTime.parse('1992-11-08T00:00:00.000Z'));
  });

  test('BigInt', () {
    final value = deserializeJsonResponse({
      r'$type': 'BigInt',
      'value': '123456789012345678901234567890',
    });

    expect(value, isA<BigInt>());
    expect(value, BigInt.parse('123456789012345678901234567890'));
  });

  test('Bytes', () {
    final value = deserializeJsonResponse({
      r'$type': 'Bytes',
      'value': 'AQIDBAU=',
    });

    expect(value, isA<ByteBuffer>());
    expect((value as ByteBuffer).asUint8List(), [1, 2, 3, 4, 5]);
  });

  test('Decimal', () {
    final value = deserializeJsonResponse({
      r'$type': 'Decimal',
      'value': '123456789012345678901234567890',
    });

    expect(value, isA<Decimal>());
    expect(value, Decimal.parse('123456789012345678901234567890'));
  });

  test('Json', () {
    final value = deserializeJsonResponse({
      r'$type': 'Json',
      'value': '{"foo": "bar"}',
    });

    expect(value, isA<Map>());
    expect(value, {'foo': 'bar'});
  });

  test('object', () {
    final value = deserializeJsonResponse({
      'foo': 1,
      'bar': 'baz',
      'money': {
        r'$type': 'Decimal',
        'value': '123.45',
      },
      'profile': {
        'birthday': {
          r'$type': 'DateTime',
          'value': '1992-11-08T00:00:00.000Z',
        },
      },
    });

    expect(value, {
      'foo': 1,
      'bar': 'baz',
      'money': Decimal.parse('123.45'),
      'profile': {
        'birthday': DateTime.parse('1992-11-08T00:00:00.000Z'),
      },
    });
  });

  test('List/Iterable', () {
    final value = deserializeJsonResponse([
      1,
      'foo',
      {
        r'$type': 'Decimal',
        'value': '123.45',
      },
      {
        'birthday': {
          r'$type': 'DateTime',
          'value': '1992-11-08T00:00:00.000Z',
        },
      },
    ]);

    expect(value, [
      1,
      'foo',
      Decimal.parse('123.45'),
      {
        'birthday': DateTime.parse('1992-11-08T00:00:00.000Z'),
      },
    ]);
  });
}
