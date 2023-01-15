import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:prisma_dmmf/prisma_dmmf.dart' show Document;
import 'package:retry/retry.dart';

import '../../../version.dart';
import '../../configure/environment.dart';
import '../../runtime/datasource.dart';
import '../../runtime/prisma_log.dart';
import '../common/errors/prisma_client_initialization_error.dart';
import '../common/errors/prisma_client_known_request_error.dart';
import '../common/errors/prisma_client_unknown_request_error.dart';
import '../common/get_config_result.dart';
import '../common/types/query_engine.dart';
import '../common/types/transaction.dart';
import '../intenal_utils/runtime_http_headers_builder.dart';
import '../intenal_utils/throw_graphql_error.dart';
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
    required super.logEmitter,
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
  Future<List<String>> get searchDirectories async {
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
    final String? superExecutable = await super.executable;
    if (superExecutable != null) {
      directories
          .addAll(_searchDirectoriesBuilder(path.dirname(superExecutable)));
    }

    return directories.toSet().toList();
  }

  @override
  Future<PrismaEnvironment> get environment async {
    final PrismaEnvironment environment = await super.environment;

    // Remove port from environment.
    environment.removeWhere((key, value) => key.toLowerCase().trim() == 'port');

    // Build schema DML to environment.
    environment['PRISMA_DML'] = base64.encode(utf8.encode(schema));

    // Add owerwrite datasources environment variables.
    environment['OVERWRITE_DATASOURCES'] =
        base64.encode(utf8.encode(overwriteDatasources));

    // Rust backtrace.
    environment['RUST_BACKTRACE'] ??= '1';

    // Rust log
    environment['RUST_LOG'] ??= rustLogLevel.name;

    if (environment['LOG_QUERIES'] == null && hasLogQueries) {
      environment['LOG_QUERIES'] = 'true';
    }

    return environment;
  }

  /// Return rust log level.
  PrismaLogLevel get rustLogLevel {
    final Iterable<PrismaLogLevel> levels =
        logEmitter.definitions.map((e) => e.level).toSet();
    if (levels.isEmpty) return PrismaLogLevel.info;

    return levels.reduce((value, element) {
      if (element == PrismaLogLevel.query) {
        return value;
      } else if (value == PrismaLogLevel.info ||
          element == PrismaLogLevel.info) {
        return PrismaLogLevel.info;
      }

      return element;
    });
  }

  /// Has log queries.
  bool get hasLogQueries => logEmitter.definitions
      .any((element) => element.level == PrismaLogLevel.query);

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
  Future<String> get executable async {
    final PrismaEnvironment environment = await this.environment;
    final String? superExecutable = await super.executable;

    // If set executable, return it.
    if (superExecutable != null) {
      final executable = File(superExecutable);
      if (executable.existsSync()) {
        return executable.path;
      }

      // Search executable in search directories.
      for (final String directory in await searchDirectories) {
        final executable =
            File(path.join(directory, path.basename(superExecutable)));
        if (executable.existsSync()) {
          return executable.path;
        }
      }
    }

    // Find query engine in enviroment.
    final String? forEnvirnoment = environment['PRISMA_QUERY_ENGINE_BINARY'];
    if (forEnvirnoment != null && forEnvirnoment.isNotEmpty) {
      if (File(forEnvirnoment).existsSync()) {
        return forEnvirnoment;
      }

      // Search executable in search directories.
      for (final String directory in await searchDirectories) {
        final executable =
            File(path.join(directory, path.basename(forEnvirnoment)));
        if (executable.existsSync()) {
          return executable.path;
        }
      }
    }

    // Find quert engine in search directories.
    for (final String directory in await searchDirectories) {
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
${(await searchDirectories).map((e) => '  - $e').join('\n')}

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
      try {
        final ProcessResult result = await Process.run(
          await executable,
          ['cli', 'get-config'],
          includeParentEnvironment: false,
          environment: await environment,
          workingDirectory: workingDirectory,
        );

        if (result.exitCode != 0) {
          throw Exception(result.stderr);
        }

        return GetConfigResult.fromJson(json.decode(result.stdout));
      } on Exception catch (e) {
        logEmitter.emit(PrismaLogLevel.error, e);
        rethrow;
      }
    });
  }

  @override
  Future<Document> getDmmf({bool forceRun = false}) async {
    if (!forceRun) return super.getDmmf(forceRun: forceRun);

    final ProcessResult result = await Process.run(
      await executable,
      ['--enable-raw-queries', 'cli', 'dmmf'],
      includeParentEnvironment: false,
      environment: await environment,
      workingDirectory: workingDirectory,
    );

    if (result.exitCode != 0) {
      final Exception e = Exception(result.stderr);
      logEmitter.emit(PrismaLogLevel.error, e);

      throw e;
    }

    return Document.fromJson(json.decode(result.stdout));
  }

  /// GraphQL request body builder.
  String gqlRequestBodyBuilder(String query) => json.encode({
        'query': query,
        'variables': {},
      });

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
    final PrismaEnvironment environment = await this.environment;
    final http.Request request = http.Request('POST', await endpoint)
      ..body = gqlRequestBodyBuilder(query)
      ..headers['Content-Type'] = 'application/json'
      ..headers.addAll(runtimeHttpHeadersBuilder(headers?.toJson()));

    return retry<QueryEngineResult>(
      () async {
        final http.StreamedResponse stream = await httpClient.send(request);
        final http.Response response = await http.Response.fromStream(stream);

        if (response.statusCode >= 400) {
          final e = PrismaClientUnknownRequestError('''
HTTP request failed with status code ${response.statusCode}.
${response.body}
''', clientVersion: packageVersion);
          logEmitter.emit(PrismaLogLevel.error, e);
          throw e;
        }

        final Map<String, dynamic> result =
            json.decode(utf8.decode(response.bodyBytes));
        throwGraphQLError(result['errors'] as List<dynamic>?);

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
  Future<void> start() async {
    process ??= await _createProcess();
  }

  /// Create engine process.
  Future<Process> _createProcess() async {
    final int port = await this.port;

    final List<String> arguments = <String>[
      '--enable-raw-queries',
      '--enable-metrics',
      '--enable-open-telemetry',
      '--port',
      port.toString(),
      '--host',
      _localhost,
    ];

    if (allowTriggerPanic == true) {
      arguments.add('--debug');
    }

    final Process process = await Process.start(
      await executable,
      arguments,
      includeParentEnvironment: false,
      environment: await environment,
      workingDirectory: workingDirectory,
    );

    process.stdout.listen(
      (List<int> data) {
        final Iterable<String> lines =
            utf8.decode(data).split(RegExp(r'\r?\n'));
        for (final String line in lines) {
          if (line.trim().isEmpty) {
            continue;
          }

          try {
            final Map<String, dynamic> json = jsonDecode(line);
            final PrismaLogLevel level = PrismaQueryEvent.isQueryEvent(json)
                ? PrismaLogLevel.query
                : PrismaLogLevel.info;
            logEmitter.emit(level, PrismaEvent.forJson(json));
          } catch (e) {
            logEmitter.emit(
                PrismaLogLevel.error, e is Exception ? e : Exception(e));
          }
        }
      },
      onDone: () => stop(),
    );

    process.stderr.listen(
      (List<int> data) {
        final Iterable<String> lines =
            utf8.decode(data).split(RegExp(r'\r?\n'));
        for (final String line in lines) {
          if (line.trim().isEmpty) {
            continue;
          }

          logEmitter.emit(PrismaLogLevel.error, Exception(line));
        }
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

      final err = PrismaClientInitializationError(
        'Failed to start the query engine: ${e.toString()}',
        clientVersion: packageVersion,
      );
      logEmitter.emit(PrismaLogLevel.error, err);
      throw err;
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
  provider = "prisma-client-dart"
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
      ..headers.addAll(runtimeHttpHeadersBuilder(headers.toJson()));

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
      await executable,
      ['--version'],
      includeParentEnvironment: false,
      environment: await environment,
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
