import 'dart:async';

import '../engine/engine.dart';
import '../runtime/plan.dart';
import '../runtime/types.dart';

abstract interface class TargetAdapter<TRequest, TRawResponse> {
  TRequest lower(OrmPlan plan);

  EngineResponse decode(TRawResponse response, OrmPlan plan);
}

abstract interface class ExplainCapableTargetAdapter<TRequest, TRawResponse> {
  JsonMap describe(OrmPlan plan, TRequest request);
}

abstract interface class ReadStreamCapableTargetAdapter<TRequest, TRawRow> {
  Stream<Object?> decodeReadRows(Stream<TRawRow> rows, OrmPlan plan);
}
