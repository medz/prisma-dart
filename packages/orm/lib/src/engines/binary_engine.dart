import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:retry/retry.dart';
import 'package:webfetch/webfetch.dart' show fetch;

import '../_internal/project_directory.dart';
import '../datasources/datasources.dart';
import '../datasources/prisma+datasource_utils.dart';
import '../errors.dart';
import '../logging.dart';
import '../prisma_client_options.dart';
import '../prisma_namespace.dart';
import '../config/prisma+env.dart';
import '../runtime/engine.dart';
import '../runtime/json_protocol/deserialize.dart';
import '../runtime/json_protocol/protocol.dart';
import '../runtime/metrics/metrics_format.dart';
import '../runtime/transaction/isolation_level.dart';
import '../runtime/transaction/transaction.dart';
import '../runtime/transaction/transaction_headers.dart';

/// Prisma branary engine.
class BinaryEngine extends Engine {
  late Uri _endpoint;
  Future<void> Function()? _stopCallback;

  /// Creates a new [BinaryEngine].
  BinaryEngine({
    required super.schema,
    required super.datasources,
    required super.options,
  });

  @override
  Future<void> start() async {
    if (_stopCallback != null) return;

    final (endpoint, stop) = await createServer();

    _endpoint = endpoint;
    _stopCallback = stop;
  }

  @override
  Future<void> stop() async => _stopCallback?.call();

  @override
  Future<Map> request(
    JsonQuery query, {
    TransactionHeaders? headers,
    Transaction? transaction,
  }) async {
    headers ??= TransactionHeaders();
    await start();

    if (transaction != null) {
      headers.set('x-transaction-id', transaction.id);
    }

    final response = await fetch(
      _endpoint,
      headers: headers,
      body: query.toJson(),
      method: 'POST',
    );

    final result = await response.json();

    return switch (result) {
      {'data': final Map data} => deserializeJsonResponse(data),
      {'errors': final Iterable errors} => throw Exception(errors),
      _ => throw Exception(result),
    };
  }

  @override
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required Transaction transaction,
  }) async {
    await start();

    final response = await fetch(
      _endpoint.resolve('/transaction/${transaction.id}/commit'),
      method: 'POST',
      headers: headers,
    );
    final result = await response.json();

    return switch (result) {
      {'errors': final Iterable errors} => throw Exception(errors),
      _ => null,
    };
  }

  @override
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required Transaction transaction,
  }) async {
    await start();

    final response = await fetch(
      _endpoint.resolve('/transaction/${transaction.id}/rollback'),
      method: 'POST',
      headers: headers,
    );
    final result = await response.json();

    return switch (result) {
      {'errors': final Iterable errors} => throw Exception(errors),
      _ => null,
    };
  }

  @override
  Future<Transaction> startTransaction({
    required TransactionHeaders headers,
    int maxWait = 2000,
    int timeout = 5000,
    TransactionIsolationLevel? isolationLevel,
  }) async {
    await start();

    final response = await fetch(
      _endpoint.resolve('/transaction/start'),
      method: 'POST',
      headers: headers,
      body: {
        'max_wait': maxWait,
        'timeout': timeout,
        if (isolationLevel != null) 'isolation_level': isolationLevel.name,
      },
    );
    final result = await response.json();

    return switch (result) {
      {'id': final String id} => Transaction(id),
      {'errors': final Iterable errors} => throw Exception(errors),
      _ => throw Exception(result),
    };
  }

  @override
  Future metrics({
    Map<String, String>? globalLabels,
    required MetricsFormat format,
  }) async {
    await start();

    final response = await fetch(
      _endpoint.replace(
        path: '/metrics',
        queryParameters: {'format': format.name},
      ),
      method: 'POST',
      body: globalLabels,
    );

    return switch (format) {
      MetricsFormat.json => response.json(),
      MetricsFormat.prometheus => response.text(),
    };
  }
}

extension on BinaryEngine {
  /// Find query engine.
  File findQueryEngine() {
    const executable = 'prisma-query-engine';
    final projectDirectory = findProjectDirectory();

    Iterable<String> generateEnginePaths(
        Iterable<Directory> searchDirectories) sync* {
      for (final dir in searchDirectories) {
        yield path.join(dir.path, executable);
        yield path.join(dir.path, 'prisma', executable);
        yield path.join(dir.path, '.dart_tool', executable);
      }
    }

    final enginePaths = generateEnginePaths([
      Directory.current,
      if (projectDirectory != null) projectDirectory,
    ]);

    for (final enginePath in enginePaths) {
      final file = File(enginePath);
      if (file.existsSync()) return file;
    }

    throw PrismaClientInitializationError(
        errorCode: "QE404",
        message:
            'No binary engine found, please make sure any of the following locations contain the executable file: $enginePaths');
  }

  /// Creates overwrite datasources string.
  String createOverwriteDatasourcesString() {
    Map<String, String> overwriteDatasources =
        this.datasources.map((name, datasource) {
      final url = switch (datasource) {
        Datasource(type: DatasourceType.url, value: final url) => url,
        Datasource(type: DatasourceType.enviroment, value: final name) =>
          Prisma.env(name).or(
            () => throw PrismaClientInitializationError(
              errorCode: "P1013",
              message: 'The environment variable "$name" does not exist',
            ),
          ),
      };

      return MapEntry(name, Prisma.validateDatasourceURL(url, isPorxy: false));
    });

    if (options.datasources?.isNotEmpty == true) {
      overwriteDatasources.addAll(options.datasources!);
    }

    if (options.datasourceUrl != null) {
      final url =
          Prisma.validateDatasourceURL(options.datasourceUrl!, isPorxy: false);
      overwriteDatasources =
          overwriteDatasources.map((name, _) => MapEntry(name, url));
    }

    final datasources = overwriteDatasources.entries
        .map((e) => {'name': e.key, 'url': e.value})
        .toList();

    return base64.encode(utf8.encode(json.encode(datasources)));
  }

