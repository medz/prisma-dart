import 'package:meta/meta.dart';

import '../runtime/plan.dart';
import '../runtime/types.dart';

@immutable
final class EngineResponse {
  final Object? data;
  final int affectedRows;

  const EngineResponse({this.data, this.affectedRows = 0});
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
