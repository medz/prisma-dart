import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';

import '../engine_downloader/binary_engine_downloader.dart';
import '../engine_downloader/binary_engine_platform.dart';
import '../engine_downloader/binary_engine_type.dart';
import '../utils/ansi_progress.dart';
import '../version.dart';

class FormatCommand extends Command<int> {
  FormatCommand() {
    argParser.addOption(
      'schema',
      help: 'Schema file path.',
      valueHelp: 'path',
      defaultsTo: 'prisma/schema.prisma',
    );
  }

  @override
  String get description => 'Format a Prisma schema.';

  @override
  String get name => 'format';

  /// Schema file.
  File get schema => File(argResults?['schema']);

  @override
  Future<int> run() async {
    if (!schema.existsSync()) {
      stderr.writeln('Missing schema file path.');
      return 1;
    }

    // Format engine binary file.
    final File formatEngineBinary =
        File('prisma/engines/${BinaryEngineType.format.value}');

    // If format engine binary file does not exist, download it.
    if (!formatEngineBinary.existsSync()) {
      final BinaryEngineDownloader downloader = BinaryEngineDownloader(
        binaryPath: formatEngineBinary.path,
        engineType: BinaryEngineType.format,
        platform: BinaryEnginePlatform.darwin,
        version: engineVersion,
      );

      await downloader.download(_onDownload);
    }

    // Create format progress.
    final AnsiProgress formatProgress =
        AnsiProgress('Formatting prisma schema...');

    // Run format engine binary.
    final ProcessResult result = await Process.run(
      formatEngineBinary.path,
      ['format', '-i', schema.path],
    );

    // If format engine binary failed, print error message.
    if (result.exitCode != 0) {
      stderr.writeln(result.stderr ?? result.stdout);
      return result.exitCode;
    }

    // Write formatted schema string to schema file.
    await schema.writeAsString(result.stdout);

    // Cancel format progress.
    formatProgress.cancel(
      overrideMessage: '${relative(schema.path)} formatted successfully.',
      showTime: false,
    );

    return result.exitCode;
  }

  /// Called when download is started.
  void _onDownload(Future<void> done) async {
    final AnsiProgress progress = AnsiProgress('Downloading format engine...');

    // Await download done.
    await done;

    // Cancel progress.
    progress.cancel(
      showTime: true,
      overrideMessage: 'Prisma format engine downloaded.',
    );
  }
}
