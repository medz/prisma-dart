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
    OrmReadCursorPlan? cursor,
    OrmReadPagePlan? page,
    OrmReadResultMode resultMode = OrmReadResultMode.all,
    OrmReadShape shape = OrmReadShape.rows,
    OrmReadAggregatePlan? aggregate,
    OrmReadGroupByPlan? groupBy,
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
        cursor: cursor,
        page: page,
        resultMode: resultMode,
        shape: shape,
        aggregate: aggregate,
        groupBy: groupBy,
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

  test('lowers cursor reads with inclusive boundary predicate', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      cursor: OrmReadCursorPlan(values: const <String, Object?>{'id': 2}),
      take: 2,
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT * FROM "users" WHERE ((("id" > ?)) OR ("id" = ?)) '
      'ORDER BY "id" ASC LIMIT ?',
    );
    expect(statement.parameters, <Object?>[2, 2, 2]);
  });

  test('lowers page after with strict boundary predicate and limit', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      page: OrmReadPagePlan(size: 2, after: const <String, Object?>{'id': 2}),
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT * FROM "users" WHERE (("id" > ?)) ORDER BY "id" ASC LIMIT ?',
    );
    expect(statement.parameters, <Object?>[2, 2]);
  });

  test('lowers page before with reverse inner query and outer reorder', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      page: OrmReadPagePlan(size: 2, before: const <String, Object?>{'id': 4}),
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT * FROM (SELECT * FROM "users" WHERE (("id" < ?)) '
      'ORDER BY "id" DESC LIMIT ?) AS "_page" ORDER BY "id" ASC',
    );
    expect(statement.parameters, <Object?>[4, 2]);
  });

  test('lowers distinct cursor reads through ranked deduplication', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      orderBy: const <OrmOrderBy>[OrmOrderBy('email'), OrmOrderBy('id')],
      distinct: const <String>['email'],
      cursor: OrmReadCursorPlan(
        values: const <String, Object?>{'email': 'a@example.com', 'id': 2},
      ),
      take: 2,
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT "email", "id" FROM (SELECT "email", "id", '
      'ROW_NUMBER() OVER (PARTITION BY "email" ORDER BY "email" ASC, "id" ASC) '
      'AS "_distinct_rank" FROM "users") AS "_distinct" '
      'WHERE "_distinct_rank" = 1 AND ((("email" > ?) OR ("email" = ? AND "id" > ?)) OR ("email" = ? AND "id" = ?)) '
      'ORDER BY "email" ASC, "id" ASC LIMIT ?',
    );
    expect(
      statement.parameters,
      <Object?>['a@example.com', 'a@example.com', 2, 'a@example.com', 2, 2],
    );
  });

  test('lowers distinct page before reads through ranked deduplication', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      orderBy: const <OrmOrderBy>[OrmOrderBy('email'), OrmOrderBy('id')],
      distinct: const <String>['email'],
      page: OrmReadPagePlan(
        size: 2,
        before: const <String, Object?>{'email': 'c@example.com', 'id': 4},
      ),
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT "email", "id" FROM (SELECT * FROM (SELECT "email", "id", '
      'ROW_NUMBER() OVER (PARTITION BY "email" ORDER BY "email" ASC, "id" ASC) '
      'AS "_distinct_rank" FROM "users") AS "_distinct" '
      'WHERE "_distinct_rank" = 1 AND (("email" < ?) OR ("email" = ? AND "id" < ?)) '
      'ORDER BY "email" DESC, "id" DESC LIMIT ?) AS "_page" '
      'ORDER BY "email" ASC, "id" ASC',
    );
    expect(
      statement.parameters,
      <Object?>['c@example.com', 'c@example.com', 4, 2],
    );
  });

  test('lowers aggregate read shapes through a windowed subquery', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      where: const <String, Object?>{'email': 'a@example.com'},
      orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      take: 2,
      shape: OrmReadShape.aggregate,
      select: const <String>['id'],
      aggregate: OrmReadAggregatePlan(countAll: true, sum: <String>['id']),
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT COUNT(*) AS "__count_all", SUM("_agg"."id") AS "__sum_id" '
      'FROM (SELECT "id" FROM "users" WHERE "email" = ? ORDER BY "id" ASC LIMIT ?) AS "_agg"',
    );
    expect(statement.parameters, <Object?>['a@example.com', 2]);
  });

  test('lowers grouped aggregate read shapes with having and orderBy', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = readPlan(
      contract: contract,
      model: 'User',
      shape: OrmReadShape.groupedAggregate,
      aggregate: OrmReadAggregatePlan(countAll: true, sum: <String>['id']),
      groupBy: OrmReadGroupByPlan(
        by: <String>['email'],
        having: OrmGroupByHaving.parse(<String, Object?>{
          '_count': <String, Object?>{
            'all': <String, Object?>{'gte': 2},
          },
        }),
        orderBy: <OrmOrderBy>[OrmOrderBy('_sum.id', order: SortOrder.desc)],
        take: 3,
        skip: 1,
      ),
    );

    final statement = adapter.lower(plan);
    expect(
      statement.text,
      'SELECT "email", COUNT(*) AS "__count_all", SUM("id") AS "__sum_id" '
      'FROM "users" GROUP BY "email" HAVING COUNT(*) >= ? '
      'ORDER BY "__sum_id" DESC LIMIT ? OFFSET ?',
    );
    expect(statement.parameters, <Object?>[2, 3, 1]);
  });

  test(
    'decodes aggregate and grouped aggregate rows into structured payloads',
    () {
      final adapter = SqlAdapter(contract: contract);

      final aggregatePlan = readPlan(
        contract: contract,
        model: 'User',
        shape: OrmReadShape.aggregate,
        aggregate: OrmReadAggregatePlan(
          countAll: true,
          min: <String>['id'],
          sum: <String>['id'],
        ),
      );
      final aggregateResponse = adapter.decode(
        SqlResult(
          rows: const <JsonMap>[
            <String, Object?>{'__count_all': 3, '__min_id': 1, '__sum_id': 8},
          ],
        ),
        aggregatePlan,
      );

      final groupedPlan = readPlan(
        contract: contract,
        model: 'User',
        shape: OrmReadShape.groupedAggregate,
        aggregate: OrmReadAggregatePlan(countAll: true, sum: <String>['id']),
        groupBy: OrmReadGroupByPlan(by: <String>['email']),
      );
      final groupedResponse = adapter.decode(
        SqlResult(
          rows: const <JsonMap>[
            <String, Object?>{
              'email': 'a@example.com',
              '__count_all': 2,
              '__sum_id': 5,
            },
          ],
        ),
        groupedPlan,
      );

      expect(
        aggregateResponse.rows,
        emitsInOrder(<Object?>[
          <String, Object?>{
            'count': <String, Object?>{'all': 3},
            'min': <String, Object?>{'id': 1},
            'sum': <String, Object?>{'id': 8},
          },
          emitsDone,
        ]),
      );
      expect(
        groupedResponse.rows,
        emitsInOrder(<Object?>[
          <String, Object?>{
            'email': 'a@example.com',
            'count': <String, Object?>{'all': 2},
            'sum': <String, Object?>{'id': 5},
          },
          emitsDone,
        ]),
      );
    },
  );

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

  test('decodes SQL result by action response shape', () async {
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
    expect(_collectResponseRows(findMany), completion(isA<List<JsonMap>>()));

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
    expect(await _collectSingleResponseRow(findUnique), <String, Object?>{
      'id': 'u1',
    });

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
    expect(await _collectSingleResponseRow(mutation), <String, Object?>{
      'id': 'u1',
    });
  });

  test('applies codec encode for where/data and decode for rows', () async {
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
    expect(await _collectSingleResponseRow(decoded), <String, Object?>{
      'email': 'app:wire:db@example.com',
      'id': 'u1',
    });
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

  test('keeps default no-codec behavior unchanged', () async {
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
    final withoutCodecRow = await _collectSingleResponseRow(
      decodedWithoutCodec,
    );
    final emptyCodecRow = await _collectSingleResponseRow(
      decodedWithEmptyCodec,
    );
    expect(emptyCodecRow, withoutCodecRow);
    expect(emptyCodecRow, <String, Object?>{
      'id': 'u1',
      'email': 'db@example.com',
    });
  });

  test(
    'matches codecs by model and field and only transforms hit fields',
    () async {
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
      expect(await _collectSingleResponseRow(decoded), <String, Object?>{
        'id': 'u1',
        'email': 'user-row:wire@example.com',
        'unmapped': 'keep',
      });
    },
  );

  test('throws when lowering unknown model', () {
    final adapter = SqlAdapter(contract: contract);

    expect(
      () => adapter.lower(readPlan(contract: contract, model: 'Missing')),
      throwsA(isA<ModelNotFoundException>()),
    );
  });
}

Future<List<JsonMap>> _collectResponseRows(EngineResponse response) async {
  final rows = <JsonMap>[];
  await for (final row in response.rows) {
    if (row is! Map<String, Object?>) {
      fail('Expected row map but got ${row.runtimeType}.');
    }
    rows.add(row);
  }
  return rows;
}

Future<JsonMap?> _collectSingleResponseRow(EngineResponse response) async {
  final rows = await _collectResponseRows(response);
  if (rows.isEmpty) {
    return null;
  }
  if (rows.length > 1) {
    fail('Expected a single row but got ${rows.length}.');
  }
  return rows.single;
}
