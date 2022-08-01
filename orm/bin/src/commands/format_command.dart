import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:io/ansi.dart';
import 'package:orm/orm.dart';
import 'package:path/path.dart';

class FormatCommand extends Command<int> {
  FormatCommand() {
    argParser.addOption(
      'schema',
      help: 'Schema file path.',
      valueHelp: 'path',
    );
  }

  EngineOptions get _engineOptions => EngineOptions(
        version: engineVersion,
        platform: EnginePlatform.darwin,
        binary: BinaryType.prismaFmt,
      );

  BinaryEngine get engine => BinaryEngine(
        _engineOptions,
        onDownloadEvent: _onDownloadProgress,
      );

  Logger get logger => Logger.standard(ansi: Ansi(true));

  @override
  String get description => 'Format a Prisma schema.';

  @override
  String get name => 'format';

  @override
  Future<int> run() async {
    final File schema = getSchemaFile(argResults?['schema']);
    final ProcessResult result = await engine.run([
      'format',
      '-i',
      schema.path,
    ]);

    if (result.exitCode != 0) {
      logger.stderr(result.stderr);
      return result.exitCode;
    }

    schema.writeAsStringSync(result.stdout);

    _progress?.finish(showTiming: true);
    _progress?.cancel();

    logger.write(
        '${relative(schema.path)} ${green.wrap('formatted successfully.')!}');

    return result.exitCode;
  }

  Progress? _progress;

  /// Download progress callback.
  void _onDownloadProgress(DownloadEvent event) async {
    switch (event) {
      case DownloadEvent.startDownload:
        _progress =
            logger.progress('Downloading ${_engineOptions.binary.value}');
        break;
      case DownloadEvent.startUnpack:
        _progress = logger.progress('Unpacking ${_engineOptions.binary.value}');
        break;
      case DownloadEvent.doneUnpack:
      case DownloadEvent.doneDownload:
        _progress?.finish(showTiming: true);
        break;
      case DownloadEvent.lookfile:
        _progress =
            logger.progress('Looking for ${_engineOptions.binary.value}');
        break;
    }
  }
}
