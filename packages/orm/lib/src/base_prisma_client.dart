import 'dmmf/datamodel.dart' show DataModel;
import 'logging.dart';
import 'prisma_client_options.dart';
import 'runtime/engine.dart';
import 'runtime/metrics/metrics_client.dart';
import 'runtime/raw/raw_client.dart';
import 'runtime/transaction/transaction_client.dart';

/// Base prisma client
abstract class BasePrismaClient<Client extends BasePrismaClient<Client>> {
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
  Engine get $engine;
  RawClient<Client> get $raw => RawClient(this as Client);
  MetricsClient get $metrics => MetricsClient($engine);
  TransactionClient<Client> get $transaction;
  DataModel get $datamodel;

  Future<void> $connect() => $engine.start();
  Future<void> $disconnect() => $engine.stop();
}
