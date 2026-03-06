import 'package:meta/meta.dart';

import 'plan.dart';

enum RuntimeErrorCategory { runtime, contract, plan, plugin }

enum RuntimeErrorSeverity { error, warn }

@immutable
class OrmRuntimeError implements Exception {
  final String code;
  final RuntimeErrorCategory category;
  final RuntimeErrorSeverity severity;
  final String message;
  final Map<String, Object?> details;

  OrmRuntimeError({
    required this.code,
    required this.category,
    required this.message,
    this.severity = RuntimeErrorSeverity.error,
    Map<String, Object?> details = const <String, Object?>{},
  }) : details = Map<String, Object?>.unmodifiable(details);

  @override
  String toString() {
    if (details.isEmpty) {
      return 'OrmRuntimeError[$code]: $message';
    }
    return 'OrmRuntimeError[$code]: $message | details=$details';
  }
}

OrmRuntimeError runtimeError(
  String code,
  String message, {
  RuntimeErrorCategory? category,
  RuntimeErrorSeverity severity = RuntimeErrorSeverity.error,
  Map<String, Object?> details = const <String, Object?>{},
}) {
  return OrmRuntimeError(
    code: code,
    category: category ?? _resolveCategory(code),
    message: message,
    severity: severity,
    details: details,
  );
}

RuntimeErrorCategory _resolveCategory(String code) {
  final prefix = code.split('.').first;
  return switch (prefix) {
    'PLAN' => RuntimeErrorCategory.plan,
    'CONTRACT' => RuntimeErrorCategory.contract,
    'PLUGIN' || 'LINT' || 'BUDGET' => RuntimeErrorCategory.plugin,
    _ => RuntimeErrorCategory.runtime,
  };
}

final class ClientNotConnectedException extends OrmRuntimeError {
  ClientNotConnectedException()
    : super(
        code: 'RUNTIME.CLIENT_NOT_CONNECTED',
        category: RuntimeErrorCategory.runtime,
        message: 'Call connect() before running ORM operations.',
      );
}

final class ContractHashMismatchException extends OrmRuntimeError {
  final String expected;
  final String actual;

  ContractHashMismatchException({required this.expected, required this.actual})
    : super(
        code: 'PLAN.CONTRACT_HASH_MISMATCH',
        category: RuntimeErrorCategory.plan,
        message: 'Plan contract hash does not match runtime contract hash.',
        details: <String, Object?>{'expected': expected, 'actual': actual},
      );
}

final class PlanTargetMismatchException extends OrmRuntimeError {
  final String expected;
  final String actual;

  PlanTargetMismatchException({required this.expected, required this.actual})
    : super(
        code: 'PLAN.TARGET_MISMATCH',
        category: RuntimeErrorCategory.plan,
        message: 'Plan target does not match runtime contract target.',
        details: <String, Object?>{'expected': expected, 'actual': actual},
      );
}

final class PlanStorageHashMismatchException extends OrmRuntimeError {
  final String expected;
  final String actual;

  PlanStorageHashMismatchException({
    required this.expected,
    required this.actual,
  }) : super(
         code: 'PLAN.STORAGE_HASH_MISMATCH',
         category: RuntimeErrorCategory.plan,
         message:
             'Plan storage hash does not match contract marker storage hash.',
         details: <String, Object?>{'expected': expected, 'actual': actual},
       );
}

final class PlanProfileHashMismatchException extends OrmRuntimeError {
  final String? expected;
  final String? actual;

  PlanProfileHashMismatchException({
    required this.expected,
    required this.actual,
  }) : super(
         code: 'PLAN.PROFILE_HASH_MISMATCH',
         category: RuntimeErrorCategory.plan,
         message:
             'Plan profile hash does not match runtime contract profile hash.',
         details: <String, Object?>{'expected': expected, 'actual': actual},
       );
}

final class ModelNotFoundException extends OrmRuntimeError {
  final String model;
  final Iterable<String> availableModels;

  ModelNotFoundException(this.model, this.availableModels)
    : super(
        code: 'PLAN.MODEL_NOT_FOUND',
        category: RuntimeErrorCategory.plan,
        message: 'Model "$model" was not found in the active contract.',
        details: <String, Object?>{
          'model': model,
          'availableModels': availableModels.toList(growable: false),
        },
      );
}

final class ContractMarkerMissingException extends OrmRuntimeError {
  ContractMarkerMissingException()
    : super(
        code: 'CONTRACT.MARKER_MISSING',
        category: RuntimeErrorCategory.contract,
        message:
            'Contract marker is required but was not available from marker reader.',
      );
}

final class ContractMarkerMismatchException extends OrmRuntimeError {
  final String expected;
  final String actual;

  ContractMarkerMismatchException({
    required this.expected,
    required this.actual,
  }) : super(
         code: 'CONTRACT.MARKER_MISMATCH',
         category: RuntimeErrorCategory.contract,
         message: 'Contract marker hash does not match runtime contract hash.',
         details: <String, Object?>{'expected': expected, 'actual': actual},
       );
}

final class RuntimeConnectionNotSupportedException extends OrmRuntimeError {
  RuntimeConnectionNotSupportedException()
    : super(
        code: 'RUNTIME.CONNECTION_NOT_SUPPORTED',
        category: RuntimeErrorCategory.runtime,
        message: 'The configured engine does not support scoped connections.',
      );
}

