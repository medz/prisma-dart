import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart';
import 'package:orm/configure.dart';

import '../utils/chmod.dart';
import '../utils/find_project.dart';
import 'binary_engine_platform.dart';
import 'binray_engine_type.dart';

class BinaryEngine {
  const BinaryEngine({
    required this.platform,
    required this.type,
    required this.version,
  });

  final BinaryEnginePlatform platform;
  final BinaryEngineType type;
  final String version;

  /// Get archive file extension.
  String get _archiveExtension =>
      platform == BinaryEnginePlatform.windows ? '.exe.gz' : '.gz';

  /// archive file name.
  String get _archiveBasename => type.value + _archiveExtension;

  /// Archive file path.
  String get _archive =>
      joinPaths(['.dart_tool', 'prisma-engines', _archiveBasename]);

  /// Executable file path.
  String get executable =>
      joinPaths(['.dart_tool', 'prisma-engines', type.value]);

  /// Has the binary engine been downloaded.
  bool get hasDownloaded => File(executable).existsSync();

  /// Run the binary engine.
  Future<ProcessResult> run(List<String> arguments) => Process.run(
        executable,
        arguments,
        workingDirectory: projectDirectory,
        includeParentEnvironment: false,
        environment: configure.environment,
      );

  /// Start the binary engine.
  Future<Process> start(List<String> arguments) => Process.start(
        executable,
        arguments,
        workingDirectory: projectDirectory,
        includeParentEnvironment: false,
        environment: configure.environment,
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
    final Uri url = Uri.parse('https://binaries.prisma.sh').replace(
      pathSegments: [
        'all_commits',
        version,
        platform.value,
        _archiveBasename,
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
