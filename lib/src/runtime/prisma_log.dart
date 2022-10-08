/// Log level
enum PrismaLogLevel {
  /// Log level for info messages
  info,

  /// Log level for warning messages
  warn,

  /// Log level for error messages
  error,

  /// Log level for query messages
  query,
}

/// Log emit.
enum PrismaLogEmit {
  /// Log emit for stdout
  stdout,

  /// Log emit for PrismaEvent
  event,
}

/// Log definition
class PrismaLogDefinition {
  /// Create a new log definition
  const PrismaLogDefinition({
    required this.level,
    required this.emit,
  });

  /// Log level
  final PrismaLogLevel level;

  /// Log emit
  final PrismaLogEmit emit;
}

abstract class PrismaEvent extends Exception {
  DateTime get timestamp;
  String get target;

  factory PrismaEvent.forJson(Map<String, dynamic> payload) {
    if (!isEvent(payload)) {
      throw ArgumentError('Invalid PrismaEvent payload');
    } else if (PrismaQueryEvent.isQueryEvent(payload)) {
      return PrismaQueryEvent(
        timestamp: DateTime.parse(payload['timestamp']),
        target: payload['target'],
        query: payload['fields']['query'],
        params: payload['fields']['params'] ?? '',
        duration: payload['fields']['duration_ms'] ?? 0,
      );
    }

    return PrismaLogEvent(
      timestamp: DateTime.parse(payload['timestamp']),
      target: payload['target'],
      message: payload['fields']['message'],
    );
  }

  /// PrismaEvent payload is PrismaEvent.
  static bool isEvent(Map<String, dynamic> payload) {
    return (PrismaLogEvent.isLogEvent(payload) ||
            PrismaQueryEvent.isQueryEvent(payload)) &&
        payload['timestamp'] != null &&
        payload['target'] != null;
  }
}

/// Log PrismaEvent
class PrismaLogEvent implements PrismaEvent {
  @override
  final DateTime timestamp;

  final String message;

  @override
  final String target;

  /// Create a new log PrismaEvent
  const PrismaLogEvent({
    required this.timestamp,
    required this.message,
    required this.target,
  });

  // Returns string representation of this object.
  @override
  String toString() {
    return 'PrismaLogEvent(timestamp: $timestamp, message: $message, target: $target)';
  }

  /// PrismaEvent payload is a log PrismaEvent.
  static bool isLogEvent(Map<String, dynamic> payload) {
    return payload['fields']['message'] != null;
  }
}

/// Query log PrismaEvent
class PrismaQueryEvent implements PrismaEvent {
  @override
  final String target;

  @override
  final DateTime timestamp;

  final String query;
  final String params;
  final int duration;

  /// Create a new query log PrismaEvent
  const PrismaQueryEvent({
    required this.target,
    required this.timestamp,
    required this.query,
    required this.params,
    required this.duration,
  });

  /// Returns string representation of this object.
  @override
  String toString() {
    return 'PrismaQueryEvent(target: $target, timestamp: $timestamp, query: $query, params: $params, duration: $duration)';
  }

  /// PrismaEvent payload is a query PrismaEvent
  static isQueryEvent(Map<String, dynamic> payload) {
    return payload['fields']['query'] != null;
  }
}

typedef PrismaLogHandler = void Function(Exception exception);

/// Loggable prisma client.
abstract class PrismaClientLoggable {
  /// Register a log handler.
  void $on(Set<PrismaLogLevel> levels, PrismaLogHandler handler);
}

/// Log emitter
abstract class PrismaLogEmitter {
  /// Emit a log message
  void emit(PrismaLogLevel level, Exception exception);

  /// Register a log handler.
  void on(Set<PrismaLogLevel> levels, PrismaLogHandler handler);

  /// Returns log definitions.
  Iterable<PrismaLogDefinition> get definitions;

  /// Create a new log emitter
  factory PrismaLogEmitter(Iterable<PrismaLogDefinition> definitions) =
      _PrismaLogEmitterImpl;
}

/// Lof emitter implementation
class _PrismaLogEmitterImpl implements PrismaLogEmitter {
  /// Create a new log emitter
  _PrismaLogEmitterImpl(this.definitions) {
    final Iterable<PrismaLogLevel> stdoutLevels = definitions
        .where((definition) => definition.emit == PrismaLogEmit.stdout)
        .map((definition) => definition.level);

    // Register stdout log handler
    on(stdoutLevels, ((exception) => print(exception)));
  }

  @override
  final Iterable<PrismaLogDefinition> definitions;
  final Map<PrismaLogLevel, Set<PrismaLogHandler>> handlers = {};

  @override
  void emit(PrismaLogLevel level, Exception exception) {
    if (!definitions.any((element) => element.level == level)) return;

    for (final PrismaLogHandler handler in handlers[level] ?? []) {
      handler(exception);
    }
  }

  @override
  void on(Iterable<PrismaLogLevel> levels, PrismaLogHandler handler) {
    for (final PrismaLogLevel level in levels.toSet()) {
      final Set<PrismaLogHandler> subHandlers =
          handlers.putIfAbsent(level, () => <PrismaLogHandler>{});
      if (!subHandlers.contains(handler)) {
        subHandlers.add(handler);
      }
    }
  }
}
