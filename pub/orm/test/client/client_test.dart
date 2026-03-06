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

  final relationalContract = OrmContract(
    version: '1',
    hash: 'contract-rel-v1',
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
    aliases: <String, String>{'users': 'User', 'posts': 'Post'},
  );
  group('OrmClient + MemoryEngine', () {
    test('default include strategy selector follows contract capabilities', () {
      final multi = defaultIncludeExecutionStrategySelector(
        contract: contract,
        modelName: 'User',
        action: OrmAction.findMany,
        include: const <String, IncludeSpec>{'posts': IncludeSpec()},
        depth: 0,
      );
      expect(multi, IncludeExecutionStrategy.multiQuery);

      final singleContract = OrmContract(
        version: '1',
        hash: 'contract-single',
        models: contract.models,
        aliases: contract.aliases,
        capabilities: const ContractCapabilities(includeSingleQuery: true),
      );
      final single = defaultIncludeExecutionStrategySelector(
        contract: singleContract,
        modelName: 'User',
        action: OrmAction.findMany,
        include: const <String, IncludeSpec>{'posts': IncludeSpec()},
        depth: 0,
      );
      expect(single, IncludeExecutionStrategy.singleQuery);
    });

    test('runs CRUD flow', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final users = client.collection('users');
      final created = await users.create(
        data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
      );
      expect(created['id'], 'u1');

      final allRows = await users.all();
      expect(allRows, hasLength(1));
      expect(allRows.first['email'], 'a@example.com');

      final unique = await users.oneOrNull(
        where: <String, Object?>{'id': 'u1'},
      );
      expect(unique?['id'], 'u1');

      final updated = await users.update(
        where: <String, Object?>{'id': 'u1'},
        data: <String, Object?>{'email': 'next@example.com'},
      );
      expect(updated?['email'], 'next@example.com');

      final removed = await users.delete(where: <String, Object?>{'id': 'u1'});
      expect(removed?['id'], 'u1');

      final remaining = await users.all();
      expect(remaining, isEmpty);
      await client.disconnect();
    });

    test('requires explicit connect', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.model('User');

      await expectLater(
        users.all(),
        throwsA(isA<ClientNotConnectedException>()),
      );
    });

    test('supports db.sql select and mutation builders', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final insertResult = await client.sql
          .insertInto('users')
          .values(<String, Object?>{'id': 'u1', 'email': 'a@example.com'})
          .returning(const <String>['id', 'email'])
          .execute();
      expect(insertResult.affectedRows, 1);
      expect(insertResult.row?['id'], 'u1');

      final selectedRows = await client.sql
          .from('User')
          .where(<String, Object?>{'id': 'u1'})
          .select(const <String>['email'])
          .query();
      expect(selectedRows, hasLength(1));
      expect(selectedRows.single['email'], 'a@example.com');

      final updated = await client.sql
          .update('User')
          .where(<String, Object?>{'id': 'u1'})
          .set(<String, Object?>{'email': 'b@example.com'})
          .returning(const <String>['email'])
          .execute();
      expect(updated.affectedRows, 1);
      expect(updated.row?['email'], 'b@example.com');

      final deleted = await client.sql
          .deleteFrom('User')
          .where(<String, Object?>{'id': 'u1'})
          .returning(const <String>['id'])
          .execute();
      expect(deleted.affectedRows, 1);
      expect(deleted.row?['id'], 'u1');

      final remaining = await client.sql.from('User').query();
      expect(remaining, isEmpty);
      await client.disconnect();
    });

    test('db.sql requires explicit connect', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await expectLater(
        client.sql.from('User').query(),
        throwsA(isA<ClientNotConnectedException>()),
      );
    });

    test('supports db namespace for orm and sql access', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final users = client.db.orm.collection('users');
      await users.create(
        data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
      );

      final sqlRow = await client.db.sql.from('User').where(<String, Object?>{
        'id': 'u1',
      }).first();
      expect(sqlRow?['email'], 'a@example.com');

      final ormRow = await client.db.orm['User'].oneOrNull(
        where: <String, Object?>{'id': 'u1'},
      );
      expect(ormRow?['id'], 'u1');
      await client.disconnect();
    });

    test('rejects plan with mismatched contract hash', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client.execute(
          OrmPlan(
            contractHash: 'mismatch',
            model: 'User',
            action: OrmAction.findMany,
          ),
        ),
        throwsA(isA<ContractHashMismatchException>()),
      );
    });

    test(
      'rejects plan with mismatched target/storage/profile metadata',
      () async {
        final profileContract = OrmContract(
          version: '1',
          hash: 'contract-meta-v1',
          target: 'sql-family',
          markerStorageHash: 'storage-v1',
          profileHash: 'profile-v1',
          models: <String, ModelContract>{
            'User': ModelContract(
              name: 'User',
              table: 'users',
              fields: <String>{'id', 'email'},
            ),
          },
        );
        final client = OrmClient(
          contract: profileContract,
          engine: MemoryEngine(),
        );
        await client.connect();

        await expectLater(
          client.execute(
            OrmPlan(
              contractHash: profileContract.hash,
              target: 'other-target',
              storageHash: profileContract.markerStorageHash,
              profileHash: profileContract.profileHash,
              model: 'User',
              action: OrmAction.findMany,
            ),
          ),
          throwsA(isA<PlanTargetMismatchException>()),
        );

        await expectLater(
          client.execute(
            OrmPlan(
              contractHash: profileContract.hash,
              target: profileContract.target,
              storageHash: 'other-storage',
              profileHash: profileContract.profileHash,
              model: 'User',
              action: OrmAction.findMany,
            ),
          ),
          throwsA(isA<PlanStorageHashMismatchException>()),
        );

        await expectLater(
          client.execute(
            OrmPlan(
              contractHash: profileContract.hash,
              target: profileContract.target,
              storageHash: profileContract.markerStorageHash,
              profileHash: 'other-profile',
              model: 'User',
              action: OrmAction.findMany,
            ),
          ),
          throwsA(isA<PlanProfileHashMismatchException>()),
        );
        await client.disconnect();
      },
    );

    test('supports ordering and pagination in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': '1', 'email': 'c@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': '2', 'email': 'a@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': '3', 'email': 'b@x.com'},
      );

      final rows = await users.all(
        orderBy: const <OrmOrderBy>[OrmOrderBy('email')],
        skip: 1,
        take: 1,
      );

      expect(rows.single['email'], 'b@x.com');
      await client.disconnect();
    });

    test(
      'supports distinct with order and pagination in memory engine',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();
        final users = client.model('User');

        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u3', 'email': 'b@x.com'},
        );

        final distinctRows = await users.all(
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
          distinct: const <String>['email'],
        );
        expect(
          distinctRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u1', 'u3'],
        );

        final pagedDistinctRows = await users.all(
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
          distinct: const <String>['email'],
          skip: 1,
          take: 1,
        );
        expect(
          pagedDistinctRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u3'],
        );

        final distinctFromQuery = await users
            .query()
            .orderByField('id')
            .distinctField('email')
            .all();
        expect(
          distinctFromQuery.map((row) => row['id']).toList(growable: false),
          <Object?>['u1', 'u3'],
        );
        await client.disconnect();
      },
    );

    test('supports aggregate helpers in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': null});
      await users.create(data: <String, Object?>{'id': 3, 'email': 'b@x.com'});

      final aggregate = await users.aggregate(
        countAll: true,
        count: const <String>['email'],
        min: const <String>['id'],
        max: const <String>['id'],
        sum: const <String>['id'],
        avg: const <String>['id'],
      );

      expect(aggregate['count'], <String, Object?>{'all': 3, 'email': 2});
      expect(aggregate['min'], <String, Object?>{'id': 1});
      expect(aggregate['max'], <String, Object?>{'id': 3});
      expect(aggregate['sum'], <String, Object?>{'id': 6});
      expect(aggregate['avg'], <String, Object?>{'id': 2.0});
      await client.disconnect();
    });

    test('supports groupBy helpers in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 4, 'email': 'b@x.com'});

      final grouped = await users
          .query()
          .orderByField('email')
          .groupBy(
            by: const <String>['email'],
            countAll: true,
            sum: const <String>['id'],
            avg: const <String>['id'],
          );

      expect(grouped, hasLength(2));
      expect(grouped.first['email'], 'a@x.com');
      expect(grouped.first['count'], <String, Object?>{'all': 2});
      expect(grouped.first['sum'], <String, Object?>{'id': 3});
      expect(grouped.first['avg'], <String, Object?>{'id': 1.5});
      expect(grouped.last['email'], 'b@x.com');
      expect(grouped.last['count'], <String, Object?>{'all': 1});
      expect(grouped.last['sum'], <String, Object?>{'id': 4});
      expect(grouped.last['avg'], <String, Object?>{'id': 4.0});
      await client.disconnect();
    });

    test(
      'supports groupBy having filters and aggregate orderBy in memory engine',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();
        final users = client.model('User');

        await users.create(
          data: <String, Object?>{'id': 1, 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 2, 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 10, 'email': 'b@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 20, 'email': 'b@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 5, 'email': 'c@x.com'},
        );

        final grouped = await users
            .query()
            .orderByField('_sum.id', order: SortOrder.desc)
            .groupBy(
              by: const <String>['email'],
              having: <String, Object?>{
                '_count': <String, Object?>{
                  'all': <String, Object?>{'gte': 2},
                },
              },
              countAll: true,
              sum: const <String>['id'],
            );

        expect(grouped, hasLength(2));
        expect(
          grouped.map((row) => row['email']).toList(growable: false),
          <Object?>['b@x.com', 'a@x.com'],
        );
        expect(grouped.first['count'], <String, Object?>{'all': 2});
        expect(grouped.first['sum'], <String, Object?>{'id': 30});
        expect(grouped.last['count'], <String, Object?>{'all': 2});
        expect(grouped.last['sum'], <String, Object?>{'id': 3});
        await client.disconnect();
      },
    );

    test('rejects invalid groupBy aggregate orderBy fields', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});

      await expectLater(
        users
            .query()
            .orderByField('sum.email')
            .groupBy(
              by: const <String>['email'],
              countAll: true,
              sum: const <String>['id'],
            ),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.GROUP_BY_ORDER_BY_INVALID',
          ),
        ),
      );
      await client.disconnect();
    });

    test('rejects invalid groupBy having aggregate fields', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});

      await expectLater(
        users.groupBy(
          by: const <String>['email'],
          having: <String, Object?>{
            '_sum': <String, Object?>{
              'email': <String, Object?>{'gte': 1},
            },
          },
          sum: const <String>['id'],
        ),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.GROUP_BY_HAVING_FIELD_INVALID',
          ),
        ),
      );
      await client.disconnect();
    });

    test('supports where operators gt/in/notIn in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': 'b@x.com'});
      await users.create(data: <String, Object?>{'id': 3, 'email': 'c@x.com'});
      await users.create(data: <String, Object?>{'id': 4, 'email': 'd@x.com'});

      final gtRows = await users.all(
        where: <String, Object?>{
          'id': <String, Object?>{'gt': 2},
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(gtRows.map((row) => row['id']).toList(growable: false), <Object?>[
        3,
        4,
      ]);

      final inRows = await users.all(
        where: <String, Object?>{
          'email': <String, Object?>{
            'in': <Object?>['a@x.com', 'c@x.com'],
          },
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(inRows.map((row) => row['id']).toList(growable: false), <Object?>[
        1,
        3,
      ]);

      final notInRows = await users.all(
        where: <String, Object?>{
          'id': <String, Object?>{
            'notIn': <Object?>[2, 3],
          },
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(
        notInRows.map((row) => row['id']).toList(growable: false),
        <Object?>[1, 4],
      );
      await client.disconnect();
    });

    test(
      'supports string where operators contains/startsWith/endsWith in memory engine',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();
        final users = client.model('User');

        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'alpha@example.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u2', 'email': 'beta@example.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u3', 'email': 'alphonse@example.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u4', 'email': 'gamma@sample.com'},
        );

        final containsRows = await users.all(
          where: <String, Object?>{
            'email': <String, Object?>{'contains': 'example.com'},
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          containsRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u1', 'u2', 'u3'],
        );

        final startsWithRows = await users.all(
          where: <String, Object?>{
            'email': <String, Object?>{'startsWith': 'alph'},
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          startsWithRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u1', 'u3'],
        );

        final endsWithRows = await users.all(
          where: <String, Object?>{
            'email': <String, Object?>{'endsWith': 'sample.com'},
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          endsWithRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u4'],
        );
        await client.disconnect();
      },
    );

    test(
      'supports logical AND/OR/NOT where composition in memory engine',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();
        final users = client.model('User');

        await users.create(
          data: <String, Object?>{'id': 1, 'email': 'a@example.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 2, 'email': 'b@example.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 3, 'email': 'alpha@sample.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 4, 'email': 'z@sample.com'},
        );

        final andRows = await users.all(
          where: <String, Object?>{
            'AND': <Object?>[
              <String, Object?>{
                'id': <String, Object?>{'gt': 1},
              },
              <String, Object?>{
                'email': <String, Object?>{'contains': 'example.com'},
              },
            ],
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          andRows.map((row) => row['id']).toList(growable: false),
          <Object?>[2],
        );

        final orRows = await users.all(
          where: <String, Object?>{
            'OR': <Object?>[
              <String, Object?>{'id': 1},
              <String, Object?>{'id': 4},
            ],
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          orRows.map((row) => row['id']).toList(growable: false),
          <Object?>[1, 4],
        );

        final notRows = await users.all(
          where: <String, Object?>{
            'NOT': <Object?>[
              <String, Object?>{
                'email': <String, Object?>{'endsWith': 'sample.com'},
              },
            ],
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          notRows.map((row) => row['id']).toList(growable: false),
          <Object?>[1, 2],
        );
        await client.disconnect();
      },
    );

    test(
      'supports select projection for direct read/mutation methods',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();
        final users = client.model('User');

        final created = await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
          select: const <String>['id'],
        );
        expect(created.keys, <String>['id']);
        expect(created['id'], 'u1');

        final unique = await users.oneOrNull(
          where: <String, Object?>{'id': 'u1'},
          select: const <String>['email'],
        );
        expect(unique?.keys, <String>['email']);
        expect(unique?['email'], 'a@example.com');

        final updated = await users.update(
          where: <String, Object?>{'id': 'u1'},
          data: <String, Object?>{'email': 'b@example.com'},
          select: const <String>['id'],
        );
        expect(updated?.keys, <String>['id']);
        expect(updated?['id'], 'u1');

        final removed = await users.delete(
          where: <String, Object?>{'id': 'u1'},
          select: const <String>['email'],
        );
        expect(removed?.keys, <String>['email']);
        expect(removed?['email'], 'b@example.com');
        await client.disconnect();
      },
    );

    test('supports immutable chained query state for reads', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': '1', 'email': 'c@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': '2', 'email': 'a@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': '3', 'email': 'b@x.com'},
      );

      final base = users.orderByField('email');
      final narrowed = base.skip(1).take(1);

      final all = await base.all();
      final page = await narrowed.all();

      expect(all, hasLength(3));
      expect(page, hasLength(1));
      expect(page.single['email'], 'b@x.com');
      await client.disconnect();
    });

    test(
      'query toPlan emits orm lane metadata and include annotations',
      () async {
        final client = OrmClient(
          contract: relationalContract,
          engine: MemoryEngine(),
        );
        final users = client.model('User');

        final plan = await users
            .query()
            .where(<String, Object?>{'id': 'u1'})
            .include(<String, IncludeSpec>{
              'posts': const IncludeSpec(
                take: 3,
                include: <String, IncludeSpec>{
                  'author': IncludeSpec(select: <String>['email']),
                },
              ),
            })
            .take(5)
            .toPlan();

        expect(plan.lane, 'orm');
        expect(plan.action, OrmAction.findMany);
        expect(plan.take, 5);
        expect(plan.annotations['resultMode'], 'all');
        expect(plan.annotations['include'], <String, Object?>{
          'posts': <String, Object?>{
            'take': 3,
            'include': <String, Object?>{
              'author': <String, Object?>{
                'select': <String>['email'],
              },
            },
          },
        });
      },
    );

    test('supports select projection through chained query state', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': '1', 'email': 'a@x.com'},
      );

      final readQuery = users.where(<String, Object?>{'id': '1'}).select(
        const <String>['email'],
      );
      final selected = await readQuery.oneOrNull();
      expect(selected?.keys, <String>['email']);
      expect(selected?['email'], 'a@x.com');

      final mutationQuery = users.where(<String, Object?>{'id': '1'}).select(
        const <String>['id'],
      );
      final updated = await mutationQuery.update(
        data: <String, Object?>{'email': 'b@x.com'},
      );
      expect(updated?.keys, <String>['id']);
      expect(updated?['id'], '1');
      await client.disconnect();
    });

    test('supports chained query state for unique/update/delete', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
      );

      final updated = await users
          .where(<String, Object?>{'id': 'u1'})
          .update(data: <String, Object?>{'email': 'b@example.com'});
      expect(updated?['email'], 'b@example.com');

      final unique = await users.where(<String, Object?>{
        'id': 'u1',
      }).oneOrNull();
      expect(unique?['email'], 'b@example.com');

      final removed = await users.where(<String, Object?>{'id': 'u1'}).delete();
      expect(removed?['id'], 'u1');

      final remaining = await users.where(<String, Object?>{
        'id': 'u1',
      }).oneOrNull();
      expect(remaining, isNull);
      await client.disconnect();
    });

    test('supports firstOrNull, count and exists helpers', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': 'u1', 'email': 'b@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': 'u3', 'email': 'c@x.com'},
      );

      final first = await users.firstOrNull(
        orderBy: const <OrmOrderBy>[OrmOrderBy('email')],
      );
      expect(first?['id'], 'u2');

      final total = await users.count();
      expect(total, 3);

      final existsU1 = await users.exists(where: <String, Object?>{'id': 'u1'});
      final existsUx = await users.exists(where: <String, Object?>{'id': 'ux'});
      expect(existsU1, isTrue);
      expect(existsUx, isFalse);
      await client.disconnect();
    });

    test('supports stream-first reads on delegate and query', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': 'u1', 'email': 'c@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
      );
      await users.create(
        data: <String, Object?>{'id': 'u3', 'email': 'b@x.com'},
      );

      final delegateRows = await users
          .stream(orderBy: const <OrmOrderBy>[OrmOrderBy('email')])
          .toList();
      expect(delegateRows, hasLength(3));
      expect(delegateRows.first['id'], 'u2');

      final queryRows = await users
          .orderByField('email')
          .take(2)
          .stream()
          .toList();
      expect(queryRows, hasLength(2));
      expect(queryRows.last['id'], 'u3');
      await client.disconnect();
    });

    test('supports upsert create and update branches', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      final created = await users.upsert(
        where: <String, Object?>{'id': 'u1'},
        create: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
        update: <String, Object?>{'email': 'b@example.com'},
      );
      expect(created['email'], 'a@example.com');

      final updated = await users.upsert(
        where: <String, Object?>{'id': 'u1'},
        create: <String, Object?>{'id': 'u1', 'email': 'x@example.com'},
        update: <String, Object?>{'email': 'b@example.com'},
      );
      expect(updated['email'], 'b@example.com');
      await client.disconnect();
    });

    test('supports createMany and deleteMany helpers', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      final createdRows = await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u3', 'email': 'b@x.com'},
        ],
      );
      expect(createdRows, hasLength(3));

      final deleted = await users.deleteMany(
        where: <String, Object?>{'email': 'a@x.com'},
      );
      expect(deleted, 2);

      final remaining = await users.count();
      expect(remaining, 1);
      await client.disconnect();
    });

    test('createMany_rolls_back_on_partial_failure', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': 'seed', 'email': 'seed@x.com'},
      );

      await expectLater(
        users.createMany(
          data: <JsonMap>[
            <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
            <String, Object?>{'id': 'u2', 'email': 'b@x.com', 'bad': true},
            <String, Object?>{'id': 'u3', 'email': 'c@x.com'},
          ],
        ),
        throwsA(isA<PlanFieldNotFoundException>()),
      );

      final rows = await users.all(
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(rows.map((row) => row['id']).toList(growable: false), <Object?>[
        'seed',
      ]);
      await client.disconnect();
    });

    test(
      'falls back for create/update/delete when mutation returning is disabled',
      () async {
        final noReturningContract = OrmContract(
          version: contract.version,
          hash: contract.hash,
          models: contract.models,
          aliases: contract.aliases,
          capabilities: const ContractCapabilities(mutationReturning: false),
        );
        final client = OrmClient(
          contract: noReturningContract,
          engine: _NoMutationReturnEngine(inner: MemoryEngine()),
        );
        await client.connect();
        final users = client.model('User');

        final created = await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          select: const <String>['id', 'email'],
        );
        expect(created['id'], 'u1');
        expect(created['email'], 'a@x.com');

        final updated = await users.update(
          where: <String, Object?>{'id': 'u1'},
          data: <String, Object?>{'email': 'b@x.com'},
          select: const <String>['id', 'email'],
        );
        expect(updated?['id'], 'u1');
        expect(updated?['email'], 'b@x.com');

        final removed = await users.delete(
          where: <String, Object?>{'id': 'u1'},
          select: const <String>['id', 'email'],
        );
        expect(removed?['id'], 'u1');
        expect(removed?['email'], 'b@x.com');

        final remaining = await users.oneOrNull(
          where: <String, Object?>{'id': 'u1'},
        );
        expect(remaining, isNull);
        await client.disconnect();
      },
    );

    test(
      'supports query state helpers for first/count/exists/upsert/deleteMany',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();

        final users = client.model('User');
        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
        );

        final query = users.where(<String, Object?>{'email': 'a@x.com'});
        final first = await query.orderByField('id').firstOrNull();
        expect(first?['id'], 'u1');
        expect(await query.count(), 2);
        expect(await query.exists(), isTrue);

        final upserted = await users
            .where(<String, Object?>{'id': 'u3'})
            .upsert(
              create: <String, Object?>{'id': 'u3', 'email': 'z@x.com'},
              update: <String, Object?>{'email': 'q@x.com'},
            );
        expect(upserted['id'], 'u3');

        final removed = await query.deleteMany();
        expect(removed, 2);
        expect(await users.count(), 1);
        await client.disconnect();
      },
    );

    test(
      'supports relation where some/none/every for to-many relation',
      () async {
        final client = OrmClient(
          contract: relationalContract,
          engine: MemoryEngine(),
        );
        await client.connect();
        await _seedRelationalData(client);
        final users = client.model('User');
        await users.create(
          data: <String, Object?>{'id': 'u3', 'email': 'u3@example.com'},
        );

        final someRows = await users.all(
          where: <String, Object?>{
            'posts': <String, Object?>{
              'some': <String, Object?>{
                'title': <String, Object?>{'contains': 'A'},
              },
            },
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          someRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u1'],
        );

        final noneRows = await users.all(
          where: <String, Object?>{
            'posts': <String, Object?>{
              'none': <String, Object?>{
                'title': <String, Object?>{'contains': 'A'},
              },
            },
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          noneRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u2', 'u3'],
        );

        final everyRows = await users.all(
          where: <String, Object?>{
            'posts': <String, Object?>{
              'every': <String, Object?>{
                'title': <String, Object?>{'contains': 'A'},
              },
            },
          },
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
        );
        expect(
          everyRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u3'],
        );
        await client.disconnect();
      },
    );

    test('supports relation where is/isNot for to-one relation', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final posts = client.model('Post');

      await posts.create(
        data: <String, Object?>{'id': 'p4', 'userId': 'ux', 'title': 'Post D'},
      );

      final isRows = await posts.all(
        where: <String, Object?>{
          'author': <String, Object?>{
            'is': <String, Object?>{
              'email': <String, Object?>{'contains': 'u1@'},
            },
          },
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(isRows.map((row) => row['id']).toList(growable: false), <Object?>[
        'p1',
        'p2',
      ]);

      final isNotRows = await posts.all(
        where: <String, Object?>{
          'author': <String, Object?>{
            'isNot': <String, Object?>{'id': 'u1'},
          },
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(
        isNotRows.map((row) => row['id']).toList(growable: false),
        <Object?>['p3', 'p4'],
      );

      final relationMissingRows = await posts.all(
        where: <String, Object?>{
          'author': <String, Object?>{'isNot': const <String, Object?>{}},
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(
        relationMissingRows.map((row) => row['id']).toList(growable: false),
        <Object?>['p4'],
      );

      final isNullRows = await posts.all(
        where: <String, Object?>{
          'author': <String, Object?>{'is': null},
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(
        isNullRows.map((row) => row['id']).toList(growable: false),
        <Object?>['p4'],
      );

      final isNotNullRows = await posts.all(
        where: <String, Object?>{
          'author': <String, Object?>{'isNot': null},
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );
      expect(
        isNotNullRows.map((row) => row['id']).toList(growable: false),
        <Object?>['p1', 'p2', 'p3'],
      );
      await client.disconnect();
    });

    test('supports relation where with nested logical operators', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final users = client.model('User');
      await users.create(
        data: <String, Object?>{'id': 'u3', 'email': 'u3@example.com'},
      );

      final rows = await users.all(
        where: <String, Object?>{
          'AND': <Object?>[
            <String, Object?>{
              'posts': <String, Object?>{
                'some': <String, Object?>{
                  'title': <String, Object?>{'contains': 'Post'},
                },
              },
            },
            <String, Object?>{
              'OR': <Object?>[
                <String, Object?>{'id': 'u2'},
                <String, Object?>{'id': 'u3'},
              ],
            },
            <String, Object?>{
              'NOT': <String, Object?>{
                'posts': <String, Object?>{
                  'some': <String, Object?>{
                    'title': <String, Object?>{'contains': 'A'},
                  },
                },
              },
            },
          ],
        },
        orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
      );

      expect(rows, hasLength(1));
      expect(rows.single['id'], 'u2');
      await client.disconnect();
    });

    test('supports relation where on mutation paths', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final users = client.model('User');

      final updated = await users.update(
        where: <String, Object?>{
          'posts': <String, Object?>{
            'some': <String, Object?>{'title': 'Post C'},
          },
        },
        data: <String, Object?>{'email': 'u2+updated@example.com'},
      );
      expect(updated?['id'], 'u2');
      expect(updated?['email'], 'u2+updated@example.com');

      final persisted = await users.oneOrNull(
        where: <String, Object?>{'id': 'u2'},
      );
      expect(persisted?['email'], 'u2+updated@example.com');
      await client.disconnect();
    });

    test('supports to-one relation where on mutation paths', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final posts = client.model('Post');

      final updated = await posts.update(
        where: <String, Object?>{
          'author': <String, Object?>{
            'is': <String, Object?>{'id': 'u2'},
          },
        },
        data: <String, Object?>{'title': 'Post C updated'},
      );
      expect(updated?['id'], 'p3');

      final persisted = await posts.oneOrNull(
        where: <String, Object?>{'id': 'p3'},
      );
      expect(persisted?['title'], 'Post C updated');
      await client.disconnect();
    });

    test('skips relation where rewrite when target is sql-family', () async {
      final sqlTargetContract = OrmContract(
        version: relationalContract.version,
        hash: 'contract-rel-sql-v1',
        target: 'sql-family',
        models: relationalContract.models,
        aliases: relationalContract.aliases,
        capabilities: relationalContract.capabilities,
      );
      final countingEngine = _CountingEngine(inner: MemoryEngine());
      final client = OrmClient(
        contract: sqlTargetContract,
        engine: countingEngine,
      );
      await client.connect();

      await client
          .model('User')
          .all(
            where: <String, Object?>{
              'posts': <String, Object?>{
                'some': <String, Object?>{'title': 'Post A'},
              },
            },
          );

      expect(countingEngine.executeCount, 1);
      expect(countingEngine.executedPlans.single.model, 'User');
      expect(countingEngine.executedPlans.single.where, <String, Object?>{
        'posts': <String, Object?>{
          'some': <String, Object?>{'title': 'Post A'},
        },
      });
      await client.disconnect();
    });

    test('supports include for one-to-many relation', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);

      final rows = await client
          .model('User')
          .all(
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            include: <String, IncludeSpec>{
              'posts': IncludeSpec(
                orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                select: const <String>['id', 'title'],
              ),
            },
          );

      expect(rows, hasLength(2));
      final firstPosts = _readRowsValue(rows.first['posts']);
      expect(firstPosts, hasLength(2));
      expect(firstPosts.first['id'], 'p1');
      expect(firstPosts.first['title'], 'Post A');

      final secondPosts = _readRowsValue(rows.last['posts']);
      expect(secondPosts, hasLength(1));
      expect(secondPosts.single['id'], 'p3');
      await client.disconnect();
    });

    test(
      'singleQuery include matches multiQuery semantics for one-to-many',
      () async {
        Future<List<JsonMap>> readWithStrategy(
          IncludeExecutionStrategy strategy,
        ) async {
          final client = OrmClient(
            contract: relationalContract,
            engine: MemoryEngine(),
            includeStrategySelector:
                ({
                  required OrmContract contract,
                  required String modelName,
                  required OrmAction action,
                  required Map<String, IncludeSpec> include,
                  required int depth,
                }) => strategy,
          );
          await client.connect();
          try {
            await _seedRelationalData(client);
            final rows = await client
                .model('User')
                .all(
                  orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                  include: <String, IncludeSpec>{
                    'posts': IncludeSpec(
                      orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                      select: const <String>['id', 'title'],
                    ),
                  },
                );
            return rows;
          } finally {
            await client.disconnect();
          }
        }

        final singleRows = await readWithStrategy(
          IncludeExecutionStrategy.singleQuery,
        );
        final multiRows = await readWithStrategy(
          IncludeExecutionStrategy.multiQuery,
        );

        expect(singleRows, equals(multiRows));
        expect(singleRows, hasLength(2));
        expect(_readRowsValue(singleRows.first['posts']), hasLength(2));
        expect(_readRowsValue(singleRows.last['posts']), hasLength(1));
      },
    );

    test('singleQuery include avoids parent fanout by execute count', () async {
      final engine = _CountingEngine(inner: MemoryEngine());
      final client = OrmClient(
        contract: relationalContract,
        engine: engine,
        includeStrategySelector:
            ({
              required OrmContract contract,
              required String modelName,
              required OrmAction action,
              required Map<String, IncludeSpec> include,
              required int depth,
            }) => IncludeExecutionStrategy.singleQuery,
      );
      await client.connect();
      try {
        await _seedRelationalData(client);
        engine.reset();

        final rows = await client
            .model('User')
            .all(
              orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
              include: <String, IncludeSpec>{
                'posts': IncludeSpec(
                  orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                ),
              },
            );

        expect(rows, hasLength(2));
        final findManyPlans = engine.executedPlans
            .where((plan) => plan.action == OrmAction.findMany)
            .toList(growable: false);
        expect(
          findManyPlans.length,
          lessThanOrEqualTo(2),
          reason:
              'singleQuery include should execute at most one parent read '
              'and one relation read for one-to-many includes.',
        );
      } finally {
        await client.disconnect();
      }
    });

    test(
      'singleQuery include throws structured error for unsupported response shape',
      () async {
        final client = OrmClient(
          contract: relationalContract,
          engine: _BadRelatedFindManyShapeEngine(inner: MemoryEngine()),
          includeStrategySelector:
              ({
                required OrmContract contract,
                required String modelName,
                required OrmAction action,
                required Map<String, IncludeSpec> include,
                required int depth,
              }) => IncludeExecutionStrategy.singleQuery,
        );
        await client.connect();
        try {
          await _seedRelationalData(client);
          await expectLater(
            client
                .model('User')
                .all(
                  include: <String, IncludeSpec>{'posts': const IncludeSpec()},
                ),
            throwsA(isA<RuntimeResponseShapeException>()),
          );
        } finally {
          await client.disconnect();
        }
      },
    );

    test('supports include for direct mutation methods', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final posts = client.model('Post');

      final created = await posts.create(
        data: <String, Object?>{'id': 'p4', 'userId': 'u1', 'title': 'Post D'},
        include: <String, IncludeSpec>{
          'author': IncludeSpec(select: const <String>['email']),
        },
      );
      final createdAuthor = _readRowValue(created['author']);
      expect(createdAuthor?['email'], 'u1@example.com');

      final updated = await posts.update(
        where: <String, Object?>{'id': 'p4'},
        data: <String, Object?>{'title': 'Post D2'},
        include: <String, IncludeSpec>{
          'author': IncludeSpec(select: const <String>['id']),
        },
      );
      final updatedAuthor = _readRowValue(updated?['author']);
      expect(updatedAuthor?['id'], 'u1');

      final deleted = await posts.delete(
        where: <String, Object?>{'id': 'p4'},
        include: <String, IncludeSpec>{
          'author': IncludeSpec(select: const <String>['email']),
        },
      );
      final deletedAuthor = _readRowValue(deleted?['author']);
      expect(deletedAuthor?['email'], 'u1@example.com');
      await client.disconnect();
    });

    test(
      'supports explicit nested create orchestration with transaction',
      () async {
        final client = OrmClient(
          contract: relationalContract,
          engine: MemoryEngine(),
        );
        await client.connect();

        final created = await client
            .model('User')
            .createNested(
              data: <String, Object?>{'id': 'u3', 'email': 'u3@example.com'},
              create: <String, List<JsonMap>>{
                'posts': <JsonMap>[
                  <String, Object?>{'id': 'p4', 'title': 'Post D'},
                  <String, Object?>{'id': 'p5', 'title': 'Post E'},
                ],
              },
            );

        expect(created['id'], 'u3');
        final createdPosts = _readRowsValue(created['posts']);
        expect(createdPosts, hasLength(2));
        expect(createdPosts.first['userId'], 'u3');

        final persistedPosts = await client
            .model('Post')
            .all(where: <String, Object?>{'userId': 'u3'});
        expect(persistedPosts, hasLength(2));
        await client.disconnect();
      },
    );

    test('nested create rolls back when child mutation fails', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();

      await expectLater(
        client
            .model('User')
            .createNested(
              data: <String, Object?>{'id': 'u4', 'email': 'u4@example.com'},
              create: <String, List<JsonMap>>{
                'posts': <JsonMap>[
                  <String, Object?>{'id': 'p6', 'title': 'Post F', 'bad': 1},
                ],
              },
            ),
        throwsA(isA<PlanFieldNotFoundException>()),
      );

      final rolledBackUser = await client
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u4'});
      expect(rolledBackUser, isNull);
      await client.disconnect();
    });

    test(
      'updateNested updates parent and creates child rows with include payload',
      () async {
        final client = OrmClient(
          contract: relationalContract,
          engine: MemoryEngine(),
        );
        await client.connect();
        await _seedRelationalData(client);

        final updated = await client
            .model('User')
            .updateNested(
              where: <String, Object?>{'id': 'u1'},
              data: <String, Object?>{'email': 'u1+updated@example.com'},
              create: <String, List<JsonMap>>{
                'posts': <JsonMap>[
                  <String, Object?>{'id': 'p4', 'title': 'Post D'},
                ],
              },
              include: <String, IncludeSpec>{
                'posts': IncludeSpec(
                  orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                ),
              },
            );

        expect(updated, isNotNull);
        expect(updated?['email'], 'u1+updated@example.com');
        final includedPosts = _readRowsValue(updated?['posts']);
        expect(includedPosts, hasLength(3));
        expect(includedPosts.last['id'], 'p4');
        expect(includedPosts.last['userId'], 'u1');

        final persistedUser = await client
            .model('User')
            .oneOrNull(where: <String, Object?>{'id': 'u1'});
        expect(persistedUser?['email'], 'u1+updated@example.com');

        final persistedChild = await client
            .model('Post')
            .oneOrNull(where: <String, Object?>{'id': 'p4'});
        expect(persistedChild?['userId'], 'u1');
        await client.disconnect();
      },
    );

    test('updateNested returns null when parent record is missing', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);

      final updated = await client
          .model('User')
          .updateNested(
            where: <String, Object?>{'id': 'ux'},
            data: <String, Object?>{'email': 'missing@example.com'},
            create: <String, List<JsonMap>>{
              'posts': <JsonMap>[
                <String, Object?>{'id': 'p9', 'title': 'Post Missing Parent'},
              ],
            },
          );

      expect(updated, isNull);
      final createdChild = await client
          .model('Post')
          .oneOrNull(where: <String, Object?>{'id': 'p9'});
      expect(createdChild, isNull);
      await client.disconnect();
    });

    test('updateNested rolls back when child create fails', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);

      await expectLater(
        client
            .model('User')
            .updateNested(
              where: <String, Object?>{'id': 'u1'},
              data: <String, Object?>{'email': 'u1+rollback@example.com'},
              create: <String, List<JsonMap>>{
                'posts': <JsonMap>[
                  <String, Object?>{
                    'id': 'p10',
                    'title': 'Post Rollback',
                    'bad': 1,
                  },
                ],
              },
            ),
        throwsA(isA<PlanFieldNotFoundException>()),
      );

      final rolledBackUser = await client
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(rolledBackUser?['email'], 'u1@example.com');

      final rolledBackChild = await client
          .model('Post')
          .oneOrNull(where: <String, Object?>{'id': 'p10'});
      expect(rolledBackChild, isNull);
      await client.disconnect();
    });

    test(
      'supports include and includeRelation on chained query APIs',
      () async {
        final client = OrmClient(
          contract: relationalContract,
          engine: MemoryEngine(),
        );
        await client.connect();
        await _seedRelationalData(client);
        final users = client.model('User');

        final delegatedRows = await users.include(<String, IncludeSpec>{
          'posts': IncludeSpec(
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            take: 1,
          ),
        }).all();
        expect(delegatedRows, hasLength(2));
        expect(_readRowsValue(delegatedRows.first['posts']), hasLength(1));

        final base = users.query().where(<String, Object?>{'id': 'u1'});
        final withInclude = base.include(<String, IncludeSpec>{
          'posts': IncludeSpec(
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            take: 1,
          ),
        });
        final withIncludeWith = base.includeWith(
          (include) => <String, IncludeSpec>{
            ...include,
            'posts': IncludeSpec(
              orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
              take: 1,
            ),
          },
        );
        final deepMergedInclude = withIncludeWith.includeWith(
          (include) => <String, IncludeSpec>{
            ...include,
            'posts': IncludeSpec(
              include: <String, IncludeSpec>{
                'author': IncludeSpec(select: const <String>['email']),
              },
            ),
          },
        );

        expect(base.includeValues, isEmpty);
        expect(withInclude.includeValues.keys, <String>['posts']);
        expect(withIncludeWith.includeValues.keys, <String>['posts']);
        expect(withIncludeWith.includeValues['posts']?.include, isEmpty);
        final deepMergedPostsSpec = deepMergedInclude.includeValues['posts'];
        expect(deepMergedPostsSpec, isNotNull);
        expect(deepMergedPostsSpec?.take, 1);
        expect(deepMergedPostsSpec?.orderBy, hasLength(1));
        expect(deepMergedPostsSpec?.orderBy.single.field, 'id');
        expect(deepMergedPostsSpec?.include.keys, <String>['author']);
        expect(deepMergedPostsSpec?.include['author']?.select, <String>[
          'email',
        ]);
        expect(base.includeValues, isEmpty);

        final includeRow = await withInclude.oneOrNull();
        final includePosts = _readRowsValue(includeRow?['posts']);
        expect(includePosts, hasLength(1));
        expect(includePosts.single['id'], 'p1');

        final deepMergedRow = await deepMergedInclude.oneOrNull();
        final deepMergedPosts = _readRowsValue(deepMergedRow?['posts']);
        expect(deepMergedPosts, hasLength(1));
        final deepMergedAuthor = _readRowValue(
          deepMergedPosts.single['author'],
        );
        expect(deepMergedAuthor?['email'], 'u1@example.com');

        final includeRelationRow = await users
            .where(<String, Object?>{'id': 'u1'})
            .includeRelation(
              'posts',
              spec: IncludeSpec(
                orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                include: <String, IncludeSpec>{
                  'author': IncludeSpec(select: const <String>['email']),
                },
              ),
            )
            .oneOrNull();

        final relationPosts = _readRowsValue(includeRelationRow?['posts']);
        expect(relationPosts, hasLength(2));
        final relationAuthor = _readRowValue(relationPosts.first['author']);
        expect(relationAuthor?['email'], 'u1@example.com');
        await client.disconnect();
      },
    );

    test(
      'supports IncludeSpec.includeWith deep-merge and replace behaviors',
      () {
        final base = IncludeSpec(
          include: <String, IncludeSpec>{
            'author': IncludeSpec(
              include: <String, IncludeSpec>{
                'posts': IncludeSpec(select: const <String>['id']),
              },
            ),
          },
        );

        final merged = base.includeWith(
          (include) => <String, IncludeSpec>{
            ...include,
            'author': IncludeSpec(
              include: <String, IncludeSpec>{
                'profile': IncludeSpec(select: const <String>['email']),
              },
            ),
          },
        );

        expect(base.include['author']?.include.keys, <String>['posts']);
        final mergedAuthor = merged.include['author'];
        expect(mergedAuthor, isNotNull);
        expect(mergedAuthor?.include.keys.toSet(), <String>{
          'posts',
          'profile',
        });
        expect(mergedAuthor?.include['profile']?.select, <String>['email']);

        final replaced = base.includeWith(
          (_) => <String, IncludeSpec>{
            'author': IncludeSpec(
              include: <String, IncludeSpec>{
                'profile': IncludeSpec(select: const <String>['email']),
              },
            ),
          },
          merge: false,
        );

        final replacedAuthor = replaced.include['author'];
        expect(replacedAuthor, isNotNull);
        expect(replacedAuthor?.include.keys, <String>['profile']);
        expect(base.include['author']?.include.keys, <String>['posts']);
      },
    );

    test('supports nested include for relation traversal', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);

      final row = await client
          .model('Post')
          .oneOrNull(
            where: <String, Object?>{'id': 'p1'},
            include: <String, IncludeSpec>{
              'author': IncludeSpec(
                select: const <String>['id', 'email'],
                include: <String, IncludeSpec>{
                  'posts': IncludeSpec(
                    orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                    select: const <String>['id'],
                  ),
                },
              ),
            },
          );

      final author = _readRowValue(row?['author']);
      expect(author?['id'], 'u1');
      expect(author?['email'], 'u1@example.com');

      final authorPosts = _readRowsValue(author?['posts']);
      expect(authorPosts, hasLength(2));
      expect(authorPosts.first['id'], 'p1');
      expect(authorPosts.last['id'], 'p2');
      await client.disconnect();
    });

    test('throws when include relation is missing on model', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);

      await expectLater(
        client
            .model('User')
            .all(
              include: <String, IncludeSpec>{'unknown': const IncludeSpec()},
            ),
        throwsA(isA<IncludeRelationNotFoundException>()),
      );
      await client.disconnect();
    });

    test('throws when nested include depth exceeds configured limit', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
        maxIncludeDepth: 1,
      );
      await client.connect();
      await _seedRelationalData(client);

      await expectLater(
        client
            .model('User')
            .all(
              include: <String, IncludeSpec>{
                'posts': IncludeSpec(
                  include: <String, IncludeSpec>{'author': const IncludeSpec()},
                ),
              },
            ),
        throwsA(isA<IncludeDepthExceededException>()),
      );
      await client.disconnect();
    });

    test('keeps root select shape when include is present', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);

      final row = await client
          .model('User')
          .oneOrNull(
            where: <String, Object?>{'id': 'u1'},
            select: const <String>['email'],
            include: <String, IncludeSpec>{
              'posts': IncludeSpec(select: const <String>['title']),
            },
          );

      expect(row, isNotNull);
      expect(row?.containsKey('email'), isTrue);
      expect(row?.containsKey('posts'), isTrue);
      expect(row?.containsKey('id'), isFalse);

      final posts = _readRowsValue(row?['posts']);
      expect(posts, hasLength(2));
      expect(posts.first.containsKey('title'), isTrue);
      expect(posts.first.containsKey('userId'), isFalse);
      await client.disconnect();
    });

    test('calls include strategy selector during include execution', () async {
      var callCount = 0;
      final callModels = <String>[];
      final callDepths = <int>[];
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
        includeStrategySelector:
            ({
              required OrmContract contract,
              required String modelName,
              required OrmAction action,
              required Map<String, IncludeSpec> include,
              required int depth,
            }) {
              callCount += 1;
              callModels.add(modelName);
              callDepths.add(depth);
              return IncludeExecutionStrategy.multiQuery;
            },
      );
      await client.connect();
      await _seedRelationalData(client);

      await client
          .model('User')
          .all(include: <String, IncludeSpec>{'posts': const IncludeSpec()});

      expect(callCount, greaterThan(0));
      expect(callModels.first, 'User');
      expect(callDepths.first, 0);
      await client.disconnect();
    });

    test('supports custom collection registration and caching', () async {
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        collections: <String, CollectionFactory>{
          'users':
              ({required OrmModelContext client, required String modelName}) {
                return _UsersCollection(client: client, modelName: modelName);
              },
        },
      );
      await client.connect();

      final first = client.collection('users');
      final second = client.model('User');

      expect(first, same(second));
      expect(first, isA<_UsersCollection>());
      await client.disconnect();
    });

    test('supports runtime connection and transaction APIs', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final connection = await client.connection();
      await connection.execute(
        OrmPlan(
          contractHash: contract.hash,
          model: 'User',
          action: OrmAction.create,
          data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
        ),
      );

      final transaction = await connection.transaction();
      await transaction.execute(
        OrmPlan(
          contractHash: contract.hash,
          model: 'User',
          action: OrmAction.update,
          where: <String, Object?>{'id': 'u1'},
          data: <String, Object?>{'email': 'b@example.com'},
        ),
      );
      await transaction.commit();
      await connection.release();

      final row = await client
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'b@example.com');
      await client.disconnect();
    });

    test('withConnection exposes scoped model delegates', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await client.withConnection((connection) async {
        await connection
            .model('User')
            .create(
              data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
            );
      });

      final row = await client
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'a@example.com');
      await client.disconnect();
    });

    test('withConnection exposes scoped sql api', () async {
      final engine = _TrackingConnectionEngine();
      final client = OrmClient(contract: contract, engine: engine);
      await client.connect();

      await client.withConnection((connection) async {
        final rows = await connection.sql.from('User').take(1).query();
        expect(rows, isEmpty);
      });

      expect(engine.connectionCount, 1);
      expect(engine.connectionExecutePlans, hasLength(1));
      expect(engine.connectionExecutePlans.single.action, OrmAction.findMany);
      expect(engine.connectionExecutePlans.single.take, 1);
      await client.disconnect();
    });

    test(
      'withConnection executes callback and always releases connection',
      () async {
        final engine = _TrackingConnectionEngine();
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        await client.withConnection((connection) async {
          final rows = await connection.model('User').all();
          expect(rows, isEmpty);
        });

        expect(engine.connectionCount, 1);
        expect(engine.connectionExecutePlans, hasLength(1));
        expect(engine.connectionExecutePlans.single.action, OrmAction.findMany);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test('withTransaction commits on success', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await client.withTransaction((transaction) async {
        await transaction
            .model('User')
            .create(
              data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
            );
      });

      final row = await client
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'a@example.com');
      await client.disconnect();
    });

    test('withTransaction exposes scoped sql api', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await client.withTransaction((transaction) async {
        await transaction.sql.insertInto('User').values(<String, Object?>{
          'id': 'u1',
          'email': 'a@example.com',
        }).execute();
      });

      final row = await client
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'a@example.com');
      await client.disconnect();
    });

    test(
      'withTransaction success branch commits and releases connection',
      () async {
        final engine = _TrackingConnectionEngine();
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        await client.withTransaction((transaction) async {
          final rows = await transaction.model('User').all();
          expect(rows, isEmpty);
        });

        expect(engine.connectionCount, 1);
        expect(engine.transactionCount, 1);
        expect(engine.transactionExecutePlans, hasLength(1));
        expect(
          engine.transactionExecutePlans.single.action,
          OrmAction.findMany,
        );
        expect(engine.commitCount, 1);
        expect(engine.rollbackCount, 0);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test('withTransaction rolls back on error', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        () => client.withTransaction((transaction) async {
          await transaction
              .model('User')
              .create(
                data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
              );
          throw StateError('stop');
        }),
        throwsA(isA<StateError>()),
      );

      final row = await client
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row, isNull);
      await client.disconnect();
    });

    test(
      'withTransaction error branch rolls back and releases connection',
      () async {
        final engine = _TrackingConnectionEngine();
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        await expectLater(
          () => client.withTransaction((transaction) async {
            await transaction.model('User').all();
            throw StateError('stop');
          }),
          throwsA(isA<StateError>()),
        );

        expect(engine.connectionCount, 1);
        expect(engine.transactionCount, 1);
        expect(engine.transactionExecutePlans, hasLength(1));
        expect(
          engine.transactionExecutePlans.single.action,
          OrmAction.findMany,
        );
        expect(engine.commitCount, 0);
        expect(engine.rollbackCount, 1);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test(
      'throws RuntimeConnectionNotSupportedException when engine has no connection support',
      () async {
        final client = OrmClient(contract: contract, engine: _ThrowingEngine());
        await client.connect();

        await expectLater(
          client.withConnection((_) async => null),
          throwsA(isA<RuntimeConnectionNotSupportedException>()),
        );
        await expectLater(
          client.withTransaction((_) async => null),
          throwsA(isA<RuntimeConnectionNotSupportedException>()),
        );
        await client.disconnect();
      },
    );

    test('rollback keeps original data in transaction API', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.model('User');

      await users.create(
        data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
      );

      final connection = await client.connection();
      final transaction = await connection.transaction();
      await transaction.execute(
        OrmPlan(
          contractHash: contract.hash,
          model: 'User',
          action: OrmAction.update,
          where: <String, Object?>{'id': 'u1'},
          data: <String, Object?>{'email': 'b@example.com'},
        ),
      );
      await transaction.rollback();
      await connection.release();

      final row = await users.oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'a@example.com');
      await client.disconnect();
    });

    test('validates connection and transaction lifecycle states', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final connection = await client.connection();
      await connection.release();
      expect(
        () => connection.execute(
          OrmPlan(
            contractHash: contract.hash,
            model: 'User',
            action: OrmAction.findMany,
          ),
        ),
        throwsA(isA<RuntimeConnectionReleasedException>()),
      );

      final connection2 = await client.connection();
      final transaction = await connection2.transaction();
      await transaction.commit();
      expect(
        () => transaction.execute(
          OrmPlan(
            contractHash: contract.hash,
            model: 'User',
            action: OrmAction.findMany,
          ),
        ),
        throwsA(isA<RuntimeTransactionCompletedException>()),
      );
      await connection2.release();
      await client.disconnect();
    });

    test('records telemetry for successful execution', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      await client.model('User').all();

      final telemetry = client.telemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.model, 'User');
      expect(telemetry?.action, OrmAction.findMany);
      expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
      await client.disconnect();
    });

    test('verify mode startup checks marker at connect once', () async {
      var readCount = 0;
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        verify: RuntimeVerifyOptions(
          mode: RuntimeVerifyMode.startup,
          requireMarker: true,
          markerReader: CallbackMarkerReader(() async {
            readCount += 1;
            return contract.hash;
          }),
        ),
      );

      await client.connect();
      expect(readCount, 1);

      await client.model('User').all();
      await client.model('User').all();
      expect(readCount, 1);
      await client.disconnect();
    });

    test(
      'verify mode onFirstUse checks marker once on first execution',
      () async {
        var readCount = 0;
        final client = OrmClient(
          contract: contract,
          engine: MemoryEngine(),
          verify: RuntimeVerifyOptions(
            mode: RuntimeVerifyMode.onFirstUse,
            requireMarker: true,
            markerReader: CallbackMarkerReader(() async {
              readCount += 1;
              return contract.hash;
            }),
          ),
        );

        await client.connect();
        expect(readCount, 0);

        await client.model('User').all();
        expect(readCount, 1);
        await client.model('User').all();
        expect(readCount, 1);
        await client.disconnect();
      },
    );

    test('verify mode always checks marker before each execution', () async {
      var readCount = 0;
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        verify: RuntimeVerifyOptions(
          mode: RuntimeVerifyMode.always,
          requireMarker: true,
          markerReader: CallbackMarkerReader(() async {
            readCount += 1;
            return contract.hash;
          }),
        ),
      );

      await client.connect();
      await client.model('User').all();
      await client.model('User').all();

      expect(readCount, 2);
      await client.disconnect();
    });

    test('fails when marker is required but missing', () async {
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        verify: RuntimeVerifyOptions(
          mode: RuntimeVerifyMode.onFirstUse,
          requireMarker: true,
          markerReader: CallbackMarkerReader(() async => null),
        ),
      );
      await client.connect();

      await expectLater(
        client.model('User').all(),
        throwsA(isA<ContractMarkerMissingException>()),
      );
      await client.disconnect();
    });

    test('fails when marker hash does not match contract hash', () async {
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        verify: RuntimeVerifyOptions(
          mode: RuntimeVerifyMode.onFirstUse,
          requireMarker: true,
          markerReader: CallbackMarkerReader(() async => 'other-hash'),
        ),
      );
      await client.connect();

      await expectLater(
        client.model('User').all(),
        throwsA(isA<ContractMarkerMismatchException>()),
      );
      await client.disconnect();
    });

    test('rejects unknown plan fields by contract', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client
            .model('User')
            .all(
              where: <String, Object?>{
                'OR': <Object?>[
                  <String, Object?>{'id': 'u1'},
                  <String, Object?>{'email': 'a@x.com'},
                ],
              },
            ),
        completes,
      );
      await expectLater(
        client.model('User').all(where: <String, Object?>{'age': 1}),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client
            .model('User')
            .all(
              where: <String, Object?>{
                'AND': <Object?>[
                  <String, Object?>{'id': 'u1'},
                  <String, Object?>{'age': 1},
                ],
              },
            ),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.model('User').create(data: <String, Object?>{'age': 1}),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client
            .model('User')
            .all(orderBy: const <OrmOrderBy>[OrmOrderBy('age')]),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.model('User').all(select: const <String>['age']),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.model('User').all(distinct: const <String>['age']),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await client.disconnect();
    });

    test('rejects negative pagination values', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client.model('User').all(skip: -1),
        throwsA(isA<PlanInvalidPaginationException>()),
      );
      await expectLater(
        client.model('User').all(take: -1),
        throwsA(isA<PlanInvalidPaginationException>()),
      );
      await client.disconnect();
    });
  });

  test('invokes plugin hooks in order', () async {
    final plugin = _TrackingPlugin();
    final client = OrmClient(
      contract: contract,
      engine: MemoryEngine(),
      plugins: <OrmPlugin>[plugin],
    );
    await client.connect();
    await client.model('User').all();

    expect(plugin.events, <String>['before:findMany', 'after:findMany']);
    await client.disconnect();
  });

  test('db.sql invokes plugin hooks in order', () async {
    final plugin = _TrackingPlugin();
    final client = OrmClient(
      contract: contract,
      engine: MemoryEngine(),
      plugins: <OrmPlugin>[plugin],
    );
    await client.connect();
    await client.sql.from('User').query();

    expect(plugin.events, <String>['before:findMany', 'after:findMany']);
    await client.disconnect();
  });

  test('invokes onError when engine execution fails', () async {
    final plugin = _TrackingPlugin();
    final client = OrmClient(
      contract: contract,
      engine: _ThrowingEngine(),
      plugins: <OrmPlugin>[plugin],
    );
    await client.connect();

    await expectLater(client.model('User').all(), throwsA(isA<StateError>()));
    expect(plugin.events, <String>[
      'before:findMany',
      'error:findMany',
      'after:findMany',
    ]);
    expect(client.telemetry()?.outcome, RuntimeTelemetryOutcome.runtimeError);
    await client.disconnect();
  });

  test('strict mode blocks unbounded read through lints plugin', () async {
    final client = OrmClient(
      contract: contract,
      engine: MemoryEngine(),
      plugins: <OrmPlugin>[lints()],
      mode: RuntimeMode.strict,
    );
    await client.connect();

    await expectLater(
      client.model('User').all(),
      throwsA(isA<OrmRuntimeError>()),
    );
    await client.disconnect();
  });

  test('permissive mode allows warn-level lints plugin', () async {
    final logs = _CollectingLog();
    final client = OrmClient(
      contract: contract,
      engine: MemoryEngine(),
      plugins: <OrmPlugin>[
        lints(
          options: const LintsOptions(
            mutationWithoutWhere: LintSeverity.warn,
            unboundedRead: LintSeverity.warn,
            uniqueWithoutWhere: LintSeverity.warn,
          ),
        ),
      ],
      mode: RuntimeMode.permissive,
      log: logs,
    );
    await client.connect();

    await client.model('User').all();
    expect(logs.warnEvents, isNotEmpty);
    await client.disconnect();
  });

  test('budgets plugin blocks when requested take exceeds maxRows', () async {
    final client = OrmClient(
      contract: contract,
      engine: MemoryEngine(),
      plugins: <OrmPlugin>[budgets(options: const BudgetsOptions(maxRows: 1))],
    );
    await client.connect();

    await expectLater(
      client.model('User').all(take: 2),
      throwsA(isA<OrmRuntimeError>()),
    );
    await client.disconnect();
  });

  test('rejects duplicate plugin names', () async {
    expect(
      () => OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        plugins: <OrmPlugin>[_TrackingPlugin(), _TrackingPlugin()],
      ),
      throwsA(isA<PluginNameDuplicateException>()),
    );
  });

  test('rejects empty plugin names', () async {
    expect(
      () => OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        plugins: const <OrmPlugin>[_EmptyNamePlugin()],
      ),
      throwsA(isA<PluginNameEmptyException>()),
    );
  });

  test('returns structured runtime response shape errors', () async {
    final client = OrmClient(contract: contract, engine: _BadShapeEngine());
    await client.connect();

    await expectLater(
      client.model('User').all(),
      throwsA(isA<RuntimeResponseShapeException>()),
    );
    await client.disconnect();
  });

  test('db.sql returns structured runtime response shape errors', () async {
    final client = OrmClient(contract: contract, engine: _BadShapeEngine());
    await client.connect();

    await expectLater(
      client.sql.from('User').query(),
      throwsA(isA<RuntimeResponseShapeException>()),
    );
    await client.disconnect();
  });
}

