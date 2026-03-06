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

  group('operation telemetry aggregation', () {
    test('aggregates createMany into one operation record', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      final rows = await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u2', 'email': 'b@x.com'},
        ],
      );

      expect(rows, hasLength(2));
      final telemetry = client.operationTelemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.kind, 'User.createMany');
      expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
      expect(telemetry?.completed, isTrue);
      expect(telemetry?.statementCount, 2);
      expect(telemetry?.affectedRows, 2);
      expect(
        telemetry?.steps.map((step) => step.trace.phase).toList(),
        <String>['item.create', 'item.create'],
      );
      expect(telemetry?.steps.map((step) => step.trace.step).toList(), <int>[
        1,
        2,
      ]);
      expect(
        client.operationTelemetry(telemetry!.operationId)?.operationId,
        telemetry.operationId,
      );
      await client.disconnect();
    });

    test(
      'aggregates fallback update reload into one operation record',
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

        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        );
        final row = await users.update(
          where: <String, Object?>{'id': 'u1'},
          data: <String, Object?>{'email': 'b@x.com'},
          select: const <String>['id', 'email'],
        );

        expect(row, <String, Object?>{'id': 'u1', 'email': 'b@x.com'});
        final telemetry = client.operationTelemetry();
        expect(telemetry, isNotNull);
        expect(telemetry?.kind, 'User.update');
        expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
        expect(telemetry?.completed, isTrue);
        expect(telemetry?.statementCount, 2);
        expect(telemetry?.rowCount, 1);
        expect(telemetry?.affectedRows, 1);
        expect(
          telemetry?.steps.map((step) => step.trace.phase).toList(),
          <String>['write', 'fallback.reload'],
        );
        expect(
          telemetry?.steps.map((step) => step.outcome).toList(),
          <RuntimeTelemetryOutcome>[
            RuntimeTelemetryOutcome.success,
            RuntimeTelemetryOutcome.success,
          ],
        );
        await client.disconnect();
      },
    );

    test(
      'aggregates fallback delete preload into one operation record',
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

        await users.create(
          data: <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        );
        final row = await users.delete(
          where: <String, Object?>{'id': 'u1'},
          select: const <String>['id', 'email'],
        );

        expect(row, <String, Object?>{'id': 'u1', 'email': 'a@x.com'});
        final telemetry = client.operationTelemetry();
        expect(telemetry, isNotNull);
        expect(telemetry?.kind, 'User.delete');
        expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
        expect(telemetry?.completed, isTrue);
        expect(telemetry?.statementCount, 2);
        expect(telemetry?.rowCount, 1);
        expect(telemetry?.affectedRows, 1);
        expect(
          telemetry?.steps.map((step) => step.trace.phase).toList(),
          <String>['fallback.preload', 'write'],
        );
        expect(telemetry?.steps.map((step) => step.trace.step).toList(), <int>[
          1,
          2,
        ]);
        await client.disconnect();
      },
    );

    test('keeps repeated operations isolated in recent history', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
        ],
      );
      final first = client.operationTelemetry();
      await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u2', 'email': 'b@x.com'},
          <String, Object?>{'id': 'u3', 'email': 'c@x.com'},
        ],
      );
      final second = client.operationTelemetry();
      final recent = client.recentOperationTelemetry(limit: 2);

      expect(first, isNotNull);
      expect(second, isNotNull);
      expect(second?.operationId, isNot(first?.operationId));
      expect(recent, hasLength(2));
      expect(recent.first.operationId, second?.operationId);
      expect(recent.first.statementCount, 2);
      expect(recent.last.operationId, first?.operationId);
      expect(recent.last.statementCount, 1);
      expect(
        recent.map((event) => event.kind).toList(growable: false),
        <String>['User.createMany', 'User.createMany'],
      );
      await client.disconnect();
    });

    test('aggregates updateCount into one operation record', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u3', 'email': 'b@x.com'},
        ],
      );

      final updated = await users.updateCount(
        where: <String, Object?>{'email': 'a@x.com'},
        data: <String, Object?>{'email': 'updated@x.com'},
      );

      expect(updated, 2);
      final telemetry = client.operationTelemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.kind, 'User.updateCount');
      expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
      expect(telemetry?.completed, isTrue);
      expect(telemetry?.statementCount, 3);
      expect(telemetry?.affectedRows, 2);
      expect(
        telemetry?.steps.map((step) => step.trace.phase).toList(),
        <String>['batch.lookup', 'item.update', 'item.update'],
      );
      expect(
        telemetry?.steps.map((step) => step.trace.step).toList(),
        <int>[1, 2, 3],
      );
      expect(
        telemetry?.steps.map((step) => step.trace.itemIndex).toList(),
        <int?>[null, 0, 1],
      );
      await client.disconnect();
    });

    test('aggregates updateAll into one operation record', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u3', 'email': 'b@x.com'},
        ],
      );

      final updated = await users
          .query()
          .where(<String, Object?>{'email': 'a@x.com'})
          .select(const <String>['id', 'email'])
          .updateAll(data: <String, Object?>{'email': 'updated@x.com'});

      expect(updated, hasLength(2));
      final telemetry = client.operationTelemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.kind, 'User.updateAll');
      expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
      expect(telemetry?.completed, isTrue);
      expect(telemetry?.statementCount, 3);
      expect(telemetry?.affectedRows, 2);
      expect(
        telemetry?.steps.map((step) => step.trace.phase).toList(),
        <String>['batch.lookup', 'item.update', 'item.update'],
      );
      expect(
        telemetry?.steps.map((step) => step.trace.itemIndex).toList(),
        <int?>[null, 0, 1],
      );
      await client.disconnect();
    });

    test('aggregates deleteAll into one operation record', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u2', 'email': 'a@x.com'},
          <String, Object?>{'id': 'u3', 'email': 'b@x.com'},
        ],
      );

      final deleted = await users
          .query()
          .where(<String, Object?>{'email': 'a@x.com'})
          .select(const <String>['id', 'email'])
          .deleteAll();

      expect(deleted, hasLength(2));
      final telemetry = client.operationTelemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.kind, 'User.deleteAll');
      expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
      expect(telemetry?.completed, isTrue);
      expect(telemetry?.statementCount, 3);
      expect(telemetry?.affectedRows, 2);
      expect(
        telemetry?.steps.map((step) => step.trace.phase).toList(),
        <String>['batch.lookup', 'item.delete', 'item.delete'],
      );
      expect(
        telemetry?.steps.map((step) => step.trace.itemIndex).toList(),
        <int?>[null, 0, 1],
      );
      await client.disconnect();
    });

    test('aggregates pageResult probes into one operation record', () async {
      final client = OrmClient(contract: contract, engine: MemoryEngine());
      await client.connect();
      final users = client.db.orm.model('User');

      await users.createMany(
        data: <JsonMap>[
          <String, Object?>{'id': 1, 'email': 'a@x.com'},
          <String, Object?>{'id': 2, 'email': 'b@x.com'},
          <String, Object?>{'id': 3, 'email': 'c@x.com'},
          <String, Object?>{'id': 4, 'email': 'd@x.com'},
        ],
      );

      final result = await users
          .query()
          .orderByField('id')
          .page(size: 2, after: <String, Object?>{'id': 1})
          .pageResult();

      expect(
        result.items.map((row) => row['id']).toList(growable: false),
        <Object?>[2, 3],
      );
      expect(result.pageInfo.hasPreviousPage, isTrue);
      expect(result.pageInfo.hasNextPage, isTrue);

      final telemetry = client.operationTelemetry();
      expect(telemetry, isNotNull);
      expect(telemetry?.kind, 'User.pageResult');
      expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
      expect(telemetry?.completed, isTrue);
      expect(telemetry?.statementCount, 2);
      expect(
        telemetry?.steps.map((step) => step.trace.phase).toList(),
        <String>['page.items', 'page.probe'],
      );
      expect(
        telemetry?.steps.map((step) => step.trace.strategy).toList(),
        <String>['windowPlusOne', 'beforeBoundary'],
      );
      expect(telemetry?.steps.map((step) => step.trace.step).toList(), <int>[
        1,
        2,
      ]);
      expect(telemetry?.steps.first.rowCount, 3);
      expect(telemetry?.steps.last.rowCount, 1);
      await client.disconnect();
    });

    test(
      'records interrupted operation telemetry when consumer stops pulling',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();
        final users = client.db.orm.model('User');

        await users.createMany(
          data: <JsonMap>[
            <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
            <String, Object?>{'id': 'u2', 'email': 'b@x.com'},
            <String, Object?>{'id': 'u3', 'email': 'c@x.com'},
          ],
        );

        final response = await client.execute(
          OrmPlan.read(
            contractHash: contract.hash,
            model: 'User',
            repositoryTrace: const OrmRepositoryTrace(
              operationId: 'op-stream-stop',
              kind: 'User.streamProbe',
              step: 1,
              phase: 'stream.read',
              strategy: 'manual',
            ),
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            resultMode: OrmReadResultMode.all,
          ),
        );

        final rows = await response.rows.take(1).toList();
        expect(rows, hasLength(1));

        final telemetry = client.operationTelemetry();
        expect(telemetry, isNotNull);
        expect(telemetry?.kind, 'User.streamProbe');
        expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
        expect(telemetry?.completed, isFalse);
        expect(telemetry?.statementCount, 1);
        expect(telemetry?.rowCount, 1);
        expect(telemetry?.steps.single.completed, isFalse);
        expect(telemetry?.steps.single.trace.phase, 'stream.read');
        await client.disconnect();
      },
    );

    test(
      'records runtime error operation telemetry when stream fails after rows',
      () async {
        final client = OrmClient(
          contract: contract,
          engine: _FailingStreamEngine(),
        );
        await client.connect();

        final response = await client.execute(
          OrmPlan.read(
            contractHash: contract.hash,
            model: 'User',
            repositoryTrace: const OrmRepositoryTrace(
              operationId: 'op-stream-fail',
              kind: 'User.streamProbe',
              step: 1,
              phase: 'stream.read',
              strategy: 'manual',
            ),
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            resultMode: OrmReadResultMode.all,
          ),
        );

        await expectLater(response.rows.toList(), throwsA(isA<StateError>()));

        final telemetry = client.operationTelemetry();
        expect(telemetry, isNotNull);
        expect(telemetry?.kind, 'User.streamProbe');
        expect(telemetry?.outcome, RuntimeTelemetryOutcome.runtimeError);
        expect(telemetry?.completed, isFalse);
        expect(telemetry?.statementCount, 1);
        expect(telemetry?.rowCount, 1);
        expect(
          telemetry?.steps.single.executionMode,
          EngineExecutionMode.stream,
        );
        expect(
          telemetry?.steps.single.executionSource,
          EngineExecutionSource.directStream,
        );
        expect(
          telemetry?.steps.single.outcome,
          RuntimeTelemetryOutcome.runtimeError,
        );
        expect(telemetry?.steps.single.completed, isFalse);
        expect(telemetry?.steps.single.trace.phase, 'stream.read');
        await client.disconnect();
      },
    );

    test(
      'keeps operation completed false after interrupted step then successful step',
      () async {
        final client = OrmClient(contract: contract, engine: MemoryEngine());
        await client.connect();
        final users = client.db.orm.model('User');

        await users.createMany(
          data: <JsonMap>[
            <String, Object?>{'id': 'u1', 'email': 'a@x.com'},
            <String, Object?>{'id': 'u2', 'email': 'b@x.com'},
            <String, Object?>{'id': 'u3', 'email': 'c@x.com'},
          ],
        );

        final first = await client.execute(
          OrmPlan.read(
            contractHash: contract.hash,
            model: 'User',
            repositoryTrace: const OrmRepositoryTrace(
              operationId: 'op-stream-sticky',
              kind: 'User.streamProbe',
              step: 1,
              phase: 'stream.read',
              strategy: 'manual',
            ),
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            resultMode: OrmReadResultMode.all,
          ),
        );
        await first.rows.take(1).toList();

        final second = await client.execute(
          OrmPlan.read(
            contractHash: contract.hash,
            model: 'User',
            repositoryTrace: const OrmRepositoryTrace(
              operationId: 'op-stream-sticky',
              kind: 'User.streamProbe',
              step: 2,
              phase: 'stream.read',
              strategy: 'manual',
            ),
            orderBy: const <OrmOrderBy>[OrmOrderBy('id')],
            where: const <String, Object?>{'id': 'u2'},
            resultMode: OrmReadResultMode.all,
          ),
        );
        final rows = await second.rows.toList();

        expect(rows, hasLength(1));

        final telemetry = client.operationTelemetry();
        expect(telemetry, isNotNull);
        expect(telemetry?.kind, 'User.streamProbe');
        expect(telemetry?.outcome, RuntimeTelemetryOutcome.success);
        expect(telemetry?.completed, isFalse);
        expect(telemetry?.statementCount, 2);
        expect(telemetry?.rowCount, 2);
        expect(telemetry?.steps.map((step) => step.completed).toList(), <bool>[
          false,
          true,
        ]);
        expect(
          telemetry?.steps.map((step) => step.executionMode).toList(),
          <EngineExecutionMode>[
            EngineExecutionMode.buffered,
            EngineExecutionMode.buffered,
          ],
        );
        await client.disconnect();
      },
    );
  });
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
