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
          r'class\s+ModelDelegate\s*\{[\s\S]*?Future<List<JsonMap>>\s+groupByWith\(\{[\s\S]*?required\s+OrmGroupBySpec\s+groupBy,[\s\S]*?\)\s*=>\s*_queryFromSpec\([\s\S]*?\)\.groupByWith\(groupBy\);',
        ).hasMatch(source),
        isTrue,
        reason:
            'Expected ModelDelegate.groupByWith(...) to route structured groupBy execution through query terminals.',
      );
    });

    test(
      'query terminals route aggregate groupBy and mutations to private helpers',
      () {
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<JsonMap>\s+aggregate\(\{[\s\S]*?\)\s*=>\s*aggregateWith\(\s*OrmAggregateSpec\(',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.aggregate(...) to compile convenience arguments into OrmAggregateSpec.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<JsonMap>\s+aggregateWith\(OrmAggregateSpec\s+aggregate\)\s*\{[\s\S]*?return\s+_delegate\._aggregate\(spec:\s*_state,\s*aggregate:\s*aggregate\);',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.aggregateWith(...) to terminate through the private aggregate helper.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+groupBy\(\{[\s\S]*?\)\s*=>\s*groupByWith\(\s*OrmGroupBySpec\(',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.groupBy(...) to compile convenience arguments into OrmGroupBySpec.',
        );
        expect(
          RegExp(
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<List<JsonMap>>\s+groupByWith\(OrmGroupBySpec\s+groupBy\)\s*\{[\s\S]*?final\s+effectiveGroupBy\s*=[\s\S]*?groupBy\.copyWith\(orderBy:\s*_state\.orderBy\)[\s\S]*?return\s+_delegate\._groupBy\(spec:\s*_state,\s*groupBy:\s*effectiveGroupBy\);',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.groupByWith(...) to terminate through the private groupBy helper.',
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
            r'class\s+ModelQuery\s*\{[\s\S]*?Future<int>\s+deleteMany\(\)\s*\{[\s\S]*?return\s+_delegate\._deleteMany\(spec:\s*_state\);',
          ).hasMatch(source),
          isTrue,
          reason:
              'Expected ModelQuery.deleteMany(...) to terminate through the private mutation helper.',
        );
      },
    );
  });
}
