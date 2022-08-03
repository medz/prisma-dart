import 'dart:async';
import 'dart:io';

import '../engine_cache.dart';

class DownloadEngineLookfile {
  const DownloadEngineLookfile(this.cache);

  /// Engine cache.
  final EngineCache cache;

  /// Get lookfile path.
  File get _lookfile => File('${cache.cachedBinaryPath}.lookfile');

  /// Lookup.
  Future<void> lookup() async {
    final Completer<void> completer = Completer<void>();
    _await(completer);

    return completer.future;
  }

  /// Exists lookfile.
  bool get exists => _lookfile.existsSync();

  /// Await checking.
  void _await(Completer<void> completer) {
    // If lookfile not exists. complete.
    if (!exists) {
      return completer.complete();
    }

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!exists) {
        timer.cancel();
        completer.complete();
      }
    });
  }

  /// Start.
  Future<void> start() async {
    await lookup();
    _lookfile.createSync(recursive: true);
  }

  /// done.
  void done() {
    if (exists) {
      _lookfile.deleteSync();
    }
  }
}
