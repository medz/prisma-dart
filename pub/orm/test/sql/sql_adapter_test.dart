import 'package:orm/orm.dart';
import 'package:test/test.dart';

void main() {
  OrmContract buildContract({bool mutationReturning = true}) {
    return OrmContract(
      version: '1',
      hash: 'hash',
      models: <String, ModelContract>{
        'User': ModelContract(
          name: 'User',
          table: 'users',
          fields: <String>{'id', 'email'},
        ),
      },
      capabilities: ContractCapabilities(mutationReturning: mutationReturning),
    );
  }

  OrmContract buildRelationalContract() {
    return OrmContract(
      version: '1',
      hash: 'rel-hash',
      target: 'sql-family',
      models: <String, ModelContract>{
        'User': ModelContract(
          name: 'User',
          table: 'users',
          fields: <String>{'id', 'email'},
          relations: <String, ModelRelationContract>{
            'posts': ModelRelationContract(
              name: 'posts',
              relatedModel: 'Post',
              sourceFields: <String>['id'],
              targetFields: <String>['userId'],
              cardinality: RelationCardinality.many,
            ),
          },
        ),
        'Post': ModelContract(
          name: 'Post',
          table: 'posts',
          fields: <String>{'id', 'userId', 'title'},
          relations: <String, ModelRelationContract>{
            'author': ModelRelationContract(
              name: 'author',
              relatedModel: 'User',
              sourceFields: <String>['userId'],
              targetFields: <String>['id'],
              cardinality: RelationCardinality.one,
            ),
          },
        ),
      },
    );
  }

  final contract = buildContract();

  OrmPlan readPlan({
    required OrmContract contract,
    required String model,
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    OrmReadResultMode resultMode = OrmReadResultMode.all,
  }) {
    return OrmPlan(
      contractHash: contract.hash,
      model: model,
      action: OrmAction.read,
      read: OrmReadPlan(
        where: where,
        skip: skip,
        take: take,
        orderBy: orderBy,
        distinct: distinct,
        select: select,
        resultMode: resultMode,
      ),
    );
  }

  OrmPlan mutationPlan({
    required OrmContract contract,
    required String model,
    required OrmAction action,
    JsonMap where = const <String, Object?>{},
    JsonMap data = const <String, Object?>{},
    List<String> select = const <String>[],
    OrmMutationResultMode resultMode = OrmMutationResultMode.rowOrNull,
  }) {
    return OrmPlan(
      contractHash: contract.hash,
      model: model,
      action: action,
      mutation: OrmMutationPlan(
        where: where,
        data: data,
        select: select,
        resultMode: resultMode,
      ),
    );
  }

  test('lowers findMany with where/order/pagination/select', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      where: <String, Object?>{'email': 'a@example.com'},
      orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      take: 10,
      skip: 5,
      select: const <String>['id', 'email'],
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT "id", "email" FROM "users" WHERE "email" = ? '
      'ORDER BY "id" ASC LIMIT ? OFFSET ?',
    );
    expect(statement.parameters, <Object?>['a@example.com', 10, 5]);
  });

  test('lowers where operators with deterministic SQL and parameters', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      where: <String, Object?>{
        'email': <String, Object?>{
          'lt': 'z@example.com',
          'gte': 'a@example.com',
          'in': <Object?>['a@example.com', 'b@example.com'],
          'notIn': <Object?>['x@example.com'],
          'not': 'blocked@example.com',
        },
        'id': <String, Object?>{'lte': 'u9', 'gt': 'u0', 'equals': 'u1'},
      },
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT * FROM "users" WHERE '
      '"email" <> ? AND '
      '"email" IN (?, ?) AND '
      '"email" NOT IN (?) AND '
      '"email" >= ? AND '
      '"email" < ? AND '
      '"id" = ? AND '
      '"id" > ? AND '
      '"id" <= ?',
    );
    expect(statement.parameters, <Object?>[
      'blocked@example.com',
      'a@example.com',
      'b@example.com',
      'x@example.com',
      'a@example.com',
      'z@example.com',
      'u1',
      'u0',
      'u9',
    ]);
  });

  test('lowers string operators with LIKE and escaped patterns', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      where: <String, Object?>{
        'email': <String, Object?>{
          'contains': 'a%b',
          'startsWith': 'x_y',
          'endsWith': 'tail\\',
        },
      },
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      "SELECT * FROM \"users\" WHERE "
      "\"email\" LIKE ? ESCAPE '\\' AND "
      "\"email\" LIKE ? ESCAPE '\\' AND "
      "\"email\" LIKE ? ESCAPE '\\'",
    );
    expect(statement.parameters, <Object?>['%a\\%b%', 'x\\_y%', '%tail\\\\']);
  });

  test('lowers logical where AND/OR/NOT with field filters', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      where: <String, Object?>{
        'id': 'u1',
        'AND': <Object?>[
          <String, Object?>{
            'email': <String, Object?>{'startsWith': 'a'},
          },
          <String, Object?>{
            'OR': <Object?>[
              <String, Object?>{'email': 'a@example.com'},
              <String, Object?>{'email': 'b@example.com'},
            ],
          },
        ],
        'NOT': <String, Object?>{
          'email': <String, Object?>{'contains': 'blocked'},
        },
      },
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      "SELECT * FROM \"users\" WHERE "
      "\"id\" = ? AND "
      "(\"email\" LIKE ? ESCAPE '\\' AND (\"email\" = ? OR \"email\" = ?)) AND "
      "NOT (\"email\" LIKE ? ESCAPE '\\')",
    );
    expect(statement.parameters, <Object?>[
      'u1',
      'a%',
      'a@example.com',
      'b@example.com',
      '%blocked%',
    ]);
  });

  test('sql_logical_operand_edge_semantics_are_deterministic', () {
    final adapter = SqlAdapter(contract: contract);

    final emptyOperandStatement = adapter.lower(
      readPlan(
        contract: contract,
        model: 'User',
        where: <String, Object?>{
          'AND': const <Object?>[],
          'OR': const <Object?>[],
          'NOT': const <Object?>[],
        },
      ),
    );
    expect(
      emptyOperandStatement.text,
      'SELECT * FROM "users" WHERE 1 = 1 AND 1 = 0 AND 1 = 1',
    );
    expect(emptyOperandStatement.parameters, isEmpty);

    final invalidOperandStatement = adapter.lower(
      readPlan(
        contract: contract,
        model: 'User',
        where: <String, Object?>{'AND': 'bad', 'OR': 1, 'NOT': true},
      ),
    );
    expect(
      invalidOperandStatement.text,
      'SELECT * FROM "users" WHERE 1 = 0 AND 1 = 0 AND 1 = 0',
    );
    expect(invalidOperandStatement.parameters, isEmpty);
  });

  test('lowers to-many relation where using EXISTS predicates', () {
    final contract = buildRelationalContract();
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      where: <String, Object?>{
        'posts': <String, Object?>{
          'some': <String, Object?>{
            'title': <String, Object?>{'contains': 'A'},
          },
          'none': <String, Object?>{'title': 'Z'},
          'every': <String, Object?>{
            'title': <String, Object?>{'startsWith': 'Post'},
          },
        },
      },
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT * FROM "users" WHERE '
      'EXISTS (SELECT 1 FROM "posts" AS "_rel" WHERE "_rel"."userId" = "users"."id" AND "_rel"."title" LIKE ? ESCAPE \'\\\') AND '
      'NOT EXISTS (SELECT 1 FROM "posts" AS "_rel" WHERE "_rel"."userId" = "users"."id" AND "_rel"."title" = ?) AND '
      'NOT EXISTS (SELECT 1 FROM "posts" AS "_rel" WHERE "_rel"."userId" = "users"."id" AND NOT ("_rel"."title" LIKE ? ESCAPE \'\\\'))',
    );
    expect(statement.parameters, <Object?>['%A%', 'Z', 'Post%']);
  });

  test('lowers to-one relation where including null semantics', () {
    final contract = buildRelationalContract();
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'Post',
      where: <String, Object?>{
        'author': <String, Object?>{
          'is': <String, Object?>{'email': 'u1@example.com'},
          'isNot': null,
        },
      },
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT * FROM "posts" WHERE '
      'EXISTS (SELECT 1 FROM "users" AS "_rel" WHERE "_rel"."id" = "posts"."userId" AND "_rel"."email" = ?) AND '
      'EXISTS (SELECT 1 FROM "users" AS "_rel" WHERE "_rel"."id" = "posts"."userId")',
    );
    expect(statement.parameters, <Object?>['u1@example.com']);
  });

  test(
    'keeps scalar where compatibility and does not misclassify normal maps',
    () {
      final adapter = SqlAdapter(contract: contract);
      final jsonPayload = <String, Object?>{
        'contains': 'literal',
        'profile': 'standard',
      };
      final plan = readPlan(
        contract: contract,
        model: 'User',
        where: <String, Object?>{'id': 'u1', 'email': jsonPayload},
      );

      final statement = adapter.lower(plan);
      expect(
        statement.text,
        'SELECT * FROM "users" WHERE "id" = ? AND "email" = ?',
      );
      expect(statement.parameters, <Object?>['u1', jsonPayload]);
    },
  );

  test('uses deterministic empty semantics for in/notIn', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      where: <String, Object?>{
        'id': <String, Object?>{'in': const <Object?>[]},
        'email': <String, Object?>{'notIn': const <Object?>[]},
      },
    );

    final statement = adapter.lower(plan);
    expect(statement.text, 'SELECT * FROM "users" WHERE 1 = 0 AND 1 = 1');
    expect(statement.parameters, isEmpty);
  });

  test('lowers mutation statements', () {
    final contract = buildContract(mutationReturning: false);
    final adapter = SqlAdapter(contract: contract);

    final createStatement = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.create,
        data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
      ),
    );
    expect(
      createStatement.text,
      'INSERT INTO "users" ("id", "email") VALUES (?, ?)',
    );
    expect(createStatement.parameters, <Object?>['u1', 'a@example.com']);

    final updateStatement = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.update,
        where: <String, Object?>{'id': 'u1'},
        data: <String, Object?>{'email': 'b@example.com'},
      ),
    );
    expect(
      updateStatement.text,
      'UPDATE "users" SET "email" = ? WHERE "id" = ?',
    );
    expect(updateStatement.parameters, <Object?>['b@example.com', 'u1']);

    final deleteStatement = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.delete,
        where: <String, Object?>{'id': 'u1'},
      ),
    );
    expect(deleteStatement.text, 'DELETE FROM "users" WHERE "id" = ?');
    expect(deleteStatement.parameters, <Object?>['u1']);
  });

  test('lowers mutation statements with returning clause when enabled', () {
    final adapter = SqlAdapter(contract: buildContract());

    final createDefaultSelect = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.create,
        data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
      ),
    );
    expect(
      createDefaultSelect.text,
      'INSERT INTO "users" ("id", "email") VALUES (?, ?) RETURNING *',
    );
    expect(createDefaultSelect.parameters, <Object?>['u1', 'a@example.com']);

    final updateSelectedColumns = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.update,
        where: <String, Object?>{'id': 'u1'},
        data: <String, Object?>{'email': 'b@example.com'},
        select: const <String>['id'],
      ),
    );
    expect(
      updateSelectedColumns.text,
      'UPDATE "users" SET "email" = ? WHERE "id" = ? RETURNING "id"',
    );
    expect(updateSelectedColumns.parameters, <Object?>['b@example.com', 'u1']);

    final deleteSelectedColumns = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.delete,
        where: <String, Object?>{'id': 'u1'},
        select: const <String>['id', 'email'],
      ),
    );
    expect(
      deleteSelectedColumns.text,
      'DELETE FROM "users" WHERE "id" = ? RETURNING "id", "email"',
    );
    expect(deleteSelectedColumns.parameters, <Object?>['u1']);
  });

  test('decodes SQL result by action response shape', () {
    final adapter = SqlAdapter(contract: contract);

    final findMany = adapter.decode(
      const SqlResult(
        rows: <JsonMap>[
          <String, Object?>{'id': 'u1'},
          <String, Object?>{'id': 'u2'},
        ],
      ),
      readPlan(contract: contract, model: 'User'),
    );
    expect(findMany.data, isA<List<Object?>>());

    final findUnique = adapter.decode(
      const SqlResult(
        rows: <JsonMap>[
          <String, Object?>{'id': 'u1'},
        ],
      ),
      readPlan(
        contract: contract,
        model: 'User',
        resultMode: OrmReadResultMode.oneOrNull,
      ),
    );
    if (findUnique.data case final Map<String, Object?> row) {
      expect(row['id'], 'u1');
    } else {
      fail('Expected row map for findUnique decode.');
    }

    final mutation = adapter.decode(
      const SqlResult(
        rows: <JsonMap>[
          <String, Object?>{'id': 'u1'},
        ],
        affectedRows: 1,
      ),
      mutationPlan(contract: contract, model: 'User', action: OrmAction.update),
    );
    expect(mutation.affectedRows, 1);
    if (mutation.data case final Map<String, Object?> row) {
      expect(row['id'], 'u1');
    } else {
      fail('Expected row map for mutation decode.');
    }
  });

  test('applies codec encode for where/data and decode for rows', () {
    final codecRegistry = SqlCodecRegistry().withField(
      model: 'User',
      field: 'email',
      codec: SqlLambdaFieldCodec(
        encode: (value) => value == null ? null : 'wire:$value',
        decode: (value) => value == null ? null : 'app:$value',
      ),
    );
    final adapter = SqlAdapter(
      contract: contract,
      codecResolver: codecRegistry,
    );

    final update = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.update,
        where: <String, Object?>{'email': 'find@example.com', 'id': 'u1'},
        data: <String, Object?>{'email': 'next@example.com', 'id': 'u1'},
      ),
    );
    expect(update.parameters, <Object?>[
      'wire:next@example.com',
      'u1',
      'wire:find@example.com',
      'u1',
    ]);

    final decoded = adapter.decode(
      const SqlResult(
        rows: <JsonMap>[
          <String, Object?>{'email': 'wire:db@example.com', 'id': 'u1'},
        ],
      ),
      readPlan(
        contract: contract,
        model: 'User',
        resultMode: OrmReadResultMode.oneOrNull,
      ),
    );
    if (decoded.data case final Map<String, Object?> row) {
      expect(row, <String, Object?>{
        'email': 'app:wire:db@example.com',
        'id': 'u1',
      });
    } else {
      fail('Expected row map for codec decode.');
    }
  });

  test('encodes where operator values via codec resolver', () {
    final codecRegistry = SqlCodecRegistry().withField(
      model: 'User',
      field: 'email',
      codec: SqlLambdaFieldCodec(
        encode: (value) => value == null ? null : 'wire:$value',
        decode: (value) => value,
      ),
    );
    final adapter = SqlAdapter(
      contract: contract,
      codecResolver: codecRegistry,
    );

    final statement = adapter.lower(
      readPlan(
        contract: contract,
        model: 'User',
        where: <String, Object?>{
          'email': <String, Object?>{
            'in': <Object?>['a@example.com', 'b@example.com'],
            'gt': 'm@example.com',
          },
          'id': <String, Object?>{'not': 'u9'},
        },
      ),
    );

    expect(
      statement.text,
      'SELECT * FROM "users" WHERE "email" IN (?, ?) AND "email" > ? AND "id" <> ?',
    );
    expect(statement.parameters, <Object?>[
      'wire:a@example.com',
      'wire:b@example.com',
      'wire:m@example.com',
      'u9',
    ]);
  });

  test('encodes string where operators via codec resolver', () {
    final codecRegistry = SqlCodecRegistry().withField(
      model: 'User',
      field: 'email',
      codec: SqlLambdaFieldCodec(
        encode: (value) => value == null ? null : 'wire:$value',
        decode: (value) => value,
      ),
    );
    final adapter = SqlAdapter(
      contract: contract,
      codecResolver: codecRegistry,
    );

    final statement = adapter.lower(
      readPlan(
        contract: contract,
        model: 'User',
        where: <String, Object?>{
          'email': <String, Object?>{
            'contains': 'example',
            'startsWith': 'head',
            'endsWith': 'tail',
          },
        },
      ),
    );

    expect(
      statement.text,
      "SELECT * FROM \"users\" WHERE "
      "\"email\" LIKE ? ESCAPE '\\' AND "
      "\"email\" LIKE ? ESCAPE '\\' AND "
      "\"email\" LIKE ? ESCAPE '\\'",
    );
    expect(statement.parameters, <Object?>[
      '%wire:example%',
      'wire:head%',
      '%wire:tail',
    ]);
  });

  test('keeps default no-codec behavior unchanged', () {
    final adapterWithoutCodec = SqlAdapter(contract: contract);
    final adapterWithEmptyCodec = SqlAdapter(
      contract: contract,
      codecResolver: SqlCodecRegistry(),
    );

    final plan = mutationPlan(
      contract: contract,
      model: 'User',
      action: OrmAction.update,
      where: <String, Object?>{'email': 'find@example.com', 'id': 'u1'},
      data: <String, Object?>{'email': 'next@example.com'},
    );

    final withoutCodecStatement = adapterWithoutCodec.lower(plan);
    final emptyCodecStatement = adapterWithEmptyCodec.lower(plan);
    expect(
      emptyCodecStatement.parameters,
      withoutCodecStatement.parameters,
      reason: 'Empty codec registry should not mutate parameters.',
    );
    expect(emptyCodecStatement.parameters, <Object?>[
      'next@example.com',
      'find@example.com',
      'u1',
    ]);

    final response = const SqlResult(
      rows: <JsonMap>[
        <String, Object?>{'id': 'u1', 'email': 'db@example.com'},
      ],
    );
    final decodePlan = readPlan(
      contract: contract,
      model: 'User',
      resultMode: OrmReadResultMode.oneOrNull,
    );

    final decodedWithoutCodec = adapterWithoutCodec.decode(
      response,
      decodePlan,
    );
    final decodedWithEmptyCodec = adapterWithEmptyCodec.decode(
      response,
      decodePlan,
    );
    expect(decodedWithEmptyCodec.data, decodedWithoutCodec.data);
    expect(decodedWithEmptyCodec.data, <String, Object?>{
      'id': 'u1',
      'email': 'db@example.com',
    });
  });

  test('matches codecs by model and field and only transforms hit fields', () {
    final codecRegistry = SqlCodecRegistry()
        .withField(
          model: 'User',
          field: 'email',
          codec: SqlLambdaFieldCodec(
            encode: (value) => value == null ? null : 'user-email:$value',
            decode: (value) => value == null ? null : 'user-row:$value',
          ),
        )
        .withField(
          model: 'OtherModel',
          field: 'email',
          codec: SqlLambdaFieldCodec(
            encode: (value) => value == null ? null : 'other:$value',
            decode: (value) => value == null ? null : 'other:$value',
          ),
        )
        .withField(
          model: 'User',
          field: 'otherField',
          codec: SqlLambdaFieldCodec(
            encode: (value) => value == null ? null : 'otherField:$value',
            decode: (value) => value == null ? null : 'otherField:$value',
          ),
        );

    final adapter = SqlAdapter(
      contract: contract,
      codecResolver: codecRegistry,
    );
    final statement = adapter.lower(
      mutationPlan(
        contract: contract,
        model: 'User',
        action: OrmAction.update,
        data: <String, Object?>{'id': 'u2', 'email': 'next@example.com'},
        where: <String, Object?>{'id': 'u1', 'email': 'find@example.com'},
      ),
    );
    expect(statement.parameters, <Object?>[
      'u2',
      'user-email:next@example.com',
      'u1',
      'user-email:find@example.com',
    ]);

    final decoded = adapter.decode(
      const SqlResult(
        rows: <JsonMap>[
          <String, Object?>{
            'id': 'u1',
            'email': 'wire@example.com',
            'unmapped': 'keep',
          },
        ],
      ),
      readPlan(
        contract: contract,
        model: 'User',
        resultMode: OrmReadResultMode.oneOrNull,
      ),
    );
    if (decoded.data case final Map<String, Object?> row) {
      expect(row, <String, Object?>{
        'id': 'u1',
        'email': 'user-row:wire@example.com',
        'unmapped': 'keep',
      });
    } else {
      fail('Expected row map for model+field codec matching.');
    }
  });

  test('throws when lowering unknown model', () {
    final adapter = SqlAdapter(contract: contract);

    expect(
      () => adapter.lower(
        readPlan(contract: contract, model: 'Missing'),
      ),
      throwsA(isA<ModelNotFoundException>()),
    );
  });
}
