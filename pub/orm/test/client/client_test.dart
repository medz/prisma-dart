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

  final selfRelationalContract = OrmContract(
    version: '1',
    hash: 'contract-self-rel-v1',
    models: <String, ModelContract>{
      'User': ModelContract(
        name: 'User',
        table: 'users',
        fields: <String>{'id', 'email', 'invitedById'},
        relations: <String, ModelRelationContract>{
          'invitedUsers': ModelRelationContract(
            name: 'invitedUsers',
            relatedModel: 'User',
            sourceFields: <String>['id'],
            targetFields: <String>['invitedById'],
            cardinality: RelationCardinality.many,
          ),
          'invitedBy': ModelRelationContract(
            name: 'invitedBy',
            relatedModel: 'User',
            sourceFields: <String>['invitedById'],
            targetFields: <String>['id'],
            cardinality: RelationCardinality.one,
          ),
        },
      ),
    },
    aliases: <String, String>{'users': 'User'},
  );
  group('OrmClient + MemoryEngine', () {
    test('default include strategy selector follows contract capabilities', () {
      final multi = defaultIncludeExecutionStrategySelector(
        contract: contract,
        modelName: 'User',
        action: OrmAction.read,
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
        action: OrmAction.read,
        include: const <String, IncludeSpec>{'posts': IncludeSpec()},
        depth: 0,
      );
      expect(single, IncludeExecutionStrategy.singleQuery);
    });

    test('runs CRUD flow', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final users = client.db.orm.model('User');
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
      final users = client.db.orm.model('User');

      await expectLater(
        users.all(),
        throwsA(isA<ClientNotConnectedException>()),
      );
    });

    test('supports db.sql select and mutation builders', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final insertResult = await client.db.sql
          .insertInto('User')
          .values(<String, Object?>{'id': 'u1', 'email': 'a@example.com'})
          .returning(const <String>['id', 'email'])
          .execute();
      expect(insertResult.affectedRows, 1);
      expect(insertResult.row?['id'], 'u1');

      final selectedRows = await client.db.sql
          .from('User')
          .where(<String, Object?>{'id': 'u1'})
          .select(const <String>['email'])
          .all();
      expect(selectedRows, hasLength(1));
      expect(selectedRows.single['email'], 'a@example.com');

      final updated = await client.db.sql
          .update('User')
          .where(<String, Object?>{'id': 'u1'})
          .set(<String, Object?>{'email': 'b@example.com'})
          .returning(const <String>['email'])
          .execute();
      expect(updated.affectedRows, 1);
      expect(updated.row?['email'], 'b@example.com');

      final deleted = await client.db.sql
          .deleteFrom('User')
          .where(<String, Object?>{'id': 'u1'})
          .returning(const <String>['id'])
          .execute();
      expect(deleted.affectedRows, 1);
      expect(deleted.row?['id'], 'u1');

      final remaining = await client.db.sql.from('User').all();
      expect(remaining, isEmpty);
      await client.disconnect();
    });

    test('db.sql requires explicit connect', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await expectLater(
        client.db.sql.from('User').all(),
        throwsA(isA<ClientNotConnectedException>()),
      );
    });

    test('supports db namespace for orm and sql access', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      final users = client.db.orm.model('User');
      await users.create(
        data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
      );

      final sqlRow = await client.db.sql.from('User').where(<String, Object?>{
        'id': 'u1',
      }).firstOrNull();
      expect(sqlRow?['email'], 'a@example.com');

      final ormRow = await client.db.orm
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(ormRow?['id'], 'u1');
      await client.disconnect();
    });

    test('requires exact model names on orm and sql roots', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      expect(
        () => client.db.orm.model('users'),
        throwsA(isA<ModelNotFoundException>()),
      );
      expect(
        () => client.db.sql.from('users'),
        throwsA(isA<ModelNotFoundException>()),
      );

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
            action: OrmAction.read,
            read: OrmReadPlan(resultMode: OrmReadResultMode.all),
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
              action: OrmAction.read,
              read: OrmReadPlan(resultMode: OrmReadResultMode.all),
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
              action: OrmAction.read,
              read: OrmReadPlan(resultMode: OrmReadResultMode.all),
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
              action: OrmAction.read,
              read: OrmReadPlan(resultMode: OrmReadResultMode.all),
            ),
          ),
          throwsA(isA<PlanProfileHashMismatchException>()),
        );
        await client.disconnect();
      },
    );

    test('rejects invalid plan result mode and action combinations', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client.execute(
          OrmPlan(
            contractHash: contract.hash,
            model: 'User',
            action: OrmAction.read,
            read: OrmReadPlan(resultMode: OrmReadResultMode.all),
            mutation: OrmMutationPlan(
              resultMode: OrmMutationResultMode.rowOrNull,
            ),
          ),
        ),
        throwsA(
          isA<PlanResultModeActionInvalidException>().having(
            (error) => error.code,
            'code',
            'PLAN.RESULT_MODE_ACTION_INVALID',
          ),
        ),
      );

      for (final action in <OrmAction>[
        OrmAction.create,
        OrmAction.update,
        OrmAction.delete,
      ]) {
        await expectLater(
          client.execute(
            OrmPlan(
              contractHash: contract.hash,
              model: 'User',
              action: action,
              read: OrmReadPlan(resultMode: OrmReadResultMode.oneOrNull),
              mutation: OrmMutationPlan(
                resultMode: OrmMutationResultMode.rowOrNull,
              ),
            ),
          ),
          throwsA(
            isA<PlanResultModeActionInvalidException>().having(
              (error) => error.code,
              'code',
              'PLAN.RESULT_MODE_ACTION_INVALID',
            ),
          ),
        );
      }

      await expectLater(
        client.execute(
          OrmPlan(
            contractHash: contract.hash,
            model: 'User',
            action: OrmAction.read,
          ),
        ),
        throwsA(isA<PlanResultModeActionInvalidException>()),
      );

      await expectLater(
        client.execute(
          OrmPlan(
            contractHash: contract.hash,
            model: 'User',
            action: OrmAction.update,
          ),
        ),
        throwsA(isA<PlanResultModeActionInvalidException>()),
      );

      await client.disconnect();
    });

    test(
      'rejects legacy and invalid typed repository trace metadata',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();

        await expectLater(
          client.execute(
            OrmPlan.read(
              contractHash: contract.hash,
              model: 'User',
              resultMode: OrmReadResultMode.all,
              annotations: const <String, Object?>{
                'repository': <String, Object?>{'operationId': 'legacy'},
              },
            ),
          ),
          throwsA(
            isA<PlanRepositoryTraceInvalidException>().having(
              (error) => error.details['reason'],
              'reason',
              'legacyAnnotation',
            ),
          ),
        );

        await expectLater(
          client.execute(
            OrmPlan.read(
              contractHash: contract.hash,
              model: 'User',
              resultMode: OrmReadResultMode.all,
              repositoryTrace: const OrmRepositoryTrace(
                operationId: '',
                kind: 'User.include',
                step: 1,
                phase: 'include.load',
                strategy: 'multiQuery',
              ),
            ),
          ),
          throwsA(
            isA<PlanRepositoryTraceInvalidException>().having(
              (error) => error.details['reason'],
              'reason',
              'operationIdEmpty',
            ),
          ),
        );

        await client.disconnect();
      },
    );

    test('supports ordering and pagination in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

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
        final users = client.db.orm.model('User');

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

        final distinctStreamRows = await users
            .query()
            .orderByField('id')
            .distinctField('email')
            .skip(1)
            .take(1)
            .stream()
            .toList();
        expect(
          distinctStreamRows.map((row) => row['id']).toList(growable: false),
          <Object?>['u3'],
        );

        final firstDistinctRow = await users.firstOrNull(
          orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
          distinct: const <String>['email'],
          skip: 1,
        );
        expect(firstDistinctRow?['id'], 'u3');
        await client.disconnect();
      },
    );

    test('supports aggregate helpers in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': null});
      await users.create(data: <String, Object?>{'id': 3, 'email': 'b@x.com'});

      final aggregate = await users.aggregate(
        build: (aggregate) => aggregate
            .countAll()
            .count('email')
            .min('id')
            .max('id')
            .sum('id')
            .avg('id'),
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
      final users = client.db.orm.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 4, 'email': 'b@x.com'});

      final grouped = await users
          .query()
          .groupedBy(const <String>['email'])
          .aggregate((aggregate) => aggregate.countAll().sum('id').avg('id'));

      expect(grouped, hasLength(2));
      final groupedByEmail = <String, JsonMap>{
        for (final row in grouped) row['email']! as String: row,
      };
      expect(groupedByEmail['a@x.com']?['count'], <String, Object?>{'all': 2});
      expect(groupedByEmail['a@x.com']?['sum'], <String, Object?>{'id': 3});
      expect(groupedByEmail['a@x.com']?['avg'], <String, Object?>{'id': 1.5});
      expect(groupedByEmail['b@x.com']?['count'], <String, Object?>{'all': 1});
      expect(groupedByEmail['b@x.com']?['sum'], <String, Object?>{'id': 4});
      expect(groupedByEmail['b@x.com']?['avg'], <String, Object?>{'id': 4.0});
      await client.disconnect();
    });

    test('supports groupBy having filters in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 10, 'email': 'b@x.com'});
      await users.create(data: <String, Object?>{'id': 20, 'email': 'b@x.com'});
      await users.create(data: <String, Object?>{'id': 5, 'email': 'c@x.com'});

      final grouped = await users
          .query()
          .groupedBy(const <String>['email'])
          .havingExpr((having) => having.countAll().gte(2), merge: false)
          .aggregate((aggregate) => aggregate.countAll().sum('id'));

      expect(grouped, hasLength(2));
      final groupedByEmail = <String, JsonMap>{
        for (final row in grouped) row['email']! as String: row,
      };
      expect(groupedByEmail['a@x.com']?['count'], <String, Object?>{'all': 2});
      expect(groupedByEmail['a@x.com']?['sum'], <String, Object?>{'id': 3});
      expect(groupedByEmail['b@x.com']?['count'], <String, Object?>{'all': 2});
      expect(groupedByEmail['b@x.com']?['sum'], <String, Object?>{'id': 30});
      await client.disconnect();
    });

    test('supports builder-style groupBy having expressions', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 3, 'email': 'b@x.com'});

      final grouped = await users
          .query()
          .groupedBy(const <String>['email'])
          .havingExpr(
            (having) => having.or(<OrmGroupByHaving>[
              having.countAll().gte(2),
              having.sum('id').gte(3),
            ]),
            merge: false,
          )
          .aggregate((aggregate) => aggregate.countAll().sum('id'));

      expect(grouped, hasLength(2));
      await client.disconnect();
    });

    test('merges repeated groupBy having clauses with AND semantics', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 2, 'email': 'a@x.com'});
      await users.create(data: <String, Object?>{'id': 10, 'email': 'b@x.com'});
      await users.create(data: <String, Object?>{'id': 20, 'email': 'b@x.com'});
      await users.create(data: <String, Object?>{'id': 30, 'email': 'b@x.com'});

      final grouped = await users
          .query()
          .groupedBy(const <String>['email'])
          .havingExpr((having) => having.countAll().gte(2), merge: false)
          .havingExpr((having) => having.countAll().lte(2))
          .aggregate((aggregate) => aggregate.countAll().sum('id'));

      expect(grouped, hasLength(1));
      expect(grouped.single['email'], 'a@x.com');
      expect(grouped.single['count'], <String, Object?>{'all': 2});
      await client.disconnect();
    });

    test('rejects groupedBy when row-query state is already present', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      expect(
        () => users.query().orderByField('email').groupedBy(const <String>[
          'email',
        ]),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.GROUP_BY_QUERY_STATE_INVALID',
          ),
        ),
      );
      await client.disconnect();
    });

    test('aggregate rejects unsupported row-query state keys', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users
            .query()
            .select(const <String>['id'])
            .aggregate((aggregate) => aggregate.countAll()),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.AGGREGATE_QUERY_STATE_INVALID',
          ),
        ),
      );
    });

    test('rejects invalid groupBy having aggregate fields', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.create(data: <String, Object?>{'id': 1, 'email': 'a@x.com'});

      await expectLater(
        users
            .groupedBy(const <String>['email'])
            .havingExpr((having) => having.sum('email').gte(1), merge: false)
            .aggregate((aggregate) => aggregate.sum('id')),
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

    test('rejects unsupported grouped having operators', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await expectLater(
        users
            .groupedBy(const <String>['email'])
            .having(
              OrmGroupByHaving.parse(const <String, Object?>{
                '_count': <String, Object?>{
                  'all': <String, Object?>{'in': <int>[1, 2]},
                },
              }),
              merge: false,
            )
            .aggregate((aggregate) => aggregate.countAll()),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.GROUP_BY_HAVING_OPERATOR_INVALID',
          ),
        ),
      );
      await client.disconnect();
    });

    test('aggregate rejects empty aggregate builder', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users.query().aggregate((aggregate) => aggregate),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.AGGREGATE_FIELDS_EMPTY',
          ),
        ),
      );
    });

    test('supports where operators gt/in/notIn in memory engine', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

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
        final users = client.db.orm.model('User');

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
        final users = client.db.orm.model('User');

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
        final users = client.db.orm.model('User');

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
      final users = client.db.orm.model('User');

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
      'query toPlan emits orm lane metadata and structured include plan',
      () async {
        final client = OrmClient(
          contract: relationalContract,
          engine: MemoryEngine(),
        );
        final users = client.db.orm.model('User');

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
        expect(plan.action, OrmAction.read);
        expect(plan.read?.take, 5);
        expect(plan.read?.resultMode, OrmReadResultMode.all);
        expect(plan.read?.include.keys, <String>['posts']);
        final posts = plan.read?.include['posts'];
        expect(posts, isNotNull);
        expect(posts?.take, 3);
        expect(posts?.include.keys, <String>['author']);
        expect(posts?.include['author']?.select, <String>['email']);
      },
    );

    test('emits structured mutation plans for orm and sql writes', () async {
      final engine = _CountingEngine(inner: MemoryEngine());
      final client = OrmClient(contract: contract, engine: engine);
      await client.connect();

      await client.db.orm
          .model('User')
          .create(data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'});
      final createPlan = engine.executedPlans.single;
      expect(createPlan.lane, 'orm');
      expect(createPlan.action, OrmAction.create);
      expect(createPlan.mutation?.resultMode, OrmMutationResultMode.row);

      engine.reset();
      await client.db.orm
          .model('User')
          .update(
            where: <String, Object?>{'id': 'u1'},
            data: <String, Object?>{'email': 'b@x.com'},
          );
      final updatePlan = engine.executedPlans.single;
      expect(updatePlan.lane, 'orm');
      expect(updatePlan.action, OrmAction.update);
      expect(updatePlan.mutation?.resultMode, OrmMutationResultMode.rowOrNull);

      final sqlPlan = client.db.sql
          .update('User')
          .where(<String, Object?>{'id': 'u1'})
          .set(<String, Object?>{'email': 'c@x.com'})
          .toPlan();
      expect(sqlPlan.lane, 'sql');
      expect(sqlPlan.action, OrmAction.update);
      expect(sqlPlan.mutation?.resultMode, OrmMutationResultMode.rowOrNull);

      await client.disconnect();
    });

    test('supports select projection through chained query state', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

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
      final users = client.db.orm.model('User');

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
      final users = client.db.orm.model('User');

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
      final users = client.db.orm.model('User');

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

    test('rejects unsupported query state on mutation terminals', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      expect(
        () => users
            .where(<String, Object?>{'id': 'u1'})
            .create(data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'}),
        throwsA(
          isA<OrmRuntimeError>()
              .having(
                (error) => error.code,
                'code',
                'PLAN.MUTATION_QUERY_STATE_INVALID',
              )
              .having(
                (error) => error.details['invalidKeys'],
                'invalidKeys',
                <String>['where'],
              ),
        ),
      );

      expect(
        () => users
            .where(<String, Object?>{'id': 'u1'})
            .orderByField('email')
            .update(data: <String, Object?>{'email': 'b@x.com'}),
        throwsA(
          isA<OrmRuntimeError>()
              .having(
                (error) => error.code,
                'code',
                'PLAN.MUTATION_QUERY_STATE_INVALID',
              )
              .having(
                (error) => error.details['invalidKeys'],
                'invalidKeys',
                <String>['orderBy'],
              ),
        ),
      );

      expect(
        () => users.take(1).deleteCount(),
        throwsA(
          isA<OrmRuntimeError>()
              .having(
                (error) => error.code,
                'code',
                'PLAN.MUTATION_QUERY_STATE_INVALID',
              )
              .having(
                (error) => error.details['invalidKeys'],
                'invalidKeys',
                <String>['take'],
              ),
        ),
      );

      expect(
        () => users
            .select(const <String>['id'])
            .updateCount(data: <String, Object?>{'email': 'b@x.com'}),
        throwsA(
          isA<OrmRuntimeError>()
              .having(
                (error) => error.code,
                'code',
                'PLAN.MUTATION_QUERY_STATE_INVALID',
              )
              .having(
                (error) => error.details['invalidKeys'],
                'invalidKeys',
                <String>['select'],
              ),
        ),
      );

      expect(
        () => users
            .include(<String, IncludeSpec>{'posts': const IncludeSpec()})
            .deleteCount(),
        throwsA(
          isA<OrmRuntimeError>()
              .having(
                (error) => error.code,
                'code',
                'PLAN.MUTATION_QUERY_STATE_INVALID',
              )
              .having(
                (error) => error.details['invalidKeys'],
                'invalidKeys',
                <String>['include'],
              ),
        ),
      );

      expect(
        () => users.query().updateCount(data: <String, Object?>{'email': 'b@x.com'}),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.MUTATION_WHERE_REQUIRED',
          ),
        ),
      );

      expect(
        () => users.query().deleteCount(),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.MUTATION_WHERE_REQUIRED',
          ),
        ),
      );

      await client.disconnect();
    });

    test('supports upsert create and update branches', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

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

    test('supports batch mutation helpers', () async {
      final engine = _CountingEngine(inner: MemoryEngine());
      final client = OrmClient(contract: contract, engine: engine);
      await client.connect();
      final users = client.db.orm.model('User');

      final createdRows = await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u3', 'email': 'b@x.com'},
        ],
      );
      expect(createdRows, hasLength(3));
      expect(
        engine.executedPlans.map((plan) => plan.action).toList(growable: false),
        <OrmAction>[OrmAction.create, OrmAction.create, OrmAction.create],
      );
      final createTraces = engine.executedPlans
          .map(_readRepositoryTrace)
          .toList(growable: false);
      final createOperationId = createTraces.first.operationId;
      expect(createOperationId, isNotNull);
      expect(createTraces.map((trace) => trace.operationId).toSet(), <String>{
        createOperationId,
      });
      expect(
        createTraces.map((trace) => trace.kind).toList(growable: false),
        <String>['User.createMany', 'User.createMany', 'User.createMany'],
      );
      expect(
        createTraces.map((trace) => trace.phase).toList(growable: false),
        <String>['item.create', 'item.create', 'item.create'],
      );
      expect(
        createTraces.map((trace) => trace.strategy).toList(growable: false),
        <String>['transaction', 'transaction', 'transaction'],
      );
      expect(
        createTraces.map((trace) => trace.step).toList(growable: false),
        <int>[1, 2, 3],
      );
      expect(
        createTraces.map((trace) => trace.itemIndex).toList(growable: false),
        <int?>[0, 1, 2],
      );

      engine.reset();
      final updatedRows = await users
          .query()
          .where(<String, Object?>{'email': 'a@x.com'})
          .select(const <String>['id', 'email'])
          .updateAll(data: <String, Object?>{'email': 'updated@x.com'});
      expect(updatedRows, hasLength(2));
      expect(
        engine.executedPlans.map((plan) => plan.action).toList(growable: false),
        <OrmAction>[OrmAction.read, OrmAction.update, OrmAction.update],
      );
      final updateAllTraces = engine.executedPlans
          .map(_readRepositoryTrace)
          .toList(growable: false);
      final updateAllOperationId = updateAllTraces.first.operationId;
      expect(updateAllOperationId, isNotNull);
      expect(
        updateAllTraces.map((trace) => trace.operationId).toSet(),
        <String>{updateAllOperationId},
      );
      expect(
        updateAllTraces.map((trace) => trace.kind).toList(growable: false),
        <String>['User.updateAll', 'User.updateAll', 'User.updateAll'],
      );
      expect(
        updateAllTraces.map((trace) => trace.phase).toList(growable: false),
        <String>['batch.lookup', 'item.update', 'item.update'],
      );
      expect(
        updateAllTraces.map((trace) => trace.itemIndex).toList(growable: false),
        <int?>[null, 0, 1],
      );

      engine.reset();
      final updated = await users.updateCount(
        where: <String, Object?>{'email': 'updated@x.com'},
        data: <String, Object?>{'email': 'counted@x.com'},
      );
      expect(updated, 2);
      expect(
        engine.executedPlans.map((plan) => plan.action).toList(growable: false),
        <OrmAction>[OrmAction.read, OrmAction.update, OrmAction.update],
      );
      final updateTraces = engine.executedPlans
          .map(_readRepositoryTrace)
          .toList(growable: false);
      final updateOperationId = updateTraces.first.operationId;
      expect(updateOperationId, isNotNull);
      expect(updateTraces.map((trace) => trace.operationId).toSet(), <String>{
        updateOperationId,
      });
      expect(
        updateTraces.map((trace) => trace.kind).toList(growable: false),
        <String>['User.updateCount', 'User.updateCount', 'User.updateCount'],
      );
      expect(
        updateTraces.map((trace) => trace.phase).toList(growable: false),
        <String>['batch.lookup', 'item.update', 'item.update'],
      );
      expect(
        updateTraces.map((trace) => trace.strategy).toList(growable: false),
        <String>['transaction', 'transaction', 'transaction'],
      );
      expect(
        updateTraces.map((trace) => trace.step).toList(growable: false),
        <int>[1, 2, 3],
      );
      expect(
        updateTraces.map((trace) => trace.itemIndex).toList(growable: false),
        <int?>[null, 0, 1],
      );

      engine.reset();
      final deletedRows = await users
          .query()
          .where(<String, Object?>{'email': 'counted@x.com'})
          .select(const <String>['id', 'email'])
          .deleteAll();
      expect(deletedRows, hasLength(2));
      expect(
        engine.executedPlans.map((plan) => plan.action).toList(growable: false),
        <OrmAction>[OrmAction.read, OrmAction.delete, OrmAction.delete],
      );
      final deleteAllTraces = engine.executedPlans
          .map(_readRepositoryTrace)
          .toList(growable: false);
      final deleteAllOperationId = deleteAllTraces.first.operationId;
      expect(deleteAllOperationId, isNotNull);
      expect(
        deleteAllTraces.map((trace) => trace.operationId).toSet(),
        <String>{deleteAllOperationId},
      );
      expect(
        deleteAllTraces.map((trace) => trace.kind).toList(growable: false),
        <String>['User.deleteAll', 'User.deleteAll', 'User.deleteAll'],
      );
      expect(
        deleteAllTraces.map((trace) => trace.phase).toList(growable: false),
        <String>['batch.lookup', 'item.delete', 'item.delete'],
      );
      expect(
        deleteAllTraces.map((trace) => trace.itemIndex).toList(growable: false),
        <int?>[null, 0, 1],
      );

      engine.reset();
      final deleted = await users.deleteCount(
        where: <String, Object?>{'email': 'b@x.com'},
      );
      expect(deleted, 1);
      expect(
        engine.executedPlans.map((plan) => plan.action).toList(growable: false),
        <OrmAction>[OrmAction.delete, OrmAction.delete],
      );
      final deleteTraces = engine.executedPlans
          .map(_readRepositoryTrace)
          .toList(growable: false);
      final deleteOperationId = deleteTraces.first.operationId;
      expect(deleteOperationId, isNotNull);
      expect(deleteTraces.map((trace) => trace.operationId).toSet(), <String>{
        deleteOperationId,
      });
      expect(
        deleteTraces.map((trace) => trace.kind).toList(growable: false),
        <String>['User.deleteCount', 'User.deleteCount'],
      );
      expect(
        deleteTraces.map((trace) => trace.phase).toList(growable: false),
        <String>['item.delete', 'item.delete'],
      );
      expect(
        deleteTraces.map((trace) => trace.strategy).toList(growable: false),
        <String>['transaction', 'transaction'],
      );
      expect(
        deleteTraces.map((trace) => trace.step).toList(growable: false),
        <int>[1, 2],
      );
      expect(
        deleteTraces.map((trace) => trace.itemIndex).toList(growable: false),
        <int?>[0, 1],
      );

      final remaining = await users.count();
      expect(remaining, 0);
      await client.disconnect();
    });

    test('createMany_rolls_back_on_partial_failure', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

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
        final users = client.db.orm.model('User');

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
      'throws when create result is missing while mutation returning is enabled',
      () async {
        final client = OrmClient(
          contract: contract,
          engine: _NoMutationReturnEngine(inner: MemoryEngine()),
        );
        await client.connect();

        await expectLater(
          client.db.orm
              .model('User')
              .create(data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'}),
          throwsA(isA<RuntimeCreateResultMissingException>()),
        );

        await client.disconnect();
      },
    );

    test(
      'reads back updated row after write when mutation returning is disabled',
      () async {
        final noReturningContract = OrmContract(
          version: contract.version,
          hash: contract.hash,
          models: contract.models,
          aliases: contract.aliases,
          capabilities: const ContractCapabilities(mutationReturning: false),
        );
        final engine = _CountingEngine(
          inner: _NoMutationReturnEngine(inner: MemoryEngine()),
        );
        final client = OrmClient(contract: noReturningContract, engine: engine);
        await client.connect();
        final users = client.db.orm.model('User');

        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        );
        engine.reset();

        final updated = await users.update(
          where: <String, Object?>{'id': 'u1'},
          data: <String, Object?>{'email': 'b@x.com'},
          select: const <String>['id', 'email'],
        );

        expect(updated, <String, Object?>{'id': 'u1', 'email': 'b@x.com'});
        expect(
          engine.executedPlans.map((plan) => plan.action).toList(),
          <OrmAction>[OrmAction.update, OrmAction.read],
        );
        final updateTrace = _readRepositoryTrace(engine.executedPlans.first);
        final reloadTrace = _readRepositoryTrace(engine.executedPlans.last);
        expect(updateTrace.kind, 'User.update');
        expect(updateTrace.phase, 'write');
        expect(updateTrace.strategy, 'singlePlan');
        expect(updateTrace.step, 1);
        expect(reloadTrace.kind, 'User.update');
        expect(reloadTrace.phase, 'fallback.reload');
        expect(reloadTrace.strategy, 'returningDisabledFallback');
        expect(reloadTrace.step, 2);
        expect(reloadTrace.operationId, updateTrace.operationId);

        await client.disconnect();
      },
    );

    test(
      'prefetches row before delete when mutation returning is disabled',
      () async {
        final noReturningContract = OrmContract(
          version: contract.version,
          hash: contract.hash,
          models: contract.models,
          aliases: contract.aliases,
          capabilities: const ContractCapabilities(mutationReturning: false),
        );
        final engine = _CountingEngine(
          inner: _NoMutationReturnEngine(inner: MemoryEngine()),
        );
        final client = OrmClient(contract: noReturningContract, engine: engine);
        await client.connect();
        final users = client.db.orm.model('User');

        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        );
        engine.reset();

        final deleted = await users.delete(
          where: <String, Object?>{'id': 'u1'},
          select: const <String>['id', 'email'],
        );

        expect(deleted, <String, Object?>{'id': 'u1', 'email': 'a@x.com'});
        expect(
          engine.executedPlans.map((plan) => plan.action).toList(),
          <OrmAction>[OrmAction.read, OrmAction.delete],
        );
        final preloadTrace = _readRepositoryTrace(engine.executedPlans.first);
        final deleteTrace = _readRepositoryTrace(engine.executedPlans.last);
        expect(preloadTrace.kind, 'User.delete');
        expect(preloadTrace.phase, 'fallback.preload');
        expect(preloadTrace.strategy, 'returningDisabledFallback');
        expect(preloadTrace.step, 1);
        expect(deleteTrace.kind, 'User.delete');
        expect(deleteTrace.phase, 'write');
        expect(deleteTrace.strategy, 'singlePlan');
        expect(deleteTrace.step, 2);
        expect(deleteTrace.operationId, preloadTrace.operationId);

        final remaining = await users.oneOrNull(
          where: <String, Object?>{'id': 'u1'},
        );
        expect(remaining, isNull);
        await client.disconnect();
      },
    );

    test(
      'supports query state helpers for first/count/exists/upsert/deleteCount',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();

        final users = client.db.orm.model('User');
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

        final removed = await query.deleteCount();
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
        final users = client.db.orm.model('User');
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

    test('records relation where lookup traces for read operations', () async {
      final engine = _CountingEngine(inner: MemoryEngine());
      final client = OrmClient(contract: relationalContract, engine: engine);
      await client.connect();
      await _seedRelationalData(client);
      engine.reset();

      final rows = await client.db.orm
          .model('User')
          .all(
            where: <String, Object?>{
              'posts': <String, Object?>{
                'some': <String, Object?>{'title': 'Post A'},
              },
            },
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
          );

      expect(rows.map((row) => row['id']).toList(growable: false), <Object?>[
        'u1',
      ]);
      expect(
        engine.executedPlans.map((plan) => plan.model).toList(growable: false),
        <String>['Post', 'User'],
      );
      expect(
        engine.executedPlans.map((plan) => plan.action).toList(growable: false),
        <OrmAction>[OrmAction.read, OrmAction.read],
      );

      final traces = engine.executedPlans
          .map(_readRepositoryTrace)
          .toList(growable: false);
      final operationId = traces.first.operationId;
      expect(traces.map((trace) => trace.operationId).toSet(), <String>{
        operationId,
      });
      expect(
        traces.map((trace) => trace.kind).toList(growable: false),
        <String>['User.read', 'User.read'],
      );
      expect(
        traces.map((trace) => trace.phase).toList(growable: false),
        <String>['where.relationLookup', 'read.execute'],
      );
      expect(
        traces.map((trace) => trace.strategy).toList(growable: false),
        <String>['relationWhereLookup', 'relationWhereRewrite'],
      );
      expect(
        traces.map((trace) => trace.relation).toList(growable: false),
        <String?>['posts', null],
      );
      expect(traces.map((trace) => trace.step).toList(growable: false), <int>[
        1,
        2,
      ]);
      expect(client.telemetry()?.operationId, operationId);
      expect(client.telemetry()?.operationKind, 'User.read');
      expect(client.operationTelemetry(operationId)?.statementCount, 2);
      await client.disconnect();
    });

    test('supports relation where is/isNot for to-one relation', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final posts = client.db.orm.model('Post');

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

    test(
      'annotates upsert branch plans with operation sequence metadata',
      () async {
        final engine = _CountingEngine(inner: MemoryEngine());
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();
        final users = client.db.orm.model('User');

        final created = await users.upsert(
          where: <String, Object?>{'id': 'u1'},
          create: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
          update: <String, Object?>{'email': 'b@example.com'},
        );
        expect(created['email'], 'a@example.com');
        expect(
          engine.executedPlans
              .map((plan) => plan.action)
              .toList(growable: false),
          <OrmAction>[OrmAction.read, OrmAction.create],
        );
        final createBranch = engine.executedPlans
            .map(_readRepositoryTrace)
            .toList(growable: false);
        final createOperationId = createBranch.first.operationId;
        expect(createBranch.map((trace) => trace.operationId).toSet(), <String>{
          createOperationId,
        });
        expect(
          createBranch.map((trace) => trace.kind).toList(growable: false),
          <String>['User.upsert', 'User.upsert'],
        );
        expect(
          createBranch.map((trace) => trace.phase).toList(growable: false),
          <String>['branch.lookup', 'branch.create'],
        );
        expect(
          createBranch.map((trace) => trace.strategy).toList(growable: false),
          <String>['branch', 'branch'],
        );
        expect(
          createBranch.map((trace) => trace.step).toList(growable: false),
          <int>[1, 2],
        );

        engine.reset();
        final updated = await users.upsert(
          where: <String, Object?>{'id': 'u1'},
          create: <String, Object?>{'id': 'u1', 'email': 'x@example.com'},
          update: <String, Object?>{'email': 'b@example.com'},
        );
        expect(updated['email'], 'b@example.com');
        expect(
          engine.executedPlans
              .map((plan) => plan.action)
              .toList(growable: false),
          <OrmAction>[OrmAction.read, OrmAction.update],
        );
        final updateBranch = engine.executedPlans
            .map(_readRepositoryTrace)
            .toList(growable: false);
        final updateOperationId = updateBranch.first.operationId;
        expect(updateBranch.map((trace) => trace.operationId).toSet(), <String>{
          updateOperationId,
        });
        expect(
          updateBranch.map((trace) => trace.kind).toList(growable: false),
          <String>['User.upsert', 'User.upsert'],
        );
        expect(
          updateBranch.map((trace) => trace.phase).toList(growable: false),
          <String>['branch.lookup', 'branch.update'],
        );
        expect(
          updateBranch.map((trace) => trace.strategy).toList(growable: false),
          <String>['branch', 'branch'],
        );
        expect(
          updateBranch.map((trace) => trace.step).toList(growable: false),
          <int>[1, 2],
        );

        await client.disconnect();
      },
    );

    test('supports relation where with nested logical operators', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final users = client.db.orm.model('User');
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
      final users = client.db.orm.model('User');

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

    test('records relation where lookup traces on mutation paths', () async {
      final engine = _CountingEngine(inner: MemoryEngine());
      final client = OrmClient(contract: relationalContract, engine: engine);
      await client.connect();
      await _seedRelationalData(client);
      engine.reset();

      final updated = await client.db.orm
          .model('User')
          .update(
            where: <String, Object?>{
              'posts': <String, Object?>{
                'some': <String, Object?>{'title': 'Post C'},
              },
            },
            data: <String, Object?>{'email': 'u2+updated@example.com'},
          );

      expect(updated?['id'], 'u2');
      expect(
        engine.executedPlans.map((plan) => plan.model).toList(growable: false),
        <String>['Post', 'User'],
      );
      expect(
        engine.executedPlans.map((plan) => plan.action).toList(growable: false),
        <OrmAction>[OrmAction.read, OrmAction.update],
      );

      final traces = engine.executedPlans
          .map(_readRepositoryTrace)
          .toList(growable: false);
      final operationId = traces.first.operationId;
      expect(traces.map((trace) => trace.operationId).toSet(), <String>{
        operationId,
      });
      expect(
        traces.map((trace) => trace.kind).toList(growable: false),
        <String>['User.update', 'User.update'],
      );
      expect(
        traces.map((trace) => trace.phase).toList(growable: false),
        <String>['where.relationLookup', 'write'],
      );
      expect(
        traces.map((trace) => trace.strategy).toList(growable: false),
        <String>['relationWhereLookup', 'singlePlan'],
      );
      expect(
        traces.map((trace) => trace.relation).toList(growable: false),
        <String?>['posts', null],
      );
      expect(traces.map((trace) => trace.step).toList(growable: false), <int>[
        1,
        2,
      ]);
      expect(client.telemetry()?.operationId, operationId);
      expect(client.telemetry()?.operationKind, 'User.update');
      expect(client.operationTelemetry(operationId)?.statementCount, 2);
      await client.disconnect();
    });

    test('supports to-one relation where on mutation paths', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);
      final posts = client.db.orm.model('Post');

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

      await client.db.orm
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
      expect(countingEngine.executedPlans.single.read?.where, <String, Object?>{
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

      final rows = await client.db.orm
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
      'supports self-relation include for to-many across strategies',
      () async {
        Future<List<JsonMap>> readWithStrategy(
          IncludeExecutionStrategy strategy,
        ) async {
          final client = OrmClient(
            contract: selfRelationalContract,
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
            await _seedSelfRelationalData(client);
            return await client.db.orm
                .model('User')
                .all(
                  orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                  include: <String, IncludeSpec>{
                    'invitedUsers': IncludeSpec(
                      orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                    ),
                  },
                );
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
        expect(singleRows, hasLength(4));
        expect(
          _readRowsValue(singleRows[0]['invitedUsers']).map((row) => row['id']),
          <Object?>['u2', 'u3'],
        );
        expect(
          _readRowsValue(singleRows[1]['invitedUsers']).map((row) => row['id']),
          <Object?>['u4'],
        );
        expect(_readRowsValue(singleRows[2]['invitedUsers']), isEmpty);
        expect(_readRowsValue(singleRows[3]['invitedUsers']), isEmpty);
      },
    );

    test(
      'supports self-relation include for to-one across strategies',
      () async {
        Future<List<JsonMap>> readWithStrategy(
          IncludeExecutionStrategy strategy,
        ) async {
          final client = OrmClient(
            contract: selfRelationalContract,
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
            await _seedSelfRelationalData(client);
            return await client.db.orm
                .model('User')
                .all(
                  orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                  include: <String, IncludeSpec>{
                    'invitedBy': IncludeSpec(
                      select: const <String>['id', 'email', 'invitedById'],
                    ),
                  },
                );
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
        expect(_readRowValue(singleRows[0]['invitedBy']), isNull);
        expect(_readRowValue(singleRows[1]['invitedBy'])?['id'], 'u1');
        expect(_readRowValue(singleRows[2]['invitedBy'])?['id'], 'u1');
        expect(_readRowValue(singleRows[3]['invitedBy'])?['id'], 'u2');
      },
    );

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
            final rows = await client.db.orm
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

    test('include stream matches all for singleQuery and multiQuery', () async {
      Future<(List<JsonMap>, List<JsonMap>)> readWithStrategy(
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
          final delegate = client.db.orm.model('User');
          final allRows = await delegate.all(
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            include: <String, IncludeSpec>{
              'posts': IncludeSpec(
                orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                select: const <String>['id', 'title'],
              ),
            },
          );
          final streamRows = await delegate
              .query()
              .orderByField('id')
              .include(<String, IncludeSpec>{
                'posts': IncludeSpec(
                  orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                  select: const <String>['id', 'title'],
                ),
              })
              .stream()
              .toList();
          return (allRows, streamRows);
        } finally {
          await client.disconnect();
        }
      }

      final single = await readWithStrategy(
        IncludeExecutionStrategy.singleQuery,
      );
      final multi = await readWithStrategy(IncludeExecutionStrategy.multiQuery);

      expect(single.$2, equals(single.$1));
      expect(multi.$2, equals(multi.$1));
      expect(single.$2, equals(multi.$2));
    });

    test(
      'inspectPlan and explain expose stream degradation metadata for include strategies',
      () async {
        Future<void> expectStrategy(IncludeExecutionStrategy strategy) async {
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
            final query = client.db.orm
                .model('User')
                .query()
                .orderByField('id')
                .include(<String, IncludeSpec>{
                  'posts': IncludeSpec(
                    orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                  ),
                });

            final inspected = await query.inspectPlan();
            final explained = await query.explain();

            for (final payload in <JsonMap>[inspected, explained]) {
              final execution =
                  payload['terminalExecution'] as Map<String, Object?>;
              final stream = execution['stream'] as Map<String, Object?>;
              expect(stream['delivery'], 'bufferedYield');
              expect(stream['degraded'], isTrue);
              expect(stream['reasons'], <String>['include']);
              expect(stream['includeAppliedAt'], 'repository');
              expect(stream['includeStrategy'], strategy.name);
            }
          } finally {
            await client.disconnect();
          }
        }

        await expectStrategy(IncludeExecutionStrategy.singleQuery);
        await expectStrategy(IncludeExecutionStrategy.multiQuery);
      },
    );

    test(
      'include stream respects distinct skip and take for both strategies',
      () async {
        Future<(List<JsonMap>, List<JsonMap>)> readWithStrategy(
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
            final users = client.db.orm.model('User');
            final posts = client.db.orm.model('Post');

            await users.create(
              data: <String, Object?>{'id': 'u1', 'email': 'same@x.com'},
            );
            await users.create(
              data: <String, Object?>{'id': 'u2', 'email': 'same@x.com'},
            );
            await users.create(
              data: <String, Object?>{'id': 'u3', 'email': 'other@x.com'},
            );

            await posts.create(
              data: <String, Object?>{
                'id': 'p1',
                'userId': 'u1',
                'title': 'P1',
              },
            );
            await posts.create(
              data: <String, Object?>{
                'id': 'p2',
                'userId': 'u2',
                'title': 'P2',
              },
            );
            await posts.create(
              data: <String, Object?>{
                'id': 'p3',
                'userId': 'u3',
                'title': 'P3',
              },
            );

            final include = <String, IncludeSpec>{
              'posts': IncludeSpec(
                orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                select: const <String>['id', 'title'],
              ),
            };

            final allRows = await users.all(
              orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
              distinct: const <String>['email'],
              skip: 1,
              take: 1,
              include: include,
            );
            final streamRows = await users
                .query()
                .orderByField('id')
                .distinctField('email')
                .skip(1)
                .take(1)
                .include(include)
                .stream()
                .toList();
            return (allRows, streamRows);
          } finally {
            await client.disconnect();
          }
        }

        final single = await readWithStrategy(
          IncludeExecutionStrategy.singleQuery,
        );
        final multi = await readWithStrategy(
          IncludeExecutionStrategy.multiQuery,
        );

        expect(single.$2, equals(single.$1));
        expect(multi.$2, equals(multi.$1));
        expect(single.$2, equals(multi.$2));
        expect(single.$2.single['id'], 'u3');
        expect(_readRowsValue(single.$2.single['posts']).single['id'], 'p3');
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

        final rows = await client.db.orm
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
            .where((plan) => plan.action == OrmAction.read)
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
      'singleQuery include annotates repository relation load plans',
      () async {
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

          final rows = await client.db.orm
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
          final includePlans = engine.executedPlans
              .where((plan) => plan.repositoryTrace != null)
              .toList(growable: false);
          expect(includePlans, hasLength(1));
          final trace = _readRepositoryTrace(includePlans.single);
          expect(trace.kind, 'User.include');
          expect(trace.phase, 'include.load');
          expect(trace.strategy, 'singleQuery');
          expect(trace.relation, 'posts');
          expect(trace.step, 1);
        } finally {
          await client.disconnect();
        }
      },
    );

    test(
      'multiQuery include annotates repository relation load sequence',
      () async {
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
              }) => IncludeExecutionStrategy.multiQuery,
        );
        await client.connect();
        try {
          await _seedRelationalData(client);
          engine.reset();

          final rows = await client.db.orm
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
          final includePlans = engine.executedPlans
              .where((plan) => plan.repositoryTrace != null)
              .toList(growable: false);
          expect(includePlans, hasLength(2));
          final traces = includePlans
              .map(_readRepositoryTrace)
              .toList(growable: false);
          final operationId = traces.first.operationId;
          expect(traces.map((trace) => trace.operationId).toSet(), <String>{
            operationId,
          });
          expect(
            traces.map((trace) => trace.kind).toList(growable: false),
            <String>['User.include', 'User.include'],
          );
          expect(
            traces.map((trace) => trace.phase).toList(growable: false),
            <String>['include.load', 'include.load'],
          );
          expect(
            traces.map((trace) => trace.strategy).toList(growable: false),
            <String>['multiQuery', 'multiQuery'],
          );
          expect(
            traces.map((trace) => trace.relation).toList(growable: false),
            <String?>['posts', 'posts'],
          );
          expect(
            traces.map((trace) => trace.step).toList(growable: false),
            <int>[1, 2],
          );
        } finally {
          await client.disconnect();
        }
      },
    );

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
            client.db.orm
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
      final posts = client.db.orm.model('Post');

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

        final created = await client.db.orm
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

        final persistedPosts = await client.db.orm
            .model('Post')
            .all(where: <String, Object?>{'userId': 'u3'});
        expect(persistedPosts, hasLength(2));
        await client.disconnect();
      },
    );

    test('supports self-relation nested create orchestration', () async {
      final client = OrmClient(
        contract: selfRelationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();

      final created = await client.db.orm
          .model('User')
          .createNested(
            data: <String, Object?>{'id': 'u1', 'email': 'u1@example.com'},
            create: <String, List<JsonMap>>{
              'invitedUsers': <JsonMap>[
                <String, Object?>{'id': 'u2', 'email': 'u2@example.com'},
                <String, Object?>{'id': 'u3', 'email': 'u3@example.com'},
              ],
            },
          );

      expect(created['id'], 'u1');
      final invitedUsers = _readRowsValue(created['invitedUsers']);
      expect(invitedUsers, hasLength(2));
      expect(
        invitedUsers.map((row) => row['invitedById']).toList(growable: false),
        <Object?>['u1', 'u1'],
      );

      final persisted = await client.db.orm
          .model('User')
          .all(orderBy: const <OrmOrderBy>[OrmOrderBy('id')]);
      expect(
        persisted.map((row) => row['id']).toList(growable: false),
        <Object?>['u1', 'u2', 'u3'],
      );
      expect(
        persisted
            .skip(1)
            .map((row) => row['invitedById'])
            .toList(growable: false),
        <Object?>['u1', 'u1'],
      );
      await client.disconnect();
    });

    test('nested create rolls back when child mutation fails', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();

      await expectLater(
        client.db.orm
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

      final rolledBackUser = await client.db.orm
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

        final updated = await client.db.orm
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

        final persistedUser = await client.db.orm
            .model('User')
            .oneOrNull(where: <String, Object?>{'id': 'u1'});
        expect(persistedUser?['email'], 'u1+updated@example.com');

        final persistedChild = await client.db.orm
            .model('Post')
            .oneOrNull(where: <String, Object?>{'id': 'p4'});
        expect(persistedChild?['userId'], 'u1');
        await client.disconnect();
      },
    );

    test(
      'updateNested supports self-relation child creation with include payload',
      () async {
        final client = OrmClient(
          contract: selfRelationalContract,
          engine: MemoryEngine(),
        );
        await client.connect();
        await _seedSelfRelationalData(client);

        final updated = await client.db.orm
            .model('User')
            .updateNested(
              where: <String, Object?>{'id': 'u1'},
              data: <String, Object?>{'email': 'u1+updated@example.com'},
              create: <String, List<JsonMap>>{
                'invitedUsers': <JsonMap>[
                  <String, Object?>{'id': 'u5', 'email': 'u5@example.com'},
                ],
              },
              include: <String, IncludeSpec>{
                'invitedUsers': IncludeSpec(
                  orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
                ),
              },
            );

        expect(updated?['email'], 'u1+updated@example.com');
        final invitedUsers = _readRowsValue(updated?['invitedUsers']);
        expect(
          invitedUsers.map((row) => row['id']).toList(growable: false),
          <Object?>['u2', 'u3', 'u5'],
        );
        expect(invitedUsers.last['invitedById'], 'u1');

        final persistedChild = await client.db.orm
            .model('User')
            .oneOrNull(where: <String, Object?>{'id': 'u5'});
        expect(persistedChild?['invitedById'], 'u1');
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

      final updated = await client.db.orm
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
      final createdChild = await client.db.orm
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
        client.db.orm
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

      final rolledBackUser = await client.db.orm
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(rolledBackUser?['email'], 'u1@example.com');

      final rolledBackChild = await client.db.orm
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
        final users = client.db.orm.model('User');

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

      final row = await client.db.orm
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
        client.db.orm
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
        client.db.orm
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

      final row = await client.db.orm
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

      await client.db.orm
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
          'User':
              ({
                required OrmCollectionContext client,
                required String modelName,
              }) {
                return _UsersCollection(client: client, modelName: modelName);
              },
        },
      );
      await client.connect();

      final first = client.db.orm.model('User');
      final second = client.db.orm.model('User');

      expect(first, same(second));
      expect(first, isA<_UsersCollection>());
      await client.disconnect();
    });

    test('requires exact custom collection keys', () {
      expect(
        () => OrmClient(
          contract: contract,
          engine: MemoryEngine(),
          collections: <String, CollectionFactory>{
            'users':
                ({
                  required OrmCollectionContext client,
                  required String modelName,
                }) {
                  return _UsersCollection(client: client, modelName: modelName);
                },
          },
        ),
        throwsA(isA<ModelNotFoundException>()),
      );
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
          mutation: OrmMutationPlan(
            data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
            resultMode: OrmMutationResultMode.row,
          ),
        ),
      );

      final transaction = await connection.transaction();
      await transaction.execute(
        OrmPlan(
          contractHash: contract.hash,
          model: 'User',
          action: OrmAction.update,
          mutation: OrmMutationPlan(
            where: <String, Object?>{'id': 'u1'},
            data: <String, Object?>{'email': 'b@example.com'},
            resultMode: OrmMutationResultMode.rowOrNull,
          ),
        ),
      );
      await transaction.commit();
      await connection.release();

      final row = await client.db.orm
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'b@example.com');
      await client.disconnect();
    });

    test('withConnection exposes scoped model delegates', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await client.withConnection((connection) async {
        await connection.db.orm
            .model('User')
            .create(
              data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
            );
      });

      final row = await client.db.orm
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
        final rows = await connection.db.sql.from('User').take(1).all();
        expect(rows, isEmpty);
      });

      expect(engine.connectionCount, 1);
      expect(engine.connectionExecutePlans, hasLength(1));
      expect(engine.connectionExecutePlans.single.action, OrmAction.read);
      expect(engine.connectionExecutePlans.single.read?.take, 1);
      await client.disconnect();
    });

    test(
      'withConnection executes callback and always releases connection',
      () async {
        final engine = _TrackingConnectionEngine();
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        await client.withConnection((connection) async {
          final rows = await connection.db.orm.model('User').all();
          expect(rows, isEmpty);
        });

        expect(engine.connectionCount, 1);
        expect(engine.connectionExecutePlans, hasLength(1));
        expect(engine.connectionExecutePlans.single.action, OrmAction.read);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test('withConnection explain uses scoped connection surface', () async {
      final engine = _TrackingConnectionEngine();
      final client = OrmClient(contract: contract, engine: engine);
      await client.connect();

      await client.withConnection((connection) async {
        final explained = await connection.db.orm
            .model('User')
            .query()
            .orderByField('id')
            .page(size: 1)
            .explain();
        expect(explained['source'], 'connection');
      });

      expect(engine.connectionExplainPlans, hasLength(1));
      expect(engine.connectionExecutePlans, isEmpty);
      expect(engine.connectionExplainPlans.single.action, OrmAction.read);
      expect(client.telemetry(), isNull);
      expect(client.operationTelemetry(), isNull);
      expect(engine.releaseCount, 1);
      await client.disconnect();
    });

    test(
      'withConnection explain failure keeps telemetry clean and releases connection',
      () async {
        final engine = _TrackingConnectionEngine(failOnConnectionExplain: true);
        final plugin = _TrackingPlugin();
        final client = OrmClient(
          contract: contract,
          engine: engine,
          plugins: <OrmPlugin>[plugin],
        );
        await client.connect();

        await expectLater(
          client.withConnection((connection) async {
            await connection.db.orm
                .model('User')
                .query()
                .orderByField('id')
                .page(size: 1)
                .explain();
          }),
          throwsA(isA<StateError>()),
        );

        expect(engine.connectionExplainPlans, hasLength(1));
        expect(engine.connectionExecutePlans, isEmpty);
        expect(plugin.events, isEmpty);
        expect(client.telemetry(), isNull);
        expect(client.operationTelemetry(), isNull);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test(
      'withConnection explain verify always marker mismatch releases and never describes',
      () async {
        final engine = _TrackingConnectionEngine();
        var readCount = 0;
        final client = OrmClient(
          contract: contract,
          engine: engine,
          verify: RuntimeVerifyOptions(
            mode: RuntimeVerifyMode.always,
            requireMarker: true,
            markerReader: CallbackMarkerReader(() async {
              readCount += 1;
              return readCount == 1 ? contract.hash : 'other-hash';
            }),
          ),
        );
        await client.connect();

        await expectLater(
          client.withConnection((connection) async {
            await connection.db.orm
                .model('User')
                .query()
                .orderByField('id')
                .page(size: 1)
                .explain();
          }),
          throwsA(isA<ContractMarkerMismatchException>()),
        );

        expect(readCount, 2);
        expect(engine.connectionExplainPlans, isEmpty);
        expect(engine.connectionExecutePlans, isEmpty);
        expect(client.telemetry(), isNull);
        expect(client.operationTelemetry(), isNull);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test('withTransaction commits on success', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await client.withTransaction((transaction) async {
        await transaction.db.orm
            .model('User')
            .create(
              data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
            );
      });

      final row = await client.db.orm
          .model('User')
          .oneOrNull(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'a@example.com');
      await client.disconnect();
    });

    test('withTransaction exposes scoped sql api', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await client.withTransaction((transaction) async {
        await transaction.db.sql.insertInto('User').values(<String, Object?>{
          'id': 'u1',
          'email': 'a@example.com',
        }).execute();
      });

      final row = await client.db.orm
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
          final rows = await transaction.db.orm.model('User').all();
          expect(rows, isEmpty);
        });

        expect(engine.connectionCount, 1);
        expect(engine.transactionCount, 1);
        expect(engine.transactionExecutePlans, hasLength(1));
        expect(engine.transactionExecutePlans.single.action, OrmAction.read);
        expect(engine.commitCount, 1);
        expect(engine.rollbackCount, 0);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test('withTransaction explain uses scoped transaction surface', () async {
      final engine = _TrackingConnectionEngine();
      final client = OrmClient(contract: contract, engine: engine);
      await client.connect();

      await client.withTransaction((transaction) async {
        final explained = await transaction.db.orm
            .model('User')
            .query()
            .orderByField('id')
            .page(size: 1)
            .explain();
        expect(explained['source'], 'transaction');
      });

      expect(engine.transactionExplainPlans, hasLength(1));
      expect(engine.transactionExecutePlans, isEmpty);
      expect(engine.transactionExplainPlans.single.action, OrmAction.read);
      expect(client.telemetry(), isNull);
      expect(client.operationTelemetry(), isNull);
      expect(engine.commitCount, 1);
      expect(engine.releaseCount, 1);
      await client.disconnect();
    });

    test(
      'withTransaction explain failure rolls back without telemetry or plugin side effects',
      () async {
        final engine = _TrackingConnectionEngine(
          failOnTransactionExplain: true,
        );
        final plugin = _TrackingPlugin();
        final client = OrmClient(
          contract: contract,
          engine: engine,
          plugins: <OrmPlugin>[plugin],
        );
        await client.connect();

        await expectLater(
          client.withTransaction((transaction) async {
            await transaction.db.orm
                .model('User')
                .query()
                .orderByField('id')
                .page(size: 1)
                .explain();
          }),
          throwsA(isA<StateError>()),
        );

        expect(engine.transactionExplainPlans, hasLength(1));
        expect(engine.transactionExecutePlans, isEmpty);
        expect(engine.commitCount, 0);
        expect(engine.rollbackCount, 1);
        expect(engine.releaseCount, 1);
        expect(plugin.events, isEmpty);
        expect(client.telemetry(), isNull);
        expect(client.operationTelemetry(), isNull);
        await client.disconnect();
      },
    );

    test(
      'withTransaction explain verify always marker missing rolls back and never describes',
      () async {
        final engine = _TrackingConnectionEngine();
        var readCount = 0;
        final client = OrmClient(
          contract: contract,
          engine: engine,
          verify: RuntimeVerifyOptions(
            mode: RuntimeVerifyMode.always,
            requireMarker: true,
            markerReader: CallbackMarkerReader(() async {
              readCount += 1;
              return readCount == 1 ? contract.hash : null;
            }),
          ),
        );
        await client.connect();

        await expectLater(
          client.withTransaction((transaction) async {
            await transaction.db.orm
                .model('User')
                .query()
                .orderByField('id')
                .page(size: 1)
                .explain();
          }),
          throwsA(isA<ContractMarkerMissingException>()),
        );

        expect(readCount, 2);
        expect(engine.transactionExplainPlans, isEmpty);
        expect(engine.transactionExecutePlans, isEmpty);
        expect(engine.commitCount, 0);
        expect(engine.rollbackCount, 1);
        expect(engine.releaseCount, 1);
        expect(client.telemetry(), isNull);
        expect(client.operationTelemetry(), isNull);
        await client.disconnect();
      },
    );

    test(
      'withTransaction releases connection when opening transaction fails',
      () async {
        final engine = _TrackingConnectionEngine(failOnTransactionStart: true);
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        await expectLater(
          () => client.withTransaction((_) async => null),
          throwsA(isA<StateError>()),
        );

        expect(engine.connectionCount, 1);
        expect(engine.transactionCount, 1);
        expect(engine.commitCount, 0);
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
          await transaction.db.orm
              .model('User')
              .create(
                data: <String, Object?>{'id': 'u1', 'email': 'a@example.com'},
              );
          throw StateError('stop');
        }),
        throwsA(isA<StateError>()),
      );

      final row = await client.db.orm
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
            await transaction.db.orm.model('User').all();
            throw StateError('stop');
          }),
          throwsA(isA<StateError>()),
        );

        expect(engine.connectionCount, 1);
        expect(engine.transactionCount, 1);
        expect(engine.transactionExecutePlans, hasLength(1));
        expect(engine.transactionExecutePlans.single.action, OrmAction.read);
        expect(engine.commitCount, 0);
        expect(engine.rollbackCount, 1);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test(
      'withTransaction commit failure rolls back and releases connection',
      () async {
        final engine = _TrackingConnectionEngine(failOnCommit: true);
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        await expectLater(
          () => client.withTransaction((transaction) async {
            final rows = await transaction.db.orm.model('User').all();
            expect(rows, isEmpty);
          }),
          throwsA(isA<StateError>()),
        );

        expect(engine.connectionCount, 1);
        expect(engine.transactionCount, 1);
        expect(engine.transactionExecutePlans, hasLength(1));
        expect(engine.transactionExecutePlans.single.action, OrmAction.read);
        expect(engine.commitCount, 1);
        expect(engine.rollbackCount, 1);
        expect(engine.releaseCount, 1);
        await client.disconnect();
      },
    );

    test(
      'withTransaction preserves original error when rollback fails',
      () async {
        final engine = _TrackingConnectionEngine(failOnRollback: true);
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        await expectLater(
          () => client.withTransaction((transaction) async {
            await transaction.db.orm.model('User').all();
            throw StateError('stop');
          }),
          throwsA(
            isA<StateError>().having(
              (error) => error.message,
              'message',
              'stop',
            ),
          ),
        );

        expect(engine.connectionCount, 1);
        expect(engine.transactionCount, 1);
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
      final users = client.db.orm.model('User');

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
          mutation: OrmMutationPlan(
            where: <String, Object?>{'id': 'u1'},
            data: <String, Object?>{'email': 'b@example.com'},
            resultMode: OrmMutationResultMode.rowOrNull,
          ),
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
            action: OrmAction.read,
            read: OrmReadPlan(resultMode: OrmReadResultMode.all),
          ),
        ),
        throwsA(isA<RuntimeConnectionReleasedException>()),
      );
      expect(
        () => connection.explain(_scopedReadPlan(contract)),
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
            action: OrmAction.read,
            read: OrmReadPlan(resultMode: OrmReadResultMode.all),
          ),
        ),
        throwsA(isA<RuntimeTransactionCompletedException>()),
      );
      expect(
        () => transaction.explain(_scopedReadPlan(contract)),
        throwsA(isA<RuntimeTransactionCompletedException>()),
      );
      await connection2.release();
      await client.disconnect();
    });

    test('scoped explain after scope end hits lifecycle guards', () async {
      final engine = _TrackingConnectionEngine();
      final client = OrmClient(contract: contract, engine: engine);
      await client.connect();

      late OrmScopedClient scopedConnection;
      await client.withConnection((connection) async {
        scopedConnection = connection;
      });

      await expectLater(
        scopedConnection.db.orm
            .model('User')
            .query()
            .orderByField('id')
            .page(size: 1)
            .explain(),
        throwsA(isA<RuntimeConnectionReleasedException>()),
      );

      late OrmScopedClient scopedTransaction;
      await client.withTransaction((transaction) async {
        scopedTransaction = transaction;
      });

      await expectLater(
        scopedTransaction.db.orm
            .model('User')
            .query()
            .orderByField('id')
            .page(size: 1)
            .explain(),
        throwsA(isA<RuntimeTransactionCompletedException>()),
      );

      expect(engine.connectionExplainPlans, isEmpty);
      expect(engine.transactionExplainPlans, isEmpty);
      expect(client.telemetry(), isNull);
      expect(client.operationTelemetry(), isNull);
      await client.disconnect();
    });

    test('records telemetry for successful execution', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      await client.db.orm.model('User').all();

      final telemetry = client.telemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.model, 'User');
      expect(telemetry?.action, OrmAction.read);
      expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
      expect(telemetry?.completed, isTrue);
      expect(telemetry?.executionMode, EngineExecutionMode.buffered);
      expect(telemetry?.executionSource, EngineExecutionSource.buffered);
      expect(telemetry?.repositoryTrace, isNull);
      await client.disconnect();
    });

    test('records repository operation trace in telemetry', () async {
      final engine = _CountingEngine(inner: MemoryEngine());
      final client = OrmClient(contract: contract, engine: engine);
      await client.connect();
      final users = client.db.orm.model('User');

      await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u2', 'email': 'b@x.com'},
        ],
      );

      final lastPlanTrace = _readRepositoryTrace(engine.executedPlans.last);
      final telemetry = client.telemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.operationId, lastPlanTrace.operationId);
      expect(telemetry?.operationKind, 'User.createMany');
      expect(telemetry?.operationPhase, 'item.create');
      expect(telemetry?.operationStrategy, 'transaction');
      expect(telemetry?.operationStep, 2);
      expect(telemetry?.completed, isTrue);
      expect(telemetry?.repositoryTrace?.itemIndex, 1);
      await client.disconnect();
    });

    test(
      'marks telemetry incomplete when consumer stops stream early',
      () async {
        final plugin = _InspectingPlugin();
        final client = OrmClient(
          contract: contract,
          engine: MemoryEngine(),
          plugins: <OrmPlugin>[plugin],
        );
        await client.connect();
        final users = client.db.orm.model('User');

        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u2', 'email': 'b@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 'u3', 'email': 'c@x.com'},
        );
        plugin.reset();

        final rows = await users
            .stream(orderBy: const <OrmOrderBy>[OrmOrderBy('id')])
            .take(1)
            .toList();

        expect(rows, hasLength(1));
        expect(plugin.events, <String>[
          'before:read',
          'row:read',
          'after:read',
        ]);
        expect(plugin.afterResults, hasLength(1));
        expect(plugin.afterResults.single.completed, isFalse);
        expect(plugin.afterResults.single.rowCount, 1);
        expect(plugin.afterResults.single.affectedRows, 0);
        expect(client.telemetry()?.outcome, RuntimeTelemetryOutcome.success);
        expect(client.telemetry()?.completed, isFalse);
        expect(client.telemetry()?.executionMode, EngineExecutionMode.buffered);
        expect(
          client.telemetry()?.executionSource,
          EngineExecutionSource.buffered,
        );
        await client.disconnect();
      },
    );

    test(
      'records runtime error telemetry when stream fails after rows',
      () async {
        final plugin = _InspectingPlugin();
        final client = OrmClient(
          contract: contract,
          engine: _FailingStreamEngine(),
          plugins: <OrmPlugin>[plugin],
        );
        await client.connect();

        await expectLater(
          client.db.orm.model('User').stream().toList(),
          throwsA(isA<StateError>()),
        );

        expect(plugin.events, <String>[
          'before:read',
          'row:read',
          'error:read',
          'after:read',
        ]);
        expect(plugin.afterResults, hasLength(1));
        expect(plugin.afterResults.single.completed, isFalse);
        expect(plugin.afterResults.single.rowCount, 1);
        expect(
          client.telemetry()?.outcome,
          RuntimeTelemetryOutcome.runtimeError,
        );
        expect(client.telemetry()?.completed, isFalse);
        expect(client.telemetry()?.executionMode, EngineExecutionMode.stream);
        expect(
          client.telemetry()?.executionSource,
          EngineExecutionSource.directStream,
        );
        await client.disconnect();
      },
    );

    test('records runtime error telemetry when plugin onRow fails', () async {
      final engine = MemoryEngine();
      final seeder = OrmClient(contract: contract, engine: engine);
      await seeder.connect();
      await seeder.db.orm
          .model('User')
          .create(data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'});
      await seeder.disconnect();

      final plugin = _OnRowThrowingPlugin();
      final client = OrmClient(
        contract: contract,
        engine: engine,
        plugins: <OrmPlugin>[plugin],
      );
      await client.connect();
      final users = client.db.orm.model('User');

      await expectLater(users.stream().toList(), throwsA(isA<StateError>()));

      expect(plugin.events, <String>[
        'before:read',
        'row:read',
        'error:read',
        'after:read',
      ]);
      expect(plugin.afterResults, hasLength(1));
      expect(plugin.afterResults.single.completed, isFalse);
      expect(plugin.afterResults.single.rowCount, 1);
      expect(client.telemetry()?.outcome, RuntimeTelemetryOutcome.runtimeError);
      expect(client.telemetry()?.completed, isFalse);
      expect(client.telemetry()?.executionMode, EngineExecutionMode.buffered);
      expect(
        client.telemetry()?.executionSource,
        EngineExecutionSource.buffered,
      );
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

      await client.db.orm.model('User').all();
      await client.db.orm.model('User').all();
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

        await client.db.orm.model('User').all();
        expect(readCount, 1);
        await client.db.orm.model('User').all();
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
      await client.db.orm.model('User').all();
      await client.db.orm.model('User').all();

      expect(readCount, 2);
      await client.disconnect();
    });

    test(
      'scoped connection explain verifies marker on every request in always mode',
      () async {
        var readCount = 0;
        final client = OrmClient(
          contract: contract,
          engine: _TrackingConnectionEngine(),
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
        final connection = await client.connection();
        await connection.explain(_scopedReadPlan(contract));
        await connection.explain(_scopedReadPlan(contract));

        expect(readCount, 3);
        await connection.release();
        await client.disconnect();
      },
    );

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
        client.db.orm.model('User').all(),
        throwsA(isA<ContractMarkerMissingException>()),
      );
      await client.disconnect();
    });

    test(
      'scoped connection explain fails verification before reaching engine describe',
      () async {
        final engine = _TrackingConnectionEngine();
        var readCount = 0;
        final client = OrmClient(
          contract: contract,
          engine: engine,
          verify: RuntimeVerifyOptions(
            mode: RuntimeVerifyMode.always,
            requireMarker: true,
            markerReader: CallbackMarkerReader(() async {
              readCount += 1;
              return readCount == 1 ? contract.hash : null;
            }),
          ),
        );
        await client.connect();

        final connection = await client.connection();
        await expectLater(
          connection.explain(_scopedReadPlan(contract)),
          throwsA(isA<ContractMarkerMissingException>()),
        );

        expect(engine.connectionExplainPlans, isEmpty);
        expect(readCount, 2);
        expect(client.telemetry(), isNull);
        expect(client.operationTelemetry(), isNull);
        await connection.release();
        await client.disconnect();
      },
    );

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
        client.db.orm.model('User').all(),
        throwsA(isA<ContractMarkerMismatchException>()),
      );
      await client.disconnect();
    });

    test(
      'scoped connection explain rejects mismatched target before engine describe',
      () async {
        final engine = _TrackingConnectionEngine();
        final client = OrmClient(contract: contract, engine: engine);
        await client.connect();

        final connection = await client.connection();
        await expectLater(
          connection.explain(_scopedReadPlan(contract, target: 'other-target')),
          throwsA(isA<PlanTargetMismatchException>()),
        );

        expect(engine.connectionExplainPlans, isEmpty);
        expect(client.telemetry(), isNull);
        expect(client.operationTelemetry(), isNull);
        await connection.release();
        await client.disconnect();
      },
    );

    test(
      'scoped transaction explain rejects mismatched profile before engine describe',
      () async {
        final profileContract = OrmContract(
          version: '1',
          hash: 'contract-profile-v1',
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
        final engine = _TrackingConnectionEngine();
        final client = OrmClient(contract: profileContract, engine: engine);
        await client.connect();

        final connection = await client.connection();
        final transaction = await connection.transaction();
        await expectLater(
          transaction.explain(
            _scopedReadPlan(profileContract, profileHash: 'other-profile'),
          ),
          throwsA(isA<PlanProfileHashMismatchException>()),
        );

        expect(engine.transactionExplainPlans, isEmpty);
        expect(client.telemetry(), isNull);
        expect(client.operationTelemetry(), isNull);
        await transaction.rollback();
        await connection.release();
        await client.disconnect();
      },
    );

    test('rejects unknown plan fields by contract', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client.db.orm
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
        client.db.orm.model('User').all(where: <String, Object?>{'age': 1}),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.db.orm
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
        client.db.orm.model('User').create(data: <String, Object?>{'age': 1}),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.db.orm
            .model('User')
            .all(orderBy: const <OrmOrderBy>[OrmOrderBy('age')]),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.db.orm.model('User').all(select: const <String>['age']),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.db.orm.model('User').all(distinct: const <String>['age']),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await client.disconnect();
    });

    test('rejects negative pagination values', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client.db.orm.model('User').all(skip: -1),
        throwsA(isA<PlanInvalidPaginationException>()),
      );
      await expectLater(
        client.db.orm.model('User').all(take: -1),
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
    await client.db.orm.model('User').all();

    expect(plugin.events, <String>['before:read', 'after:read']);
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
    await client.db.sql.from('User').all();

    expect(plugin.events, <String>['before:read', 'after:read']);
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

    await expectLater(
      client.db.orm.model('User').all(),
      throwsA(isA<StateError>()),
    );
    expect(plugin.events, <String>['before:read', 'error:read', 'after:read']);
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
      client.db.orm.model('User').all(),
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

    await client.db.orm.model('User').all();
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
      client.db.orm.model('User').all(take: 2),
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
      client.db.orm.model('User').all(),
      throwsA(isA<RuntimeResponseShapeException>()),
    );
    await client.disconnect();
  });

  test('db.sql returns structured runtime response shape errors', () async {
    final client = OrmClient(contract: contract, engine: _BadShapeEngine());
    await client.connect();

    await expectLater(
      client.db.sql.from('User').all(),
      throwsA(isA<RuntimeResponseShapeException>()),
    );
    await client.disconnect();
  });
}

