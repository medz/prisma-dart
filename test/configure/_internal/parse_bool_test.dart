import 'package:orm/src/configure/_internal/internal.dart';
import 'package:test/test.dart';

void main() {
  test('truthy', () {
    for (final String element in truthy) {
      expect(parseBool(element), isTrue);
    }
  });

  test('falsey', () {
    for (final String element in falsey) {
      expect(parseBool(element), isFalse);
    }
  });

  test('empty', () {
    expect(parseBool(''), isFalse);
  });

  test('null', () {
    expect(parseBool(null), isFalse);
  });

  test('whitespace', () {
    expect(parseBool(' '), isFalse);
  });

  test('other', () {
    expect(parseBool('other'), isTrue);
  });
}
