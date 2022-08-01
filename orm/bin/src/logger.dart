import 'package:cli_util/cli_logging.dart';
import 'package:orm/orm.dart';

Progress? _progress;
Logger get logger => Logger.standard(ansi: Ansi(true));
DownloadEventHandler createOnDownloadProgress(EngineOptions options) {
  return (DownloadEvent event) {
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
  };
}