Future<void> _seedRelationalData(OrmClient client) async {
  final users = client.model('User');
  final posts = client.model('Post');

  await users.create(
    data: <String, Object?>{'id': 'u1', 'email': 'u1@example.com'},
  );
  await users.create(
    data: <String, Object?>{'id': 'u2', 'email': 'u2@example.com'},
  );

  await posts.create(
    data: <String, Object?>{'id': 'p1', 'userId': 'u1', 'title': 'Post A'},
  );
  await posts.create(
    data: <String, Object?>{'id': 'p2', 'userId': 'u1', 'title': 'Post B'},
  );
  await posts.create(
    data: <String, Object?>{'id': 'p3', 'userId': 'u2', 'title': 'Post C'},
  );
}

JsonMap? _readRowValue(Object? value) {
  if (value == null) {
    return null;
  }
  if (value is Map<String, Object?>) {
    return Map<String, Object?>.unmodifiable(value);
  }
  if (value is Map<Object?, Object?>) {
    return Map<String, Object?>.unmodifiable(
      value.map((key, item) => MapEntry(key.toString(), item)),
    );
  }
  fail('Expected row map but got ${value.runtimeType}.');
}

List<JsonMap> _readRowsValue(Object? value) {
  if (value == null) {
    return const <JsonMap>[];
  }
  if (value is! List<Object?>) {
    fail('Expected row list but got ${value.runtimeType}.');
  }

  final rows = <JsonMap>[];
  for (final entry in value) {
    final row = _readRowValue(entry);
    if (row == null) {
      fail('Expected row map entry but got null.');
    }
    rows.add(row);
  }
  return List<JsonMap>.unmodifiable(rows);
}

