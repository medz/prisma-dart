import 'package:meta/meta.dart';

import '../contract/contract.dart';
import '../engine/engine.dart';
import 'errors.dart';
import 'plan.dart';
import 'plugin.dart';
import 'types.dart';

typedef MarkerHashReader = Future<String?> Function();
const Set<String> _whereLogicalKeys = <String>{'AND', 'OR', 'NOT'};

abstract interface class ContractMarkerReader {
  Future<String?> readContractHash();
}

final class CallbackMarkerReader implements ContractMarkerReader {
  final MarkerHashReader _reader;

  const CallbackMarkerReader(this._reader);

  @override
  Future<String?> readContractHash() => _reader();
}

enum RuntimeVerifyMode { startup, onFirstUse, always }

@immutable
final class RuntimeVerifyOptions {
  final RuntimeVerifyMode mode;
  final bool requireMarker;
  final ContractMarkerReader? markerReader;

  const RuntimeVerifyOptions({
    this.mode = RuntimeVerifyMode.onFirstUse,
    this.requireMarker = false,
    this.markerReader,
  });
}

enum RuntimeTelemetryOutcome { success, runtimeError }

@immutable
final class RuntimeTelemetryEvent {
  final String model;
  final OrmAction action;
  final RuntimeTelemetryOutcome outcome;
  final int durationMs;
  final DateTime recordedAt;

  const RuntimeTelemetryEvent({
    required this.model,
    required this.action,
    required this.outcome,
    required this.durationMs,
    required this.recordedAt,
  });
}

abstract interface class OrmRuntimeQueryable {
  Future<EngineResponse> execute(OrmPlan plan);
}

abstract interface class OrmRuntimeConnection implements OrmRuntimeQueryable {
  Future<OrmRuntimeTransaction> transaction();

  Future<void> release();
}

abstract interface class OrmRuntimeTransaction implements OrmRuntimeQueryable {
  Future<void> commit();

  Future<void> rollback();
}

abstract interface class RuntimeCore implements OrmRuntimeQueryable {
  Future<void> connect();

  Future<void> disconnect();

  bool get isConnected;

  Future<OrmRuntimeConnection> connection();

  RuntimeTelemetryEvent? telemetry();
}

final class OrmRuntimeCore implements RuntimeCore {
  final OrmContract contract;
  final OrmEngine engine;
  final RuntimeVerifyOptions verify;
  final RuntimeMode mode;
  final RuntimeLog log;
  final List<OrmPlugin> _plugins;
  late final PluginContext _pluginContext;

  bool _connected = false;
  bool _startupVerified = false;
  bool _firstUseVerified = false;
  RuntimeTelemetryEvent? _telemetry;

  OrmRuntimeCore({
    required this.contract,
    required this.engine,
    List<OrmPlugin> plugins = const <OrmPlugin>[],
    this.verify = const RuntimeVerifyOptions(),
    this.mode = RuntimeMode.strict,
    this.log = const SilentRuntimeLog(),
  }) : _plugins = _normalizePlugins(plugins) {
    _pluginContext = PluginContext(
      contract: contract,
      engine: engine,
      mode: mode,
      now: DateTime.now,
      log: log,
    );
  }

  @override
  bool get isConnected => _connected;

