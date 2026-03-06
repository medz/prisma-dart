import '../errors.dart';
import '../plan.dart';
import '../plugin.dart';

enum BudgetSeverity { warn, error }

final class BudgetsOptions {
  final int maxRows;
  final int maxLatencyMs;
  final BudgetSeverity rowSeverity;
  final BudgetSeverity latencySeverity;

  const BudgetsOptions({
    this.maxRows = 10000,
    this.maxLatencyMs = 1000,
    this.rowSeverity = BudgetSeverity.error,
    this.latencySeverity = BudgetSeverity.warn,
  });
}

OrmPlugin budgets({BudgetsOptions options = const BudgetsOptions()}) {
  return _BudgetsPlugin(options);
}

final class _BudgetsPlugin extends OrmPlugin {
  final BudgetsOptions options;

  const _BudgetsPlugin(this.options);

  @override
  String get name => 'budgets';

  @override
  void beforeExecute(OrmPlan plan, PluginContext ctx) {
    final read = plan.read;
    if (plan.action == OrmAction.read &&
        read != null &&
        read.take != null &&
        read.take! > options.maxRows) {
      _handle(
        ctx: ctx,
        severity: options.rowSeverity,
        code: 'BUDGET.ROWS_EXCEEDED',
        message: 'Requested row budget exceeds configured maxRows limit.',
        details: <String, Object?>{
          'maxRows': options.maxRows,
          'requestedRows': read.take,
          'model': plan.model,
        },
      );
    }
  }

  @override
  void afterExecute(
    OrmPlan plan,
    AfterExecuteResult result,
    PluginContext ctx,
  ) {
    if (result.rowCount > options.maxRows) {
      _handle(
        ctx: ctx,
        severity: options.rowSeverity,
        code: 'BUDGET.ROWS_EXCEEDED',
        message: 'Observed row count exceeds configured maxRows limit.',
        details: <String, Object?>{
          'maxRows': options.maxRows,
          'rowCount': result.rowCount,
          'model': plan.model,
        },
      );
    }

    if (result.latencyMs > options.maxLatencyMs) {
      _handle(
        ctx: ctx,
        severity: options.latencySeverity,
        code: 'BUDGET.LATENCY_EXCEEDED',
        message: 'Execution latency exceeds configured maxLatencyMs limit.',
        details: <String, Object?>{
          'maxLatencyMs': options.maxLatencyMs,
          'latencyMs': result.latencyMs,
          'model': plan.model,
        },
      );
    }
  }
}

void _handle({
  required PluginContext ctx,
  required BudgetSeverity severity,
  required String code,
  required String message,
  required Map<String, Object?> details,
}) {
  if (severity == BudgetSeverity.error) {
    throw runtimeError(code, message, details: details);
  }

  if (ctx.mode == RuntimeMode.strict) {
    throw runtimeError(code, message, details: details);
  }

  ctx.log.warn(<String, Object?>{
    'code': code,
    'message': message,
    'details': details,
    'severity': 'warn',
  });
}
