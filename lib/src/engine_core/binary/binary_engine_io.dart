import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:retry/retry.dart';

import '../../../version.dart';
import '../../dmmf/dmmf.dart' as dmmf;
import '../../runtime/datasource.dart';
import '../common/errors/prisma_client_initialization_error.dart';
import '../common/errors/prisma_client_known_request_error.dart';
import '../common/errors/prisma_client_rust_panic_error.dart';
import '../common/errors/prisma_client_unknown_request_error.dart';
import '../common/get_config_result.dart';
import '../common/types/query_engine.dart';
import '../common/types/transaction.dart';
import 'binary_engine_unimplemented.dart' as unimplemented;
import 'status_retry_exception.dart';
import 'utils/get_free_port.dart';

/// localhost address.
const String _localhost = r'127.0.0.1';

class BinaryEngine extends unimplemented.BinaryEngine {
  BinaryEngine({
    required super.dmmf,
    required super.schema,
    required super.datasources,
    required super.environment,
    super.allowTriggerPanic,
    super.executable,
    super.workingDirectory,
  });

  /// Started engine process.
  Process? process;

  /// Cached port.
  int? _port;

  /// Get current running port.
  Future<int> get port async => _port ??= await getFreePort();

  /// Http client
  final http.Client httpClient = http.Client();

  /// Get server endpoint.
  Future<Uri> get endpoint async =>
      Uri.http(_localhost, '/').replace(port: await port);

  /// Get search path.
  List<String> get searchDirectories {
    final List<String> directories = [];
    // If cwd is not null, add it to search directories.
    if (workingDirectory != null) {
      directories.addAll(_searchDirectoriesBuilder(workingDirectory!));
    }

    // Add current directory to search directories.
    directories.addAll(_searchDirectoriesBuilder(Directory.current.path));

    // Add script directory to search directories.
    directories.addAll(
        _searchDirectoriesBuilder(path.dirname(Platform.script.toFilePath())));

    // Add executable directory to search directories.
    if (super.executable != null) {
      directories
          .addAll(_searchDirectoriesBuilder(path.dirname(super.executable!)));
    }

    return directories.toSet().toList();
  }

  @override
  Map<String, String> get environment {
    final Map<String, String> environment = Map.from(super.environment)
      ..removeWhere((key, value) => key.toLowerCase() == 'port');

    // Build schema DML to environment.
    environment['PRISMA_DML'] = base64.encode(utf8.encode(schema));

    // Add owerwrite datasources environment variables.
    environment['OVERWRITE_DATASOURCES'] =
        base64.encode(utf8.encode(overwriteDatasources));

    // Rust backtrace.
    if (!environment.containsKey('RUST_BACKTRACE')) {
      environment['RUST_BACKTRACE'] = '1';
    }

    // Rust log
    if (!environment.containsKey('RUST_LOG')) {
      environment['RUST_BACKTRACE'] = 'info';
    }

    return environment;
  }

  /// Get overwrite datasources.
  String get overwriteDatasources {
    final List<Map<String, dynamic>> overwriteDatasources = [];
    for (final MapEntry<String, Datasource> entry in datasources.entries) {
      // If entry value is not defined, skip it.
      if (entry.value.url == null) {
        continue;
      }

      // Add overwrite datasource.
      overwriteDatasources.add({
        'name': entry.key,
        'url': entry.value.url,
      });
    }

    return json.encode(overwriteDatasources);
  }

