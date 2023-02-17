library prisma.engine.data_proxy;

import 'package:http/http.dart' as http;

import 'logger.dart';
import 'engine_core.dart';
import 'universal_engine.dart';

/// Prisma Data Proxy api key name.
const String _tokenName = 'api_key';

/// Priama Data Proxy Engine.
///
/// The Data Proxy Engine is a wrapper around the Prisma Data Proxy.
class DataProxyEngine extends UniversalEngine implements Engine {
  /// Base64 encoded schema.
  final String schema;

  /// Prisma schema origin bytes hash (SHA-256).
  final String hash;

  /// Remote prisma client version.
  final String version;

  /// Create a new instance of [DataProxyEngine].
  const DataProxyEngine({
    required super.endpoint,
    required super.logger,
    super.headers,
    required this.schema,
    required this.hash,
    required this.version,
  });

  /// Resolve the Data Proxy endpoint.
  @override
  Uri get endpoint {
    if (!super.endpoint.isScheme('prisma')) {
      throw ArgumentError.value(
        super.endpoint,
        'endpoint',
        'The endpoint must be a prisma:// protocol.',
      );
    } else if (!super.endpoint.queryParameters.containsKey(_tokenName)) {
      throw ArgumentError.value(
        super.endpoint,
        'endpoint',
        'The endpoint must not contain an "$_tokenName" query parameter.',
      );
    }

    return Uri.https(
      super.endpoint.authority,
      '/$version/$hash',
    );
  }

  /// Resolve the Data Proxy headers.
  @override
  Map<String, String> get headers {
    final token = super.endpoint.queryParameters[_tokenName];

    return {
      ...?super.headers,
      'Authorization': 'Bearer $token',
    };
  }

  /// Update schema.
  Future<void> updateSchema() async {
    final url = endpoint.replace(
      pathSegments: [...endpoint.pathSegments, 'schema'],
    );
    final headers = {
      ...this.headers,
      'Content-Type': 'plain/text; charset=utf-8',
    };
    logger.emit(
        Event.info, Payload(message: 'Calling $url for schema update...'));

    final response = await http.put(url, headers: headers, body: schema);

    if (response.statusCode != 201) {
      final message = 'Error while updating schema: ${response.body}';
      logger.emit(Event.warn, Payload(message: message));
      throw Exception(message);
    }

    logger.emit(
        Event.info, Payload(message: 'Schema (re)uploaded (hash: $hash)'));
  }

  @override
  Uri resolveCommitTransactionEndpoint(info) =>
      _resolveTransactionEndpoint(info, 'commit');

  @override
  Uri resolveRollbackTransactionEndpoint(info) =>
      _resolveTransactionEndpoint(info, 'rollback');

  /// Resolve the Data Proxy endpoint for a transaction(commit or rollback).
  Uri _resolveTransactionEndpoint(TransactionInfo info, String action) {
    if (info['data-proxy'] is Map) {
      final dataProxy = (info['data-proxy'] as Map).cast<String, dynamic>();
      if (dataProxy['endpoint'] is String) {
        final enpoint = dataProxy['endpoint'] as String;
        if (enpoint.isNotEmpty) {
          final url = Uri.parse(enpoint);

          return url.replace(pathSegments: [...url.pathSegments, action]);
        }
      }
    }

    logger.emit(Event.error, Payload(message: 'No Data Proxy endpoint found.'));
    throw Exception('No Data Proxy endpoint found.');
  }

  @override
  Future<GraphQLResult> request(
      {required String query,
      QueryEngineRequestHeaders? headers,
      TransactionInfo? transaction}) async {
    final result = await super.request(
      query: query,
      headers: headers,
      transaction: transaction,
    );

    if (result['enginenotstarted'] is Map &&
        result['enginenotstarted']['reason'] == 'SchemaMissing') {
      await updateSchema();
      final result = super.request(
        query: query,
        headers: headers,
        transaction: transaction,
      );

      return result;
    }

    return result;
  }
}
