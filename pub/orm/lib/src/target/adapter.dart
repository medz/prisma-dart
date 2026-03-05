import '../engine/engine.dart';
import '../runtime/plan.dart';

abstract interface class TargetAdapter<TRequest, TRawResponse> {
  TRequest lower(OrmPlan plan);

  EngineResponse decode(TRawResponse response, OrmPlan plan);
}
