library prisma.engines;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:orm/orm.dart';
import 'package:path/path.dart';
import 'package:retry/retry.dart';
import 'package:stdweb/stdweb.dart' show fetch;

class BinaryEngine implements Engine<Null> {
  /// Prisma schema string.
  ///
  /// Exported from `client.dart` file.
  final String schema;

  /// Your datasource defined in `schema.prisma` file.
  ///
  /// Example:
  ///
  /// ```prisma
  /// datasource db {
  ///  provider = "postgresql"
  ///  url      = env("DATABASE_URL")
  /// }
  /// ```
  ///
  /// You **datasource** name is `db`.
  final String datasource;

  /// Path to prisma binary query engine.
  ///
  /// If not provided, it will search for `prisma-query-engine` binary in
  /// current directory.
  ///
  /// If you provide a path, but the file does not exist, it will search for
  /// base name of the path in current directory.
  final String? binary;

  /// Your database url.
  ///
  /// If you not provide [url], it will search for [envVariable] environment:
  ///
  /// Priority:
  ///
  /// 1. [url]
  /// 2. `String.fromEnvironment(envVariable)`
  /// 3. `Platform.environment[envVariable]`
  final Uri? url;

  /// Database url environment variable name.
  ///
  /// If you provide [url], this will be ignored.
  final String envVariable;

  Process? _process;
  Uri? _endpoint;

  BinaryEngine({
    required this.schema,
    required this.datasource,
    this.binary,
    this.url,
    this.envVariable = 'DATABASE_URL',
  });

  /// Resolve prisma binary query engine path.
  File get _executable {
    if (this.binary == null) {
      return _searchExecutable();
    }

    final binary = File(this.binary!);
    if (!binary.existsSync()) return _searchExecutable();

    return binary;
  }

  /// Search for prisma binary query engine path.
  File _searchExecutable() {
    const defaultExecutableName = 'prisma-query-engine';
    final executableName = switch (binary) {
      String binary => basename(binary),
      _ => defaultExecutableName,
    };

    final executable = File(executableName);
    if (executable.existsSync()) return executable;

    final defaultExecutable = File(defaultExecutableName);
    if (defaultExecutable.existsSync()) return defaultExecutable;

    throw Exception('No query engine binary found ($executableName)');
  }

  /// Generate owerwrite datasources.
  String get _overwriteDatasources {
    final overwrite = [
      {'name': datasource, 'url': url?.toString() ?? _urlFromEnv},
    ];

    return base64.encode(
      utf8.encode(
        json.encode(overwrite),
      ),
    );
  }

  /// Get database url from environment.
  String get _urlFromEnv {
    if (bool.hasEnvironment(envVariable)) {
      return String.fromEnvironment(envVariable);
    } else if (Platform.environment.containsKey(envVariable)) {
      return Platform.environment[envVariable]!;
    }

    throw Exception('No database url found ($envVariable)');
  }

  @override
  Future<void> start() async {
    _process ??= await _internalStart();
  }

  Future<Process> _internalStart() async {
    if (_process != null) return _process!;

    final arguments = [
      '--enable-metrics',
      '--enable-open-telemetry',
      '--enable-raw-queries',
    ];

    // Set port.
    arguments.addAll(['--port', '0']);

    // Set --datamodel
    arguments.addAll(['--datamodel', base64.encode(utf8.encode(schema))]);

    // Set protocol is json
    arguments.addAll(['--engine-protocol', 'json']);

    // Set overwrite datasources
    arguments.addAll(['--overwrite-datasources', _overwriteDatasources]);

    final process = await Process.start(
      _executable.path,
      arguments,
      includeParentEnvironment: true,
      environment: {
        'RUST_BACKTRACE': '1',
        'RUST_LOG': 'info',
      },
    );

    _listenProcess(process);
    final ready = await _serverReady();
    if (!ready) {
      process.kill();
      throw Exception('Unable to start query engine');
    }

    const shutdownSignals = [
      ProcessSignal.sigterm,
      ProcessSignal.sighup,
      ProcessSignal.sigterm,
      ProcessSignal.sigint,
      ProcessSignal.sigwinch,
    ];
    for (final signal in shutdownSignals) {
      signal.watch().listen((event) {
        process.kill();
        exit(0);
      });
    }

    return process;
  }

