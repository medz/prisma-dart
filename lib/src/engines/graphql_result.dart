import 'case_insensitive_map.dart';

/// GraphQL error.
class GraphQLError extends CaseInsensitiveMap<String, dynamic>
    implements Exception {
  GraphQLError.fromJson(super.store);
}

/// GraphQL result.
class GraphQLResult extends CaseInsensitiveMap<String, dynamic> {
  GraphQLResult.fromJson(super.store);

  /// Returns the result data.
  Map<String, dynamic>? get data => (this['data'] as Map?)?.cast();

  /// Returns the result errors.
  Iterable<GraphQLError>? get errors => (this['errors'] as Iterable?)
      ?.cast<Map>()
      .map((e) => GraphQLError.fromJson(e.cast()));
}
