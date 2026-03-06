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
    expect(read['cursor'], <String, Object?>{
      'values': <String, Object?>{'id': 'u1'},
    });
    expect(read['page'], <String, Object?>{
      'size': 20,
      'after': <String, Object?>{'id': 'u2'},
    });
  });

  test('read plan serializes aggregate and grouped aggregate metadata', () {
    final plan = OrmPlan.read(
      contractHash: 'contract-v1',
      lane: 'orm',
      model: 'User',
      where: const <String, Object?>{'email': 'a@x.com'},
      select: const <String>['email', 'id'],
      resultMode: OrmReadResultMode.all,
      shape: OrmReadShape.groupedAggregate,
      aggregate: OrmReadAggregatePlan(
        countAll: true,
        sum: const <String>['id'],
      ),
      groupBy: OrmReadGroupByPlan(
        by: const <String>['email'],
        having: const <String, Object?>{
          '_count': <String, Object?>{
            'all': <String, Object?>{'gte': 2},
          },
        },
        orderBy: const <OrmOrderBy>[
          OrmOrderBy('_sum.id', order: SortOrder.desc),
        ],
        take: 5,
      ),
    );

    expect(plan.read?.shape, OrmReadShape.groupedAggregate);
    final encoded = plan.toJson();
    final read = encoded['read'] as Map<String, Object?>;
    expect(read['shape'], 'groupedAggregate');
    expect(read['aggregate'], <String, Object?>{
      'countAll': true,
      'count': const <String>[],
      'min': const <String>[],
      'max': const <String>[],
      'sum': const <String>['id'],
      'avg': const <String>[],
    });
    expect(read['groupBy'], <String, Object?>{
      'by': const <String>['email'],
      'having': const <String, Object?>{
        '_count': <String, Object?>{
          'all': <String, Object?>{'gte': 2},
        },
      },
      'orderBy': const <Object?>[
        <String, Object?>{'field': '_sum.id', 'order': 'desc'},
      ],
      'take': 5,
    });
  });
}
