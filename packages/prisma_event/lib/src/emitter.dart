import 'dart:async';

import 'definition.dart';
import 'emit.dart';
import 'event.dart';
import 'payload.dart';

/// Prisma event emitter.
abstract class Emitter {
  /// Create a new logger.
  factory Emitter({
    Iterable<Event>? stdout,
    Iterable<Event>? event,
  }) = _EmitterImpl;

  /// The log definitions.
  Iterable<Definition> get definitions;

  /// Listen to log events.
  void on(Iterable<Event> events, void Function(Payload payload) listener);

  /// Emit a log event.
  void emit(Event event, Payload payload);
}

/// Broadcast Event.
class _BroadcastEvent {
  final Event event;
  final Payload payload;

  _BroadcastEvent(this.event, this.payload);
}

class _EmitterImpl implements Emitter {
  @override
  final List<Definition> definitions;

  /// Briadcast stream controller.
  final StreamController<_BroadcastEvent> broadcast;

  /// Create a new Emmiter.
  const _EmitterImpl._internal({
    required this.definitions,
    required this.broadcast,
  });

  /// Create a new logger.
  factory _EmitterImpl({
    Iterable<Event>? stdout,
    Iterable<Event>? event,
  }) {
    final broadcast = StreamController<_BroadcastEvent>.broadcast();
    final definitions = <Definition>[];

    if (stdout != null) {
      definitions.addAll(
          stdout.toSet().map((event) => Definition(event, Emit.stdout)));

      broadcast.stream
          .where((event) => stdout.contains(event.event))
          .map((event) => event.payload)
          .listen(print);
    }
    if (event != null) {
      definitions
          .addAll(event.toSet().map((event) => Definition(event, Emit.event)));
    }

    return _EmitterImpl._internal(
      definitions: definitions,
      broadcast: broadcast,
    );
  }

  @override
  void emit(Event event, Payload payload) {
    // If [event] is [Event.query], The [playload] must be a [QueryPayload].
    if (event == Event.query && payload is! QueryPayload) {
      throw ArgumentError.value(
        payload,
        'payload',
        'The payload must be a QueryPayload',
      );

      // If [paload] is a [QueryPayload], The [event] must be [Event.query].
    } else if (payload is QueryPayload && event != Event.query) {
      throw ArgumentError.value(
        event,
        'event',
        'The event must be Event.query',
      );
    }

    broadcast.add(_BroadcastEvent(event, payload));
  }

  @override
  void on(Iterable<Event> events, void Function(Payload payload) listener) {
    broadcast.stream
        .where((event) => events.contains(event.event))
        .where((event) => definitions
            .where((element) => element.emit == Emit.event)
            .map((element) => element.event)
            .contains(event.event))
        .map((event) => event.payload)
        .listen(listener);
  }
}
