import 'engine_cache.dart';
import 'engine_downloader/engine_downloader.dart';
import 'engine_options.dart';

class BinaryEngine {
  const BinaryEngine(this.options);

  /// Engine options.
  final EngineOptions options;

  /// Cache instance.
  EngineCache get cache => EngineCache(options);

  /// Load binary, If binary is not found, download it.
  Future<String> load() async {
    // If binary exists, return it.
    if (cache.exists) {
      return cache.cachedBinaryPath;
    }

    return EngineDownloader(cache).download();
  }
}
