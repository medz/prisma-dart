import 'dart:async';

import 'package:meta/meta.dart';

import '../runtime/plan.dart';
import '../runtime/types.dart';

enum EngineExecutionMode { buffered, stream }

enum EngineExecutionSource { buffered, directStream }

@immutable
final class EngineResponse {
  final Stream<Object?> rows;
  final int affectedRows;
  final EngineExecutionMode executionMode;
  final EngineExecutionSource executionSource;

  EngineResponse({
    required this.rows,
    this.affectedRows = 0,
    this.executionMode = EngineExecutionMode.buffered,
    this.executionSource = EngineExecutionSource.buffered,
  });

  factory EngineResponse.buffered(Object? data, {int affectedRows = 0}) {
    if (data == null) {
      return EngineResponse.empty(affectedRows: affectedRows);
    }
    if (data is List<Object?>) {
      return EngineResponse(
        rows: Stream<Object?>.fromIterable(data),
        affectedRows: affectedRows,
        executionMode: EngineExecutionMode.buffered,
        executionSource: EngineExecutionSource.buffered,
      );
    }
    return EngineResponse(
      rows: Stream<Object?>.value(data),
      affectedRows: affectedRows,
      executionMode: EngineExecutionMode.buffered,
      executionSource: EngineExecutionSource.buffered,
    );
  }

  factory EngineResponse.empty({int affectedRows = 0}) {
    return EngineResponse(
      rows: const Stream<Object?>.empty(),
      affectedRows: affectedRows,
      executionMode: EngineExecutionMode.buffered,
      executionSource: EngineExecutionSource.buffered,
    );
  }
}

abstract interface class RuntimeQueryable {
  Future<EngineResponse> execute(OrmPlan plan);
}

abstract interface class EngineConnection implements RuntimeQueryable {
  Future<EngineTransaction> transaction();

  Future<void> release();
}

abstract interface class EngineTransaction implements RuntimeQueryable {
  Future<void> commit();

  Future<void> rollback();
}

abstract interface class ConnectionCapableEngine {
  Future<EngineConnection> connection();
}

abstract interface class OrmEngine implements RuntimeQueryable {
  Future<void> open();

  Future<void> close();
}

abstract interface class ExplainCapableEngine {
  Future<JsonMap> describePlan(OrmPlan plan);
}