  Future<Uri> _serverEndpoint() async {
    // Await _endpoint is not null
    // With `retry` package, retry 5 times with 1 second delay
    return retry<Uri>(
      () => _endpoint != null
          ? _endpoint!
          : throw Exception('Prisma binary query engine not ready'),
    );
  }

  /// Server ready
  Future<bool> _serverReady() async {
    // Check if server is ready
    final url = (await _serverEndpoint()).resolve('/status');

    return retry(() async {
      final response = await fetch(url);
      final data = await response.json();

      if (data case {'status': 'ok'}) {
        return true;
      }

      throw Exception('Prisma binary query engine not ready');
    });
  }

  /// Listen process
  void _listenProcess(Process process) {
    final stream =
        process.stdout.transform(utf8.decoder).transform(const LineSplitter());
    stream.listen((message) {
      if (message.isEmpty) return;
      // print(message);
      try {
        final data = json.decode(message);
        if (data
            case {
              'level': "INFO",
              'target': 'query_engine::server',
              'fields': {
                'ip': final String host,
                'port': final String port,
              }
            }) {
          _endpoint = Uri(scheme: 'http', host: host, port: int.parse(port));
        }
      } catch (e) {
        // TODO: log error
        // print(message);
      }
    });
  }

  @override
  Future<void> stop() async {
    _process?.kill();
    _process = null;
  }

  @override
  Future request(
    JsonQuery query, {
    required String action,
    TransactionHeaders? headers,
    Transaction<Null>? transaction,
  }) async {
    print(query.toJson());

    await start();
    final endpoint = await _serverEndpoint();
    final httpHeaders = headers?.toJson() ?? <String, String>{};

    if (transaction != null) {
      httpHeaders['x-transaction-id'] = transaction.id;
    }

    final response = await fetch(
      endpoint,
      headers: httpHeaders,
      body: query.toJson(),
      method: 'POST',
    );

    return switch (await response.json()) {
      {'data': final Map data} => deserializeJsonResponse(data[action]),
      {'errors': final Iterable errors} => throw Exception(errors),
      dynamic value => throw Exception(value),
    };
  }

  @override
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required Transaction transaction,
  }) async {
    await start();

    final endpoint = await _serverEndpoint();
    final response = await fetch(
      endpoint.resolve('/transaction/${transaction.id}/commit'),
      method: 'POST',
      headers: headers.toJson(),
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

    final endpoint = await _serverEndpoint();
    final response = await fetch(
      endpoint.resolve('/transaction/${transaction.id}/rollback'),
      method: 'POST',
      headers: headers.toJson(),
    );
    final result = await response.json();

    return switch (result) {
      {'errors': final Iterable errors} => throw Exception(errors),
      _ => null,
    };
  }

  @override
  Future<Transaction<Null>> startTransaction({
    required TransactionHeaders headers,
    int maxWait = 2000,
    int timeout = 5000,
    IsolationLevel? isolationLevel,
  }) async {
    await start();
    final endpoint = await _serverEndpoint();
    final response = await fetch(
      endpoint.resolve('/transaction/start'),
      method: 'POST',
      headers: headers.toJson(),
      body: {
        'max_wait': maxWait,
        'timeout': timeout,
        if (isolationLevel != null) 'isolation_level': isolationLevel.value,
      },
    );
    final result = await response.json();

    return switch (result) {
      {'id': final String id} => Transaction(id, null),
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

    final endpoint = await _serverEndpoint();
    final response = await fetch(
      endpoint.replace(
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
