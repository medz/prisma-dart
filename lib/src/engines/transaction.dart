import 'case_insensitive_map.dart';

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
class TransactionInfo extends CaseInsensitiveMap<String, dynamic> {
  TransactionInfo.fromJson(super.store);

  /// Transaction info ready.
  bool get ready => _id is String && _endpoint is Uri;

  String? get _id {
    final id = this['id'];

    return id is String ? id : null;
  }

  Uri? get _endpoint {
    final endpoint = _resolveEndpoint(this);
    if (endpoint != null) return endpoint;

    // Data proxy.
    final dataProxy = this['data-proxy'];
    if (dataProxy is Map) {
      final endpoint = _resolveEndpoint(dataProxy.cast());
      if (endpoint != null) return endpoint;
    }

    return null;
  }

  /// Returns the transaction id.
  String get id {
    if (_id is String) return _id!;

    throw ArgumentError.value(this, 'id', 'Transaction id not found.');
  }

  /// Returns the transaction endpoint.
  Uri get endpoint {
    if (_endpoint is Uri) return _endpoint!;

    throw ArgumentError.value(
        this, 'endpoint', 'Transaction endpoint not found.');
  }

  /// Resolve the transaction endpoint.
  Uri? _resolveEndpoint(Map<String, dynamic> json) {
    if (json.containsKey('endpoint')) {
      final endpoint = json['endpoint'];
      if (endpoint is String) return Uri.parse(endpoint);
      if (endpoint is Uri) return endpoint;
    }

    return null;
  }
}

/// Transaction Headers.
class TransactionHeaders extends CaseInsensitiveMap<String, String> {
  TransactionHeaders.fromJson(super.store);

  /// Create a new instance of [TransactionHeaders].
  TransactionHeaders({String? traceparent}) : super({}) {
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
}
