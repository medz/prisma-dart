import 'dart:async';

import 'package:meta/meta.dart';

import '../contract/contract.dart';
import '../engine/engine.dart';
import 'plan.dart';
import 'types.dart';

enum RuntimeMode { strict, permissive }

abstract interface class RuntimeLog {
  void info(Object? event);

  void warn(Object? event);

  void error(Object? event);
}

final class SilentRuntimeLog implements RuntimeLog {
  const SilentRuntimeLog();

  @override
  void error(Object? event) {
    // Intentionally no-op.
  }

  @override
  void info(Object? event) {
    // Intentionally no-op.
  }

  @override
  void warn(Object? event) {
    // Intentionally no-op.
  }
}

@immutable
final class PluginContext {
  final OrmContract contract;
  final OrmEngine engine;
  final RuntimeMode mode;
  final DateTime Function() now;
  final RuntimeLog log;

  const PluginContext({
    required this.contract,
    required this.engine,
    required this.mode,
    required this.now,
    required this.log,
  });
}

@immutable
final class AfterExecuteResult {
  final int rowCount;
  final int affectedRows;
  final int latencyMs;
  final bool completed;

  const AfterExecuteResult({
    required this.rowCount,
    required this.affectedRows,
    required this.latencyMs,
    required this.completed,
  });
}

abstract base class OrmPlugin {
  const OrmPlugin();

  String get name;

  FutureOr<void> beforeExecute(OrmPlan plan, PluginContext ctx) {}

  FutureOr<void> onRow(JsonMap row, OrmPlan plan, PluginContext ctx) {}

  FutureOr<void> afterExecute(
    OrmPlan plan,
    AfterExecuteResult result,
    PluginContext ctx,
  ) {}

  FutureOr<void> onError(
    OrmPlan plan,
    Object error,
    StackTrace stackTrace,
    PluginContext ctx,
  ) {}
}
