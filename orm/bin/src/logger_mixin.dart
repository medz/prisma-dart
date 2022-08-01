import 'package:cli_util/cli_logging.dart';
import 'package:orm/orm.dart';

mixin LoggerMixin {
  EngineOptions get options;

  Logger get logger => Logger.standard(ansi: Ansi(true));

  Progress? _progress;

  /// Download progress callback.
  void onDownloadProgress(DownloadEvent event) async {
    switch (event) {
      case DownloadEvent.startDownload:
        _progress = logger.progress('Downloading ${options.binary.value}');
        break;
      case DownloadEvent.startUnpack:
        _progress = logger.progress('Unpacking ${options.binary.value}');
        break;
      case DownloadEvent.doneUnpack:
      case DownloadEvent.doneDownload:
      case DownloadEvent.done:
        _progress?.finish(showTiming: true);
        _progress?.cancel();
        break;
      case DownloadEvent.lookfile:
        _progress = logger.progress('Looking for ${options.binary.value}');
        break;
    }
  }
}
