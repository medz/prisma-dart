import 'package:orm/orm.dart';
import 'package:test/test.dart';

void main() {
  test('forwards open and close to target driver', () async {
    final adapter = _TrackingAdapter();
    final driver = _TrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    await engine.close();

    expect(driver.openCount, 1);
    expect(driver.closeCount, 1);
  });

  test('requires open before execute', () async {
    final engine = AdapterDriverEngine<String, String>(
      adapter: _TrackingAdapter(),
      driver: _TrackingDriver(),
    );

    await expectLater(engine.execute(_plan()), throwsA(isA<StateError>()));
  });

  test('executes lowering and decode pipeline', () async {
    final adapter = _TrackingAdapter();
    final driver = _TrackingDriver();
    final engine = AdapterDriverEngine<String, String>(
      adapter: adapter,
      driver: driver,
    );

    await engine.open();
    final response = await engine.execute(
      _plan(where: <String, Object?>{'id': 'u1'}),
    );

    expect(adapter.loweredPlans, hasLength(1));
    expect(adapter.decodedRaw, <String>['driver:User:findMany']);
    expect(driver.requests, <String>['User:findMany']);
    expect(response.affectedRows, 1);

    final row = response.data;
    expect(row, isA<Map<String, Object?>>());
    if (row case final Map<String, Object?> map) {
      expect(map['request'], 'User:findMany');
      expect(map['action'], 'findMany');
      expect(map['whereId'], 'u1');
    } else {
      fail('Expected map response data.');
    }

    await engine.close();
  });
}

OrmPlan _plan({JsonMap where = const <String, Object?>{}}) {
  return OrmPlan(
    contractHash: 'hash',
    model: 'User',
    action: OrmAction.findMany,
    where: where,
  );
}

final class _TrackingAdapter implements TargetAdapter<String, String> {
  final List<OrmPlan> loweredPlans = <OrmPlan>[];
  final List<String> decodedRaw = <String>[];

  @override
  String lower(OrmPlan plan) {
    loweredPlans.add(plan);
    return '${plan.model}:${plan.action.name}';
  }

  @override
  EngineResponse decode(String response, OrmPlan plan) {
    decodedRaw.add(response);
    return EngineResponse(
      data: <String, Object?>{
        'request': '${plan.model}:${plan.action.name}',
        'action': plan.action.name,
        'whereId': plan.where['id'],
      },
      affectedRows: 1,
    );
  }
}

final class _TrackingDriver implements TargetDriver<String, String> {
  int openCount = 0;
  int closeCount = 0;
  final List<String> requests = <String>[];

  @override
  Future<void> open() async {
    openCount += 1;
  }

  @override
  Future<void> close() async {
    closeCount += 1;
  }

  @override
  Future<String> execute(String request) async {
    requests.add(request);
    return 'driver:$request';
  }
}
