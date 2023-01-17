import 'dart:collection';

/// Isolation level.
enum IsolationLevel {
  /// Read uncommitted.
  readUncommitted('ReadUncommitted'),

  /// Read committed.
  readCommitted('ReadCommitted'),

  /// Repeatable read.
  repeatableRead('RepeatableRead'),

  /// Serializable.
  serializable('Serializable'),

  /// Snapshot.
  snapshot('Snapshot');

  /// String representation.
  final String value;

  /// Creates a new instance of [IsolationLevel].
  const IsolationLevel(this.value);
}

/// Transaction Info.
class TransactionInfo {
  /// Transaction id.
  final String id;

  /// Original JSON.
  final Map<String, dynamic> json;

  /// Transaction commit and rollback url.
  final Uri endpoint;

  /// Creates a new instance of [TransactionInfo].
  const TransactionInfo(
      {required this.id, required this.json, required this.endpoint});

  /// Create a new instance of [TransactionInfo] from a JSON.
  factory TransactionInfo.fromJson(Map<String, dynamic> json) {
    return TransactionInfo(
      id: json['id'] as String,
      json: json,
      endpoint: _resolveEndpoint(json),
    );
  }

  /// Resolves the transaction endpoint.
  static Uri _resolveEndpoint(Map<String, dynamic> json) {
    if (json.containsKey('endpoint')) {
      final endpoint = json['endpoint'];
      if (endpoint is Uri) return endpoint;

      return Uri.parse(endpoint.toString());
    } else if (json.containsKey('data-proxy') && json['data-proxy'] is Map) {
      return Uri.parse(json['data-proxy']['endpoint'] as String);
    }

    throw ArgumentError.value(json, 'json', 'Invalid transaction info');
  }
}

/// Transaction Headers.
class TransactionHeaders
    with MapMixin<String, String>
    implements Map<String, String> {
  /// Headers store.
  final Map<String, String> _headers = <String, String>{};

  /// Creates a new instance of [TransactionHeaders].
  TransactionHeaders({String? traceparent}) {
    this.traceparent = traceparent;
  }

  /// Returns the traceparent.
  String? get traceparent => this['traceparent'];

  /// Sets the traceparent.
  set traceparent(String? value) {
    if (value != null && value.isNotEmpty) {
      this['traceparent'] = value;
    }
  }

  @override
  String? operator [](Object? key) => _headers[_serializeKey<Object?>(key)];

  @override
  void operator []=(String key, String value) =>
      _headers[_serializeKey(key)] = value;

  @override
  void clear() => _headers.clear();

  @override
  Iterable<String> get keys => _headers.keys;

  @override
  String? remove(Object? key) => _headers.remove(_serializeKey(key));

  /// Serializes the header key
  T _serializeKey<T>(T key) {
    return (key is String ? key.toLowerCase() : key) as T;
  }
}
