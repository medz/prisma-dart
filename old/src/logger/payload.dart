/// Prisma event payload.
class Payload {
  /// Event target.
  final String? target;

  /// Event timestamp.
  final DateTime? timestamp;

  /// Event message.
  final String message;

  /// Create a new event payload.
  const Payload({
    this.target,
    this.timestamp,
    required this.message,
  });

  /// Create a new event payload from a JSON [Map].
  factory Payload.fromJson(Map<String, dynamic> json) {
    if (json['fields']['query'] != null) return QueryPayload.fromJson(json);

    return Payload(
      target: json['target'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      message: json['fields']['message'].toString(),
    );
  }

  /// Serialize the event payload to a [String].
  @override
  String toString() {
    final buffer = StringBuffer(
        target?.isNotEmpty == true ? '$target: $message' : message);

    if (timestamp != null) {
      buffer.write(' - ${timestamp.toString()}');
    }

    return buffer.toString();
  }
}

/// Query payload.
class QueryPayload extends Payload {
  /// Query sent to the database
  final String query;

  /// Query parameters
  final String? params;

  /// Time elapsed (in milliseconds) between client issuing query and database responding
  final Duration? duration;

  const QueryPayload({
    super.target,
    super.timestamp,
    required this.query,
    this.params,
    this.duration,
  }) : super(message: 'Query: $query');

  /// Create a new query payload from a JSON [Map].
  factory QueryPayload.fromJson(Map<String, dynamic> json) {
    return QueryPayload(
      target: json['target'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      query: json['fields']['query'] as String,
      params: json['fields']['params'] as String?,
      duration: json['fields']['duration_ms'] == null
          ? null
          : Duration(milliseconds: json['fields']['duration_ms'] as int),
    );
  }

  /// Serialize the query payload to a [String].
  @override
  String toString() {
    final buffer = StringBuffer(target?.isNotEmpty == true ? '$target: ' : '');
    buffer.write(message);

    if (params != null) {
      buffer.write(' ($params)');
    }

    if (timestamp != null) {
      buffer.write(' - $timestamp');
    }

    if (duration != null) {
      String ms = ' - ${duration!.inMilliseconds}ms';
      if (timestamp != null) {
        ms = '(${duration!.inMilliseconds}ms)';
      }

      buffer.write(ms);
    }

    return buffer.toString();
  }
}