  @override
  Future<void> connect() async {
    if (_connected) {
      return;
    }

    await engine.open();
    try {
      _connected = true;
      _startupVerified = false;
      _firstUseVerified = false;

      if (verify.mode == RuntimeVerifyMode.startup) {
        await _verifyMarker();
        _startupVerified = true;
      }
    } catch (_) {
      _connected = false;
      _startupVerified = false;
      _firstUseVerified = false;
      await engine.close();
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    if (!_connected) {
      return;
    }

    await engine.close();
    _connected = false;
    _startupVerified = false;
    _firstUseVerified = false;
    _telemetry = null;
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) {
    return _executeOnQueryable(plan, engine);
  }

  @override
  Future<OrmRuntimeConnection> connection() async {
    _ensureConnected();
    await _verifyForRequest();

    if (engine case final ConnectionCapableEngine connectionEngine) {
      final engineConnection = await connectionEngine.connection();
      return _RuntimeConnection(this, engineConnection);
    }

    throw RuntimeConnectionNotSupportedException();
  }

  @override
  RuntimeTelemetryEvent? telemetry() => _telemetry;

  Future<EngineResponse> _executeOnQueryable(
    OrmPlan plan,
    RuntimeQueryable queryable,
  ) async {
    _ensureConnected();
    _assertPlan(plan);
    await _verifyForRequest();

    final startedAt = DateTime.now();
    var rowCount = 0;

    try {
      for (final plugin in _plugins) {
        await plugin.beforeExecute(plan, _pluginContext);
      }

      final response = await queryable.execute(plan);
      final rows = _extractRows(response.data, action: plan.action.name);
      rowCount = rows.length;
      for (final row in rows) {
        for (final plugin in _plugins) {
          await plugin.onRow(row, plan, _pluginContext);
        }
      }

      final result = AfterExecuteResult(
        rowCount: rowCount,
        affectedRows: response.affectedRows,
        latencyMs: DateTime.now().difference(startedAt).inMilliseconds,
        completed: true,
      );

      for (final plugin in _plugins) {
        await plugin.afterExecute(plan, result, _pluginContext);
      }

      _telemetry = RuntimeTelemetryEvent(
        model: plan.model,
        action: plan.action,
        outcome: RuntimeTelemetryOutcome.success,
        durationMs: result.latencyMs,
        recordedAt: DateTime.now(),
      );

      return response;
    } catch (error, stackTrace) {
      final latencyMs = DateTime.now().difference(startedAt).inMilliseconds;
      _telemetry = RuntimeTelemetryEvent(
        model: plan.model,
        action: plan.action,
        outcome: RuntimeTelemetryOutcome.runtimeError,
        durationMs: latencyMs,
        recordedAt: DateTime.now(),
      );

      for (final plugin in _plugins) {
        try {
          await plugin.onError(plan, error, stackTrace, _pluginContext);
        } catch (_) {
          // Keep original error when error observers fail.
        }
      }

      final result = AfterExecuteResult(
        rowCount: rowCount,
        affectedRows: 0,
        latencyMs: latencyMs,
        completed: false,
      );
      for (final plugin in _plugins) {
        try {
          await plugin.afterExecute(plan, result, _pluginContext);
        } catch (_) {
          // Ignore afterExecute errors on failure path.
        }
      }

      rethrow;
    }
  }

  Future<void> _verifyForRequest() async {
    switch (verify.mode) {
      case RuntimeVerifyMode.startup:
        if (!_startupVerified) {
          await _verifyMarker();
          _startupVerified = true;
        }
      case RuntimeVerifyMode.onFirstUse:
        if (!_firstUseVerified) {
          await _verifyMarker();
          _firstUseVerified = true;
        }
      case RuntimeVerifyMode.always:
        await _verifyMarker();
    }
  }

  Future<void> _verifyMarker() async {
    final reader = verify.markerReader;
    if (reader == null) {
      if (verify.requireMarker) {
        throw ContractMarkerMissingException();
      }
      return;
    }

    final markerHash = await reader.readContractHash();
    if (markerHash == null) {
      if (verify.requireMarker) {
        throw ContractMarkerMissingException();
      }
      return;
    }

    if (markerHash != contract.hash) {
      throw ContractMarkerMismatchException(
        expected: contract.hash,
        actual: markerHash,
      );
    }
  }

  void _assertPlan(OrmPlan plan) {
    if (plan.contractHash != contract.hash) {
      throw ContractHashMismatchException(
        expected: contract.hash,
        actual: plan.contractHash,
      );
    }

    final planTarget = plan.target ?? contract.target;
    if (planTarget != contract.target) {
      throw PlanTargetMismatchException(
        expected: contract.target,
        actual: planTarget,
      );
    }

    final planStorageHash = plan.storageHash ?? contract.markerStorageHash;
    if (planStorageHash != contract.markerStorageHash) {
      throw PlanStorageHashMismatchException(
        expected: contract.markerStorageHash,
        actual: planStorageHash,
      );
    }

    final expectedProfileHash = contract.profileHash;
    final planProfileHash = plan.profileHash ?? expectedProfileHash;
    if (planProfileHash != expectedProfileHash) {
      throw PlanProfileHashMismatchException(
        expected: expectedProfileHash,
        actual: planProfileHash,
      );
    }

    if (!contract.models.containsKey(plan.model)) {
      throw ModelNotFoundException(plan.model, contract.models.keys);
    }

    final model = contract.models[plan.model]!;
    _assertWhereFields(model: model, where: plan.where, source: 'where');
    _assertKnownFields(model: model, fields: plan.data.keys, source: 'data');
    _assertKnownFields(
      model: model,
      fields: plan.orderBy.map((entry) => entry.field),
      source: 'orderBy',
    );
    _assertKnownFields(model: model, fields: plan.select, source: 'select');

    if (plan.skip case final skip? when skip < 0) {
      throw PlanInvalidPaginationException(key: 'skip', value: skip);
    }

    if (plan.take case final take? when take < 0) {
      throw PlanInvalidPaginationException(key: 'take', value: take);
    }
  }

  void _assertKnownFields({
    required ModelContract model,
    required Iterable<String> fields,
    required String source,
  }) {
    for (final field in fields) {
      if (model.fields.contains(field)) {
        continue;
      }
      throw PlanFieldNotFoundException(
        model: model.name,
        field: field,
        source: source,
      );
    }
  }

  void _assertWhereFields({
    required ModelContract model,
    required JsonMap where,
    required String source,
  }) {
    for (final entry in where.entries) {
      final key = entry.key;
      if (_whereLogicalKeys.contains(key)) {
        _assertWhereLogicalOperand(
          model: model,
          operand: entry.value,
          source: source,
        );
        continue;
      }
      _assertKnownFields(model: model, fields: <String>[key], source: source);
    }
  }

  void _assertWhereLogicalOperand({
    required ModelContract model,
    required Object? operand,
    required String source,
  }) {
    final nestedWhere = _coerceWhereMap(operand);
    if (nestedWhere != null) {
      _assertWhereFields(model: model, where: nestedWhere, source: source);
      return;
    }

    final nestedWhereList = _coerceWhereList(operand);
    if (nestedWhereList == null) {
      return;
    }

    for (final item in nestedWhereList) {
      _assertWhereFields(model: model, where: item, source: source);
    }
  }

  void _ensureConnected() {
    if (_connected) {
      return;
    }
    throw ClientNotConnectedException();
  }
}

JsonMap? _coerceWhereMap(Object? value) {
  if (value is! Map) {
    return null;
  }

  final normalized = <String, Object?>{};
  for (final entry in value.entries) {
    final key = entry.key;
    if (key is! String) {
      return null;
    }
    normalized[key] = entry.value;
  }
  return normalized;
}

List<JsonMap>? _coerceWhereList(Object? value) {
  if (value is! List) {
    return null;
  }

  final whereList = <JsonMap>[];
  for (final item in value) {
    final where = _coerceWhereMap(item);
    if (where == null) {
      return null;
    }
    whereList.add(where);
  }
  return whereList;
}

List<JsonMap> _extractRows(Object? data, {required String action}) {
  if (data == null) {
    return const <JsonMap>[];
  }
  if (data is List<Object?>) {
    return data
        .map((value) => _coerceToRow(value, action: action))
        .toList(growable: false);
  }
  return <JsonMap>[_coerceToRow(data, action: action)];
}

JsonMap _coerceToRow(Object? value, {required String action}) {
  if (value is Map<String, Object?>) {
    return Map<String, Object?>.unmodifiable(value);
  }
  if (value is Map<Object?, Object?>) {
    return Map<String, Object?>.unmodifiable(
      value.map((key, item) => MapEntry(key.toString(), item)),
    );
  }
  throw RuntimeResponseShapeException(
    action: action,
    expected: 'Map<String, Object?>',
    actual: value,
  );
}

final class _RuntimeConnection implements OrmRuntimeConnection {
  final OrmRuntimeCore _core;
  final EngineConnection _inner;
  bool _released = false;