final class _TrackingPlugin extends OrmPlugin {
  final List<String> events = <String>[];

  @override
  String get name => 'tracking';

  @override
  void beforeExecute(OrmPlan plan, PluginContext ctx) {
    events.add('before:${plan.action.name}');
  }

  @override
  void afterExecute(
    OrmPlan plan,
    AfterExecuteResult result,
    PluginContext ctx,
  ) {
    events.add('after:${plan.action.name}');
  }

  @override
  void onError(
    OrmPlan plan,
    Object error,
    StackTrace stackTrace,
    PluginContext ctx,
  ) {
    events.add('error:${plan.action.name}');
  }
}

final class _ThrowingEngine implements OrmEngine {
  @override
  Future<void> close() async {}

  @override
  Future<EngineResponse> execute(OrmPlan plan) {
    throw StateError('boom');
  }

  @override
  Future<void> open() async {}
}

final class _BadShapeEngine implements OrmEngine {
  @override
  Future<void> close() async {}

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    return const EngineResponse(data: 'bad-shape');
  }

  @override
  Future<void> open() async {}
}

final class _NoMutationReturnEngine implements OrmEngine {
  final OrmEngine inner;

  _NoMutationReturnEngine({required this.inner});

  @override
  Future<void> close() => inner.close();

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    final response = await inner.execute(plan);
    if (plan.action == OrmAction.create ||
        plan.action == OrmAction.update ||
        plan.action == OrmAction.delete) {
      return EngineResponse(affectedRows: response.affectedRows);
    }
    return response;
  }

  @override
  Future<void> open() => inner.open();
}

