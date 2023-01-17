import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:orm/logger.dart' as logger_package;

import '../engine.dart';
import '../universal/universal_engine.dart';

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
    } else if (super.endpoint.queryParameters.containsKey(_tokenName)) {
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
    logger.emit(logger_package.Event.info,
        logger_package.Payload(message: 'Calling $url for schema update...'));

    final response = await http.put(url, headers: headers, body: schema);

    if (response.statusCode != 200) {
      final message = 'Error while updating schema: ${response.body}';
      logger.emit(
          logger_package.Event.warn, logger_package.Payload(message: message));
      throw Exception(message);
    }

    logger.emit(logger_package.Event.info,
        logger_package.Payload(message: 'Schema (re)uploaded (hash: $hash)'));
  }
}
