/// Log level
enum LogLevel { info, query, warn, error }

/// Log emit
enum LogEmit { stdout, event }

/// Prisma engine log event.
///
/// @see [QueryEvent]
/// @see [LogEvent]
base class EngineEvent {
  /// Event timestamp.
  final DateTime timestamp;

  /// Event target.
  final String target;

  const EngineEvent({required this.timestamp, required this.target});
}

/// Log event.
final class LogEvent extends EngineEvent {
  /// Log message.
  final String message;

  const LogEvent(
      {required super.timestamp, required super.target, required this.message});
}

/// Query log event.
final class QueryEvent extends EngineEvent {
  final String query;
  final String params;
  final double duration;

  const QueryEvent(
      {required super.timestamp,
      required super.target,
      required this.duration,
      required this.params,
      required this.query});
}

typedef LogDefinition = Set<(LogLevel level, LogEmit emit)>;
typedef LogListener = void Function(EngineEvent event);

/// Prisma log event emitter.
class LogEmitter {
  final LogDefinition _definition;
  final _listeners = <(LogLevel, LogListener)>[];

  LogEmitter(LogDefinition definition) : _definition = definition;

  void on(LogLevel level, LogListener listener) {
    final extsis = _listeners.any((e) => e.$1 == level && e.$2 == listener);
    if (extsis) return;

    _listeners.add((level, listener));
  }

  void emit(LogLevel level, EngineEvent event) {
    _emitStdout(level, event);
    _emitEvent(level, event);
  }

  void _emitStdout(LogLevel level, EngineEvent event) {
    if (_definition.should(level, LogEmit.stdout)) {
      final name = 'prisma:${level.name}';
      final message = switch (event) {
        LogEvent(message: final String message) => message,
        QueryEvent(query: final String query, params: final String params) =>
          '$query - $params',
        _ => 'Unknown log event: $event',
      };

      print('$name $message');
    }
  }

  void _emitEvent(LogLevel level, EngineEvent event) {
    if (!_definition.should(level, LogEmit.event)) return;

    final listeners = _listeners.where((e) => e.$1 == level).map((e) => e.$2);
    for (final listener in listeners) {
      listener(event);
    }
  }
}

extension on LogDefinition {
  bool should(LogLevel level, LogEmit emit) {
    return any((e) => e.$1 == level && e.$2 == emit);
  }
}