final class _CountingEngine implements OrmEngine {
  final OrmEngine inner;
  var executeCount = 0;
  final List<OrmPlan> executedPlans = <OrmPlan>[];

  _CountingEngine({required this.inner});

  @override
  Future<void> close() => inner.close();

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    executeCount += 1;
    executedPlans.add(plan);
    return inner.execute(plan);
  }

  @override
  Future<void> open() => inner.open();

  void reset() {
    executeCount = 0;
    executedPlans.clear();
  }
}

final class _BadRelatedFindManyShapeEngine implements OrmEngine {
  final OrmEngine inner;
  final String relatedModel;

  _BadRelatedFindManyShapeEngine({
    required this.inner,
    this.relatedModel = 'Post',
  });

  @override
  Future<void> close() => inner.close();

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    if (plan.model == relatedModel && plan.action == OrmAction.findMany) {
      return const EngineResponse(data: 'bad-shape');
    }
    return inner.execute(plan);
  }

  @override
  Future<void> open() => inner.open();
}

final class _TrackingConnectionEngine
    implements OrmEngine, ConnectionCapableEngine {
  var connectionCount = 0;
  var transactionCount = 0;
  var releaseCount = 0;
  var commitCount = 0;
  var rollbackCount = 0;
  final List<OrmPlan> connectionExecutePlans = <OrmPlan>[];
  final List<OrmPlan> transactionExecutePlans = <OrmPlan>[];

  @override
  Future<void> close() async {}

  @override
  Future<EngineConnection> connection() async {
    connectionCount += 1;
    return _TrackingEngineConnection(this);
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    return const EngineResponse(data: <JsonMap>[]);
  }

  @override
  Future<void> open() async {}
}

