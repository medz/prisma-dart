import 'logging.dart';
import 'prisma_client_options.dart';
import 'runtime/engine.dart';

/// Base prisma client
abstract class BasePrismaClient<E extends Engine> {
  BasePrismaClient({
    String? datasourceUrl,
    final Map<String, String>? datasources,
    ErrorFormat errorFormat = ErrorFormat.colorless,
    LogDefinition? log,
  }) : _options = PrismaClientOptions(
          datasources: datasources,
          datasourceUrl: datasourceUrl,
          errorFormat: errorFormat,
          logEmitter: LogEmitter(log ?? const {}),
        );

  final PrismaClientOptions _options;

  /// Prisma client options
  PrismaClientOptions get $options => _options;

  /// Returns the [Engine] instance typeof [E].
  E get $engine;

  Future<void> $connect() => $engine.start();
  Future<void> $disconnect() => $engine.stop();
}
