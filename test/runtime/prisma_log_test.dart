import 'package:orm/orm.dart';
import 'package:test/test.dart';

void main() {
  late PrismaLogEmitter emitter;

  setUp(() {
    emitter = PrismaLogEmitter([
      PrismaLogDefinition(
        level: PrismaLogLevel.info,
        emit: PrismaLogEmit.event,
      ),
    ]);
  });

  test('should emit log event', () {
    final List<PrismaLogEvent> logs = [];

    emitter.on({PrismaLogLevel.info}, (exception) {
      logs.add(exception as PrismaLogEvent);
    });

    emitter.emit(
      PrismaLogLevel.info,
      PrismaLogEvent(
        message: 'Hello world!',
        target: '',
        timestamp: DateTime.now(),
      ),
    );

    expect(logs.length, 1);
    expect(logs.first.message, 'Hello world!');
  });
}
