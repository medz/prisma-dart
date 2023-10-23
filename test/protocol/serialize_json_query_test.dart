import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:orm/src/core/field_ref.dart';
import 'package:orm/src/core/json_convertible.dart';
import 'package:orm/src/core/raw_parameters.dart';
import 'package:test/test.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/protocol.dart';
import 'package:orm/src/core/error_format.dart';

import '../test_utils/datamodel_builder.dart';

final user = model('User', [
  field(dmmf.FieldKind.scalar, 'name', 'String'),
  field(dmmf.FieldKind.scalar, 'nickname', 'String'),
  field(dmmf.FieldKind.object, 'posts', 'Post', {
    'isList': true,
    'relationName': 'UserToPost',
  }),
]);

final post = model('Post', [
  field(dmmf.FieldKind.scalar, 'title', 'String'),
  field(dmmf.FieldKind.scalar, 'userId', 'String'),
  field(dmmf.FieldKind.scalar, 'published', 'Boolean'),
  field(dmmf.FieldKind.object, 'user', 'User', {
    'relationName': 'UserToPost',
  }),
  field(dmmf.FieldKind.object, 'attachments', 'Attachment', {
    'relationName': 'PostToAttachment',
    'isList': true,
  }),
]);

final attachment = model('Attachment', [
  field(dmmf.FieldKind.scalar, 'filename', 'String'),
  field(dmmf.FieldKind.scalar, 'postId', 'String'),
  field(dmmf.FieldKind.object, 'post', 'Post', {
    'relationName': 'PostToAttachment',
  }),
]);

final datamodel = dmmf.Datamodel(
  models: [user, post, attachment],
  enums: const [],
  types: const [],
);

Map serialize({
  final String? modelName,
  required final ModelAction action,
  final Map? args,
}) =>
    serializeJsonQuery(
      args: args,
      action: action,
      datamodel: datamodel,
      modelName: modelName,
      clientMethod: 'foo',
      clientVersion: '0.0.0',
      errorFormat: ErrorFormat.colorless,
    );

class _Name implements JsonConvertible<String> {
  const _Name();

  @override
  String toJson() => 'Seven';
}

