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

      final allRows = await users.findMany();
      expect(allRows, hasLength(1));
      expect(allRows.first['email'], 'a@example.com');

      final unique = await users.findUnique(
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

      final remaining = await users.findMany();
      expect(remaining, isEmpty);
      await client.disconnect();
    });

    test('requires explicit connect', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.model('User');

      await expectLater(
        users.findMany(),
        throwsA(isA<ClientNotConnectedException>()),
      );
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

      final rows = await users.findMany(
        orderBy: const <OrmOrderBy>[OrmOrderBy('email')],
        skip: 1,
        take: 1,
      );

      expect(rows.single['email'], 'b@x.com');
      await client.disconnect();
    });

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

        final unique = await users.findUnique(
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

      final all = await base.findMany();
      final page = await narrowed.findMany();

      expect(all, hasLength(3));
      expect(page, hasLength(1));
      expect(page.single['email'], 'b@x.com');
      await client.disconnect();
    });

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
      final selected = await readQuery.findUnique();
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
      }).findUnique();
      expect(unique?['email'], 'b@example.com');

      final removed = await users.where(<String, Object?>{'id': 'u1'}).delete();
      expect(removed?['id'], 'u1');

      final remaining = await users.where(<String, Object?>{
        'id': 'u1',
      }).findUnique();
      expect(remaining, isNull);
      await client.disconnect();
    });

    test('supports findFirst, count and exists helpers', () async {
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

      final first = await users.findFirst(
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

        final remaining = await users.findUnique(
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
        final first = await query.orderByField('id').findFirst();
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

    test('supports include for one-to-many relation', () async {
      final client = OrmClient(
        contract: relationalContract,
        engine: MemoryEngine(),
      );
      await client.connect();
      await _seedRelationalData(client);

      final rows = await client
          .model('User')
          .findMany(
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
            .findMany(where: <String, Object?>{'userId': 'u3'});
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
          .findUnique(where: <String, Object?>{'id': 'u4'});
      expect(rolledBackUser, isNull);
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
        }).findMany();
        expect(delegatedRows, hasLength(2));
        expect(_readRowsValue(delegatedRows.first['posts']), hasLength(1));

        final base = users.query().where(<String, Object?>{'id': 'u1'});
        final withInclude = base.include(<String, IncludeSpec>{
          'posts': IncludeSpec(
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            take: 1,
          ),
        });

        expect(base.includeValues, isEmpty);
        expect(withInclude.includeValues.keys, <String>['posts']);

        final includeRow = await withInclude.findUnique();
        final includePosts = _readRowsValue(includeRow?['posts']);
        expect(includePosts, hasLength(1));
        expect(includePosts.single['id'], 'p1');

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
            .findUnique();

        final relationPosts = _readRowsValue(includeRelationRow?['posts']);
        expect(relationPosts, hasLength(2));
        final relationAuthor = _readRowValue(relationPosts.first['author']);
        expect(relationAuthor?['email'], 'u1@example.com');
        await client.disconnect();
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
          .findUnique(
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
            .findMany(
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
            .findMany(
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
          .findUnique(
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
          .findMany(
            include: <String, IncludeSpec>{'posts': const IncludeSpec()},
          );

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
          .findUnique(where: <String, Object?>{'id': 'u1'});
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
          .findUnique(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'a@example.com');
      await client.disconnect();
    });

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
          .findUnique(where: <String, Object?>{'id': 'u1'});
      expect(row?['email'], 'a@example.com');
      await client.disconnect();
    });

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
          .findUnique(where: <String, Object?>{'id': 'u1'});
      expect(row, isNull);
      await client.disconnect();
    });

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

      final row = await users.findUnique(where: <String, Object?>{'id': 'u1'});
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
      await client.model('User').findMany();

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

      await client.model('User').findMany();
      await client.model('User').findMany();
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

        await client.model('User').findMany();
        expect(readCount, 1);
        await client.model('User').findMany();
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
      await client.model('User').findMany();
      await client.model('User').findMany();

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
        client.model('User').findMany(),
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
        client.model('User').findMany(),
        throwsA(isA<ContractMarkerMismatchException>()),
      );
      await client.disconnect();
    });

    test('rejects unknown plan fields by contract', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client.model('User').findMany(where: <String, Object?>{'age': 1}),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.model('User').create(data: <String, Object?>{'age': 1}),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client
            .model('User')
            .findMany(orderBy: const <OrmOrderBy>[OrmOrderBy('age')]),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await expectLater(
        client.model('User').findMany(select: const <String>['age']),
        throwsA(isA<PlanFieldNotFoundException>()),
      );
      await client.disconnect();
    });

    test('rejects negative pagination values', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();

      await expectLater(
        client.model('User').findMany(skip: -1),
        throwsA(isA<PlanInvalidPaginationException>()),
      );
      await expectLater(
        client.model('User').findMany(take: -1),
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
    await client.model('User').findMany();

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

    await expectLater(
      client.model('User').findMany(),
      throwsA(isA<StateError>()),
    );
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
      client.model('User').findMany(),
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

    await client.model('User').findMany();
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
      client.model('User').findMany(take: 2),
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
      client.model('User').findMany(),
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
