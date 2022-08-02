import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:io/ansi.dart';
import 'package:path/path.dart';
import 'package:prisma_cli/prisma_cli.dart';

import '../logger.dart';

class FormatCommand extends Command<int> {
  FormatCommand() {
    argParser.addOption(
      'schema',
      help: 'Schema file path.',
      valueHelp: 'path',
    );
  }

  @override
  String get description => 'Format a Prisma schema.';

  @override
  String get name => 'format';

  @override
  Future<int> run() async {
    final EngineOptions options = EngineOptions(
      version: engineVersion,
      platform: EnginePlatform.darwin,
      binary: BinaryType.prismaFmt,
    );
    final BinaryEngine engine = BinaryEngine(
      options,
      onDownloadEvent: createOnDownloadProgress(options),
    );
    final File schema = getSchemaFile(argResults?['schema']);

    final ProcessResult result =
        await engine.run(['format', '-i', schema.path]);

    if (result.exitCode != 0) {
      logger.write(result.stderr ?? result.stdout);
      return result.exitCode;
    }

    await schema.writeAsString(result.stdout);
    logger.write(
        '${relative(schema.path)} ${green.wrap('formatted successfully.')!}');

    return result.exitCode;
  }
}
