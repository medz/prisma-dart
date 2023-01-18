import 'dart:convert' as convert;
import 'dart:io';

import 'package:orm/environtment.dart';
import 'package:orm/logger.dart' as logger_package;
import 'package:path/path.dart' as path;

import '../engine.dart';
import '../universal/universal_engine.dart';

/// Prisma binary query engine.
class BinaryEngine extends UniversalEngine implements Engine {
  /// Create a new instance of [BinaryEngine].
  BinaryEngine({
    required super.logger,
    super.headers,
    required this.executable,
    required this.schema,
    required this.datasources,
  }) : super(endpoint: Uri.base);

  /// Current working address.
  final InternetAddress address = InternetAddress.loopbackIPv4;

  /// Current working port.
  int? port;

  /// Binary query engine executable path.
  final String executable;

  /// Base64 encoded schema.
  final String schema;

  /// Database datasources.
  ///
  /// Example:
  /// ```dart
  /// final datasources = {
  ///  'db': 'postgresql://localhost:5432',
  /// };
  /// ```
  final Map<String, String> datasources;

  /// Cached current started process.
  Process? process;

  /// Resolve the binary endpoint.
  @override
  Uri get endpoint => Uri.http(address.host).replace(port: port);

  /// Resolve the binary query engine executable path.
  String get resolvedExecutable {
    // If executable exists, return it.
    if (File(executable).existsSync()) {
      return executable;
    }

    // If define in environtment, return it.
    if (Environtment.queryEngineBinary is String &&
        Environtment.queryEngineBinary?.isNotEmpty == true) {
      return Environtment.queryEngineBinary!;
    }

    final basename = path.basename(executable);
    final searchDirectories = [
      // Search in current working directory.
      ..._generateSearchDirectories(Directory.current.path),
      // Search in the executable directory.
      ..._generateSearchDirectories(path.dirname(Platform.resolvedExecutable)),
      // Search in current script directory.
      ..._generateSearchDirectories(path.dirname(Platform.script.toFilePath())),
    ];

    // Search in the search directories.
    for (final directory in searchDirectories) {
      final file = File(path.join(directory, basename));
      if (file.existsSync()) {
        return file.path;
      }
    }

    throw Exception(
        'Cannot find the query engine binary (Basename: $basename)');
  }

  /// Generate search directories.
  Iterable<String> _generateSearchDirectories(String directory) sync* {
    yield directory;
    yield path.join(directory, 'node_modules', 'prisma');
    yield path.join(directory, 'prisma');
    yield path.join(directory, '.dart_tool', 'prisma');
  }

  /// Generate owerwrite datasources.
  String get overwriteDatasources {
    final overwrite = [];
    for (final entry in datasources.entries) {
      overwrite.add({'name': entry.key, 'url': entry.value});
    }

    return convert.base64.encode(
      convert.utf8.encode(
        convert.json.encode(overwrite),
      ),
    );
  }

  /// Generate engine environment.
  Map<String, String> get environment {
    final env = <String, String>{};

    // Add overwrite datasources.
    env['OVERWRITE_DATASOURCES'] = overwriteDatasources;

    // Add schema.
    env['PRISMA_DML'] = schema;

    // Set log level.
    env['RUST_LOG'] = Platform.environment['RUST_LOG'] ?? _rustLogLevel;
    if (!Platform.environment.containsKey('LOG_QUERIES') && hasLogQueries) {
      env['LOG_QUERIES'] = 'true';
    }

    // Set rust backtrace.
    env['RUST_BACKTRACE'] = Platform.environment['RUST_BACKTRACE'] ?? '1';

    return env;
  }

  /// Resolve rust log level.
  String get _rustLogLevel {
    return logger.definitions.map((e) => e.event).reduce((value, element) {
      if (element == logger_package.Event.query) return element;
      if (element == logger_package.Event.info ||
          value == logger_package.Event.info) return logger_package.Event.info;

      return element;
    }).name;
  }

  /// Has log queries.
  bool get hasLogQueries =>
      logger.definitions.any((e) => e.event == logger_package.Event.query);

  /// Start the binary query engine.
  @override
  Future<void> start() async {
    port ??= await _findAvailablePort();
    process ??= await _createProcess();
  }

  /// Find available port.
  Future<int> _findAvailablePort() async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final port = server.port;
    await server.close();
    return port;
  }

  /// Create process.
  Future<Process> _createProcess() async {
    final arguments = [
      '--enable-raw-queries',
      '--enable-metrics',
      '--enable-open-telemetry',
    ];

    // Set port
    port ??= await _findAvailablePort();
    arguments.add('--port');
    arguments.add(port.toString());

    // Set host
    arguments.add('--host');
    arguments.add(address.host);

    // Create process.
    final process = await Process.start(
      resolvedExecutable,
      arguments,
      environment: environment,
      includeParentEnvironment: true,
      mode: ProcessStartMode.normal,
    );
    // TODO;
  }
}
