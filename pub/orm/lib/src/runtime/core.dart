import 'dart:collection';

import 'package:meta/meta.dart';

import '../contract/contract.dart';
import '../engine/engine.dart';
import 'errors.dart';
import 'plan.dart';
import 'plugin.dart';
import 'types.dart';

typedef MarkerHashReader = Future<String?> Function();
const Set<String> _whereLogicalKeys = <String>{'AND', 'OR', 'NOT'};
const Set<String> _toManyRelationWhereOperators = <String>{
  'some',
  'every',
  'none',
};
const Set<String> _toOneRelationWhereOperators = <String>{'is', 'isNot'};

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

String _readPaginationMode(OrmReadPlan? read) {
  if (read == null) {
    return 'none';
  }
  if (read.page != null) {
    return 'page';
  }
  if (read.cursor != null) {
    return 'cursor';
  }
  if (read.skip != null || read.take != null) {
    return 'offset';
  }
  return 'none';
}

int? _estimatedRowsForExplain(OrmPlan plan) {
  final read = plan.read;
  if (read == null) {
    return null;
  }
  if (read.shape == OrmReadShape.aggregate) {
    return 1;
  }
  if (read.page case final page?) {
    return page.size;
  }
  if (read.resultMode != OrmReadResultMode.all) {
    return 1;
  }
  return read.take;
}

JsonMap _buildExplainResult(OrmPlan plan) {
  final read = plan.read;
  final mutation = plan.mutation;

  return Map<String, Object?>.unmodifiable(<String, Object?>{
    'source': 'heuristic',
    'estimatedRows': _estimatedRowsForExplain(plan),
    'usedIndexes': const <String>[],
    'planSummary': Map<String, Object?>.unmodifiable(<String, Object?>{
      'model': plan.model,
      'action': plan.action.name,
      if (plan.lane != null) 'lane': plan.lane,
      'executionMode': 'deferred',
      'executionSource': 'notExecuted',
      if (read != null) 'readResultMode': read.resultMode.name,
      if (read != null) 'readShape': read.shape.name,
      if (mutation != null) 'mutationResultMode': mutation.resultMode.name,
      if (read != null) 'selectedFieldCount': read.select.length,
      if (mutation != null) 'selectedFieldCount': mutation.select.length,
      if (read != null) 'includeCount': read.include.length,
      'pagination': <String, Object?>{
        'mode': _readPaginationMode(read),
        if (read?.skip != null) 'skip': read!.skip,
        if (read?.take != null) 'take': read!.take,
        if (read?.cursor != null) 'cursor': read!.cursor!.toJson(),
        if (read?.page != null) 'page': read!.page!.toJson(),
        if (read != null)
          'orderBy': read.orderBy
              .map((entry) => entry.toJson())
              .toList(growable: false),
      },
    }),
    'plan': plan.toJson(),
  });
}

JsonMap _mergeExplainResult(JsonMap base, JsonMap details) {
  if (details.isEmpty) {
    return base;
  }

  final merged = <String, Object?>{...base};
  for (final entry in details.entries) {
    if (entry.key == 'planSummary' &&
        merged['planSummary'] is JsonMap &&
        entry.value is JsonMap) {
      final current = merged['planSummary']! as JsonMap;
      final next = entry.value as JsonMap;
      merged['planSummary'] = Map<String, Object?>.unmodifiable(
        <String, Object?>{...current, ...next},
      );
      continue;
    }
    merged[entry.key] = entry.value;
  }

  return Map<String, Object?>.unmodifiable(merged);
}

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
final class RuntimeOperationStepTelemetry {
  final String model;
  final OrmAction action;
  final RuntimeTelemetryOutcome outcome;
  final bool completed;
  final EngineExecutionMode? executionMode;
  final EngineExecutionSource? executionSource;
  final int rowCount;
  final int affectedRows;
  final int durationMs;
  final DateTime recordedAt;
  final OrmRepositoryTrace trace;

  const RuntimeOperationStepTelemetry({
    required this.model,
    required this.action,
    required this.outcome,
    required this.completed,
    this.executionMode,
    this.executionSource,
    required this.rowCount,
    required this.affectedRows,
    required this.durationMs,
    required this.recordedAt,
    required this.trace,
  });
}

