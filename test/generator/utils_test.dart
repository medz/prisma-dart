import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../../bin/generator/utils.dart';

void main() {
  group('DartStyleName', () {
    test('toDartClassname', () {
      expect('a'.toDartClassname(), 'A');
      expect('aB'.toDartClassname(), 'AB');
      expect('a_b'.toDartClassname(), 'AB');
      expect('a_b_c'.toDartClassname(), 'ABC');
      expect('_a'.toDartClassname(), r'$a');
    });

    test('toDartPropertyName', () {
      expect('a'.toDartPropertyName(), 'a');
      expect('aB'.toDartPropertyName(), 'aB');
      expect('a_b'.toDartPropertyName(), 'aB');
      expect('a_b_c'.toDartPropertyName(), 'aBC');
      expect('_a'.toDartPropertyName(), r'$a');
    });

    test('toDartPublicName', () => expect('_a'.toDartPublicName(), r'$a'));

    test('withoutDartReserved',
        () => expect('in'.withoutDartReserved(), r'$in'));
  });

  group('NullableReferenceExtension', () {
    late TypeReference typeReference;

    setUp(() => typeReference = refer('String').nullable as TypeReference);

    test('isNullable', () => expect(typeReference.isNullable, isTrue));
  });
}
