import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../../bin/src/generator/utils/dart_style.dart';

void main() {
  test('test single char', () {
    expect(dartClassnameFixer('a'), 'A');
  });

  test('test single char with underscore', () {
    expect(dartClassnameFixer('_a'), r'$A');
  });

  test('test single char with underscore', () {
    expect(dartClassnameFixer('a_'), r'A_');
  });

  test('test multiple char', () {
    expect(dartClassnameFixer('abc'), r'Abc');
  });

  test('test multiple char with underscore', () {
    expect(dartClassnameFixer('_abc'), r'$Abc');
  });

  test('test multiple char with underscore', () {
    expect(dartClassnameFixer('abc_'), r'Abc_');
  });

  test('test multiple char with underscore', () {
    expect(dartClassnameFixer('_abc_'), r'$Abc_');
  });
}
