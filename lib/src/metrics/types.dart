import '../core/json_convertible.dart';

class Metric<T> implements JsonConvertible<Map<String, dynamic>> {
  const Metric({
    required this.key,
    required this.value,
    required this.labels,
    required this.description,
  });

  final String key;
  final T value;
  final Map<String, String> labels;
  final String description;

  @override
  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'labels': labels,
        'description': description,
      };

  /// Creates a new [Metric] instance from a json [Map].
  factory Metric.fromJson(Map<String, dynamic> json) {
    return Metric(
      key: json['key'] as String,
      value: json['value'] as T,
      labels: json['labels'] as Map<String, String>,
      description: json['description'] as String,
    );
  }
}

typedef MetricHistogramBucket = Iterable<num>;

class MetricHistogram implements JsonConvertible<Map<String, dynamic>> {
  final Iterable<MetricHistogramBucket> buckets;
  final num sum;
  final num count;

  const MetricHistogram({
    required this.buckets,
    required this.sum,
    required this.count,
  });

  @override
  Map<String, dynamic> toJson() => {
        'buckets': buckets,
        'sum': sum,
        'count': count,
      };

  /// Creates a new [MetricHistogram] instance from a json [Map].
  factory MetricHistogram.fromJson(Map<String, dynamic> json) {
    return MetricHistogram(
      buckets: json['buckets'] as Iterable<MetricHistogramBucket>,
      sum: json['sum'] as num,
      count: json['count'] as num,
    );
  }
}

class Metrics implements JsonConvertible<Map<String, dynamic>> {
  final Metric<num> counters;
  final Metric<num> gauges;
  final Metric<MetricHistogram> histograms;

  const Metrics({
    required this.counters,
    required this.gauges,
    required this.histograms,
  });

  @override
  Map<String, dynamic> toJson() => {
        'counters': counters.toJson(),
        'gauges': gauges.toJson(),
        'histograms': histograms.toJson(),
      };

  /// Creates a new [Metrics] instance from a json [Map].
  factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      counters: Metric.fromJson(json['counters'] as Map<String, dynamic>),
      gauges: Metric.fromJson(json['gauges'] as Map<String, dynamic>),
      histograms: Metric.fromJson(json['histograms'] as Map<String, dynamic>),
    );
  }
}
