import 'package:orm/orm.dart';
import 'package:test/test.dart';

void main() {
  test('read plan keeps cursor and page immutable and serializable', () {
    final cursor = <String, Object?>{'id': 'u1'};
    final after = <String, Object?>{'id': 'u2'};

    final plan = OrmPlan.read(
      contractHash: 'contract-v1',
      lane: 'orm',
      model: 'User',
      where: const <String, Object?>{'email': 'a@x.com'},
      cursor: OrmReadCursorPlan(values: cursor),
      page: OrmReadPagePlan(size: 20, after: after),
      resultMode: OrmReadResultMode.all,
    );

    cursor['id'] = 'mutated';
    after['id'] = 'mutated';

    expect(plan.read?.cursor?.values, <String, Object?>{'id': 'u1'});
    expect(plan.read?.page?.after, <String, Object?>{'id': 'u2'});

    final encoded = plan.toJson();
    expect(encoded['lane'], 'orm');
    expect(encoded['action'], 'read');
    final read = encoded['read'] as Map<String, Object?>;
    expect(
      read['cursor'],
      <String, Object?>{
        'values': <String, Object?>{'id': 'u1'},
      },
    );
    expect(
      read['page'],
      <String, Object?>{
        'size': 20,
        'after': <String, Object?>{'id': 'u2'},
      },
    );
  });
}
