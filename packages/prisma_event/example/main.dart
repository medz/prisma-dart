import 'package:prisma_event/prisma_event.dart';

void main() {
  final emitter = Emitter(
    event: [Event.query],
  );

  emitter.on({Event.query}, (payload) {
    print('$payload!!!');
  });

  emitter.emit(
      Event.info, Payload(message: 'Hello World!')); // Won't be printed
  emitter.emit(Event.error, Payload(message: '222')); // Won't be printed
  emitter.emit(Event.query, QueryPayload(query: 'Hey')); // Will be printed
}
