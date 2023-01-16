import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'query_engine_request_headers.dart';
import 'transaction.dart';

/// Default query request headers.
const Map<String, String> _defaultRequestHeaders = {
  'user-agent': 'Prisma ORM (https://prisma.pub)',
  'content-type': 'application/json; charset=utf-8',
  'accept': 'application/json; charset=utf-8',
};

/// Max retry attempts.
const int _maxRetryAttempts = 10;

/// Prisma query engine interface.
class Engine {
  /// The GraphQL endpoint.
  final Uri endpoint;

  /// HTTP headers.
  final Map<String, String>? headers;

  /// Create a new instance of [Engine].
  const Engine({required this.endpoint, this.headers});

  /// Starts the engine.
  Future<void> start() async {}

  /// Stops the engine.
  Future<void> stop() async {}

  /// Requests a query execution.
  Future<dynamic> request({
    required String query,
    int attempt = 0,
    QueryEngineRequestHeaders? headers,
    TransactionInfo? transaction,
  }) async {
    final url = endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'graphql'],
    );

    try {
      final response = await http.post(
        url,
        headers: _resolveHeaders(headers: headers, transaction: transaction),
        body: _stringifyQuery(query),
      );

      if (response.statusCode != 200) {
        throw Exception('GraphQL request failed with status code: '
            '${response.statusCode}');
      }

      return convert.json.decode(response.body);
    } catch (e) {
      if (attempt >= _maxRetryAttempts) {
        rethrow;
      }

      return request(
        query: query,
        attempt: attempt + 1,
        headers: headers,
        transaction: transaction,
      );
    }
  }

  /// Starts a transaction.
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    Duration timeout = const Duration(seconds: 5),
    Duration maxWait = const Duration(seconds: 2),
    IsolationLevel? isolationLevel,
  }) async {
    throw UnimplementedError();
  }

  /// Commits a transaction.
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) async {}

  /// Rolls back a transaction.
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) async {}

  /// Resolve the HTTP headers.
  Map<String, String> _resolveHeaders({
    Map<String, String>? headers,
    TransactionInfo? transaction,
  }) {
    final resolvedHeaders = <String, String>{
      ..._defaultRequestHeaders,
      ...?this.headers,
      ...?headers,
    };

    if (transaction != null) {
      resolvedHeaders['x-transaction-id'] = transaction.id;
    }

    return resolvedHeaders;
  }

  /// Generate a GraphQL body.
  static String _stringifyQuery(String query) => convert.json.encode({
        'query': query,
        'variables': {},
      });
}
