import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

import '../../bin/src/scalars.dart';

void main() {
  test('scalar', () {
    expect(scalar('String', location: FieldLocation.scalar), refer('String'));
  });

  test('iterable scalar', () {
    expect(
        scalar(
          'String',
          location: FieldLocation.scalar,
          isList: true,
        ).symbol,
        'Iterable');
  });
}
