import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../engine_downloader/binary_engine_downloader.dart';
import '../../engine_downloader/binary_engine_platform.dart';
import '../../engine_downloader/binary_engine_type.dart';
import '../../json_rpc/schema_push.dart';
import '../../migrate/migrate.dart';
import '../../utils/ansi_progress.dart';
import '../../version.dart';

class DbPushSubCommand extends Command<int> {
  @override
  String get description =>
      '🙌  Push the state from your Prisma schema to your database';

  @override
  String get name => 'push';

  DbPushSubCommand() {
    argParser.addFlag(
      'force-reset',
      help: 'Force a reset of the database before push',
    );
    argParser.addOption(
      'schema',
      help: 'Custom path to your Prisma schema',
      valueHelp: 'path',
      defaultsTo: 'prisma/schema.prisma',
    );
  }

  /// Schema file.
  File get schema => File(argResults?['schema']);

  @override
  Future<int> run() async {
    if (!schema.existsSync()) {
      stderr.writeln('Missing schema file path.');
      return 1;
    }

    // Prisma migrate engine binary file.
    final File migrateEngineBinary =
        File('prisma/engines/${BinaryEngineType.migration.value}');

    // If migrate engine binary file does not exist, download it.
    if (!migrateEngineBinary.existsSync()) {
      final BinaryEngineDownloader downloader = BinaryEngineDownloader(
        binaryPath: migrateEngineBinary.path,
        engineType: BinaryEngineType.migration,
        platform: BinaryEnginePlatform.current,
        version: engineVersion,
      );

      await downloader.download(_onDownload);
    }

    // Create migrate
    final Migrate migrate = Migrate(
      path: migrateEngineBinary.path,
      schema: schema,
    );

    // Create push progress bar.
    final AnsiProgress progress = AnsiProgress('Pushing schema...');

    // Push schema.
    SchemaPushResponse result = await migrate.push(
      force: argResults?['force-reset'],
    );

    if (result.warnings.isNotEmpty) {
      stderr.writeln('Warnings:');
      for (final String warning in result.warnings) {
        stderr.writeln('  - $warning');
      }

      stderr.write('Press enter to continue...[y/n]: ');
      final String? value = stdin.readLineSync()?.trim().toLowerCase();
      if (value != 'y') {
        migrate.stop();
        progress.cancel();
        stdout.writeln('Aborted.');
        return 1;
      }

      result = await migrate.push(force: true);
    }

    // Stop migrate engine.
    migrate.stop();

    // Finish progress bar.
    progress.cancel(showTime: true);

    // If there is an error, print it.
    if (result.error != null) {
      stderr.writeln(result.error!.message);
      return 1;
    }

    // Print success message.
    stdout.writeln('Schema pushed successfully!');

    return 0;
  }

  /// Called when download is started.
  void _onDownload(Future<void> done) async {
    final AnsiProgress progress =
        AnsiProgress('Downloading ${BinaryEngineType.migration.value}...');

    // Await download done.
    await done;

    // Cancel progress.
    progress.cancel(
      showTime: true,
      overrideMessage: '${BinaryEngineType.migration.value} downloaded.',
    );
  }
}
