import 'package:orm/orm.dart';
import 'package:test/test.dart';

import '../_generated/client.dart';
import '../utils/contains_map.dart';

void main() {
  test('createManyAndReturn', tags: ['sqlite', 'postgresql', 'cockroachdb'],
      () {
    final query = serializeJsonQuery(
      datamodel: PrismaClient.datamodel,
      action: JsonQueryAction.createManyAndReturn,
      modelName: "User",
    );

    expect(
      query.toJson(),
      ContainsMap({
        'modelName': 'User',
        'action': "createManyAndReturn",
        'query': {
          'arguments': allOf(isMap, isEmpty),
          'selection': {
            '\$composites': equals(true),
            '\$scalars': equals(true),
          },
        },
      }),
    );
  });
}
