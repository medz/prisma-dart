import 'package:cli_util/cli_logging.dart';

mixin LoggerMixin {
  Logger get logger => Logger.standard(ansi: Ansi(true));
}
