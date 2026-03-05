import '../errors.dart';
import '../plan.dart';
import '../plugin.dart';

enum LintSeverity { warn, error }

final class LintsOptions {
  final LintSeverity mutationWithoutWhere;
  final LintSeverity unboundedRead;
  final LintSeverity uniqueWithoutWhere;

  const LintsOptions({
    this.mutationWithoutWhere = LintSeverity.error,
    this.unboundedRead = LintSeverity.warn,
    this.uniqueWithoutWhere = LintSeverity.error,
  });
}

OrmPlugin lints({LintsOptions options = const LintsOptions()}) {
  return _LintsPlugin(options);
}

final class _LintsPlugin extends OrmPlugin {
  final LintsOptions options;

  const _LintsPlugin(this.options);

  @override
  String get name => 'lints';

  @override
  void beforeExecute(OrmPlan plan, PluginContext ctx) {
    if (_isMutation(plan) && plan.where.isEmpty) {
      _handle(
        ctx: ctx,
        severity: options.mutationWithoutWhere,
        code: 'LINT.MUTATION_WITHOUT_WHERE',
        message:
            'Mutation without where clause is blocked to prevent accidental wide updates/deletes.',
        details: <String, Object?>{
          'action': plan.action.name,
          'model': plan.model,
        },
      );
    }

    if (plan.action == OrmAction.findUnique && plan.where.isEmpty) {
      _handle(
        ctx: ctx,
        severity: options.uniqueWithoutWhere,
        code: 'LINT.UNIQUE_WITHOUT_WHERE',
        message: 'findUnique requires a non-empty where clause.',
        details: <String, Object?>{'model': plan.model},
      );
    }

    if (plan.action == OrmAction.findMany && plan.take == null) {
      _handle(
        ctx: ctx,
        severity: options.unboundedRead,
        code: 'LINT.UNBOUNDED_READ',
        message: 'Unbounded findMany may return very large result sets.',
        details: <String, Object?>{'model': plan.model},
      );
    }
  }
}

bool _isMutation(OrmPlan plan) {
  return switch (plan.action) {
    OrmAction.create || OrmAction.update || OrmAction.delete => true,
    OrmAction.findMany || OrmAction.findUnique => false,
  };
}

void _handle({
  required PluginContext ctx,
  required LintSeverity severity,
  required String code,
  required String message,
  required Map<String, Object?> details,
}) {
  if (severity == LintSeverity.error) {
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
