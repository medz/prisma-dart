import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:orm/configure.dart';
import 'package:orm/version.dart';

import '../../../binary_engine/binary_engine.dart';
import '../../../binary_engine/binary_engine_platform.dart';
import '../../../binary_engine/binray_engine_type.dart';
import '../../../migrate/json_rpc.dart';
import '../../../migrate/migrate.dart';
import '../../../utils/ansi_progress.dart';
import '../../../utils/find_project.dart';

class DbPushSubCommand extends Command {
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
      help: 'Schema file path.',
      valueHelp: 'path',
      defaultsTo:
          configure('schema', joinRelativePaths(['prisma', 'schema.prisma'])),
    );
  }

  @override
  Future<void> run() async {
    final File schema = File(argResults!['schema']);
    if (!schema.existsSync()) {
      return print('Missing schema file path.');
    }

    final BinaryEngine engine = BinaryEngine(
      platform: BinaryEnginePlatform.current,
      type: BinaryEngineType.migration,
      version: binaryVersion,
    );
    if (!engine.hasDownloaded) {
      await engine.download(
          AnsiProgress.createFutureHandler('Download migration engine'));
      await Future.delayed(Duration(microseconds: 500));
    }

    // Create progress bar.
    final AnsiProgress progress = AnsiProgress('Pushing schema...');

    // Create migrate.
    final Migrate migrate = Migrate(
      engine: engine,
      schemaPath: schema.path,
      // TODO: add enable preview flag.
    );
    final SchemaPushResponse response =
        await migrate.schemaPush(force: argResults?['force-reset']);
    displayMessages(response, migrate);

    if (response.result?.warnings.isNotEmpty == true) {
      print('Warnings:');
      for (final dynamic warning in response.result!.warnings) {
        print('  $warning');
      }

      stdout.write('Press enter to continue...[y/n]: ');
      final String? value = stdin.readLineSync()?.trim().toLowerCase();
      if (value != 'y') {
        migrate.stop();
        progress.cancel();
        stdout.writeln('Aborted.');
        return;
      }

      final SchemaPushResponse response2 =
          await migrate.schemaPush(force: true);
      displayMessages(response2, migrate);
    }

    progress.cancel(
      overrideMessage: 'Pushed schema successfully.',
      showTime: false,
    );
    migrate.stop();
  }

  /// Display messages.
  void displayMessages(SchemaPushResponse response, Migrate migrate) {
    if (response.error != null) {
      final StringBuffer message = StringBuffer();
      message.writeln(response.error?.message);
      message.writeln(response.error?.data.message);
      migrate.stop();

      print('');

      throw Exception(message);
    }

    if (response.result?.unexecutable.isNotEmpty == true) {
      final StringBuffer message = StringBuffer();
      message.writeln('Unexecutable:');
      for (final dynamic migration in response.result!.unexecutable) {
        message.writeln('  $migration');
      }

      print(message);
    }
  }
}
