import 'dart:io';

import 'package:test/test.dart';

void main() {
  final source = File(
    '/Users/seven/workspace/dart-orm/pub/orm/lib/src/client/client.dart',
  ).readAsStringSync();

  group('dynamic client source surface', () {
    test('delegate routes public terminals through query specs', () {
      expect(
        RegExp(
          r'class\s+ModelDelegate\s*\{[\s\S]*?ModelQuery\s+query\(\)\s*=>\s*_queryFromSpec\(OrmReadQuerySpec\(\)\);',
        ).hasMatch(source),
        isTrue,
        reason: 'Expected ModelDelegate.query() to centralize query creation.',
      );
      expect(
        RegExp(
          r'class\s+ModelDelegate\s*\{[\s\S]*?Future<List<JsonMap>>\s+all\(\{[\s\S]*?\)\s*=>\s*_queryFromSpec\([\s\S]*?\)\.all\(\);',
        ).hasMatch(source),
        isTrue,
        reason:
            'Expected ModelDelegate.all(...) to route through _queryFromSpec(...).all().',
      );
      expect(
        RegExp(
          r'class\s+ModelDelegate\s*\{[\s\S]*?Future<int>\s+count\(\{[\s\S]*?\)\s*=>\s*_queryFromSpec\([\s\S]*?\)\.count\(\);',
        ).hasMatch(source),
        isTrue,
        reason:
            'Expected ModelDelegate.count(...) to route through _queryFromSpec(...).count().',
      );
      expect(
        RegExp(
          r'class\s+ModelDelegate\s*\{[\s\S]*?Future<JsonMap>\s+create\(\{[\s\S]*?\)\s*=>\s*_queryFromSpec\([\s\S]*?\)\.create\(data:\s*data\);',
        ).hasMatch(source),
        isTrue,
        reason:
            'Expected ModelDelegate.create(...) to route through _queryFromSpec(...).create(...).',
      );
      expect(
        RegExp(
          r'class\s+ModelDelegate\s*\{[\s\S]*?Future<JsonMap>\s+aggregateWith\(\{[\s\S]*?required\s+OrmAggregateSpec\s+aggregate,[\s\S]*?\)\s*=>\s*_queryFromSpec\([\s\S]*?\)\.aggregateWith\(aggregate\);',
        ).hasMatch(source),
        isTrue,
        reason:
            'Expected ModelDelegate.aggregateWith(...) to route structured aggregate execution through query terminals.',
      );
      expect(
        RegExp(
          r'class\s+ModelDelegate\s*\{[\s\S]*?ModelGroupedQuery\s+groupedBy\(\s*List<String>\s+by,\s*\{[\s\S]*?JsonMap\s+where\s*=\s*const\s+<String,\s*Object\?>\{\},[\s\S]*?\)\s*=>\s*_queryFromSpec\(OrmReadQuerySpec\(where:\s*where\)\)\.groupedBy\(by\);',
        ).hasMatch(source),
        isTrue,
        reason:
            'Expected ModelDelegate.groupedBy(...) to create grouped queries from where-only query specs.',
      );
      expect(
        RegExp(
          r'class\s+ModelDelegate\s*\{[\s\S]*?Future<List<JsonMap>>\s+groupByWith\(',
        ).hasMatch(source),
        isFalse,
        reason:
            'Expected ModelDelegate to avoid redundant groupByWith(...) wrappers.',
      );
    });

    test(
      'query terminals route aggregate groupBy and mutations to private helpers',
      () {
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<JsonMap>\s+aggregate\(\s*OrmAggregateBuilder\s+Function\(OrmAggregateBuilder\s+aggregate\)\s+build,\s*\)\s*\{[\s\S]*?return\s+aggregateWith\(build\(OrmAggregateBuilder\(\)\)\.toSpec\(\)\);',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.aggregate(...) to route through the aggregate builder callback.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<JsonMap>\s+aggregateWith\(OrmAggregateSpec\s+aggregate\)\s*\{[\s\S]*?_assertAggregateQueryState\(\);[\s\S]*?_prepareAggregateQuery\(spec:\s*_state,\s*aggregate:\s*aggregate\)[\s\S]*?prepared\.execute\(\)',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.aggregateWith(...) to prepare an aggregate plan before execution.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?ModelGroupedQuery\s+groupedBy\(List<String>\s+by\)\s*\{[\s\S]*?_assertGroupedQueryBaseState\(\);[\s\S]*?return\s+ModelGroupedQuery\._\([\s\S]*?OrmGroupBySpec\(by:\s*by\),',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.groupedBy(...) to construct a distinct grouped builder.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+groupBy\(',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelQuery to avoid redundant groupBy(...) convenience terminals.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+groupByWith\(',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelQuery to avoid redundant groupByWith(...) terminals.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+aggregateWith\(OrmAggregateSpec\s+aggregate\)\s*\{[\s\S]*?_prepareGrouped\([\s\S]*?groupBy:\s*_groupBy\.copyWith\([\s\S]*?prepared\.execute\(\)',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelGroupedQuery.aggregateWith(...) to prepare a grouped aggregate plan before execution.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?Future<OrmPlan>\s+toPlan\(\)\s+async\s*\{[\s\S]*?_prepareGrouped\(groupBy:\s*_groupBy\)\)\.plan;',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelGroupedQuery.toPlan() to expose the grouped aggregate plan surface.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?ModelGroupedQuery\s+havingWith\(',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelGroupedQuery to avoid redundant havingWith(...) wrappers.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?ModelGroupedQuery\s+havingExpr\(\s*OrmGroupByHaving\s+Function\(OrmGroupByHavingBuilder\s+having\)\s+build,\s*\{\s*bool\s+merge\s*=\s*true,\s*\}\s*\)',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelGroupedQuery to expose a builder-style havingExpr(...) surface.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?ModelGroupedQuery\s+having\(OrmGroupByHaving\s+having,\s*\{\s*bool\s+merge\s*=\s*true\s*\}\)',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelGroupedQuery.having(...) to accept structured grouped having clauses instead of raw maps.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?ModelGroupedQuery\s+having\(JsonMap\s+having,',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelGroupedQuery to keep raw JsonMap having out of the public grouped surface.',
        );
        expect(
          RegExp(r'\bclass\s+OrmGroupByHavingBuilder\b').hasMatch(source),
          isTrue,
          reason:
              'Expected dynamic client source to include OrmGroupByHavingBuilder.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?ModelGroupedQuery\s+orderBy\(',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelGroupedQuery to not expose grouped orderBy state.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?ModelGroupedQuery\s+skip\(',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelGroupedQuery to not expose grouped skip state.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?ModelGroupedQuery\s+take\(',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelGroupedQuery to not expose grouped take state.',
        );
        expect(
          RegExp(
            r'class\s+ModelGroupedQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+all\(',
          ).hasMatch(source),
          isFalse,
          reason:
              'Expected ModelGroupedQuery to avoid row-query all() terminals.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+createMany\(\{required\s+List<JsonMap>\s+data\}\)\s*\{[\s\S]*?return\s+_delegate\._createMany\(data:\s*data,\s*spec:\s*_state\);',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.createMany(...) to terminate through the private mutation helper.',
        );
        expect(
          RegExp(
            r"class\s+ModelQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+updateAll\(\{required\s+JsonMap\s+data\}\)\s*\{[\s\S]*?_assertMutationQueryState\(\s*action:\s*'updateAll',\s*requireWhere:\s*true\);[\s\S]*?return\s+_delegate\._updateAll\(data:\s*data,\s*spec:\s*_state\);",
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.updateAll(...) to require where() and terminate through the private mutation helper.',
        );
        expect(
          RegExp(
            r"class\s+ModelQuery\s*\{[\s\S]*?Future<int>\s+updateCount\(\{required\s+JsonMap\s+data\}\)\s*\{[\s\S]*?_assertMutationQueryState\(\s*action:\s*'updateCount',\s*requireWhere:\s*true,\s*allowSelect:\s*false,\s*allowInclude:\s*false,\s*\);[\s\S]*?return\s+_delegate\._updateCount\(data:\s*data,\s*spec:\s*_state\);",
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.updateCount(...) to reject row-shaping state and terminate through the private mutation helper.',
        );
        expect(
          RegExp(
            r"class\s+ModelQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+deleteAll\(\)\s*\{[\s\S]*?_assertMutationQueryState\(\s*action:\s*'deleteAll',\s*requireWhere:\s*true\);[\s\S]*?return\s+_delegate\._deleteAll\(spec:\s*_state\);",
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.deleteAll(...) to require where() and terminate through the private mutation helper.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<int>\s+deleteCount\(\)\s*\{[\s\S]*?return\s+_delegate\._deleteCount\(spec:\s*_state\);',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.deleteCount(...) to terminate through the private mutation helper.',
        );
        expect(
          RegExp(
            r"class\s+ModelQuery\s*\{[\s\S]*?Future<int>\s+deleteCount\(\)\s*\{[\s\S]*?_assertMutationQueryState\(\s*action:\s*'deleteCount',\s*requireWhere:\s*true,\s*allowSelect:\s*false,\s*allowInclude:\s*false,\s*\);",
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.deleteCount(...) to reject row-shaping state.',
        );
      },
    );
  });
}
