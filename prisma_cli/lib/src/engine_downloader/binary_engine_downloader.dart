import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

import 'binary_engine_platform.dart';
import 'binary_engine_type.dart';

typedef BinaryEngineDownloadEventHandler = void Function(Future<void> done);

class BinaryEngineDownloader {
  BinaryEngineDownloader({
    required this.binaryPath,
    required this.engineType,
    required this.platform,
    required this.version,
    required this.downloadDir,
  });

  /// Binary download save path.
  final String binaryPath;

  /// Binary engine type.
  final BinaryEngineType engineType;

  /// Binary engine running platform.
  final BinaryEnginePlatform platform;

  /// Binary engine version.
  final String version;

  /// Download Directory (a cache dir of the system)
  final String downloadDir;

  /// Get binary download url.
  Uri get downloadUrl => Uri.parse('https://binaries.prisma.sh').replace(
        pathSegments: [
          'all_commits',
          version,
          platform.value,
          _archiveBasename,
        ],
      );

  /// Get archive file name.
  String get _archiveBasename => engineType.value + _archiveExtension;

  late final String _archiveBasenamePath =
      join(downloadDir, "prisma/download",version, _archiveBasename);

  String get completeBinaryPath => join(downloadDir,binaryPath);

  /// Get archive file extension.
  String get _archiveExtension {
    if (platform == BinaryEnginePlatform.windows) {
      return '.exe.gz';
    }

    return '.gz';
  }

  /// Clean binary and archive.
  void _clean() {
    for (final File file in [
      File(_archiveBasenamePath),
      File(completeBinaryPath),
    ]) {
      if (file.existsSync()) file.deleteSync();

      // Check parent directory.
      // If directory is not exist, create it.
      final Directory parent = file.parent;
      if (!parent.existsSync()) parent.createSync(recursive: true);
    }
  }

  /// Download binary.
  Future<void> download([BinaryEngineDownloadEventHandler? handler]) async {
    // Create done completer.
    final Completer<void> done = Completer<void>();

    // Send start download event.
    handler?.call(done.future);

    // Clean binary and archive.
    _clean();

    // Create HTTP request.
    final Request request = Request('GET', downloadUrl);

    // Create HTTP client.
    final Client client = Client();

    // Send request, and await response.
    final StreamedResponse response = await client.send(request);

    // Save response to archive file.
    final File archive = File(_archiveBasenamePath);
    final IOSink archiveSink = archive.openWrite();
    await response.stream.pipe(archiveSink);

    // Close all io streams.
    await archiveSink.close();
    client.close();

    // Create gzip decoder.
    final GZipDecoder decoder = GZipDecoder();

    // Create input and output streams.
    final InputFileStream input = InputFileStream(archive.path);
    final OutputFileStream output = OutputFileStream(completeBinaryPath);

    // Decode stream.
    decoder.decodeStream(input, output);

    // Close all io streams.
    await input.close();
    await output.close();

    // Delete archive file.
    archive.deleteSync(recursive: true);

    // If archive parent directory is empty, delete it.
    final Directory parent = archive.parent;
    if (parent.listSync().isEmpty) parent.deleteSync();

    // Send done event.
    done.complete();
  }
}