void main() {
  test('findMany', () {
    expect(serialize(modelName: 'User', action: ModelAction.findMany), {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('create', () {
    expect(serialize(modelName: 'User', action: ModelAction.create), {
      'modelName': 'User',
      'action': 'createOne',
      'query': {
        'arguments': {},
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('delete', () {
    expect(serialize(modelName: 'User', action: ModelAction.delete), {
      'modelName': 'User',
      'action': 'deleteOne',
      'query': {
        'arguments': {},
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('upsert', () {
    expect(serialize(modelName: 'User', action: ModelAction.upsert), {
      'modelName': 'User',
      'action': 'upsertOne',
      'query': {
        'arguments': {},
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('queryRaw', () {
    expect(
      serialize(action: ModelAction.queryRaw, args: {
        'query': 'SELECT ?',
        'parameters': RawParameters([1]),
      }),
      {
        'action': 'queryRaw',
        'query': {
          'arguments': {
            'query': 'SELECT ?',
            'parameters': '[1]',
          },
          'selection': {},
        },
      },
    );
  });

  test('executeRaw', () {
    final serizlized = serialize(action: ModelAction.executeRaw, args: {
      'query': 'INSET INTO test VALUES (?, ?)',
      'parameters': RawParameters([1, 2]),
    });

    expect(serizlized, {
      'action': "executeRaw",
      'query': {
        'arguments': {
          'query': 'INSET INTO test VALUES (?, ?)',
          'parameters': '[1,2]',
        },
        'selection': {}
      },
    });
  });

  test('findRaw', () {
    expect(serialize(action: ModelAction.findRaw, modelName: 'User'), {
      'modelName': 'User',
      'action': 'findRaw',
      'query': {
        'arguments': {},
        'selection': {},
      },
    });
  });

  test('aggregateRaw', () {
    expect(
      serialize(action: ModelAction.aggregateRaw, modelName: 'User', args: {
        'pipeline': [],
      }),
      {
        'modelName': 'User',
        'action': 'aggregateRaw',
        'query': {
          'arguments': {
            'pipeline': [],
          },
          'selection': {},
        },
      },
    );
  });

  test('args - int', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {'id': 1},
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {'id': 1},
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('args - double', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {'id': 1.2345},
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {'id': 1.2345},
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('args - string', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {'id': 'foo'},
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {'id': 'foo'},
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  group('args bool', () {
    test('true', () {
      final serialized =
          serialize(action: ModelAction.findMany, modelName: 'User', args: {
        'where': {'id': true},
      });

      expect(serialized, {
        'modelName': 'User',
        'action': 'findMany',
        'query': {
          'arguments': {
            'where': {'id': true},
          },
          'selection': {
            r'$composites': true,
            r'$scalars': true,
          },
        },
      });
    });

    test('false', () {
      final serialized =
          serialize(action: ModelAction.findMany, modelName: 'User', args: {
        'where': {'id': false},
      });

      expect(serialized, {
        'modelName': 'User',
        'action': 'findMany',
        'query': {
          'arguments': {
            'where': {'id': false},
          },
          'selection': {
            r'$composites': true,
            r'$scalars': true,
          },
        },
      });
    });
  });

  test('args DateTime', () {
    final now = DateTime.now();
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {'birthday': now},
    });
    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {
            'birthday': {
              r'$type': 'DateTime',
              'value': now.toUtc().toIso8601String(),
            },
          },
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('args BitInt', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {'id': BigInt.from(1e+30)},
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {
            'id': {
              r'$type': 'BigInt',
              'value': '1000000000000000019884624838656',
            }
          },
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        },
      },
    });
  });

  test('args ByteBuffer', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {
        'binary': utf8.encoder.convert('hello world').buffer,
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {
            'binary': {
              r'$type': 'Bytes',
              'value': 'aGVsbG8gd29ybGQ=',
            },
          },
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        }
      },
    });
  });

  test('args Decimal', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {
        'height': Decimal.parse('123.45'),
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {
            'height': {
              r'$type': 'Decimal',
              'value': '123.45',
            },
          },
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        }
      },
    });
  });

  test('args FieldRef', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {
        'name': FieldRef('User', 'nickname'),
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {
            'name': {
              r'$type': 'FieldRef',
              'value': {'_ref': 'nickname', '_container': 'User'},
            },
          },
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        }
      },
    });
  });

  test('args JsonConvertible', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {
        'name': const _Name(),
      }
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {
            'name': const _Name().toJson(),
          },
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        }
      },
    });
  });

  test('args with null values', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'where': {
        'nullField': null,
        'definedField': 123,
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {
          'where': {
            'definedField': 123,
          },
        },
        'selection': {
          r'$composites': true,
          r'$scalars': true,
        }
      },
    });
  });

  group('args', () {
    test(r'object with $type field', () {
      final serialized =
          serialize(action: ModelAction.findMany, modelName: 'User', args: {
        'where': {
          'jsonColumn': {r'$type': 'Decimal', 'value': '123'},
        },
      });

      expect(serialized, {
        'modelName': 'User',
        'action': 'findMany',
        'query': {
          'arguments': {
            'where': {
              'jsonColumn': {
                r'$type': 'Json',
                'value': json.encode({
                  r'$type': 'Decimal',
                  'value': '123',
                }),
              },
            },
          },
          'selection': {
            r'$composites': true,
            r'$scalars': true,
          }
        },
      });
    });
  });

  test('1 level include', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'include': {'posts': true},
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          r'$composites': true,
          r'$scalars': true,
          'posts': true,
        },
      },
    });
  });

  test('include with arguments', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'include': {
        'posts': {
          'where': {'published': true},
        },
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          r'$composites': true,
          r'$scalars': true,
          'posts': {
            'arguments': {
              'where': {'published': true},
            },
            'selection': {
              r'$composites': true,
              r'$scalars': true,
            },
          },
        },
      },
    });
  });

  test('multiple level include', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'include': {
        'posts': {
          'include': {'attachments': true},
        },
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          r'$composites': true,
          r'$scalars': true,
          'posts': {
            'arguments': {},
            'selection': {
              r'$composites': true,
              r'$scalars': true,
              'attachments': true,
            },
          },
        },
      },
    });
  });

  test('explicit selection', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'select': {'name': true},
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          'name': true,
        },
      },
    });
  });

  test('explicit nested selection', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'select': {
        'name': true,
        'posts': {
          'select': {
            'attachments': {
              'select': {'filename': true},
            }
          }
        },
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          'name': true,
          'posts': {
            'arguments': {},
            'selection': {
              'attachments': {
                'arguments': {},
                'selection': {
                  'filename': true,
                },
              },
            },
          },
        },
      },
    });
  });

  test('explicit nested selection with arguments', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'select': {
        'name': true,
        'posts': {
          'select': {
            'attachments': {
              'select': {'filename': true},
            }
          },
          'where': {'published': true},
        },
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          'name': true,
          'posts': {
            'arguments': {
              'where': {'published': true},
            },
            'selection': {
              'attachments': {
                'arguments': {},
                'selection': {
                  'filename': true,
                },
              },
            },
          },
        },
      },
    });
  });

  test('mixed include and select', () {
    final serialized =
        serialize(action: ModelAction.findMany, modelName: 'User', args: {
      'select': {
        'name': true,
        'posts': {
          'include': {'attachments': true},
        },
      },
    });

    expect(serialized, {
      'modelName': 'User',
      'action': 'findMany',
      'query': {
        'arguments': {},
        'selection': {
          'name': true,
          'posts': {
            'arguments': {},
            'selection': {
              r'$composites': true,
              r'$scalars': true,
              'attachments': true,
            },
          },
        },
      },
    });
  });
}
