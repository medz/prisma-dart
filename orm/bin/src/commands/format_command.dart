import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:io/ansi.dart';
import 'package:orm/orm.dart';
import 'package:path/path.dart';

import '../logger_mixin.dart';

class FormatCommand extends Command<int> with LoggerMixin {
  FormatCommand() {
    argParser.addOption(
      'schema',
      help: 'Schema file path.',
      valueHelp: 'path',
    );
  }

  @override
  EngineOptions get options => EngineOptions(
        version: engineVersion,
        platform: EnginePlatform.darwin,
        binary: BinaryType.prismaFmt,
      );

  BinaryEngine get engine => BinaryEngine(
        options,
        onDownloadEvent: onDownloadProgress,
      );

  @override
  String get description => 'Format a Prisma schema.';

  @override
  String get name => 'format';

  @override
  Future<int> run() async {
    final File schema = getSchemaFile(argResults?['schema']);

    final Process process = await engine.run([
      'format',
      '-i',
      schema.path,
    ]);
    final IOSink sink = schema.openWrite();

    await process.stdout.pipe(sink);
    await process.stderr.pipe(stderr);

    process.kill();

    logger.write(
        '${relative(schema.path)} ${green.wrap('formatted successfully.')!}');

    return process.exitCode;
  }
}
