import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart';
import 'package:test/test.dart';

import '../../bin/generator/scalars.dart';

void main() {
  late SchemaType type;

  setUp(
    () => type = const SchemaType(
      type: 'String',
      isList: false,
      location: FieldLocation.scalar,
    ),
  );

  test('scalar', () {
    expect(scalar(type), refer('String'));
  });

  late SchemaType type2;
  setUp(() => type2 = const SchemaType(
        type: 'String',
        isList: true,
        location: FieldLocation.scalar,
      ));
  test('iterable scalar', () {
    expect(scalar(type2).symbol, 'Iterable');
  });
}