final class RuntimeConnectionReleasedException extends OrmRuntimeError {
  RuntimeConnectionReleasedException()
    : super(
        code: 'RUNTIME.CONNECTION_RELEASED',
        category: RuntimeErrorCategory.runtime,
        message: 'Connection is already released.',
      );
}

final class RuntimeTransactionCompletedException extends OrmRuntimeError {
  RuntimeTransactionCompletedException()
    : super(
        code: 'RUNTIME.TRANSACTION_COMPLETED',
        category: RuntimeErrorCategory.runtime,
        message: 'Transaction is already completed.',
      );
}

final class PluginNameEmptyException extends OrmRuntimeError {
  PluginNameEmptyException()
    : super(
        code: 'PLUGIN.NAME_EMPTY',
        category: RuntimeErrorCategory.plugin,
        message: 'Plugin name cannot be empty.',
      );
}

final class PluginNameDuplicateException extends OrmRuntimeError {
  final String pluginName;

  PluginNameDuplicateException(this.pluginName)
    : super(
        code: 'PLUGIN.NAME_DUPLICATE',
        category: RuntimeErrorCategory.plugin,
        message: 'Plugin "$pluginName" is registered more than once.',
        details: <String, Object?>{'plugin': pluginName},
      );
}

final class PlanFieldNotFoundException extends OrmRuntimeError {
  final String model;
  final String field;
  final String source;

  PlanFieldNotFoundException({
    required this.model,
    required this.field,
    required this.source,
  }) : super(
         code: 'PLAN.FIELD_NOT_FOUND',
         category: RuntimeErrorCategory.plan,
         message:
             'Field "$field" from $source is not declared on model "$model".',
         details: <String, Object?>{
           'model': model,
           'field': field,
           'source': source,
         },
       );
}

final class PlanInvalidPaginationException extends OrmRuntimeError {
  PlanInvalidPaginationException({required String key, required int value})
    : super(
        code: 'PLAN.INVALID_PAGINATION',
        category: RuntimeErrorCategory.plan,
        message: 'Pagination value "$key" must be greater than or equal to 0.',
        details: <String, Object?>{'key': key, 'value': value},
      );
}

final class PlanResultModeActionInvalidException extends OrmRuntimeError {
  final OrmAction action;
  final OrmReadResultMode? readResultMode;
  final OrmMutationResultMode? mutationResultMode;
  final bool hasRead;
  final bool hasMutation;

  PlanResultModeActionInvalidException({
    required this.action,
    required this.readResultMode,
    required this.mutationResultMode,
    required this.hasRead,
    required this.hasMutation,
  }) : super(
         code: 'PLAN.RESULT_MODE_ACTION_INVALID',
         category: RuntimeErrorCategory.plan,
         message: 'Plan branch shape does not match the requested action.',
         details: <String, Object?>{
           'action': action.name,
           'hasRead': hasRead,
           'readResultMode': readResultMode?.name,
           'hasMutation': hasMutation,
           'mutationResultMode': mutationResultMode?.name,
         },
       );
}

final class PlanRepositoryTraceInvalidException extends OrmRuntimeError {
  PlanRepositoryTraceInvalidException({
    required String reason,
    Map<String, Object?> details = const <String, Object?>{},
  }) : super(
         code: 'PLAN.REPOSITORY_TRACE_INVALID',
         category: RuntimeErrorCategory.plan,
         message: 'Repository trace metadata is invalid for this plan.',
         details: <String, Object?>{'reason': reason, ...details},
       );
}

final class RuntimeCreateResultMissingException extends OrmRuntimeError {
  RuntimeCreateResultMissingException({required String model})
    : super(
        code: 'RUNTIME.CREATE_RESULT_MISSING',
        category: RuntimeErrorCategory.runtime,
        message: 'create() expected a row but got null.',
        details: <String, Object?>{'model': model},
      );
}

final class RuntimeResponseShapeException extends OrmRuntimeError {
  RuntimeResponseShapeException({
    required String action,
    required String expected,
    Object? actual,
  }) : super(
         code: 'RUNTIME.RESPONSE_SHAPE_INVALID',
         category: RuntimeErrorCategory.runtime,
         message: 'Engine response shape is invalid for $action.',
         details: <String, Object?>{
           'action': action,
           'expected': expected,
           'actualType': actual?.runtimeType.toString(),
         },
       );
}

final class IncludeRelationNotFoundException extends OrmRuntimeError {
  IncludeRelationNotFoundException({
    required String model,
    required String relation,
    required Iterable<String> availableRelations,
  }) : super(
         code: 'PLAN.RELATION_NOT_FOUND',
         category: RuntimeErrorCategory.plan,
         message: 'Relation "$relation" was not found on model "$model".',
         details: <String, Object?>{
           'model': model,
           'relation': relation,
           'availableRelations': availableRelations.toList(growable: false),
         },
       );
}

final class IncludeDepthExceededException extends OrmRuntimeError {
  IncludeDepthExceededException({required int maxDepth})
    : super(
        code: 'RUNTIME.INCLUDE_DEPTH_EXCEEDED',
        category: RuntimeErrorCategory.runtime,
        message: 'Include nesting depth exceeds maximum allowed depth.',
        details: <String, Object?>{'maxDepth': maxDepth},
      );
}