  @override
  String get executable {
    // If set executable, return it.
    if (super.executable != null && super.executable?.isNotEmpty == true) {
      final executable = File(super.executable!);
      if (executable.existsSync()) {
        return executable.path;
      }
    }

    // Find query engine in enviroment.
    final String? forEnvirnoment = environment['PRISMA_QUERY_ENGINE_BINARY'];
    if (forEnvirnoment != null && forEnvirnoment.isNotEmpty) {
      if (File(forEnvirnoment).existsSync()) {
        return forEnvirnoment;
      }
    }

    // Find quert engine in search directories.
    for (final String directory in searchDirectories) {
      final File executable = File(path.join(directory, 'query-engine'));
      if (executable.existsSync()) {
        return executable.path;
      }
    }

    // If not found, throw exception.
    throw PrismaClientInitializationError(
      '''
Could not find query engine binary for current platform "${Platform.operatingSystem}" in query-engine path.

This probably happens, because you built Prisma Client on a different platform.

Searched Locations:
${searchDirectories.map((e) => '  - $e').join('\n')}

You already added the platform "${Platform.operatingSystem}" to the "generator" block in the "schema.prisma" file as described in https://pris.ly/d/client-generator, but something went wrong. That's suboptimal.

Please create an issue at https://github.com/odroe/prisma-dart/issues/new
'''
          .trim(),
      clientVersion: packageVersion,
    );
  }

  /// Cached get config result.
  Future<GetConfigResult>? _getConfigResult;

  @override
  Future<GetConfigResult> getConfig({bool forceRun = false}) {
    if (!forceRun && _getConfigResult != null) return _getConfigResult!;

    return _getConfigResult = Future<GetConfigResult>.sync(() async {
      final ProcessResult result = await Process.run(
        executable,
        ['cli', 'get-config'],
        includeParentEnvironment: false,
        environment: environment,
        workingDirectory: workingDirectory,
      );

      if (result.exitCode != 0) {
        throw Exception(result.stderr);
      }

      return GetConfigResult.fromJson(json.decode(result.stdout));
    });
  }

  @override
  Future<dmmf.Document> getDmmf({bool forceRun = false}) async {
    if (!forceRun) return super.getDmmf(forceRun: forceRun);

    final ProcessResult result = await Process.run(
      executable,
      ['--enable-raw-queries', 'cli', 'dmmf'],
      includeParentEnvironment: false,
      environment: environment,
      workingDirectory: workingDirectory,
    );

    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }

