import 'package:orm/engine_core.dart';

/// Model delegate
class ModelDelegate<T> {
  /// Prisma engine.
  final Engine engine;

  /// Query engine request headers.
  final QueryEngineRequestHeaders? headers;

  /// Creates a new model delegate.
  const ModelDelegate(this.engine, [this.headers]);
}
