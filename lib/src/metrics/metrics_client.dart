import '../engine.dart';
import 'metrics_format.dart';

class MetricsClient {
  const MetricsClient(Engine engine) : _engine = engine;

  final Engine _engine;

  /// Returns all metrics gathered up to this point in prometheus format.
  ///
  /// Result of this call can be exposed directly to prometheus scraping
  /// endpoint
  ///
  /// - [globalLabels] are the labels to be added to all metrics.
  Future<String> prometheus({Map<String, String>? globalLabels}) async {
    final result = await _engine.metrics(
        globalLabels: globalLabels, format: MetricsFormat.prometheus);

    return result.toString();
  }

  /// Returns all metrics gathered up to this point in json format.
  Future<Map<String, dynamic>> json({Map<String, String>? globalLabels}) async {
    final result = await _engine.metrics(
        globalLabels: globalLabels, format: MetricsFormat.json);

    return result as Map<String, dynamic>;
  }
}