  _RuntimeConnection(this._core, this._inner);

  @override
  Future<EngineResponse> execute(OrmPlan plan) {
    _ensureNotReleased();
    return _core._executeOnQueryable(plan, _inner);
  }

  @override
  Future<OrmRuntimeTransaction> transaction() async {
    _ensureNotReleased();
    final transaction = await _inner.transaction();
    return _RuntimeTransaction(_core, transaction);
  }

  @override
  Future<void> release() async {
    _released = true;
    await _inner.release();
  }

  void _ensureNotReleased() {
    if (_released) {
      throw RuntimeConnectionReleasedException();
    }
  }
}

final class _RuntimeTransaction implements OrmRuntimeTransaction {
  final OrmRuntimeCore _core;
  final EngineTransaction _inner;
  bool _completed = false;

  _RuntimeTransaction(this._core, this._inner);

  @override
  Future<void> commit() async {
    _ensureActive();
    _completed = true;
    await _inner.commit();
  }

  @override
  Future<void> rollback() async {
    _ensureActive();
    _completed = true;
    await _inner.rollback();
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) {
    _ensureActive();
    return _core._executeOnQueryable(plan, _inner);
  }

  void _ensureActive() {
    if (_completed) {
      throw RuntimeTransactionCompletedException();
    }
  }
}

List<OrmPlugin> _normalizePlugins(List<OrmPlugin> plugins) {
  if (plugins.isEmpty) {
    return const <OrmPlugin>[];
  }

  final seenNames = <String>{};
  final normalized = <OrmPlugin>[];

  for (final plugin in plugins) {
    final name = plugin.name.trim();
    if (name.isEmpty) {
      throw PluginNameEmptyException();
    }

    final canonical = name.toLowerCase();
    if (!seenNames.add(canonical)) {
      throw PluginNameDuplicateException(name);
    }

    normalized.add(plugin);
  }

  return List<OrmPlugin>.unmodifiable(normalized);
}
