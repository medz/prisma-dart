library prisma.engine.data_proxy;

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'logger.dart';
import 'engine_core.dart';
import 'src/exceptions.dart';
import 'universal_engine.dart';

/// Prisma Data Proxy api key name.
const String _tokenName = 'api_key';

/// Prisma Data Proxy Engine.
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
      throw PrismaInitializationException(
        message: 'The endpoint must be a prisma:// protocol.',
        engine: this,
      );
    } else if (!super.endpoint.queryParameters.containsKey(_tokenName)) {
      throw PrismaInitializationException(
        message: 'The endpoint must contain a "$_tokenName" query parameter.',
        engine: this,
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

    final response =
        await http.put(url, headers: headers, body: schema.codeUnits);
    if (response.statusCode != 201) {
      final message =
          'Error while updating schema: ${convert.utf8.decode(response.bodyBytes)}';
      logger.emit(Event.warn, Payload(message: message));

      throw PrismaRequestException(message: message, engine: this);
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

    final message = 'No Data Proxy endpoint found.';
    logger.emit(Event.error, Payload(message: 'No Data Proxy endpoint found.'));

    throw PrismaInitializationException(message: message, engine: this);
  }

  @override
  Future<GraphQLResult> request(
      {required String query,
      QueryEngineRequestHeaders? headers,
      TransactionInfo? transaction}) async {
    GraphQLResult result = await super.request(
      query: query,
      headers: headers,
      transaction: transaction,
    );

    if (result.orginal['EngineNotStarted'] is Map &&
        result.orginal['EngineNotStarted']['reason'] == 'SchemaMissing') {
      await updateSchema();
      result = await super.request(
        query: query,
        headers: headers,
        transaction: transaction,
      );
    }

    tryThrowDataProxyErrors(result.orginal);

    return result;
  }

  /// Try throw a [PrismaRequestException] from a [GraphQLResult].
  void tryThrowDataProxyErrors(Map<String, dynamic> json) {
    if (json.containsKey('InteractiveTransactionMisrouted')) {
      final Map<String, String> messages = {
        'IDParseError': 'Could not parse interactive transaction ID',
        'NoQueryEngineFoundError':
            'Could not find Query Engine for the specified host and transaction ID',
        'TransactionStartError': 'Could not start interactive transaction',
      };
      throw PrismaRequestException(
        message: messages[json['InteractiveTransactionMisrouted']['reason']]!,
        engine: this,
      );
    } else if (json.containsKey('InvalidRequestError')) {
      throw PrismaRequestException(
        message: json['InvalidRequestError']['reason']!,
        engine: this,
      );
    } else if (json.containsKey('EngineNotStarted')) {
      final engineNotStarted = json['EngineNotStarted'];
      if (engineNotStarted is! Map) {
        return;
      } else if (engineNotStarted['reason'] == 'SchemaMissing') {
        throw PrismaException(
          message: 'Data Proxy: ${engineNotStarted['reason']}',
          engine: this,
        );
      } else if (engineNotStarted['reason'] == 'EngineVersionNotSupported') {
        throw PrismaInitializationException(
          message: 'Data Proxy: ${engineNotStarted['reason']}',
          engine: this,
        );
      }

      final Map<String, dynamic> reason = engineNotStarted['reason'];
      if (reason.containsKey('EngineStartupError')) {
        throw PrismaInitializationException(
          message: 'Data Proxy: ${reason['EngineStartupError']['msg']}',
          engine: this,
        );
      } else if (reason.containsKey('KnownEngineStartupError')) {
        throw PrismaInitializationException(
          message: 'Data Proxy: ${reason['KnownEngineStartupError']['msg']}',
          engine: this,
        );
      } else if (reason.containsKey('HealthcheckTimeout')) {
        throw PrismaInitializationException(
          message: 'Data Proxy: Healthcheck timeout',
          engine: this,
        );
      }
    }
  }
}