  /// Create engine args
  Iterable<String> createQueryEngineArgs() sync* {
    yield '--enable-metrics';
    yield '--enable-raw-queries';
    yield* ['--engine-protocol', 'json'];

    // Set port is dynamic free port
    yield* ['--port', '0'];

    // Sets datamodel
    yield '--datamodel';
    yield base64.encode(utf8.encode(schema));

    // Set overwrite datasources
    yield '--overwrite-datasources';
    yield createOverwriteDatasourcesString();
  }

  Map<String, String> createQueryEngineEnvironment() {
    final environment = Map<String, String>.from(Prisma.environment);

    // log queries
    if (options.logEmitter.definition.any((e) => e.$1 == LogLevel.query)) {
      environment['LOG_QUERIES'] = 'true';
    }

    // no color
    if (!Prisma.envAsBoolean('NO_COLOR') &&
        options.errorFormat == ErrorFormat.pretty) {
      environment['CLICOLOR_FORCE'] = "1";
    }

    environment['RUST_BACKTRACE'] = Prisma.env('RUST_BACKTRACE').or(() => '1');
    environment['RUST_LOG'] =
        Prisma.env('RUST_LOG').or(() => LogLevel.info.name);

    return environment;
  }

  Future<(Uri, Future<void> Function())> createServer() async {
    String executable = path.join(
      '.',
      path.relative(findQueryEngine().path, from: Directory.current.path),
    );
    final arguments = createQueryEngineArgs().toList();
    final environment = createQueryEngineEnvironment();
    final process = await Process.start(
      executable,
      arguments,
      workingDirectory: Directory.current.path,
      includeParentEnvironment: false,
      environment: environment,
    );

    final stderrSubscription = process.stderr.byline().listen((event) {
      final payload = tryParseJSON(event);
      if (payload
          case {
            'error_code': final String errorCode,
            'message': final String message
          }) {
        process.kill();

        throw PrismaClientInitializationError(
            message: message, errorCode: errorCode);
      }
    });

    final endpointCompleter = Completer<Uri>.sync();
    final stdoutSubscription = process.stdout.byline().listen((event) {
      final payload = tryParseJSON(event);
      tryCompleteEndpoint(endpointCompleter, payload);

      if (payload case {'span': true, 'spans': final List _}) {
        // TODO: Tracing engine span. current print payload to console.
        print('EngineSpan:payload $payload');

        return;
      }

      final (level, engineEvent) = createEngineEvent(payload);
      if (level == LogLevel.error &&
          engineEvent is LogEvent &&
          engineEvent.message.contains('fatal error')) {
        process.kill();

        throw PrismaClientRustPanicError(message: engineEvent.message);
      }

      options.logEmitter.emit(level, engineEvent);
    });

    Future<void> stop() async {
      process.kill();
      await stderrSubscription.cancel();
      await stdoutSubscription.cancel();
    }

    final endpoint = await retry<Uri>(() async {
      return endpointCompleter.future.timeout(Duration(seconds: 1),
          onTimeout: () {
        throw PrismaClientInitializationError(
            message: 'Prisma binary query engine not ready');
      });
    }).catchError((e) {
      stop();
      throw e;
    });

    return (endpoint, stop);
  }

  (LogLevel, EngineEvent) createEngineEvent(payload) {
    if (payload
        case {
          'timestamp': final String timestamp,
          'target': final String target,
          'fields': {
            'query': final String query,
            'params': final String params,
            'duration': final num duration,
          },
        }) {
      final event = QueryEvent(
        timestamp: DateTime.parse(timestamp),
        target: target,
        query: query,
        params: params,
        duration: Duration(milliseconds: duration.toInt()),
      );

      return (LogLevel.query, event);
    } else if (payload
        case {
          'timestamp': final String timestamp,
          'target': final String target,
          'level': final String rawLogLevel,
          'fields': {'message': final String message}
        }) {
      final level = LogLevel.values.firstWhere(
          (e) => e.name.toLowerCase() == rawLogLevel.toLowerCase(),
          orElse: () => LogLevel.warn);
      final event = LogEvent(
        timestamp: DateTime.parse(timestamp),
        target: target,
        message: message,
      );

      return (level, event);
    }

    return (
      LogLevel.warn,
      LogEvent(
        target: 'prisma:client:engines:binary',
        timestamp: DateTime.now(),
        message: 'Parse event fail, raw event: ${json.encode(payload)}',
      )
    );
  }

  void tryCompleteEndpoint(Completer<Uri> completer, payload) {
    if (payload
        case {
          'level': 'INFO',
          'target': 'query_engine::server',
          'fields': {
            'message': final String message,
            'ip': final String ip,
            'port': final String port,
          }
        }
        when message.startsWith('Started query engine http server') &&
            ip.isNotEmpty &&
            port.isNotEmpty &&
            !completer.isCompleted) {
      final endpoint = Uri.http('$ip:$port');
      completer.complete(endpoint);
    }
  }

  Object? tryParseJSON(String encoded) {
    try {
      return json.decode(encoded);
    } catch (e) {
      // TODO, debug
      return null;
    }
  }
}

extension<T> on T? {
  T or(T Function() fn) {
    if (this != null) return this as T;

    return fn();
  }
}

extension on Stream<List<int>> {
  Stream<String> byline() =>
      transform(utf8.decoder).transform(const LineSplitter());
}
