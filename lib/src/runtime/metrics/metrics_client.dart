import '../engine/engine.dart';

class MetriceClient<T> {
  const MetriceClient(Engine<T> engine) : _engine = engine;

  final Engine<T> _engine;

  /// Returns all metrics gathered up to this point in prometheus format.
  ///
  /// Result of this call can be exposed directly to prometheus scraping
  /// endpoint
  ///
  /// - [globalLabels] are the labels to be added to all metrics.
  Future<String> prometheus({Map<String, String>? globalLabels}) {
    return _engine.prometheusMetrics(globalLabels: globalLabels);
  }
}
