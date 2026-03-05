import '../engine/engine.dart';
import '../runtime/plan.dart';
import 'adapter.dart';
import 'driver.dart';

final class AdapterDriverEngine<TRequest, TRawResponse> implements OrmEngine {
  final TargetAdapter<TRequest, TRawResponse> adapter;
  final TargetDriver<TRequest, TRawResponse> driver;
  bool _opened = false;

  AdapterDriverEngine({required this.adapter, required this.driver});

  @override
  Future<void> open() async {
    if (_opened) {
      return;
    }
    await driver.open();
    _opened = true;
  }

  @override
  Future<void> close() async {
    if (!_opened) {
      return;
    }
    await driver.close();
    _opened = false;
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    if (!_opened) {
      throw StateError(
        'AdapterDriverEngine is closed. Call open() before execute().',
      );
    }

    final request = adapter.lower(plan);
    final raw = await driver.execute(request);
    return adapter.decode(raw, plan);
  }
}
