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

  group('OrmClient + MemoryEngine', () {
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
