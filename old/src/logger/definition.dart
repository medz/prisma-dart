import 'emit.dart';
import 'event.dart';

/// Prisma event definition.
class Definition {
  /// Event type.
  final Event event;

  /// Emit type.
  final Emit emit;

  /// Create a new event definition.
  const Definition(this.event, this.emit);
}