final class _TrackingEngineConnection implements EngineConnection {
  final _TrackingConnectionEngine _engine;

  _TrackingEngineConnection(this._engine);

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _engine.connectionExecutePlans.add(plan);
    return const EngineResponse(data: <JsonMap>[]);
  }

  @override
  Future<void> release() async {
    _engine.releaseCount += 1;
  }

  @override
  Future<EngineTransaction> transaction() async {
    _engine.transactionCount += 1;
    return _TrackingEngineTransaction(_engine);
  }
}

final class _TrackingEngineTransaction implements EngineTransaction {
  final _TrackingConnectionEngine _engine;

  _TrackingEngineTransaction(this._engine);

  @override
  Future<void> commit() async {
    _engine.commitCount += 1;
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _engine.transactionExecutePlans.add(plan);
    return const EngineResponse(data: <JsonMap>[]);
  }

  @override
  Future<void> rollback() async {
    _engine.rollbackCount += 1;
  }
}

final class _EmptyNamePlugin extends OrmPlugin {
  const _EmptyNamePlugin();

  @override
  String get name => '   ';
}

final class _UsersCollection extends ModelDelegate {
  _UsersCollection({required super.client, required super.modelName});
}

final class _CollectingLog implements RuntimeLog {
  final List<Object?> infoEvents = <Object?>[];
  final List<Object?> warnEvents = <Object?>[];
  final List<Object?> errorEvents = <Object?>[];

  @override
  void error(Object? event) {
    errorEvents.add(event);
  }

  @override
  void info(Object? event) {
    infoEvents.add(event);
  }

  @override
  void warn(Object? event) {
    warnEvents.add(event);
  }
}
