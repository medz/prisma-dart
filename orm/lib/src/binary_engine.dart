import 'dart:io';

import 'configure.dart';
import 'engine_cache.dart';
import 'engine_downloader/download_event.dart';
import 'engine_downloader/engine_downloader.dart';
import 'engine_options.dart';

typedef _ProcessHandler<T> = T Function(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
  Map<String, String>? environment,
  bool includeParentEnvironment,
  bool runInShell,
  ProcessStartMode mode,
});

class BinaryEngine {
  const BinaryEngine(
    this.options, {
    this.onDownloadEvent,
  });

  /// Engine options.
  final EngineOptions options;

  /// Download event handler.
  final DownloadEventHandler? onDownloadEvent;

  /// Cache instance.
  EngineCache get cache => EngineCache(options);

  /// Load binary, If binary is not found, download it.
  Future<String> load() async {
    // If binary exists, return it.
    if (cache.exists) {
      return cache.cachedBinaryPath;
    }

    return EngineDownloader(cache).download(onDownloadEvent);
  }

  /// Start process.
  Future<Process> start(List<String> arguments) async {
    return Process.start(
      await load(),
      arguments,
      includeParentEnvironment: false,
      environment: configured.environment,
    );
  }

  /// Starts a process and runs it to completion.
  Future<ProcessResult> run(List<String> arguments) async {
    return Process.run(
      await load(),
      arguments,
      includeParentEnvironment: false,
      environment: configured.environment,
    );
  }
}
