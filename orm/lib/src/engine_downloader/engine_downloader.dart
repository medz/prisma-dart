import 'dart:io';

import 'package:http/http.dart' as http;

import '../configure.dart';
import '../engine_cache.dart';
import '../engine_options.dart';
import '../engine_platform.dart';
import 'download_engine_lookfile.dart';
import 'download_event.dart';

/// Default download binaries mirror.
const String _defaultBinariesMirror = r'https://binaries.prisma.sh';

class EngineDownloader {
  const EngineDownloader(this.cache);

  /// Engine cache.
  final EngineCache cache;

  /// Download url.
  Uri get downloadUrl => url(cache.options);

  /// GZip file.
  File get _gzip => File('${cache.cachedBinaryPath}.gz');

  /// Download engine binary.
  Future<String> download([DownloadEventHandler? handler]) async {
    final DownloadEngineLookfile lookfile = DownloadEngineLookfile(cache);

    // If lookfile exists, await lookup.
    if (lookfile.exists) {
      handler?.call(DownloadEvent.lookfile);
    }

    try {
      // Start lookfile.
      await lookfile.start();

      // Override files.
      _override();

      handler?.call(DownloadEvent.progress);
      final http.Request request = http.Request('GET', downloadUrl);
      final http.Client client = http.Client();
      final http.StreamedResponse response = await client.send(request);

      return '';
    } finally {
      // Done lookfile.
      lookfile.done();
    }
  }

  /// Start lookup.
  Future<void> _startLookup(
      DownloadEngineLookfile lookfile, DownloadEventHandler? handler) async {
    if (lookfile.exists) {
      handler?.call(DownloadEvent.lookfile);
    }
  }

  /// Override files.
  void _override() {
    cache.override();
    if (_gzip.existsSync()) {
      _gzip.deleteSync();
    }
  }

  /// Get download url.
  static Uri url(EngineOptions options) {
    // Resolve binaries mirror.
    final String binariesMirror =
        configured('binaries_mirror') ?? _defaultBinariesMirror;

    // extension.
    final String extension =
        options.platform == EnginePlatform.windows ? '.exe.gz' : '.gz';

    return Uri.parse(binariesMirror).replace(pathSegments: [
      'all_commits',
      options.version,
      options.platform.value,
      '${options.binary.value}$extension',
    ]);
  }
}
