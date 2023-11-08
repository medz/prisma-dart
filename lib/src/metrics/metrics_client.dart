import '../engine.dart';
import 'metrics_format.dart';
import 'types.dart';

/// Prisma metrics client.
class MetricsClient {
  const MetricsClient(Engine engine) : _engine = engine;

  /// The prisma engine.
  final Engine _engine;

  /// Returns all metrics gathered up to this point in prometheus format.
  ///
  /// Result of this call can be exposed directly to prometheus scraping endpoint.
  ///
  /// - [globalLabels] - Global labels to be added to the metrics.
  Future<String> prometheus({Map<String, String>? globalLabels}) async {
    final metrics = await _engine.metrics(
      globalLabels: globalLabels,
      format: MetricsFormat.prometheus,
    );

    return metrics.toString();
  }

  /// Returns all metrics gathered up to this point in json format.
  ///
  /// - [globalLabels] - Global labels to be added to the metrics.
  Future<Metrics> json({Map<String, String>? globalLabels}) async {
    final metrics = await _engine.metrics(
      globalLabels: globalLabels,
      format: MetricsFormat.json,
    );

    return Metrics.fromJson(metrics as Map<String, dynamic>);
  }
}
