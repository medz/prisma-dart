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

      final plan = await users.query().orderByField('id').cursor(
        <String, Object?>{'id': 'u1'},
      ).toPlan();

      expect(plan.read?.cursor?.values, <String, Object?>{'id': 'u1'});
      expect(plan.read?.page, isNull);
      expect(plan.read?.orderBy.map((entry) => entry.field).toList(), <String>[
        'id',
      ]);
    });

    test('page compiles into structured query plan state', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      final plan = await users
          .query()
          .orderByField('id')
          .page(size: 20, after: <String, Object?>{'id': 'u1'})
          .toPlan();

      expect(plan.read?.cursor, isNull);
      expect(plan.read?.page?.size, 20);
      expect(plan.read?.page?.after, <String, Object?>{'id': 'u1'});
      expect(plan.read?.orderBy.map((entry) => entry.field).toList(), <String>[
        'id',
      ]);
    });

    test(
      'inspectPlan returns structured plan json without connecting',
      () async {
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
      },
    );

    test(
      'inspectPlan exposes terminal execution metadata for native stream and page envelopes',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        final users = client.db.orm.model('User');
        final inspected = await users
            .query()
            .orderByField('id')
            .page(size: 2, after: <String, Object?>{'id': 'u1'})
            .inspectPlan();

        final execution =
            inspected['terminalExecution'] as Map<String, Object?>;
        final stream = execution['stream'] as Map<String, Object?>;
        final pageResult = execution['pageResult'] as Map<String, Object?>;

        expect(stream['delivery'], 'nativeStream');
        expect(stream['degraded'], isFalse);
        expect(stream['windowAppliedAt'], 'engine');
        expect(stream['includeAppliedAt'], 'none');
        expect(pageResult['available'], isTrue);
        expect(pageResult['delivery'], 'pageEnvelope');
      },
    );

    test(
      'inspectPlan marks stream as bufferedYield when distinct requires client-side collection',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        final users = client.db.orm.model('User');
        final inspected = await users
            .query()
            .orderByField('id')
            .distinctField('email')
            .inspectPlan();

        final execution =
            inspected['terminalExecution'] as Map<String, Object?>;
        final stream = execution['stream'] as Map<String, Object?>;

        expect(stream['delivery'], 'bufferedYield');
        expect(stream['degraded'], isTrue);
        expect(stream['reasons'], <String>['distinct']);
        expect(stream['distinctAppliedAt'], 'client');
      },
    );

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
        expect(summary['executionMode'], 'deferred');
        expect(summary['executionSource'], 'notExecuted');
        final pagination = summary['pagination'] as Map<String, Object?>;
        expect(pagination['mode'], 'page');
        final execution =
            explained['terminalExecution'] as Map<String, Object?>;
        expect(
          (execution['stream'] as Map<String, Object?>)['delivery'],
          'nativeStream',
        );
        expect(
          (execution['pageResult'] as Map<String, Object?>)['available'],
          isTrue,
        );
        expect(explained['plan'], isA<Map<String, Object?>>());
      } finally {
        await client.disconnect();
      }
    });

    test(
      'heuristic explain does not execute engines without explain support',
      () async {
        final engine = _ExecuteForbiddenEngine();
        final plugin = _TrackingPlugin();
        final client = OrmClient(
          contract: contract,
          engine: engine,
          plugins: <OrmPlugin>[plugin],
        );
        await client.connect();
        try {
          final users = client.db.orm.model('User');
          final explained = await users
              .query()
              .orderByField('id')
              .page(size: 2)
              .explain();

          expect(explained['source'], 'heuristic');
          expect(engine.executeCount, 0);
          expect(plugin.events, isEmpty);
          expect(client.telemetry(), isNull);
          expect(client.operationTelemetry(), isNull);
        } finally {
          await client.disconnect();
        }
      },
    );

    test(
      'explain includes target-aware adapter details when available',
      () async {
        final sqlContract = OrmContract(
          version: '1',
          hash: 'contract-sql-v1',
          target: 'sql-family',
          models: <String, ModelContract>{
            'User': ModelContract(
              name: 'User',
              table: 'users',
              fields: <String>{'id', 'email'},
            ),
          },
          aliases: <String, String>{'users': 'User'},
        );
        final client = OrmClient(
          contract: sqlContract,
          engine: AdapterDriverEngine<SqlStatement, SqlResult>(
            adapter: SqlAdapter(contract: sqlContract),
            driver: _ExplainOnlySqlDriver(),
          ),
        );
        await client.connect();
        try {
          final users = client.db.orm.model('User');
          final explained = await users
              .query()
              .where(<String, Object?>{'id': 'u1'})
              .orderByField('id')
              .page(size: 2)
              .explain();

          expect(explained['source'], 'adapter');
          expect(explained['target'], 'sql-family');
          final request = explained['request'] as Map<String, Object?>;
          expect(request['kind'], 'sql');
          expect(request['action'], 'read');
          expect(request['text'], contains('SELECT'));
          expect(request['parameterCount'], greaterThan(0));

          final summary = explained['planSummary'] as Map<String, Object?>;
          expect(summary['model'], 'User');
          expect(client.telemetry(), isNull);
          expect(client.operationTelemetry(), isNull);
        } finally {
          await client.disconnect();
        }
      },
    );

    test(
      'adapter explain stays non-executing while stream executes once',
      () async {
        final sqlContract = OrmContract(
          version: '1',
          hash: 'contract-sql-stream-v1',
          target: 'sql-family',
          models: <String, ModelContract>{
            'User': ModelContract(
              name: 'User',
              table: 'users',
              fields: <String>{'id', 'email'},
            ),
          },
          aliases: <String, String>{'users': 'User'},
        );
        final driver = _CountingSqlDriver(
          rows: <JsonMap>[
            <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          ],
        );
        final client = OrmClient(
          contract: sqlContract,
          engine: AdapterDriverEngine<SqlStatement, SqlResult>(
            adapter: SqlAdapter(contract: sqlContract),
            driver: driver,
          ),
        );
        await client.connect();
        try {
          final users = client.db.orm.model('User');

          await users
              .query()
              .where(<String, Object?>{'id': 'u1'})
              .orderByField('id')
              .page(size: 1)
              .explain();
          expect(driver.executeCount, 0);

          final rows = await users
              .query()
              .where(<String, Object?>{'id': 'u1'})
              .stream()
              .toList();
          expect(driver.executeCount, 1);
          expect(rows, <JsonMap>[
            <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          ]);
        } finally {
          await client.disconnect();
        }
      },
    );

    test(
      'adapter explain stays non-executing while native stream executes once',
      () async {
        final sqlContract = OrmContract(
          version: '1',
          hash: 'contract-sql-native-stream-v1',
          target: 'sql-family',
          models: <String, ModelContract>{
            'User': ModelContract(
              name: 'User',
              table: 'users',
              fields: <String>{'id', 'email'},
            ),
          },
          aliases: <String, String>{'users': 'User'},
        );
        final driver = _StreamingSqlDriver(
          rows: <JsonMap>[
            <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
            <String, Object?>{'id': 'u2', 'email': 'b@x.com'},
          ],
        );
        final client = OrmClient(
          contract: sqlContract,
          engine: AdapterDriverEngine<SqlStatement, SqlResult>(
            adapter: SqlAdapter(contract: sqlContract),
            driver: driver,
          ),
        );
        await client.connect();
        try {
          final users = client.db.orm.model('User');

          await users
              .query()
              .where(<String, Object?>{'id': 'u1'})
              .orderByField('id')
              .page(size: 1)
              .explain();
          expect(driver.executeCount, 0);
          expect(driver.streamCount, 0);

          final rows = await users
              .query()
              .where(<String, Object?>{'id': 'u1'})
              .stream()
              .take(1)
              .toList();
          expect(driver.executeCount, 0);
          expect(driver.streamCount, 1);
          expect(rows, <JsonMap>[
            <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          ]);
          expect(client.telemetry()?.outcome, RuntimeTelemetryOutcome.success);
          expect(client.telemetry()?.completed, isFalse);
          expect(client.telemetry()?.executionMode, EngineExecutionMode.stream);
          expect(
            client.telemetry()?.executionSource,
            EngineExecutionSource.directStream,
          );
          expect(client.operationTelemetry(), isNull);
        } finally {
          await client.disconnect();
        }
      },
    );

    test('explain preserves existing telemetry snapshots', () async {
      final plugin = _TrackingPlugin();
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        plugins: <OrmPlugin>[plugin],
      );
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await users.create(
          data: <String, Object?>{'id': 1, 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 2, 'email': 'b@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 3, 'email': 'c@x.com'},
        );

        await users.query().orderByField('id').page(size: 2).pageResult();
        final telemetryBefore = client.telemetry();
        final operationBefore = client.operationTelemetry();
        final pluginEventsBefore = List<String>.from(plugin.events);

        await users.query().orderByField('id').page(size: 2).explain();

        final telemetryAfter = client.telemetry();
        final operationAfter = client.operationTelemetry();
        expect(telemetryAfter, isNotNull);
        expect(operationAfter, isNotNull);
        expect(telemetryAfter?.model, telemetryBefore?.model);
        expect(telemetryAfter?.action, telemetryBefore?.action);
        expect(telemetryAfter?.outcome, telemetryBefore?.outcome);
        expect(telemetryAfter?.completed, telemetryBefore?.completed);
        expect(operationAfter?.operationId, operationBefore?.operationId);
        expect(operationAfter?.statementCount, operationBefore?.statementCount);
        expect(operationAfter?.completed, operationBefore?.completed);
        expect(plugin.events, pluginEventsBefore);
      } finally {
        await client.disconnect();
      }
    });

    test('cursor and page execution return deterministic windows', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await users.create(
          data: <String, Object?>{'id': 1, 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 2, 'email': 'b@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 3, 'email': 'c@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 4, 'email': 'd@x.com'},
        );

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

    test('pageResult returns structured items and pageInfo', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await users.create(
          data: <String, Object?>{'id': 1, 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 2, 'email': 'b@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 3, 'email': 'c@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 4, 'email': 'd@x.com'},
        );

        final firstPage = await users
            .query()
            .orderByField('id')
            .select(const <String>['email'])
            .page(size: 2)
            .pageResult();
        final beforePage = await users
            .query()
            .orderByField('id')
            .select(const <String>['email'])
            .page(size: 2, before: <String, Object?>{'id': 4})
            .pageResult();

        expect(
          firstPage.items.map((row) => row['email']).toList(growable: false),
          <Object?>['a@x.com', 'b@x.com'],
        );
        expect(firstPage.items.first.containsKey('id'), isFalse);
        expect(firstPage.pageInfo.startCursor, <String, Object?>{'id': 1});
        expect(firstPage.pageInfo.endCursor, <String, Object?>{'id': 2});
        expect(firstPage.pageInfo.hasPreviousPage, isFalse);
        expect(firstPage.pageInfo.hasNextPage, isTrue);

        expect(
          beforePage.items.map((row) => row['email']).toList(growable: false),
          <Object?>['b@x.com', 'c@x.com'],
        );
        expect(beforePage.pageInfo.startCursor, <String, Object?>{'id': 2});
        expect(beforePage.pageInfo.endCursor, <String, Object?>{'id': 3});
        expect(beforePage.pageInfo.hasPreviousPage, isTrue);
        expect(beforePage.pageInfo.hasNextPage, isFalse);
      } finally {
        await client.disconnect();
      }
    });

    test('direct plan execution supports cursor and page plans', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      try {
        final users = client.db.orm.model('User');
        await users.create(
          data: <String, Object?>{'id': 1, 'email': 'a@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 2, 'email': 'b@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 3, 'email': 'c@x.com'},
        );
        await users.create(
          data: <String, Object?>{'id': 4, 'email': 'd@x.com'},
        );

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
        final cursorRows = await _readEngineRows(cursorResponse);
        final pageRows = await _readEngineRows(pageResponse);

        expect(
          cursorRows.map((row) => row['id']).toList(growable: false),
          <Object?>[2, 3, 4],
        );
        expect(
          pageRows.map((row) => row['id']).toList(growable: false),
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
        () =>
            users.query().orderByField('id').cursor(const <String, Object?>{}),
        throwsA(isA<PlanCursorWindowInvalidException>()),
      );
      expect(
        () => users.query().orderByField('id').page(size: 0),
        throwsA(isA<PlanCursorWindowInvalidException>()),
      );
      expect(
        () => users
            .query()
            .orderByField('id')
            .page(
              size: 10,
              after: <String, Object?>{'id': 'u1'},
              before: <String, Object?>{'id': 'u2'},
            ),
        throwsA(isA<PlanCursorWindowInvalidException>()),
      );
    });

    test('cursor and page require orderBy first', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users.query().cursor(<String, Object?>{'id': 'u1'}),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.CURSOR_ORDER_BY_REQUIRED',
          ),
        ),
      );
      expect(
        () => users.query().page(size: 2, after: <String, Object?>{'id': 'u1'}),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.CURSOR_ORDER_BY_REQUIRED',
          ),
        ),
      );
    });

    test('cursor and page require stable id-suffixed ordering', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users.query().orderByField('email').cursor(<String, Object?>{
          'email': 'a@x.com',
        }),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.CURSOR_STABLE_ORDER_REQUIRED',
          ),
        ),
      );
      expect(
        () => users
            .query()
            .orderByField('email')
            .page(size: 2, after: <String, Object?>{'email': 'a@x.com'}),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.CURSOR_STABLE_ORDER_REQUIRED',
          ),
        ),
      );
    });

    test('pageResult requires page() first', () {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      final users = client.db.orm.model('User');

      expect(
        () => users.query().orderByField('id').pageResult(),
        throwsA(
          isA<OrmRuntimeError>().having(
            (error) => error.code,
            'code',
            'PLAN.PAGE_RESULT_REQUIRES_PAGE_WINDOW',
          ),
        ),
      );
    });

    test(
      'updateMany placeholder throws stable not implemented error',
      () async {
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
      },
    );
  });
}

