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

    test('cursor placeholder throws stable not implemented error', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users.query().cursor(<String, Object?>{'id': 'u1'}),
        throwsA(
          isA<ApiNotImplementedException>().having(
            (error) => error.details['surface'],
            'surface',
            'orm.query.cursor',
          ),
        ),
      );
    });

    test('page placeholder throws stable not implemented error', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users.query().page(size: 20, after: <String, Object?>{'id': 'u1'}),
        throwsA(
          isA<ApiNotImplementedException>().having(
            (error) => error.details['surface'],
            'surface',
            'orm.query.page',
          ),
        ),
      );
    });

    test('explain placeholder throws stable not implemented error', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await expectLater(
          users.where(<String, Object?>{'id': 'u1'}).explain(),
          throwsA(
            isA<ApiNotImplementedException>().having(
              (error) => error.details['surface'],
              'surface',
              'orm.query.explain',
            ),
          ),
        );
      } finally {
        await client.disconnect();
      }
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
