import '../engine/engine.dart';
import '../runtime/errors.dart';
import '../runtime/plan.dart';
import 'adapter.dart';
import 'driver.dart';

final class AdapterDriverEngine<TRequest, TRawResponse>
    implements OrmEngine, ConnectionCapableEngine {
  final TargetAdapter<TRequest, TRawResponse> adapter;
  final TargetDriver<TRequest, TRawResponse> driver;
  bool _opened = false;

  AdapterDriverEngine({required this.adapter, required this.driver});

  @override
  Future<void> open() async {
    if (_opened) {
      return;
    }
    await driver.open();
    _opened = true;
  }

  @override
  Future<void> close() async {
    if (!_opened) {
      return;
    }
    await driver.close();
    _opened = false;
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _ensureOpen();

    final request = adapter.lower(plan);
    final raw = await driver.execute(request);
    return adapter.decode(raw, plan);
  }

  @override
  Future<EngineConnection> connection() async {
    _ensureOpen();

    if (driver
        case final TargetDriverConnectionCapable<TRequest, TRawResponse>
            connectionDriver) {
      final connection = await connectionDriver.connection();
      return _AdapterDriverConnection<TRequest, TRawResponse>(
        adapter: adapter,
        connection: connection,
      );
    }

    throw RuntimeConnectionNotSupportedException();
  }

  void _ensureOpen() {
    if (_opened) {
      return;
    }
    throw StateError(
      'AdapterDriverEngine is closed. Call open() before execute().',
    );
  }
}

final class _AdapterDriverConnection<TRequest, TRawResponse>
    implements EngineConnection {
  final TargetAdapter<TRequest, TRawResponse> adapter;
  final TargetDriverConnection<TRequest, TRawResponse> connection;
  bool _released = false;

  _AdapterDriverConnection({required this.adapter, required this.connection});

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _ensureActive();
    final request = adapter.lower(plan);
    final raw = await connection.execute(request);
    return adapter.decode(raw, plan);
  }

  @override
  Future<EngineTransaction> transaction() async {
    _ensureActive();
    final transaction = await connection.transaction();
    return _AdapterDriverTransaction<TRequest, TRawResponse>(
      adapter: adapter,
      transaction: transaction,
    );
  }

  @override
  Future<void> release() async {
    _released = true;
    await connection.release();
  }

  void _ensureActive() {
    if (_released) {
      throw StateError('Adapter driver connection has been released.');
    }
  }
}

final class _AdapterDriverTransaction<TRequest, TRawResponse>
    implements EngineTransaction {
  final TargetAdapter<TRequest, TRawResponse> adapter;
  final TargetDriverTransaction<TRequest, TRawResponse> transaction;
  bool _completed = false;

  _AdapterDriverTransaction({required this.adapter, required this.transaction});

  @override
  Future<void> commit() async {
    _ensureActive();
    _completed = true;
    await transaction.commit();
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _ensureActive();
    final request = adapter.lower(plan);
    final raw = await transaction.execute(request);
    return adapter.decode(raw, plan);
  }

  @override
  Future<void> rollback() async {
    _ensureActive();
    _completed = true;
    await transaction.rollback();
  }

  void _ensureActive() {
    if (_completed) {
      throw StateError('Adapter driver transaction is already completed.');
    }
  }
}
