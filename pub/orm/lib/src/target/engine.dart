import '../engine/engine.dart';
import '../runtime/errors.dart';
import '../runtime/plan.dart';
import '../runtime/types.dart';
import 'adapter.dart';
import 'driver.dart';

final class AdapterDriverEngine<TRequest, TRawResponse>
    implements OrmEngine, ConnectionCapableEngine, ExplainCapableEngine {
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
    final streamed = _tryExecuteReadStream(
      plan: plan,
      request: request,
      adapter: adapter,
      streamRows: _driverReadStream(driver),
    );
    if (streamed != null) {
      return streamed;
    }
    final raw = await driver.execute(request);
    return adapter.decode(raw, plan);
  }

  @override
  Future<JsonMap> describePlan(OrmPlan plan) async {
    _ensureOpen();
    return _describeTargetPlan(
      plan: plan,
      adapter: adapter,
      request: adapter.lower(plan),
      describeRequest: _driverExplain(driver),
    );
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
    implements EngineConnection, ExplainCapableEngineConnection {
  final TargetAdapter<TRequest, TRawResponse> adapter;
  final TargetDriverConnection<TRequest, TRawResponse> connection;
  bool _released = false;

  _AdapterDriverConnection({required this.adapter, required this.connection});

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _ensureActive();
    final request = adapter.lower(plan);
    final streamed = _tryExecuteReadStream(
      plan: plan,
      request: request,
      adapter: adapter,
      streamRows: _connectionReadStream(connection),
    );
    if (streamed != null) {
      return streamed;
    }
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

  @override
  Future<JsonMap> describePlan(OrmPlan plan) async {
    _ensureActive();
    return _describeTargetPlan(
      plan: plan,
      adapter: adapter,
      request: adapter.lower(plan),
      describeRequest: _connectionExplain(connection),
    );
  }

  void _ensureActive() {
    if (_released) {
      throw StateError('Adapter driver connection has been released.');
    }
  }
}

final class _AdapterDriverTransaction<TRequest, TRawResponse>
    implements EngineTransaction, ExplainCapableEngineTransaction {
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
    final streamed = _tryExecuteReadStream(
      plan: plan,
      request: request,
      adapter: adapter,
      streamRows: _transactionReadStream(transaction),
    );
    if (streamed != null) {
      return streamed;
    }
    final raw = await transaction.execute(request);
    return adapter.decode(raw, plan);
  }

  @override
  Future<void> rollback() async {
    _ensureActive();
    _completed = true;
    await transaction.rollback();
  }

  @override
  Future<JsonMap> describePlan(OrmPlan plan) async {
    _ensureActive();
    return _describeTargetPlan(
      plan: plan,
      adapter: adapter,
      request: adapter.lower(plan),
      describeRequest: _transactionExplain(transaction),
    );
  }

  void _ensureActive() {
    if (_completed) {
      throw StateError('Adapter driver transaction is already completed.');
    }
  }
}

EngineResponse? _tryExecuteReadStream<TRequest>({
  required OrmPlan plan,
  required TRequest request,
  required Object adapter,
  required Stream<dynamic> Function(TRequest request)? streamRows,
}) {
  if (plan.action != OrmAction.read || streamRows == null) {
    return null;
  }
  if (adapter
      case final ReadStreamCapableTargetAdapter<TRequest, dynamic>
          streamAdapter) {
    return EngineResponse(
      rows: streamAdapter.decodeReadRows(streamRows(request), plan),
      executionMode: EngineExecutionMode.stream,
      executionSource: EngineExecutionSource.directStream,
    );
  }
  return null;
}

Future<JsonMap> _describeTargetPlan<TRequest, TRawResponse>({
  required OrmPlan plan,
  required TargetAdapter<TRequest, TRawResponse> adapter,
  required TRequest request,
  required Future<JsonMap> Function(TRequest request)? describeRequest,
}) async {
  final driverExplain = describeRequest == null
      ? null
      : await describeRequest(request);
  if (adapter
      case final ExplainCapableTargetAdapter<TRequest, TRawResponse>
          explainAdapter) {
    return explainAdapter.describe(plan, request, driverExplain: driverExplain);
  }
  return driverExplain ?? const <String, Object?>{};
}

Stream<dynamic> Function(TRequest request)? _driverReadStream<
  TRequest,
  TRawResponse
>(TargetDriver<TRequest, TRawResponse> driver) {
  if (driver
      case final ReadStreamCapableTargetDriver<TRequest, dynamic>
          streamDriver) {
    return streamDriver.stream;
  }
  return null;
}

Future<JsonMap> Function(TRequest request)? _driverExplain<
  TRequest,
  TRawResponse
>(TargetDriver<TRequest, TRawResponse> driver) {
  if (driver case final ExplainCapableTargetDriver<TRequest> explainDriver) {
    return explainDriver.explain;
  }
  return null;
}

Stream<dynamic> Function(TRequest request)? _connectionReadStream<
  TRequest,
  TRawResponse
>(TargetDriverConnection<TRequest, TRawResponse> connection) {
  if (connection
      case final ReadStreamCapableTargetDriverConnection<TRequest, dynamic>
          streamConnection) {
    return streamConnection.stream;
  }
  return null;
}

Future<JsonMap> Function(TRequest request)? _connectionExplain<
  TRequest,
  TRawResponse
>(TargetDriverConnection<TRequest, TRawResponse> connection) {
  if (connection
      case final ExplainCapableTargetDriverConnection<TRequest>
          explainConnection) {
    return explainConnection.explain;
  }
  return null;
}

Stream<dynamic> Function(TRequest request)? _transactionReadStream<
  TRequest,
  TRawResponse
>(TargetDriverTransaction<TRequest, TRawResponse> transaction) {
  if (transaction
      case final ReadStreamCapableTargetDriverTransaction<TRequest, dynamic>
          streamTransaction) {
    return streamTransaction.stream;
  }
  return null;
}

Future<JsonMap> Function(TRequest request)? _transactionExplain<
  TRequest,
  TRawResponse
>(TargetDriverTransaction<TRequest, TRawResponse> transaction) {
  if (transaction
      case final ExplainCapableTargetDriverTransaction<TRequest>
          explainTransaction) {
    return explainTransaction.explain;
  }
  return null;
}