    return dmmf.Document.fromJson(json.decode(result.stdout));
  }

  /// GraphQL request body builder.
  String gqlRequestBodyBuilder(String query) => json.encode({
        'query': query,
        'variables': {},
      });

  /// Runtime headers to http headers.
  Map<String, String> runtimeHeadersToHttpHeaders(
      [Map<String, dynamic>? headers]) {
    return headers?.map<String, String>((key, value) {
          if (key == 'transactionId') {
            return MapEntry(
                'X-transaction-id', value != null ? value.toString() : '');
          }

          return MapEntry(key, value != null ? value.toString() : '');
        }) ??
        {};
  }

  /// Request error handler.
  void requestErrorHandler(List<dynamic>? errors) {
    // If errors is null, return.
    if (errors == null || errors.isEmpty == true) return;

    // Throw errors.
    for (final dynamic error in errors) {
      // If error is user_facing_error.
      if (error is Map && error['user_facing_error'] is Map) {
        throw PrismaClientKnownRequestError.fromJson({
          ...error['user_facing_error'],
          'clientVersion': packageVersion,
        });
      }

      // Otherwise, throw unknown error.
      throw PrismaClientUnknownRequestError(
        json.encode(error),
        clientVersion: packageVersion,
      );
    }
  }

  /// Header getter.
  String? headerGetter(Map<String, String> headers, String key) {
    if (headers.keys.map((e) => e.toLowerCase()).contains(key.toLowerCase())) {
      return headers.entries
          .firstWhere(
              (element) => element.key.toLowerCase() == key.toLowerCase())
          .value;
    }

    return null;
  }

  @override
  Future<QueryEngineResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
  }) async {
    await start();

    final http.Request request = http.Request('POST', await endpoint)
      ..body = gqlRequestBodyBuilder(query)
      ..headers['Content-Type'] = 'application/json'
      ..headers.addAll(runtimeHeadersToHttpHeaders(headers?.toJson()));

    return retry<QueryEngineResult>(
      () async {
        final http.StreamedResponse stream = await httpClient.send(request);
        final http.Response response = await http.Response.fromStream(stream);

        if (response.statusCode >= 400) {
          throw PrismaClientUnknownRequestError('''
HTTP request failed with status code ${response.statusCode}.
${response.body}
''', clientVersion: packageVersion);
        }

        final Map<String, dynamic> result =
            json.decode(utf8.decode(response.bodyBytes));
        requestErrorHandler(result['errors'] as List<dynamic>?);

        // Rust engine returns time in microseconds and we want it in miliseconds
        final int elapsed =
            int.parse(headerGetter(response.headers, 'x-elapsed')!) ~/ 1000;

        return QueryEngineResult(result['data'], elapsed);
      },
      maxDelay: const Duration(milliseconds: 200),
      maxAttempts:
          environment.containsKey('PRISMA_CLIENT_NO_RETRY') == true ? 1 : 2,
      retryIf: (e) =>
          e is http.ClientException ||
          e is SocketException ||
          e is TimeoutException,
    );
  }

  @override
  Future<List<QueryEngineResult>> requestBatch({
    required List<String> queries,
    QueryEngineRequestHeaders? headers,
    bool? transaction,
  }) async {
    await start();

    final String body = json.encode({
      'transaction': transaction ?? false,
      'batch':
          queries.map((e) => json.decode(gqlRequestBodyBuilder(e))).toList(),
    });

    final http.Request request = http.Request('POST', await endpoint)
      ..body = body
      ..headers['Content-Type'] = 'application/json'
      ..headers.addAll(runtimeHeadersToHttpHeaders(headers?.toJson()));

    return retry<List<QueryEngineResult>>(
      () async {
        final http.StreamedResponse stream = await httpClient.send(request);
        final http.Response response = await http.Response.fromStream(stream);

        if (response.statusCode >= 400) {
          throw PrismaClientUnknownRequestError('''
HTTP request failed with status code ${response.statusCode}.
${response.body}
''', clientVersion: packageVersion);
        }

        final Map<String, dynamic> result = json.decode(response.body);

        // Rust engine returns time in microseconds and we want it in miliseconds
        final int elapsed =
            int.parse(headerGetter(response.headers, 'x-elapsed')!) ~/ 1000;

        final dynamic betch = result['batchResult'];
        if (betch is List) {
          return betch.map<QueryEngineResult>((element) {
            if (element['errors'] is List) {
              requestErrorHandler(element['errors']);
            }

            return QueryEngineResult(element['data'], elapsed);
          }).toList();
        }

        final List<dynamic>? errors = result['errors'] as List<dynamic>?;
        if (errors != null && errors.isNotEmpty) {
          requestErrorHandler(errors);
        }

        throw PrismaClientUnknownRequestError(
          'Unexpected response from the query engine: ${json.encode(result)}',
          clientVersion: packageVersion,
        );
      },
      maxDelay: const Duration(),
      maxAttempts:
          environment.containsKey('PRISMA_CLIENT_NO_RETRY') == true ? 1 : 2,
      retryIf: (e) =>
          e is http.ClientException ||
          e is SocketException ||
          e is TimeoutException,
    );
  }

  @override
  Future<void> start() async {
    process ??= await _createProcess();
  }

  /// Create engine process.
  Future<Process> _createProcess() async {
    final int port = await this.port;
    final List<String> additionalFlag = <String>[];

    if (allowTriggerPanic == true) {
      additionalFlag.add('--debug');
    }

    final Process process = await Process.start(
      executable,
      [
        '--enable-raw-queries',
        '--enable-open-telemetry',
        '--port',
        port.toString(),
        '--host',
        _localhost,
        ...additionalFlag,
      ],
      includeParentEnvironment: false,
      environment: environment,
      workingDirectory: workingDirectory,
    );

    // Listen for stderr.
    process.stderr.listen(
      (data) {
        throw PrismaClientInitializationError.fromJson({
          ...json.decode(utf8.decode(data)),
          'clientVersion': packageVersion,
        });
      },
      onDone: () => stop(),
    );

    // Build GraphQL server endpoint.
    final Uri url = (await endpoint).replace(path: '/status');

    // Wait for server to start.
    try {
      await retry<bool>(
        () async {
          // Send GET request to server.
          final http.Response response = await httpClient.get(url);

          // If request status code not 200, throw exception.
          if (response.statusCode >= 400) {
            throw StatusRetryException(false);
          }

          // If response body contains 'ok', return true.
          final dynamic result = json.decode(response.body);
          if (result is Map && result['status'] == 'ok') {
            return true;
          }

          // Otherwise, throw exception.
          throw StatusRetryException(false);
        },
        retryIf: (e) =>
            e is StatusRetryException ||
            e is http.ClientException ||
            e is SocketException ||
            e is TimeoutException,
        maxAttempts: 5,
      );
    } catch (e) {
      process.kill();
      await stop();

      throw PrismaClientInitializationError(
        'Failed to start the query engine: ${e.toString()}',
        clientVersion: packageVersion,
      );
    }

    // Return created process
    return process;
  }

  /// Transaction request.
  Future<Map<String, dynamic>> _transaction(http.Request request) async {
    await start();

    final http.StreamedResponse stream = await httpClient.send(request);
    final http.Response response = await http.Response.fromStream(stream);

    if (response.bodyBytes.isEmpty || response.statusCode == 404) {
      throw PrismaClientUnknownRequestError('''
Use the `prisma.\$transaction()` API to run queries in a transaction.

Add the following to your `schema.prisma` file:

generator client {
  provider        = "prisma-client-js"
  previewFeatures = ["interactiveTransactions"]
}

Read more about transactions in our documentation: 
 - https://github.com/odroe/prisma-dart#qa
 - https://www.prisma.io/docs/concepts/components/prisma-client/transactions#interactive-transactions-in-preview
''', clientVersion: packageVersion);
    }

    final Map<String, dynamic> result = json.decode(response.body);

    // If result is a known error, throw it.
    if (result['error_code'] != null) {
      throw PrismaClientKnownRequestError.fromJson({
        ...result,
        'clientVersion': packageVersion,
      });
    }

    if (response.statusCode >= 400) {
      throw PrismaClientUnknownRequestError('''
HTTP request failed with status code ${response.statusCode}.
${response.body}
''', clientVersion: packageVersion);
    }

    return result;
  }

  @override
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    TransactionOptions options = const TransactionOptions(),
  }) async {
    final String body = json.encode({
      'max_wait': options.maxWait,
      'timeout': options.timeout,
      'isolation_level': options.isolationLevel?.name,
    });
    final Uri url = (await endpoint).replace(path: '/transaction/start');
    final http.Request request = http.Request('POST', url)
      ..body = body
      ..headers['Content-Type'] = 'application/json'
      ..headers.addAll(runtimeHeadersToHttpHeaders(headers.toJson()));

    final Map<String, dynamic> result = await _transaction(request);

    return TransactionInfo.fromJson(result);
  }

  @override
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) async {
    final Uri url =
        (await endpoint).replace(path: '/transaction/${info.id}/commit');
    final http.Request request = http.Request('POST', url);

    await _transaction(request);
  }

  @override
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) async {
    await start();
    final Uri url =
        (await endpoint).replace(path: '/transaction/${info.id}/rollback');
    final http.Request request = http.Request('POST', url);

    await _transaction(request);
  }

  @override
  Future<void> stop() async {
    process?.kill();
    _port = null;
  }

  @override
  Future<String> version({bool forceRun = false}) async {
    if (!forceRun) return super.version(forceRun: forceRun);

    final ProcessResult result = await Process.run(
      executable,
      ['--version'],
      includeParentEnvironment: false,
      environment: environment,
      workingDirectory: workingDirectory,
    );

    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }

    return result.stdout
        .toString()
        .trim()
        .replaceAll(' ', '')
        .replaceAll('query-engine', '')
        .trim();
  }

  /// Search directories builder.
  List<String> _searchDirectoriesBuilder(String parent) {
    final List<String> directories = <String>[parent];
    final List<String> parts = [
      path.joinAll(['.dart_tool', 'prisma']),
      'prisma',
    ];

    for (final String part in parts) {
      final String directory = path.join(parent, part);
      if (Directory(directory).existsSync()) {
        directories.add(directory);
      }
    }

    return directories;
  }
}