Future<void> _seedRelationalData(OrmClient client) async {
  final users = client.db.orm.model('User');
  final posts = client.db.orm.model('Post');

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

Future<void> _seedSelfRelationalData(OrmClient client) async {
  final users = client.db.orm.model('User');

  await users.create(
    data: <String, Object?>{
      'id': 'u1',
      'email': 'u1@example.com',
      'invitedById': null,
    },
  );
  await users.create(
    data: <String, Object?>{
      'id': 'u2',
      'email': 'u2@example.com',
      'invitedById': 'u1',
    },
  );
  await users.create(
    data: <String, Object?>{
      'id': 'u3',
      'email': 'u3@example.com',
      'invitedById': 'u1',
    },
  );
  await users.create(
    data: <String, Object?>{
      'id': 'u4',
      'email': 'u4@example.com',
      'invitedById': 'u2',
    },
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

OrmPlan _scopedReadPlan(
  OrmContract contract, {
  String? target,
  String? storageHash,
  String? profileHash,
}) {
  return OrmPlan.read(
    contractHash: contract.hash,
    target: target ?? contract.target,
    storageHash: storageHash ?? contract.markerStorageHash,
    profileHash: profileHash ?? contract.profileHash,
    model: 'User',
    resultMode: OrmReadResultMode.all,
  );
}

OrmRepositoryTrace _readRepositoryTrace(OrmPlan plan) {
  final trace = plan.repositoryTrace;
  if (trace == null) {
    fail('Expected repository trace on plan ${plan.action.name}.');
  }
  return trace;
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

final class _InspectingPlugin extends OrmPlugin {
  final List<String> events = <String>[];
  final List<AfterExecuteResult> afterResults = <AfterExecuteResult>[];

  @override
  String get name => 'inspecting';

  @override
  void beforeExecute(OrmPlan plan, PluginContext ctx) {
    events.add('before:${plan.action.name}');
  }

  @override
  void onRow(JsonMap row, OrmPlan plan, PluginContext ctx) {
    events.add('row:${plan.action.name}');
  }

  @override
  void afterExecute(
    OrmPlan plan,
    AfterExecuteResult result,
    PluginContext ctx,
  ) {
    afterResults.add(result);
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

  void reset() {
    events.clear();
    afterResults.clear();
  }
}

final class _OnRowThrowingPlugin extends _InspectingPlugin {
  @override
  String get name => 'row-throwing';

  @override
  void onRow(JsonMap row, OrmPlan plan, PluginContext ctx) {
    super.onRow(row, plan, ctx);
    throw StateError('plugin-row-boom');
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

final class _FailingStreamEngine implements OrmEngine {
  @override
  Future<void> close() async {}

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    return EngineResponse(
      rows: () async* {
        yield <String, Object?>{'id': 'u1', 'email': 'a@x.com'};
        throw StateError('stream-boom');
      }(),
      executionMode: EngineExecutionMode.stream,
      executionSource: EngineExecutionSource.directStream,
    );
  }

  @override
  Future<void> open() async {}
}

final class _BadShapeEngine implements OrmEngine {
  @override
  Future<void> close() async {}

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    return EngineResponse.buffered('bad-shape');
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
      return EngineResponse.empty(affectedRows: response.affectedRows);
    }
    return response;
  }

  @override
  Future<void> open() => inner.open();
}

final class _CountingEngine implements OrmEngine, ConnectionCapableEngine {
  final OrmEngine inner;
  var executeCount = 0;
  final List<OrmPlan> executedPlans = <OrmPlan>[];

  _CountingEngine({required this.inner});

  @override
  Future<void> close() => inner.close();

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _record(plan);
    return inner.execute(plan);
  }

  @override
  Future<void> open() => inner.open();

  @override
  Future<EngineConnection> connection() async {
    if (inner case final ConnectionCapableEngine connectionEngine) {
      final connection = await connectionEngine.connection();
      return _CountingEngineConnection(this, connection);
    }
    throw UnsupportedError('Inner engine does not support connections.');
  }

  void reset() {
    executeCount = 0;
    executedPlans.clear();
  }

  void _record(OrmPlan plan) {
    executeCount += 1;
    executedPlans.add(plan);
  }
}

final class _CountingEngineConnection implements EngineConnection {
  final _CountingEngine _engine;
  final EngineConnection _inner;

  _CountingEngineConnection(this._engine, this._inner);

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _engine._record(plan);
    return _inner.execute(plan);
  }

  @override
  Future<void> release() => _inner.release();

  @override
  Future<EngineTransaction> transaction() async {
    final transaction = await _inner.transaction();
    return _CountingEngineTransaction(_engine, transaction);
  }
}

final class _CountingEngineTransaction implements EngineTransaction {
  final _CountingEngine _engine;
  final EngineTransaction _inner;

  _CountingEngineTransaction(this._engine, this._inner);

  @override
  Future<void> commit() => _inner.commit();

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _engine._record(plan);
    return _inner.execute(plan);
  }

  @override
  Future<void> rollback() => _inner.rollback();
}

final class _BadRelatedFindManyShapeEngine implements OrmEngine {
  final OrmEngine inner;

  _BadRelatedFindManyShapeEngine({required this.inner});

  @override
  Future<void> close() => inner.close();

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    if (plan.model == 'Post' && plan.action == OrmAction.read) {
      return EngineResponse.buffered('bad-shape');
    }
    return inner.execute(plan);
  }

  @override
  Future<void> open() => inner.open();
}