@immutable
final class RuntimeOperationTelemetryEvent {
  final String operationId;
  final String kind;
  final RuntimeTelemetryOutcome outcome;
  final bool completed;
  final int statementCount;
  final int rowCount;
  final int affectedRows;
  final int durationMs;
  final DateTime startedAt;
  final DateTime recordedAt;
  final List<RuntimeOperationStepTelemetry> steps;

  RuntimeOperationTelemetryEvent({
    required this.operationId,
    required this.kind,
    required this.outcome,
    required this.completed,
    required this.statementCount,
    required this.rowCount,
    required this.affectedRows,
    required this.durationMs,
    required this.startedAt,
    required this.recordedAt,
    required List<RuntimeOperationStepTelemetry> steps,
  }) : steps = List.unmodifiable(steps);

  int get lastStep => steps.isEmpty ? 0 : steps.last.trace.step;
}

@immutable
final class RuntimeTelemetryEvent {
  final String model;
  final OrmAction action;
  final RuntimeTelemetryOutcome outcome;
  final bool completed;
  final EngineExecutionMode? executionMode;
  final EngineExecutionSource? executionSource;
  final int durationMs;
  final DateTime recordedAt;
  final OrmRepositoryTrace? repositoryTrace;

  const RuntimeTelemetryEvent({
    required this.model,
    required this.action,
    required this.outcome,
    required this.completed,
    this.executionMode,
    this.executionSource,
    required this.durationMs,
    required this.recordedAt,
    this.repositoryTrace,
  });

  String? get operationId => repositoryTrace?.operationId;

  String? get operationKind => repositoryTrace?.kind;

  int? get operationStep => repositoryTrace?.step;

  String? get operationPhase => repositoryTrace?.phase;

  String? get operationStrategy => repositoryTrace?.strategy;
}

abstract interface class OrmRuntimeQueryable {
  Future<EngineResponse> execute(OrmPlan plan);
}

abstract interface class OrmRuntimeConnection implements OrmRuntimeQueryable {
  Future<JsonMap> explain(OrmPlan plan);

  Future<OrmRuntimeTransaction> transaction();

  Future<void> release();
}

abstract interface class OrmRuntimeTransaction implements OrmRuntimeQueryable {
  Future<JsonMap> explain(OrmPlan plan);

  Future<void> commit();

  Future<void> rollback();
}

abstract interface class RuntimeCore implements OrmRuntimeQueryable {
  Future<void> connect();

  Future<void> disconnect();

  bool get isConnected;

  Future<OrmRuntimeConnection> connection();

  RuntimeTelemetryEvent? telemetry();

  Future<JsonMap> explain(OrmPlan plan);

  RuntimeOperationTelemetryEvent? operationTelemetry([String? operationId]);

  List<RuntimeOperationTelemetryEvent> recentOperationTelemetry({
    int limit = 50,
  });
}

final class OrmRuntimeCore implements RuntimeCore {
  static const int _maxOperationTelemetryEntries = 128;

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
  RuntimeOperationTelemetryEvent? _operationTelemetry;
  final LinkedHashMap<String, RuntimeOperationTelemetryEvent>
  _operationTelemetryById =
      LinkedHashMap<String, RuntimeOperationTelemetryEvent>();

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
    _operationTelemetry = null;
    _operationTelemetryById.clear();
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

  @override
  Future<JsonMap> explain(OrmPlan plan) async {
    return _explainOnSource(plan, engine);
  }

  @override
  RuntimeOperationTelemetryEvent? operationTelemetry([String? operationId]) {
    if (operationId == null) {
      return _operationTelemetry;
    }
    return _operationTelemetryById[operationId];
  }

  @override
  List<RuntimeOperationTelemetryEvent> recentOperationTelemetry({
    int limit = 50,
  }) {
    if (limit <= 0 || _operationTelemetryById.isEmpty) {
      return const <RuntimeOperationTelemetryEvent>[];
    }
    final values = _operationTelemetryById.values.toList(growable: false);
    if (limit >= values.length) {
      return values.reversed.toList(growable: false);
    }
    return values
        .sublist(values.length - limit)
        .reversed
        .toList(growable: false);
  }

