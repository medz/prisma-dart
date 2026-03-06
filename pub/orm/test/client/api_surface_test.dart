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
    });

    test('explain returns structured plan json', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');
      final explained = await users
          .where(<String, Object?>{'id': 'u1'})
          .take(1)
          .explain();

      expect(explained['lane'], 'orm');
      final read = explained['read'] as Map<String, Object?>;
      expect(read['where'], <String, Object?>{'id': 'u1'});
      expect(read['take'], 1);
      expect(read['resultMode'], 'all');
    });

    test('cursor and page execution remain explicit placeholders', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        expect(
          () => users.query().cursor(<String, Object?>{'id': 'u1'}).all(),
          throwsA(
            isA<ApiNotImplementedException>().having(
              (error) => error.details['surface'],
              'surface',
              'orm.query.cursor.execute',
            ),
          ),
        );
        expect(
          () => users
              .query()
              .page(size: 10, after: <String, Object?>{'id': 'u1'})
              .all(),
          throwsA(
            isA<ApiNotImplementedException>().having(
              (error) => error.details['surface'],
              'surface',
              'orm.query.page.execute',
            ),
          ),
        );
      } finally {
        await client.disconnect();
      }
    });

    test('direct plan execution rejects cursor and page plans', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        final cursorPlan = await users
            .query()
            .cursor(<String, Object?>{'id': 'u1'})
            .toPlan();
        final pagePlan = await users
            .query()
            .page(size: 10, after: <String, Object?>{'id': 'u1'})
            .toPlan();

        await expectLater(
          client.execute(cursorPlan),
          throwsA(
            isA<ApiNotImplementedException>().having(
              (error) => error.details['surface'],
              'surface',
              'orm.plan.cursor.execute',
            ),
          ),
        );
        await expectLater(
          client.execute(pagePlan),
          throwsA(
            isA<ApiNotImplementedException>().having(
              (error) => error.details['surface'],
              'surface',
              'orm.plan.page.execute',
            ),
          ),
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
