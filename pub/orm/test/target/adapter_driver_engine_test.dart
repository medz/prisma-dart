import 'package:orm/orm.dart';
import 'package:test/test.dart';

void main() {
  test('forwards open and close to target driver', () async {
    final adapter = _TrackingAdapter();
    final driver = _TrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    await engine.close();

    expect(driver.openCount, 1);
    expect(driver.closeCount, 1);
  });

  test('keeps open and close idempotent', () async {
    final driver = _TrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: _TrackingAdapter(),
      driver: driver,
    );

    await engine.open();
    await engine.open();
    await engine.close();
    await engine.close();

    expect(driver.openCount, 1);
    expect(driver.closeCount, 1);
  });

  test('requires open before execute', () async {
    final engine = AdapterDriverEngine<String, String>(
      adapter: _TrackingAdapter(),
      driver: _TrackingDriver(),
    );

    await expectLater(engine.execute(_plan()), throwsA(isA<StateError>()));
  });

  test('requires open before connection', () async {
    final engine = AdapterDriverEngine<String, String>(
      adapter: _TrackingAdapter(),
      driver: _ConnectionCapableTrackingDriver(),
    );

    await expectLater(engine.connection(), throwsA(isA<StateError>()));
  });

  test(
    'throws not supported when driver has no connection capability',
    () async {
      final engine = AdapterDriverEngine<String, String>(
        adapter: _TrackingAdapter(),
        driver: _TrackingDriver(),
      );

      await engine.open();
      await expectLater(
        engine.connection(),
        throwsA(isA<RuntimeConnectionNotSupportedException>()),
      );
      await engine.close();
    },
  );

  test('executes lowering and decode pipeline', () async {
    final adapter = _TrackingAdapter();
    final driver = _TrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    final response = await engine.execute(
      _plan(where: <String, Object?>{'id': 'u1'}),
    );

    expect(adapter.loweredPlans, hasLength(1));
    expect(adapter.decodedRaw, <String>['driver:User:findMany']);
    expect(driver.requests, <String>['User:findMany']);
    expect(response.affectedRows, 1);

    final row = response.data;
    expect(row, isA<Map<String, Object?>>());
    if (row case final Map<String, Object?> map) {
      expect(map['request'], 'User:findMany');
      expect(map['action'], 'findMany');
      expect(map['whereId'], 'u1');
    } else {
      fail('Expected map response data.');
    }

    await engine.close();
  });

  test('supports connection lifecycle when driver is capable', () async {
    final adapter = _TrackingAdapter();
    final driver = _ConnectionCapableTrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    final connection = await engine.connection();
    final response = await connection.execute(
      _plan(where: <String, Object?>{'id': 'u1'}),
    );

    expect(driver.connectionCount, 1);
    expect(driver.connections.single.requests, <String>['User:findMany']);
    expect(adapter.decodedRaw, <String>['connection:User:findMany']);
    expect(response.affectedRows, 1);

    await connection.release();
    expect(driver.connections.single.releaseCount, 1);
    await expectLater(connection.execute(_plan()), throwsA(isA<StateError>()));
    await expectLater(connection.transaction(), throwsA(isA<StateError>()));
    await engine.close();
  });

  test('forwards transaction commit and marks transaction completed', () async {
    final adapter = _TrackingAdapter();
    final driver = _ConnectionCapableTrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    final connection = await engine.connection();
    final transaction = await connection.transaction();
    await transaction.execute(_plan(where: <String, Object?>{'id': 'u2'}));
    await transaction.commit();

    final inner = driver.connections.single.transactions.single;
    expect(inner.requests, <String>['User:findMany']);
    expect(adapter.decodedRaw, <String>['transaction:User:findMany']);
    expect(inner.commitCount, 1);
    expect(inner.rollbackCount, 0);

    await expectLater(transaction.execute(_plan()), throwsA(isA<StateError>()));
    await expectLater(transaction.commit(), throwsA(isA<StateError>()));
    await expectLater(transaction.rollback(), throwsA(isA<StateError>()));
    await connection.release();
    await engine.close();
  });

  test(
    'forwards transaction rollback and marks transaction completed',
    () async {
      final driver = _ConnectionCapableTrackingDriver();
      final engine = AdapterDriverEngine<String, String>(
        adapter: _TrackingAdapter(),
        driver: driver,
      );

      await engine.open();
      final connection = await engine.connection();
      final transaction = await connection.transaction();
      await transaction.execute(_plan(where: <String, Object?>{'id': 'u3'}));
      await transaction.rollback();

      final inner = driver.connections.single.transactions.single;
      expect(inner.commitCount, 0);
      expect(inner.rollbackCount, 1);

      await expectLater(
        transaction.execute(_plan()),
        throwsA(isA<StateError>()),
      );
      await expectLater(transaction.commit(), throwsA(isA<StateError>()));
      await expectLater(transaction.rollback(), throwsA(isA<StateError>()));
      await connection.release();
      await engine.close();
    },
  );
}