  Future<EngineResponse> _executeOnQueryable(
    OrmPlan plan,
    RuntimeQueryable queryable,
  ) async {
    _ensureConnected();
    _assertPlan(plan);
    await _verifyForRequest();

    final startedAt = DateTime.now();

    try {
      for (final plugin in _plugins) {
        await plugin.beforeExecute(plan, _pluginContext);
      }

      final response = await queryable.execute(plan);
      return EngineResponse(
        rows: _observeExecutionRows(
          plan: plan,
          rows: response.rows,
          affectedRows: response.affectedRows,
          executionMode: response.executionMode,
          executionSource: response.executionSource,
          startedAt: startedAt,
        ),
        affectedRows: response.affectedRows,
        executionMode: response.executionMode,
        executionSource: response.executionSource,
      );
    } catch (error, stackTrace) {
      final latencyMs = DateTime.now().difference(startedAt).inMilliseconds;
      await _recordExecutionFailure(
        plan: plan,
        error: error,
        stackTrace: stackTrace,
        rowCount: 0,
        latencyMs: latencyMs,
        startedAt: startedAt,
      );
      rethrow;
    }
  }

  Stream<Object?> _observeExecutionRows({
    required OrmPlan plan,
    required Stream<Object?> rows,
    required int affectedRows,
    required EngineExecutionMode executionMode,
    required EngineExecutionSource executionSource,
    required DateTime startedAt,
  }) async* {
    var rowCount = 0;
    var completed = false;
    var failed = false;

    try {
      await for (final rawRow in rows) {
        final row = _coerceToRow(rawRow, action: plan.action.name);
        rowCount += 1;
        for (final plugin in _plugins) {
          await plugin.onRow(row, plan, _pluginContext);
        }
        yield row;
      }

      completed = true;
      await _recordExecutionSuccess(
        plan: plan,
        rowCount: rowCount,
        affectedRows: affectedRows,
        executionMode: executionMode,
        executionSource: executionSource,
        startedAt: startedAt,
      );
    } catch (error, stackTrace) {
      failed = true;
      final latencyMs = DateTime.now().difference(startedAt).inMilliseconds;
      await _recordExecutionFailure(
        plan: plan,
        error: error,
        stackTrace: stackTrace,
        rowCount: rowCount,
        latencyMs: latencyMs,
        executionMode: executionMode,
        executionSource: executionSource,
        startedAt: startedAt,
      );
      rethrow;
    } finally {
      if (!completed && !failed) {
        await _recordExecutionInterrupted(
          plan: plan,
          rowCount: rowCount,
          affectedRows: affectedRows,
          executionMode: executionMode,
          executionSource: executionSource,
          startedAt: startedAt,
        );
      }
    }
  }

  Future<JsonMap> _explainOnSource(OrmPlan plan, Object source) async {
    _ensureConnected();
    _assertPlan(plan);
    await _verifyForRequest();

    final base = _buildExplainResult(plan);
    final details = switch (source) {
      final ExplainCapableEngine explainEngine =>
        await explainEngine.describePlan(plan),
      final ExplainCapableEngineConnection explainConnection =>
        await explainConnection.describePlan(plan),
      final ExplainCapableEngineTransaction explainTransaction =>
        await explainTransaction.describePlan(plan),
      _ => const <String, Object?>{},
    };
    return _mergeExplainResult(base, details);
  }

  Future<void> _recordExecutionSuccess({
    required OrmPlan plan,
    required int rowCount,
    required int affectedRows,
    required EngineExecutionMode executionMode,
    required EngineExecutionSource executionSource,
    required DateTime startedAt,
  }) async {
    final latencyMs = DateTime.now().difference(startedAt).inMilliseconds;
    final result = AfterExecuteResult(
      rowCount: rowCount,
      affectedRows: affectedRows,
      latencyMs: latencyMs,
      completed: true,
    );

    for (final plugin in _plugins) {
      await plugin.afterExecute(plan, result, _pluginContext);
    }

    _telemetry = RuntimeTelemetryEvent(
      model: plan.model,
      action: plan.action,
      outcome: RuntimeTelemetryOutcome.success,
      completed: true,
      executionMode: executionMode,
      executionSource: executionSource,
      durationMs: latencyMs,
      recordedAt: DateTime.now(),
      repositoryTrace: plan.repositoryTrace,
    );
    _recordOperationTelemetry(
      plan: plan,
      outcome: RuntimeTelemetryOutcome.success,
      completed: true,
      executionMode: executionMode,
      executionSource: executionSource,
      rowCount: rowCount,
      affectedRows: affectedRows,
      durationMs: latencyMs,
      startedAt: startedAt,
      recordedAt: _telemetry!.recordedAt,
    );
  }

