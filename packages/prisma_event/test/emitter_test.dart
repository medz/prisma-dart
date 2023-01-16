import 'package:prisma_event/prisma_event.dart';
import 'package:test/test.dart';

void main() {
  test('emit - query', () {
    final emitter = Emitter(event: Event.values);
    final payload = QueryPayload(query: '1');

    emitter.on({Event.query}, expectAsync1((p) => expect(p, payload)));
    emitter.emit(Event.query, payload);

    // Test Exception
    expect(
        Future(() => emitter.emit(Event.info, payload)), throwsArgumentError);
  });
}
