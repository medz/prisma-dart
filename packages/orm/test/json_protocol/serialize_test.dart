import 'package:orm/orm.dart';
import 'package:test/test.dart';

import '../_generated/client.dart';

void main() {
  test('createManyAndReturn', () {
    final query = serializeJsonQuery(
      datamodel: PrismaClient.datamodel,
      action: JsonQueryAction.createManyAndReturn,
      modelName: "User",
    );

    expect(query.toJson(), {
      'modelName': 'User',
      'action': "createManyAndReturn",
      'query': {
        'arguments': allOf(isMap, isEmpty),
        'selection': {
          '\$composites': equals(true),
          '\$scalars': equals(true),
        },
      },
    });
  });

  test('updateManyAndReturn', () {
    final query = serializeJsonQuery(
      datamodel: PrismaClient.datamodel,
      action: JsonQueryAction.updateManyAndReturn,
      modelName: "User",
    );
    expect(query.toJson(), {
      'modelName': 'User',
      'action': "updateManyAndReturn",
      'query': {
        'arguments': allOf(isMap, isEmpty),
        'selection': {
          '\$composites': equals(true),
          '\$scalars': equals(true),
        },
      },
    });
  });
}
