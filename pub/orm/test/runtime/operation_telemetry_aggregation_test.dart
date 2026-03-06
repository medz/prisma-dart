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