final class _TrackingConnectionEngine
    implements OrmEngine, ConnectionCapableEngine {
  final bool failOnTransactionStart;
  final bool failOnCommit;
  final bool failOnRollback;
  final bool failOnConnectionExplain;
  final bool failOnTransactionExplain;
  var connectionCount = 0;
  var transactionCount = 0;
  var releaseCount = 0;
  var commitCount = 0;
  var rollbackCount = 0;
  final List<OrmPlan> connectionExecutePlans = <OrmPlan>[];
  final List<OrmPlan> connectionExplainPlans = <OrmPlan>[];
  final List<OrmPlan> transactionExecutePlans = <OrmPlan>[];
  final List<OrmPlan> transactionExplainPlans = <OrmPlan>[];

  _TrackingConnectionEngine({
    this.failOnTransactionStart = false,
    this.failOnCommit = false,
    this.failOnRollback = false,
    this.failOnConnectionExplain = false,
    this.failOnTransactionExplain = false,
  });

  @override
  Future<void> close() async {}

  @override
  Future<EngineConnection> connection() async {
    connectionCount += 1;
    return _TrackingEngineConnection(this);
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    return EngineResponse.buffered(const <JsonMap>[]);
  }

  @override
  Future<void> open() async {}
}

final class _TrackingEngineConnection
    implements EngineConnection, ExplainCapableEngineConnection {
  final _TrackingConnectionEngine _engine;

  _TrackingEngineConnection(this._engine);

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _engine.connectionExecutePlans.add(plan);
    return EngineResponse.buffered(const <JsonMap>[]);
  }

  @override
  Future<void> release() async {
    _engine.releaseCount += 1;
  }

  @override
  Future<EngineTransaction> transaction() async {
    _engine.transactionCount += 1;
    if (_engine.failOnTransactionStart) {
      throw StateError('transaction start failed');
    }
    return _TrackingEngineTransaction(_engine);
  }

  @override
  Future<JsonMap> describePlan(OrmPlan plan) async {
    _engine.connectionExplainPlans.add(plan);
    if (_engine.failOnConnectionExplain) {
      throw StateError('connection explain failed');
    }
    return <String, Object?>{'source': 'connection'};
  }
}

final class _TrackingEngineTransaction
    implements EngineTransaction, ExplainCapableEngineTransaction {
  final _TrackingConnectionEngine _engine;

  _TrackingEngineTransaction(this._engine);

  @override
  Future<void> commit() async {
    _engine.commitCount += 1;
    if (_engine.failOnCommit) {
      throw StateError('commit failed');
    }
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _engine.transactionExecutePlans.add(plan);
    return EngineResponse.buffered(const <JsonMap>[]);
  }

  @override
  Future<void> rollback() async {
    _engine.rollbackCount += 1;
    if (_engine.failOnRollback) {
      throw StateError('rollback failed');
    }
  }

  @override
  Future<JsonMap> describePlan(OrmPlan plan) async {
    _engine.transactionExplainPlans.add(plan);
    if (_engine.failOnTransactionExplain) {
      throw StateError('transaction explain failed');
    }
    return <String, Object?>{'source': 'transaction'};
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
