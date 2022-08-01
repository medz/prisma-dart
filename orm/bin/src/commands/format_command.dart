import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:io/ansi.dart';
import 'package:orm/orm.dart';
import 'package:path/path.dart';

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

    final Process process = await engine.run([
      'format',
      '-i',
      schema.path,
    ]);

    final IOSink sink = schema.openWrite();
    await process.stdout.pipe(sink);
    await process.stderr.pipe(stderr);
    await sink.flush();
    await sink.close();
    process.kill();

    logger.write(
        '${relative(schema.path)} ${green.wrap('formatted successfully.')!}');

    return await process.exitCode;
  }
}
