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

  final contract = buildContract();

  test('lowers findMany with where/order/pagination/select', () {
    final adapter = SqlAdapter(contract: contract);
    final plan = OrmPlan(
      contractHash: contract.hash,
      model: 'User',
      action: OrmAction.findMany,
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

  test('lowers mutation statements', () {
    final contract = buildContract(mutationReturning: false);
    final adapter = SqlAdapter(contract: contract);

    final createStatement = adapter.lower(
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
        model: 'User',
        action: OrmAction.findMany,
      ),
    );
    expect(findMany.data, isA<List<Object?>>());

    final findUnique = adapter.decode(
      const SqlResult(
        rows: <JsonMap>[
          <String, Object?>{'id': 'u1'},
        ],
      ),
      OrmPlan(
        contractHash: contract.hash,
        model: 'User',
        action: OrmAction.findUnique,
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
      OrmPlan(
        contractHash: contract.hash,
        model: 'User',
        action: OrmAction.update,
      ),
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
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
        model: 'User',
        action: OrmAction.findUnique,
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

  test('keeps default no-codec behavior unchanged', () {
    final adapterWithoutCodec = SqlAdapter(contract: contract);
    final adapterWithEmptyCodec = SqlAdapter(
      contract: contract,
      codecResolver: SqlCodecRegistry(),
    );

    final plan = OrmPlan(
      contractHash: contract.hash,
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
    final decodePlan = OrmPlan(
      contractHash: contract.hash,
      model: 'User',
      action: OrmAction.findUnique,
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
      OrmPlan(
        contractHash: contract.hash,
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
      OrmPlan(
        contractHash: contract.hash,
        model: 'User',
        action: OrmAction.findUnique,
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
        OrmPlan(
          contractHash: contract.hash,
          model: 'Missing',
          action: OrmAction.findMany,
        ),
      ),
      throwsA(isA<ModelNotFoundException>()),
    );
  });
}
