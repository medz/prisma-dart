import 'package:orm/orm.dart';
import 'package:test/test.dart';

void main() {
  final contract = OrmContract(
    version: '1',
    hash: 'contract-v1',
    models: <String, ModelContract>{
      'User': ModelContract(
        name: 'User',
        table: 'users',
        fields: <String>{'id', 'email'},
      ),
    },
    aliases: <String, String>{'users': 'User'},
  );

  group('api surface shell', () {
    test('whereWith merges immutable query state', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      final base = users.where(<String, Object?>{'id': 'u1'});
      final next = base.whereWith(
        (where) => <String, Object?>{...where, 'email': 'a@x.com'},
      );

      expect(base.whereClause, <String, Object?>{'id': 'u1'});
      expect(next.whereClause, <String, Object?>{
        'id': 'u1',
        'email': 'a@x.com',
      });
    });

    test('selectWith appends from immutable selected fields snapshot', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      final base = users.select(const <String>['id']);
      final next = base.selectWith(
        (fields) => <String>[...fields, 'email'],
        append: false,
      );

      expect(base.selectedFields, <String>['id']);
      expect(next.selectedFields, <String>['id', 'email']);
    });

    test('cursor compiles into structured query plan state', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      final plan = await users.query().cursor(<String, Object?>{'id': 'u1'}).toPlan();

      expect(plan.read?.cursor?.values, <String, Object?>{'id': 'u1'});
      expect(plan.read?.page, isNull);
      expect(plan.read?.orderBy.map((entry) => entry.field).toList(), <String>['id']);
    });

    test('page compiles into structured query plan state', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      final plan = await users
          .query()
          .page(size: 20, after: <String, Object?>{'id': 'u1'})
          .toPlan();

      expect(plan.read?.cursor, isNull);
      expect(plan.read?.page?.size, 20);
      expect(plan.read?.page?.after, <String, Object?>{'id': 'u1'});
      expect(plan.read?.orderBy.map((entry) => entry.field).toList(), <String>['id']);
    });

    test('inspectPlan returns structured plan json without connecting', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');
      final inspected = await users
          .where(<String, Object?>{'id': 'u1'})
          .take(1)
          .inspectPlan();

      expect(inspected['lane'], 'orm');
      final read = inspected['read'] as Map<String, Object?>;
      expect(read['where'], <String, Object?>{'id': 'u1'});
      expect(read['take'], 1);
      expect(read['resultMode'], 'all');
    });

    test('explain requires an active runtime connection', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      await expectLater(
        users.query().orderByField('id').page(size: 2).explain(),
        throwsA(isA<ClientNotConnectedException>()),
      );
    });

    test('explain returns structured runtime report when connected', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        final explained = await users
            .query()
            .orderByField('id')
            .page(size: 2, after: <String, Object?>{'id': 'u1'})
            .explain();

        expect(explained['source'], 'heuristic');
        final summary = explained['planSummary'] as Map<String, Object?>;
        expect(summary['model'], 'User');
        final pagination = summary['pagination'] as Map<String, Object?>;
        expect(pagination['mode'], 'page');
        expect(explained['plan'], isA<Map<String, Object?>>());
      } finally {
        await client.disconnect();
      }
    });

    test('cursor and page execution return deterministic windows', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
        await users.create(data: <String, Object?>{'id': 2, 'email': 'b@x.com'});
        await users.create(data: <String, Object?>{'id': 3, 'email': 'c@x.com'});
        await users.create(data: <String, Object?>{'id': 4, 'email': 'd@x.com'});

        final cursorRows = await users
            .query()
            .orderByField('id')
            .cursor(<String, Object?>{'id': 2})
            .skip(1)
            .take(2)
            .all();
        final afterRows = await users
            .query()
            .orderByField('id')
            .page(size: 2, after: <String, Object?>{'id': 2})
            .all();
        final beforeRows = await users
            .query()
            .orderByField('id')
            .page(size: 2, before: <String, Object?>{'id': 4})
            .all();

        expect(
          cursorRows.map((row) => row['id']).toList(growable: false),
          <Object?>[3, 4],
        );
        expect(
          afterRows.map((row) => row['id']).toList(growable: false),
          <Object?>[3, 4],
        );
        expect(
          beforeRows.map((row) => row['id']).toList(growable: false),
          <Object?>[2, 3],
        );
      } finally {
        await client.disconnect();
      }
    });

    test('direct plan execution supports cursor and page plans', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
        await users.create(data: <String, Object?>{'id': 2, 'email': 'b@x.com'});
        await users.create(data: <String, Object?>{'id': 3, 'email': 'c@x.com'});
        await users.create(data: <String, Object?>{'id': 4, 'email': 'd@x.com'});

        final pagePlan = await users
            .query()
            .orderByField('id')
            .page(size: 2, after: <String, Object?>{'id': 2})
            .toPlan();

        final cursorResponse = await client.execute(
          OrmPlan.read(
            contractHash: contract.hash,
            model: 'User',
            lane: 'orm',
            where: const <String, Object?>{},
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            cursor: OrmReadCursorPlan(values: const <String, Object?>{'id': 2}),
            resultMode: OrmReadResultMode.all,
          ),
        );
        final pageResponse = await client.execute(pagePlan);

        expect(
          (cursorResponse.data as List<JsonMap>)
              .map((row) => row['id'])
              .toList(growable: false),
          <Object?>[2, 3, 4],
        );
        expect(
          (pageResponse.data as List<JsonMap>)
              .map((row) => row['id'])
              .toList(growable: false),
          <Object?>[3, 4],
        );
      } finally {
        await client.disconnect();
      }
    });

    test('cursor and page validation are deterministic', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users.query().cursor(const <String, Object?>{}),
        throwsA(isA<PlanCursorWindowInvalidException>()),
      );
      expect(
        () => users.query().page(size: 0),
        throwsA(isA<PlanCursorWindowInvalidException>()),
      );
      expect(
        () => users.query().page(
          size: 10,
          after: <String, Object?>{'id': 'u1'},
          before: <String, Object?>{'id': 'u2'},
        ),
        throwsA(isA<PlanCursorWindowInvalidException>()),
      );
    });

    test('updateMany placeholder throws stable not implemented error', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await expectLater(
          users
              .where(<String, Object?>{'id': 'u1'})
              .updateMany(data: <String, Object?>{'email': 'b@x.com'}),
          throwsA(
            isA<ApiNotImplementedException>().having(
              (error) => error.details['surface'],
              'surface',
              'orm.updateMany',
            ),
          ),
        );
      } finally {
        await client.disconnect();
      }
    });
  });
}
