import 'dart:typed_data';

import 'package:orm/orm.dart';
import 'package:test/test.dart';

import '../_generated/client.dart';
import '../_generated/prisma.dart';

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

  test("Bytes serialize", () {
    final bytes = Uint8List(50);
    final query = serializeJsonQuery(
        datamodel: PrismaClient.datamodel,
        action: JsonQueryAction.createOne,
        modelName: "Test",
        args: {'data': PrismaUnion.$1(TestCreateInput(bytes: bytes))});
    expect(query.toJson(), {
      'modelName': 'Test',
      'action': "createOne",
      'query': {
        'arguments': {
          'data': {
            "bytes": {
              '\$type': "Bytes",
              'value':
                  'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='
            }
          },
        },
        'selection': {'\$composites': true, '\$scalars': true}
      },
    });
  });
}
