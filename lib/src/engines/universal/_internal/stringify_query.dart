import 'dart:convert' show json;

/// Stringify a GraphQL query JSON [Map].
String stringifyQuery(String query) =>
    json.encode({'query': query, 'variables': {}});
