import 'dart:io';

import 'package:args/args.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart';
import 'package:prisma_common/prisma_common.dart';
import 'package:prisma_engines_download/prisma_engines_download.dart';
import 'package:prisma_engines_platform/prisma_engines_platform.dart';
import 'package:prisma_engines_version/prisma_engines_version.dart';

final ArgParser _argParser = ArgParser()
  ..addOption('schema', help: 'Custom path to your Prisma schema')
  ..addFlag('help', abbr: 'h', help: 'Show help', negatable: false);

final Logger logger = Logger.standard(ansi: Ansi(true));

void main(List<String> arguments) async {
  final ArgResults result = _argParser.parse(arguments);

  if (result.wasParsed('help')) {
    return logger.write(_argParser.usage);
  }

  final String prismaFmtBinaryPath = await downloadBinary(
    version: prismaEngineVersion,
    platform: PrismaEnginesPlatform.darwin,
    binary: PrismaBinaryType.prismaFmt,
    onDownloadProgress: _onDownloadProgress,
  );

  final String schemaPath = getSchemaPath(result['schema']);
  final Progress formatProgress =
      logger.progress('Formatting ${relative(schemaPath)}');
  final ProcessResult response = await Process.run(prismaFmtBinaryPath, [
    'format',
    '-i',
    schemaPath,
  ]);

  if (response.exitCode != 0) {
    logger.stderr(response.stderr);
    exit(response.exitCode);
  }

  File(schemaPath).writeAsStringSync(response.stdout);
  formatProgress.finish(showTiming: true);
  formatProgress.cancel();

  // logger.write();
  exit(response.exitCode);
}

/// Download progress callback.
Future<void> _onDownloadProgress(
    PrismaBinaryType binary, Future<void> done) async {
  final Progress progress = logger.progress('Downloading ${binary.value}');

  await done.then((_) {
    progress.finish(showTiming: true);
    progress.cancel();
  });
}