OrmPlan _plan({JsonMap where = const <String, Object?>{}}) {
  return OrmPlan(
    contractHash: 'hash',
    model: 'User',
    action: OrmAction.findMany,
    where: where,
  );
}

final class _TrackingAdapter implements TargetAdapter<String, String> {
  final List<OrmPlan> loweredPlans = <OrmPlan>[];
  final List<String> decodedRaw = <String>[];

  @override
  String lower(OrmPlan plan) {
    loweredPlans.add(plan);
    return '${plan.model}:${plan.action.name}';
  }

  @override
  EngineResponse decode(String response, OrmPlan plan) {
    decodedRaw.add(response);
    return EngineResponse(
      data: <String, Object?>{
        'request': '${plan.model}:${plan.action.name}',
        'action': plan.action.name,
        'whereId': plan.where['id'],
      },
      affectedRows: 1,
    );
  }
}

final class _TrackingDriver implements TargetDriver<String, String> {
  int openCount = 0;
  int closeCount = 0;
  final List<String> requests = <String>[];

  @override
  Future<void> open() async {
    openCount += 1;
  }

  @override
  Future<void> close() async {
    closeCount += 1;
  }

  @override
  Future<String> execute(String request) async {
    requests.add(request);
    return 'driver:$request';
  }
}

final class _ConnectionCapableTrackingDriver
    implements
        TargetDriver<String, String>,
        TargetDriverConnectionCapable<String, String> {
  int openCount = 0;
  int closeCount = 0;
  int connectionCount = 0;
  final List<String> requests = <String>[];
  final List<_TrackingConnection> connections = <_TrackingConnection>[];

  @override
  Future<void> open() async {
    openCount += 1;
  }

  @override
  Future<void> close() async {
    closeCount += 1;
  }

  @override
  Future<String> execute(String request) async {
    requests.add(request);
    return 'driver:$request';
  }

  @override
  Future<TargetDriverConnection<String, String>> connection() async {
    connectionCount += 1;
    final connection = _TrackingConnection();
    connections.add(connection);
    return connection;
  }
}

final class _TrackingConnection
    implements TargetDriverConnection<String, String> {
  int releaseCount = 0;
  int transactionCount = 0;
  final List<String> requests = <String>[];
  final List<_TrackingTransaction> transactions = <_TrackingTransaction>[];

  @override
  Future<String> execute(String request) async {
    requests.add(request);
    return 'connection:$request';
  }

  @override
  Future<void> release() async {
    releaseCount += 1;
  }

  @override
  Future<TargetDriverTransaction<String, String>> transaction() async {
    transactionCount += 1;
    final transaction = _TrackingTransaction();
    transactions.add(transaction);
    return transaction;
  }
}

final class _TrackingTransaction
    implements TargetDriverTransaction<String, String> {
  int commitCount = 0;
  int rollbackCount = 0;
  final List<String> requests = <String>[];

  @override
  Future<void> commit() async {
    commitCount += 1;
  }

  @override
  Future<void> rollback() async {
    rollbackCount += 1;
  }

  @override
  Future<String> execute(String request) async {
    requests.add(request);
    return 'transaction:$request';
  }
}
