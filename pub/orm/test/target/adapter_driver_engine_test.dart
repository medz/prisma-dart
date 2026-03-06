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
    expect(adapter.decodedRaw, <String>['driver:User:read']);
    expect(driver.requests, <String>['User:read']);
    expect(response.affectedRows, 1);

    final rows = await response.rows.toList();
    final row = rows.single;
    expect(row, isA<Map<String, Object?>>());
    if (row case final Map<String, Object?> map) {
      expect(map['request'], 'User:read');
      expect(map['action'], 'read');
      expect(map['whereId'], 'u1');
    } else {
      fail('Expected map response data.');
    }

    await engine.close();
  });

  test(
    'describes lowered plan through driver explain without executing',
    () async {
      final adapter = _ExplainTrackingAdapter();
      final driver = _ExplainTrackingDriver();
      final engine = AdapterDriverEngine<String, String>(
        adapter: adapter,
        driver: driver,
      );

      await engine.open();
      final description = await engine.describePlan(
        _plan(where: <String, Object?>{'id': 'u1'}),
      );

      expect(adapter.loweredPlans, hasLength(1));
      expect(driver.requests, isEmpty);
      expect(driver.explainRequests, <String>['User:read']);
      expect(description['source'], 'driver');
      expect(description['request'], <String, Object?>{
        'kind': 'tracking',
        'value': 'User:read',
      });
      expect(description['driver'], <String, Object?>{
        'scope': 'driver',
        'value': 'User:read',
      });

      await engine.close();
    },
  );

  test(
    'prefers native read streaming when adapter and driver support it',
    () async {
      final adapter = _StreamingTrackingAdapter();
      final driver = _StreamingTrackingDriver(
        streamedRows: <String>['stream:u1', 'stream:u2'],
      );
      final engine = AdapterDriverEngine<String, String>(
        adapter: adapter,
        driver: driver,
      );

      await engine.open();
      final response = await engine.execute(_plan());
      final rows = await response.rows.toList();

      expect(driver.requests, isEmpty);
      expect(driver.streamRequests, <String>['User:read']);
      expect(adapter.decodedRaw, isEmpty);
      expect(adapter.streamDecodedPlans, hasLength(1));
      expect(rows, <JsonMap>[
        <String, Object?>{'request': 'User:read', 'streamed': 'stream:u1'},
        <String, Object?>{'request': 'User:read', 'streamed': 'stream:u2'},
      ]);

      await engine.close();
    },
  );

  test(
    'keeps mutations on buffered execute when streaming is available',
    () async {
      final adapter = _StreamingTrackingAdapter();
      final driver = _StreamingTrackingDriver(
        streamedRows: <String>['ignored'],
      );
      final engine = AdapterDriverEngine<String, String>(
        adapter: adapter,
        driver: driver,
      );

      await engine.open();
      final response = await engine.execute(_createPlan());

      expect(driver.streamRequests, isEmpty);
      expect(driver.requests, <String>['User:create']);
      expect(adapter.streamDecodedPlans, isEmpty);
      expect(adapter.decodedRaw, <String>['driver:User:create']);
      expect(await response.rows.toList(), <JsonMap>[
        <String, Object?>{
          'request': 'User:create',
          'action': 'create',
          'whereId': null,
        },
      ]);

      await engine.close();
    },
  );

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
    expect(driver.connections.single.requests, <String>['User:read']);
    expect(adapter.decodedRaw, <String>['connection:User:read']);
    expect(response.affectedRows, 1);

    await connection.release();
    expect(driver.connections.single.releaseCount, 1);
    await expectLater(connection.execute(_plan()), throwsA(isA<StateError>()));
    await expectLater(connection.transaction(), throwsA(isA<StateError>()));
    await engine.close();
  });

  test('connection describePlan uses scoped driver explain surface', () async {
    final adapter = _ExplainTrackingAdapter();
    final driver = _ConnectionCapableTrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    final connection = await engine.connection();
    final description = await (connection as ExplainCapableEngineConnection)
        .describePlan(_plan(where: <String, Object?>{'id': 'u1'}));

    expect(driver.connectionCount, 1);
    expect(driver.connections.single.explainRequests, <String>['User:read']);
    expect(driver.connections.single.requests, isEmpty);
    expect(description['source'], 'driver');
    expect(description['driver'], <String, Object?>{
      'scope': 'connection',
      'value': 'User:read',
    });

    await connection.release();
    await engine.close();
  });

  test(
    'connection prefers native read streaming when scoped driver supports it',
    () async {
      final adapter = _StreamingTrackingAdapter();
      final driver = _ConnectionCapableStreamingDriver(
        streamedRows: <String>['connection:u1', 'connection:u2'],
      );
      final engine = AdapterDriverEngine<String, String>(
        adapter: adapter,
        driver: driver,
      );

      await engine.open();
      final connection = await engine.connection();
      final response = await connection.execute(_plan());
      final rows = await response.rows.toList();

      final inner = driver.connections.single as _StreamingConnection;
      expect(inner.requests, isEmpty);
      expect(inner.streamRequests, <String>['User:read']);
      expect(adapter.decodedRaw, isEmpty);
      expect(adapter.streamDecodedPlans, hasLength(1));
      expect(response.executionMode, EngineExecutionMode.stream);
      expect(response.executionSource, EngineExecutionSource.directStream);
      expect(rows, <JsonMap>[
        <String, Object?>{'request': 'User:read', 'streamed': 'connection:u1'},
        <String, Object?>{'request': 'User:read', 'streamed': 'connection:u2'},
      ]);

      await connection.release();
      await engine.close();
    },
  );

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
    expect(inner.requests, <String>['User:read']);
    expect(adapter.decodedRaw, <String>['transaction:User:read']);
    expect(inner.commitCount, 1);
    expect(inner.rollbackCount, 0);

    await expectLater(transaction.execute(_plan()), throwsA(isA<StateError>()));
    await expectLater(transaction.commit(), throwsA(isA<StateError>()));
    await expectLater(transaction.rollback(), throwsA(isA<StateError>()));
    await connection.release();
    await engine.close();
  });

  test(
    'transaction prefers native read streaming when scoped driver supports it',
    () async {
      final adapter = _StreamingTrackingAdapter();
      final driver = _ConnectionCapableStreamingDriver(
        streamedRows: <String>['transaction:u1', 'transaction:u2'],
      );
      final engine = AdapterDriverEngine<String, String>(
        adapter: adapter,
        driver: driver,
      );

      await engine.open();
      final connection = await engine.connection();
      final transaction = await connection.transaction();
      final response = await transaction.execute(_plan());
      final rows = await response.rows.toList();

      final inner =
          driver.connections.single.transactions.single
              as _StreamingTransaction;
      expect(inner.requests, isEmpty);
      expect(inner.streamRequests, <String>['User:read']);
      expect(adapter.decodedRaw, isEmpty);
      expect(adapter.streamDecodedPlans, hasLength(1));
      expect(response.executionMode, EngineExecutionMode.stream);
      expect(response.executionSource, EngineExecutionSource.directStream);
      expect(rows, <JsonMap>[
        <String, Object?>{'request': 'User:read', 'streamed': 'transaction:u1'},
        <String, Object?>{'request': 'User:read', 'streamed': 'transaction:u2'},
      ]);

      await transaction.rollback();
      await connection.release();
      await engine.close();
    },
  );

  test('transaction describePlan uses scoped driver explain surface', () async {
    final adapter = _ExplainTrackingAdapter();
    final driver = _ConnectionCapableTrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    final connection = await engine.connection();
    final transaction = await connection.transaction();
    final description = await (transaction as ExplainCapableEngineTransaction)
        .describePlan(_plan(where: <String, Object?>{'id': 'u2'}));

    final inner = driver.connections.single.transactions.single;
    expect(inner.explainRequests, <String>['User:read']);
    expect(inner.requests, isEmpty);
    expect(description['source'], 'driver');
    expect(description['driver'], <String, Object?>{
      'scope': 'transaction',
      'value': 'User:read',
    });

    await transaction.rollback();
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
    action: OrmAction.read,
    read: OrmReadPlan(where: where, resultMode: OrmReadResultMode.all),
  );
}