final class _ExplainOnlySqlDriver
    implements TargetDriver<SqlStatement, SqlResult> {
  @override
  Future<void> open() async {}

  @override
  Future<void> close() async {}

  @override
  Future<SqlResult> execute(SqlStatement request) {
    throw StateError('explain() should not execute the SQL driver.');
  }
}

final class _ExecuteForbiddenEngine implements OrmEngine {
  int executeCount = 0;

  @override
  Future<void> close() async {}

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    executeCount += 1;
    throw StateError('heuristic explain should not execute the engine.');
  }

  @override
  Future<void> open() async {}
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
  void onRow(JsonMap row, OrmPlan plan, PluginContext ctx) {
    events.add('row:${plan.action.name}');
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

final class _CountingSqlDriver
    implements TargetDriver<SqlStatement, SqlResult> {
  final List<JsonMap> rows;
  int executeCount = 0;

  _CountingSqlDriver({required this.rows});

  @override
  Future<void> open() async {}

  @override
  Future<void> close() async {}

  @override
  Future<SqlResult> execute(SqlStatement request) async {
    executeCount += 1;
    return SqlResult(rows: rows);
  }
}

final class _StreamingSqlDriver extends _CountingSqlDriver
    implements ReadStreamCapableTargetDriver<SqlStatement, JsonMap> {
  int streamCount = 0;

  _StreamingSqlDriver({required super.rows});

  @override
  Stream<JsonMap> stream(SqlStatement request) async* {
    streamCount += 1;
    for (final row in rows) {
      yield row;
    }
  }
}

Future<List<JsonMap>> _readEngineRows(EngineResponse response) async {
  final rows = <JsonMap>[];
  await for (final row in response.rows) {
    if (row is! Map<String, Object?>) {
      throw StateError('Expected engine row map but got ${row.runtimeType}.');
    }
    rows.add(row);
  }
  return rows;
}
