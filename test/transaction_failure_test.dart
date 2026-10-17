import 'package:orm/database.dart';
import 'package:orm/postgres.dart';
import 'package:orm/sqlite.dart';
import 'package:test/test.dart';

import 'support/database.dart';

void main() {
  for (final engine in Engine.values) {
    group('failed transaction on ${engine.name}', () {
      late TestDatabase fixture;
      setUp(() async => fixture = await openTestDatabase(engine));
      tearDown(() => fixture.db.close());

      for (final autoRollback in [false, if (engine == Engine.sqlite) true]) {
        for (final queued in [false, true]) {
          test('${queued ? 'queued' : 'caught'} failure stops subsequent SQL'
              '${autoRollback ? ' after engine rollback' : ''}', () async {
            final db = fixture.db;
            final original = await db.users.create(username: 'taken', age: 28);
            if (autoRollback) {
              await db.session.run('''
CREATE TRIGGER reject_duplicate BEFORE INSERT ON users
WHEN NEW.username = 'taken'
BEGIN
  SELECT RAISE(ROLLBACK, 'rejected user');
END
''');
            }
            fixture.events.clear();
            final failures = <(Object, StackTrace)?>[];
            late Session escaped;
            final transactionFailure = await _capture(
              db.transaction<void>((tx) async {
                escaped = tx;
                await tx.users.update(original.id, age: 99);
                final first = _capture(
                  tx.users.create(username: 'taken', age: 30),
                );
                if (!queued) await first;
                final update = _capture(tx.users.update(original.id, age: 50));
                final insert = _capture(
                  tx.users.create(username: 'must not persist', age: 40),
                );
                final read = _capture(tx.users.count());
                failures.addAll(
                  await Future.wait([first, update, insert, read]),
                );
              }),
            );
            final events = fixture.events.toList();

            expect((await db.users.get(original.id))!.age, 28);
            expect(await db.users.count(), 1);
            final (error, stack) = failures.first!;
            expect(
              error,
              engine == Engine.sqlite
                  ? isA<SqliteException>()
                  : isA<UniqueViolationException>(),
            );
            for (final failure in [...failures.skip(1), transactionFailure]) {
              expect(failure, isNotNull);
              expect(failure!.$1, same(error));
              expect(failure.$2.toString(), stack.toString());
            }
            expect(
              events
                  .where((event) => event.kind.startsWith('statement'))
                  .map((event) => event.kind),
              ['statement', 'statementError'],
            );
            expect(events.any((event) => event.kind == 'commit'), isFalse);
            await expectLater(escaped.run('SELECT 1'), throwsStateError);

            await db.transaction((tx) => tx.users.update(original.id, age: 29));
            expect((await db.users.get(original.id))!.age, 29);
          });
        }
      }
    }, skip: engine == Engine.postgresql && !hasPostgres);
  }
}

Future<(Object, StackTrace)?> _capture(Future<Object?> work) async {
  try {
    await work;
    return null;
  } catch (error, stack) {
    return (error, stack);
  }
}