  Future<void> _recordExecutionFailure({
    required OrmPlan plan,
    required Object error,
    required StackTrace stackTrace,
    required int rowCount,
    required int latencyMs,
    EngineExecutionMode? executionMode,
    EngineExecutionSource? executionSource,
    required DateTime startedAt,
  }) async {
    _telemetry = RuntimeTelemetryEvent(
      model: plan.model,
      action: plan.action,
      outcome: RuntimeTelemetryOutcome.runtimeError,
      completed: false,
      executionMode: executionMode,
      executionSource: executionSource,
      durationMs: latencyMs,
      recordedAt: DateTime.now(),
      repositoryTrace: plan.repositoryTrace,
    );
    if (error is! PlanRepositoryTraceInvalidException) {
      _recordOperationTelemetry(
        plan: plan,
        outcome: RuntimeTelemetryOutcome.runtimeError,
        completed: false,
        executionMode: executionMode,
        executionSource: executionSource,
        rowCount: rowCount,
        affectedRows: 0,
        durationMs: latencyMs,
        startedAt: startedAt,
        recordedAt: _telemetry!.recordedAt,
      );
    }

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
  }

  Future<void> _recordExecutionInterrupted({
    required OrmPlan plan,
    required int rowCount,
    required int affectedRows,
    required EngineExecutionMode executionMode,
    required EngineExecutionSource executionSource,
    required DateTime startedAt,
  }) async {
    final latencyMs = DateTime.now().difference(startedAt).inMilliseconds;
    _telemetry = RuntimeTelemetryEvent(
      model: plan.model,
      action: plan.action,
      outcome: RuntimeTelemetryOutcome.success,
      completed: false,
      executionMode: executionMode,
      executionSource: executionSource,
      durationMs: latencyMs,
      recordedAt: DateTime.now(),
      repositoryTrace: plan.repositoryTrace,
    );
    _recordOperationTelemetry(
      plan: plan,
      outcome: RuntimeTelemetryOutcome.success,
      completed: false,
      executionMode: executionMode,
      executionSource: executionSource,
      rowCount: rowCount,
      affectedRows: affectedRows,
      durationMs: latencyMs,
      startedAt: startedAt,
      recordedAt: _telemetry!.recordedAt,
    );
    final result = AfterExecuteResult(
      rowCount: rowCount,
      affectedRows: affectedRows,
      latencyMs: latencyMs,
      completed: false,
    );

    for (final plugin in _plugins) {
      await plugin.afterExecute(plan, result, _pluginContext);
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
    _assertPlanModes(plan);
    _assertRepositoryTrace(plan);
    switch (plan.action) {
      case OrmAction.read:
        _assertReadPlan(model: model, plan: plan.read!);
      case OrmAction.create || OrmAction.update || OrmAction.delete:
        _assertMutationPlan(model: model, plan: plan.mutation!);
    }
  }

  void _assertPlanModes(OrmPlan plan) {
    switch (plan.action) {
      case OrmAction.read:
        if (plan.read == null || plan.mutation != null) {
          throw PlanResultModeActionInvalidException(
            action: plan.action,
            readResultMode: plan.read?.resultMode,
            mutationResultMode: plan.mutation?.resultMode,
            hasRead: plan.read != null,
            hasMutation: plan.mutation != null,
          );
        }
      case OrmAction.create || OrmAction.update || OrmAction.delete:
        if (plan.mutation == null || plan.read != null) {
          throw PlanResultModeActionInvalidException(
            action: plan.action,
            readResultMode: plan.read?.resultMode,
            mutationResultMode: plan.mutation?.resultMode,
            hasRead: plan.read != null,
            hasMutation: plan.mutation != null,
          );
        }
    }
  }

  void _assertRepositoryTrace(OrmPlan plan) {
    if (plan.annotations.containsKey('repository')) {
      throw PlanRepositoryTraceInvalidException(
        reason: 'legacyAnnotation',
        details: <String, Object?>{'model': plan.model},
      );
    }

    final trace = plan.repositoryTrace;
    if (trace == null) {
      return;
    }

    if (trace.operationId.trim().isEmpty) {
      throw PlanRepositoryTraceInvalidException(
        reason: 'operationIdEmpty',
        details: <String, Object?>{'model': plan.model},
      );
    }
    if (trace.kind.trim().isEmpty) {
      throw PlanRepositoryTraceInvalidException(
        reason: 'kindEmpty',
        details: <String, Object?>{
          'model': plan.model,
          'operationId': trace.operationId,
        },
      );
    }
    if (trace.phase.trim().isEmpty) {
      throw PlanRepositoryTraceInvalidException(
        reason: 'phaseEmpty',
        details: <String, Object?>{
          'model': plan.model,
          'operationId': trace.operationId,
        },
      );
    }
    if (trace.strategy.trim().isEmpty) {
      throw PlanRepositoryTraceInvalidException(
        reason: 'strategyEmpty',
        details: <String, Object?>{
          'model': plan.model,
          'operationId': trace.operationId,
        },
      );
    }
    if (trace.step <= 0) {
      throw PlanRepositoryTraceInvalidException(
        reason: 'stepInvalid',
        details: <String, Object?>{
          'model': plan.model,
          'operationId': trace.operationId,
          'step': trace.step,
        },
      );
    }
    if (trace.itemIndex case final itemIndex? when itemIndex < 0) {
      throw PlanRepositoryTraceInvalidException(
        reason: 'itemIndexInvalid',
        details: <String, Object?>{
          'model': plan.model,
          'operationId': trace.operationId,
          'itemIndex': itemIndex,
        },
      );
    }
  }

  void _recordOperationTelemetry({
    required OrmPlan plan,
    required RuntimeTelemetryOutcome outcome,
    required bool completed,
    EngineExecutionMode? executionMode,
    EngineExecutionSource? executionSource,
    required int rowCount,
    required int affectedRows,
    required int durationMs,
    required DateTime startedAt,
    required DateTime recordedAt,
  }) {
    final trace = plan.repositoryTrace;
    if (trace == null) {
      return;
    }

    final current = _operationTelemetryById[trace.operationId];
    if (current != null) {
      if (current.kind != trace.kind) {
        throw PlanRepositoryTraceInvalidException(
          reason: 'kindMismatch',
          details: <String, Object?>{
            'operationId': trace.operationId,
            'expectedKind': current.kind,
            'actualKind': trace.kind,
          },
        );
      }
      if (trace.step <= current.lastStep) {
        throw PlanRepositoryTraceInvalidException(
          reason: 'stepOutOfOrder',
          details: <String, Object?>{
            'operationId': trace.operationId,
            'lastStep': current.lastStep,
            'actualStep': trace.step,
          },
        );
      }
    }

    final nextStep = RuntimeOperationStepTelemetry(
      model: plan.model,
      action: plan.action,
      outcome: outcome,
      completed: completed,
      executionMode: executionMode,
      executionSource: executionSource,
      rowCount: rowCount,
      affectedRows: affectedRows,
      durationMs: durationMs,
      recordedAt: recordedAt,
      trace: trace,
    );
    final next = RuntimeOperationTelemetryEvent(
      operationId: trace.operationId,
      kind: trace.kind,
      outcome: current?.outcome == RuntimeTelemetryOutcome.runtimeError
          ? RuntimeTelemetryOutcome.runtimeError
          : outcome,
      completed: (current?.completed ?? true) && completed,
      statementCount: (current?.statementCount ?? 0) + 1,
      rowCount: (current?.rowCount ?? 0) + rowCount,
      affectedRows: (current?.affectedRows ?? 0) + affectedRows,
      durationMs: (current?.durationMs ?? 0) + durationMs,
      startedAt: current?.startedAt ?? startedAt,
      recordedAt: recordedAt,
      steps: <RuntimeOperationStepTelemetry>[...?current?.steps, nextStep],
    );

    if (current != null) {
      _operationTelemetryById.remove(trace.operationId);
    }
    _operationTelemetryById[trace.operationId] = next;
    while (_operationTelemetryById.length > _maxOperationTelemetryEntries) {
      _operationTelemetryById.remove(_operationTelemetryById.keys.first);
    }
    _operationTelemetry = next;
  }

  void _assertReadPlan({
    required ModelContract model,
    required OrmReadPlan plan,
  }) {
    _assertReadShape(model: model, plan: plan);
    _assertWhereFields(model: model, where: plan.where, source: 'where');
    _assertKnownFields(
      model: model,
      fields: plan.orderBy.map((entry) => entry.field),
      source: 'orderBy',
    );
    _assertKnownFields(model: model, fields: plan.distinct, source: 'distinct');
    _assertKnownFields(model: model, fields: plan.select, source: 'select');

    if (plan.skip case final skip? when skip < 0) {
      throw PlanInvalidPaginationException(key: 'skip', value: skip);
    }

    if (plan.take case final take? when take < 0) {
      throw PlanInvalidPaginationException(key: 'take', value: take);
    }

    final cursor = plan.cursor;
    if (cursor != null) {
      if (cursor.values.isEmpty) {
        throw PlanCursorWindowInvalidException(
          reason: 'cursorEmpty',
          details: <String, Object?>{'model': model.name},
        );
      }
      _assertKnownFields(
        model: model,
        fields: cursor.values.keys,
        source: 'cursor',
      );
    }

    final page = plan.page;
    if ((cursor != null || page != null) && plan.distinct.isNotEmpty) {
      throw runtimeError(
        'PLAN.CURSOR_DISTINCT_UNSUPPORTED',
        'Cursor and page windows do not support distinct yet.',
        details: <String, Object?>{
          'model': model.name,
          'distinct': plan.distinct,
        },
      );
    }
    if ((cursor != null || page != null) && plan.orderBy.isEmpty) {
      throw runtimeError(
        'PLAN.CURSOR_ORDER_BY_REQUIRED',
        'Cursor and page windows require explicit orderBy fields in the plan.',
        details: <String, Object?>{
          'model': model.name,
          if (cursor != null) 'cursor': cursor.toJson(),
          if (page != null) 'page': page.toJson(),
        },
      );
    }
    if (cursor != null &&
        !_matchesBoundaryFields(
          orderBy: plan.orderBy,
          boundaryFields: cursor.values.keys,
        )) {
      throw runtimeError(
        'PLAN.CURSOR_ORDER_BY_FIELDS_INVALID',
        'Cursor boundary fields must match orderBy fields.',
        details: <String, Object?>{
          'model': model.name,
          'orderBy': plan.orderBy.map((entry) => entry.field).toList(),
          'boundaryFields': cursor.values.keys.toList(growable: false),
        },
      );
    }
    if (page != null) {
      if (page.size <= 0) {
        throw PlanCursorWindowInvalidException(
          reason: 'pageSizeInvalid',
          details: <String, Object?>{'model': model.name, 'size': page.size},
        );
      }
      if (page.after != null && page.before != null) {
        throw PlanCursorWindowInvalidException(
          reason: 'pageDirectionAmbiguous',
          details: <String, Object?>{'model': model.name},
        );
      }
      if (page.after case final after? when after.isEmpty) {
        throw PlanCursorWindowInvalidException(
          reason: 'pageAfterEmpty',
          details: <String, Object?>{'model': model.name},
        );
      }
      if (page.before case final before? when before.isEmpty) {
        throw PlanCursorWindowInvalidException(
          reason: 'pageBeforeEmpty',
          details: <String, Object?>{'model': model.name},
        );
      }
      if (cursor != null) {
        throw PlanCursorWindowInvalidException(
          reason: 'cursorAndPageTogether',
          details: <String, Object?>{'model': model.name},
        );
      }
      if (plan.skip != null || plan.take != null) {
        throw PlanCursorWindowInvalidException(
          reason: 'pageWithOffsetLimit',
          details: <String, Object?>{
            'model': model.name,
            if (plan.skip != null) 'skip': plan.skip,
            if (plan.take != null) 'take': plan.take,
          },
        );
      }
      if (page.after != null) {
        _assertKnownFields(
          model: model,
          fields: page.after!.keys,
          source: 'page.after',
        );
      }
      if (page.before != null) {
        _assertKnownFields(
          model: model,
          fields: page.before!.keys,
          source: 'page.before',
        );
      }
      if (plan.resultMode != OrmReadResultMode.all) {
        throw runtimeError(
          'PLAN.PAGE_RESULT_MODE_INVALID',
          'Page windows currently require read result mode "all".',
          details: <String, Object?>{
            'model': model.name,
            'resultMode': plan.resultMode.name,
          },
        );
      }
      final boundaryFields = page.after?.keys ?? page.before?.keys;
      if (boundaryFields != null &&
          !_matchesBoundaryFields(
            orderBy: plan.orderBy,
            boundaryFields: boundaryFields,
          )) {
        throw runtimeError(
          'PLAN.CURSOR_ORDER_BY_FIELDS_INVALID',
          'Page boundary fields must match orderBy fields.',
          details: <String, Object?>{
            'model': model.name,
            'orderBy': plan.orderBy.map((entry) => entry.field).toList(),
            'boundaryFields': boundaryFields.toList(growable: false),
          },
        );
      }
    }
  }

  void _assertReadShape({
    required ModelContract model,
    required OrmReadPlan plan,
  }) {
    switch (plan.shape) {
      case OrmReadShape.rows:
        if (plan.aggregate != null || plan.groupBy != null) {
          throw runtimeError(
            'PLAN.READ_SHAPE_INVALID',
            'Row read plans cannot include aggregate or grouped metadata.',
            details: <String, Object?>{
              'model': model.name,
              'shape': plan.shape.name,
            },
          );
        }
      case OrmReadShape.aggregate:
        final aggregate = plan.aggregate;
        if (aggregate == null || plan.groupBy != null) {
          throw runtimeError(
            'PLAN.READ_SHAPE_INVALID',
            'Aggregate read plans require aggregate metadata and forbid groupBy metadata.',
            details: <String, Object?>{
              'model': model.name,
              'shape': plan.shape.name,
            },
          );
        }
        if (!aggregate.countAll &&
            aggregate.count.isEmpty &&
            aggregate.min.isEmpty &&
            aggregate.max.isEmpty &&
            aggregate.sum.isEmpty &&
            aggregate.avg.isEmpty) {
          throw runtimeError(
            'PLAN.AGGREGATE_FIELDS_EMPTY',
            'aggregate requires at least one aggregation selector.',
            details: <String, Object?>{
              'model': model.name,
              'shape': plan.shape.name,
            },
          );
        }
        if (plan.include.isNotEmpty) {
          throw runtimeError(
            'PLAN.READ_INCLUDE_UNSUPPORTED',
            'Aggregate read plans do not support include.',
            details: <String, Object?>{
              'model': model.name,
              'shape': plan.shape.name,
              'include': plan.include.keys.toList(growable: false),
            },
          );
        }
        _assertKnownFields(
          model: model,
          fields: <String>[
            ...aggregate.count,
            ...aggregate.min,
            ...aggregate.max,
            ...aggregate.sum,
            ...aggregate.avg,
          ],
          source: 'aggregate',
        );
      case OrmReadShape.groupedAggregate:
        final aggregate = plan.aggregate;
        final groupBy = plan.groupBy;
        if (aggregate == null || groupBy == null) {
          throw runtimeError(
            'PLAN.READ_SHAPE_INVALID',
            'Grouped aggregate plans require both aggregate and groupBy metadata.',
            details: <String, Object?>{
              'model': model.name,
              'shape': plan.shape.name,
            },
          );
        }
        if (!aggregate.countAll &&
            aggregate.count.isEmpty &&
            aggregate.min.isEmpty &&
            aggregate.max.isEmpty &&
            aggregate.sum.isEmpty &&
            aggregate.avg.isEmpty) {
          throw runtimeError(
            'PLAN.AGGREGATE_FIELDS_EMPTY',
            'grouped aggregate requires at least one aggregation selector.',
            details: <String, Object?>{
              'model': model.name,
              'shape': plan.shape.name,
            },
          );
        }
        if (plan.include.isNotEmpty) {
          throw runtimeError(
            'PLAN.READ_INCLUDE_UNSUPPORTED',
            'Grouped aggregate plans do not support include.',
            details: <String, Object?>{
              'model': model.name,
              'shape': plan.shape.name,
              'include': plan.include.keys.toList(growable: false),
            },
          );
        }
        _assertKnownFields(
          model: model,
          fields: groupBy.by,
          source: 'groupBy.by',
        );
        _assertKnownFields(
          model: model,
          fields: <String>[
            ...aggregate.count,
            ...aggregate.min,
            ...aggregate.max,
            ...aggregate.sum,
            ...aggregate.avg,
          ],
          source: 'groupBy.aggregate',
        );
        if (groupBy.skip case final skip? when skip < 0) {
          throw PlanInvalidPaginationException(
            key: 'groupBy.skip',
            value: skip,
          );
        }
        if (groupBy.take case final take? when take < 0) {
          throw PlanInvalidPaginationException(
            key: 'groupBy.take',
            value: take,
          );
        }
        if (groupBy.by.isEmpty) {
          throw runtimeError(
            'PLAN.GROUP_BY_FIELDS_EMPTY',
            'GroupBy requires at least one field in by.',
            details: <String, Object?>{'model': model.name},
          );
        }
        if (plan.cursor != null || plan.page != null) {
          throw runtimeError(
            'PLAN.GROUP_BY_CURSOR_WINDOW_UNSUPPORTED',
            'Grouped aggregate plans do not support cursor or page windows.',
            details: <String, Object?>{'model': model.name},
          );
        }
    }
  }

  bool _matchesBoundaryFields({
    required List<OrmOrderBy> orderBy,
    required Iterable<String> boundaryFields,
  }) {
    final orderByFields = orderBy
        .map((entry) => entry.field)
        .toList(growable: false);
    final boundary = boundaryFields.toList(growable: false);
    return orderByFields.length == boundary.length &&
        orderByFields.every(boundary.contains);
  }

  void _assertMutationPlan({
    required ModelContract model,
    required OrmMutationPlan plan,
  }) {
    _assertWhereFields(model: model, where: plan.where, source: 'where');
    _assertKnownFields(model: model, fields: plan.data.keys, source: 'data');
    _assertKnownFields(model: model, fields: plan.select, source: 'select');
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
      final relation = model.relations[key];
      if (relation != null) {
        _assertRelationWhereFields(
          relation: relation,
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

  void _assertRelationWhereFields({
    required ModelRelationContract relation,
    required Object? operand,
    required String source,
  }) {
    final relationWhere = _coerceWhereMap(operand);
    if (relationWhere == null || relationWhere.isEmpty) {
      return;
    }

    final supportedOperators = _relationWhereOperatorsFor(
      cardinality: relation.cardinality,
    );
    final unknownOperators = relationWhere.keys
        .where((key) => !supportedOperators.contains(key))
        .toList(growable: false);
    if (unknownOperators.isNotEmpty) {
      throw runtimeError(
        'PLAN.RELATION_WHERE_OPERATOR_INVALID',
        'Relation where contains unknown operators.',
        details: <String, Object?>{
          'relation': relation.name,
          'unknownOperators': unknownOperators,
          'supportedOperators': supportedOperators.toList(growable: false),
          'source': source,
        },
      );
    }

    final relatedModel = contract.models[relation.relatedModel];
    if (relatedModel == null) {
      throw ModelNotFoundException(relation.relatedModel, contract.models.keys);
    }

    for (final entry in relationWhere.entries) {
      final value = entry.value;
      if (value == null) {
        continue;
      }

      final nestedWhere = _coerceWhereMap(value);
      if (nestedWhere == null) {
        throw runtimeError(
          'PLAN.RELATION_WHERE_VALUE_INVALID',
          'Relation where operator expects a nested where map.',
          details: <String, Object?>{
            'relation': relation.name,
            'operator': entry.key,
            'source': source,
          },
        );
      }
      _assertWhereFields(
        model: relatedModel,
        where: nestedWhere,
        source: source,
      );
    }
  }

  void _ensureConnected() {
    if (_connected) {
      return;
    }
    throw ClientNotConnectedException();
  }

  Set<String> _relationWhereOperatorsFor({
    required RelationCardinality cardinality,
  }) {
    return switch (cardinality) {
      RelationCardinality.many => _toManyRelationWhereOperators,
      RelationCardinality.one => _toOneRelationWhereOperators,
    };
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
  Future<JsonMap> explain(OrmPlan plan) {
    _ensureNotReleased();
    return _core._explainOnSource(plan, _inner);
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
    await _inner.commit();
    _completed = true;
  }

  @override
  Future<void> rollback() async {
    _ensureActive();
    try {
      await _inner.rollback();
    } finally {
      _completed = true;
    }
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) {
    _ensureActive();
    return _core._executeOnQueryable(plan, _inner);
  }

  @override
  Future<JsonMap> explain(OrmPlan plan) {
    _ensureActive();
    return _core._explainOnSource(plan, _inner);
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
