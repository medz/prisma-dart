import 'dart:collection';

/// GraphQL error.
class GraphQLError extends UnmodifiableMapBase<String, dynamic>
    implements Exception, Map<String, dynamic> {
  /// The error map store
  final Map<String, dynamic> _store;

  /// Internal constructor.
  GraphQLError._internal(this._store);

  /// Create a new GraphQL error from a JSON [Map].
  factory GraphQLError.fromJson(Map<String, dynamic> json) {
    final map = json.map((key, value) => MapEntry(_serializeKey(key), value));
    if (!map.containsKey('message')) {
      throw ArgumentError.value(
        json,
        'json',
        'The JSON map must contain a "message" key.',
      );
    }
    if (map['message'] is! String) {
      throw ArgumentError.value(
        json,
        'json',
        'The "message" key must be a String.',
      );
    }

    return GraphQLError._internal(map);
  }

  /// Create a new GraphQL error with message.
  factory GraphQLError(
    String message, {
    Map<String, dynamic>? json,
  }) =>
      GraphQLError.fromJson({
        ...?json?.map((key, value) => MapEntry(_serializeKey(key), value)),
        'message': message,
      });

  /// Read the error message.
  String get message => _store['message'] as String;

  @override
  operator [](Object? key) => _store[_serializeKey<Object?>(key)];

  @override
  bool containsKey(Object? key) => super.containsKey(key);

  @override
  Iterable<String> get keys => _store.keys;

  /// Serializes the header key
  static T _serializeKey<T>(T key) {
    return (key is String ? key.toLowerCase() : key) as T;
  }
}

/// GraphQL result.
class GraphQLResult {
  /// Requested data.
  final Map<String, dynamic>? data;

  /// Errors.
  final Iterable<GraphQLError>? errors;

  /// Original JSON.
  final Map<String, dynamic> json;

  /// Creates a new instance of [GraphQLResult].
  const GraphQLResult({
    this.data,
    this.errors,
    required this.json,
  }) : assert(data != null || errors != null);

  /// Creates a new instance of [GraphQLResult] from a JSON [Map].
  factory GraphQLResult.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as Map?)?.cast<String, dynamic>();
    final errors = ((json['errors'] as Iterable?)?.cast<Map>())
        ?.map((element) => element.cast<String, dynamic>())
        .map((element) => GraphQLError.fromJson(element));

    return GraphQLResult(
      data: data,
      errors: errors,
      json: json,
    );
  }
}
