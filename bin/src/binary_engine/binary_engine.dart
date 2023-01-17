import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart';
import 'package:orm/environtment.dart';
import 'package:path/path.dart';

import '../utils/chmod.dart';
import '../utils/finder.dart';
import 'binary_engine_type.dart';

class BinaryEngine {
  const BinaryEngine({
    required this.platform,
    required this.type,
    required this.version,
  });

  final String platform;
  final BinaryEngineType type;
  final String version;

  /// Get archive file extension.
  String get _archiveExtension => Platform.isWindows ? '.exe.gz' : '.gz';

  /// Archive file path.
  String get _archive => executable + _archiveExtension;

  /// Executable file path.
  String get executable {
    switch (type) {
      case BinaryEngineType.query:
        return Environtment.queryEngineBinary ??
            _defaultEnginePathBuilder('query-engine');
      case BinaryEngineType.migration:
        return Environtment.migrationEngineBinary ??
            _defaultEnginePathBuilder('migration-engine');
      case BinaryEngineType.introspection:
        return Environtment.introspectionEngineBinary ??
            _defaultEnginePathBuilder('introspection-engine');
      case BinaryEngineType.format:
        return Environtment.fmtBinary ??
            _defaultEnginePathBuilder('prisma-fmt');
    }
  }

  /// Default engine path builder.
  String _defaultEnginePathBuilder(String name) =>
      joinAll([findProjectRoot(), '.dart_tool', 'prisma', name]);

  /// Has the binary engine been downloaded.
  Future<bool> get hasDownloaded async {
    if (!File(executable).existsSync()) {
      return false;
    }

    try {
      // Get excutable file version.
      final ProcessResult result = await run(['--version']);

      // If excutable file version is not same as binary engine version, delete it.
      if (result.stdout.toString().contains(version)) {
        return true;
      }

      throw Exception('Binary engine version is not same as excutable file.');
    } catch (_) {
      await _clean();
      return false;
    }
  }

  /// Run the binary engine.
  Future<ProcessResult> run(
    List<String> arguments, {
    Map<String, String> environment = const <String, String>{},
  }) =>
      Process.run(
        executable,
        arguments,
        includeParentEnvironment: true,
        environment: {
          ...environment,
        },
      );

  /// Start the binary engine.
  Future<Process> start(
    List<String> arguments, {
    Map<String, String> environment = const <String, String>{},
  }) =>
      Process.start(
        executable,
        arguments,
        includeParentEnvironment: true,
        environment: {
          ...environment,
        },
      );

  /// Download the binary engine.
  Future<void> download(void Function(Future<void> done) onDownload) async {
    // Create done completer.
    final Completer<void> done = Completer<void>();

    // Call onDownload.
    onDownload.call(done.future);

    // Clean binary and archive.
    await _clean();

    // Create download url.
    final Uri url = Environtment.enginesMirror.replace(
      pathSegments: [
        'all_commits',
        version,
        platform,
        type.value + _archiveExtension,
      ],
    );

    // Create http client.
    final Client client = Client();

    // Create download request.
    final Request request = Request('GET', url);

    // Create download response.
    final StreamedResponse response = await client.send(request);

    // Save download response to file.
    final File archive = File(_archive);
    final IOSink archiveSink = archive.openWrite();
    await response.stream.pipe(archiveSink);

    // Close all streams.
    await archiveSink.close();
    client.close();

    // Decode archive.
    // archive is idempotent, enabling self-threading prevents blocking the main thread.
    final Completer<void> decoded = Completer<void>();
    final ReceivePort receivePort = ReceivePort();
    final Isolate isolate =
        await Isolate.spawn<SendPort>(_decodeArchive, receivePort.sendPort);
    receivePort.listen((message) => decoded.complete());

    await decoded.future;
    isolate.kill();
    receivePort.close();

    // Change binary permissions.
    await chmod(executable);

    // Delete archive.
    await archive.delete();

    // If archive parent directory is empty, delete it.
    final Directory parent = archive.parent;
    if (parent.listSync().isEmpty) parent.deleteSync();

    // Send done event.
    done.complete();
  }

  /// Decode archive.
  void _decodeArchive(SendPort sendPort) async {
    // Create gzip decoder.
    final GZipDecoder decoder = GZipDecoder();

    // Create archive input stream.
    final InputFileStream input = InputFileStream(_archive);

    // Create archive output stream.
    final OutputFileStream output = OutputFileStream(executable);

    // Decode archive.
    decoder.decodeStream(input, output);
    await output.close();
    await input.close();
    sendPort.send(null);
  }

  /// Clean binary and archive.
  Future<void> _clean() async {
    for (final File file in [
      File(_archive),
      File(executable),
    ]) {
      if (file.existsSync()) {
        await file.delete();
      }

      // If parent directory is not exist, create it.
      final Directory parent = file.parent;
      if (!parent.existsSync()) {
        await parent.create(recursive: true);
      }
    }
  }
}