OrmPlan _createPlan() {
  return OrmPlan(
    contractHash: 'hash',
    model: 'User',
    action: OrmAction.create,
    mutation: OrmMutationPlan(
      data: const <String, Object?>{'id': 'u1'},
      resultMode: OrmMutationResultMode.row,
    ),
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
    return EngineResponse.buffered(<String, Object?>{
      'request': '${plan.model}:${plan.action.name}',
      'action': plan.action.name,
      'whereId': plan.read?.where['id'],
    }, affectedRows: 1);
  }
}

final class _ExplainTrackingAdapter extends _TrackingAdapter
    implements ExplainCapableTargetAdapter<String, String> {
  @override
  JsonMap describe(OrmPlan plan, String request, {JsonMap? driverExplain}) {
    return <String, Object?>{
      'source': driverExplain == null ? 'adapter' : 'driver',
      'request': <String, Object?>{'kind': 'tracking', 'value': request},
      if (driverExplain != null) 'driver': driverExplain,
    };
  }
}

final class _StreamingTrackingAdapter extends _TrackingAdapter
    implements ReadStreamCapableTargetAdapter<String, String> {
  final List<OrmPlan> streamDecodedPlans = <OrmPlan>[];

  @override
  Stream<Object?> decodeReadRows(Stream<String> rows, OrmPlan plan) async* {
    streamDecodedPlans.add(plan);
    await for (final row in rows) {
      yield <String, Object?>{
        'request': '${plan.model}:${plan.action.name}',
        'streamed': row,
      };
    }
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

final class _ExplainTrackingDriver extends _TrackingDriver
    implements ExplainCapableTargetDriver<String> {
  final List<String> explainRequests = <String>[];

  @override
  Future<JsonMap> explain(String request) async {
    explainRequests.add(request);
    return <String, Object?>{'scope': 'driver', 'value': request};
  }
}

final class _StreamingTrackingDriver extends _TrackingDriver
    implements ReadStreamCapableTargetDriver<String, String> {
  final List<String> streamedRows;
  final List<String> streamRequests = <String>[];

  _StreamingTrackingDriver({required this.streamedRows});

  @override
  Stream<String> stream(String request) async* {
    streamRequests.add(request);
    for (final row in streamedRows) {
      yield row;
    }
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

final class _ConnectionCapableStreamingDriver
    extends _ConnectionCapableTrackingDriver {
  final List<String> streamedRows;

  _ConnectionCapableStreamingDriver({required this.streamedRows});

  @override
  Future<TargetDriverConnection<String, String>> connection() async {
    connectionCount += 1;
    final connection = _StreamingConnection(streamedRows: streamedRows);
    connections.add(connection);
    return connection;
  }
}

final class _TrackingConnection
    implements
        TargetDriverConnection<String, String>,
        ExplainCapableTargetDriverConnection<String> {
  int releaseCount = 0;
  int transactionCount = 0;
  final List<String> requests = <String>[];
  final List<String> explainRequests = <String>[];
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

  @override
  Future<JsonMap> explain(String request) async {
    explainRequests.add(request);
    return <String, Object?>{'scope': 'connection', 'value': request};
  }
}

final class _StreamingConnection extends _TrackingConnection
    implements ReadStreamCapableTargetDriverConnection<String, String> {
  final List<String> streamedRows;
  final List<String> streamRequests = <String>[];

  _StreamingConnection({required this.streamedRows});

  @override
  Stream<String> stream(String request) async* {
    streamRequests.add(request);
    for (final row in streamedRows) {
      yield row;
    }
  }

  @override
  Future<TargetDriverTransaction<String, String>> transaction() async {
    transactionCount += 1;
    final transaction = _StreamingTransaction(streamedRows: streamedRows);
    transactions.add(transaction);
    return transaction;
  }
}

final class _TrackingTransaction
    implements
        TargetDriverTransaction<String, String>,
        ExplainCapableTargetDriverTransaction<String> {
  int commitCount = 0;
  int rollbackCount = 0;
  final List<String> requests = <String>[];
  final List<String> explainRequests = <String>[];

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

  @override
  Future<JsonMap> explain(String request) async {
    explainRequests.add(request);
    return <String, Object?>{'scope': 'transaction', 'value': request};
  }
}

final class _StreamingTransaction extends _TrackingTransaction
    implements ReadStreamCapableTargetDriverTransaction<String, String> {
  final List<String> streamedRows;
  final List<String> streamRequests = <String>[];

  _StreamingTransaction({required this.streamedRows});

  @override
  Stream<String> stream(String request) async* {
    streamRequests.add(request);
    for (final row in streamedRows) {
      yield row;
    }
  }
}
