import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:orm/orm.dart';

import '../logger_mixin.dart';

class DbComment extends Command<int> with LoggerMixin {
  DbComment() {
    argParser.addOption(
      'schema',
      help: 'Custom path to your Prisma schema',
      valueHelp: 'path',
    );
  }

  @override
  String get description => 'Manage your database schema and lifecycle';

  @override
  String get name => 'db';

  /// Engine options.
  @override
  EngineOptions get options => EngineOptions(
        version: engineVersion,
        platform: EnginePlatform.darwin,
        binary: BinaryType.migrationEngine,
      );

  /// Binary engine.
  BinaryEngine get _binaryEngine => BinaryEngine(
        options,
        onDownloadEvent: onDownloadProgress,
      );

  @override
  Future<int> run() async {
    final Migrate migrate = Migrate(
      _binaryEngine,
      schema: getSchemaFile(argResults?['schema']),
    );

    final progress = logger.progress('Pushing schema...');
    final result = await migrate.push();
    migrate.stop();
    progress.finish(showTiming: true);

    if (result.error != null) {
      logger.write(result.error!.message);
      return 1;
    }

    logger.write('Schema pushed successfully!');

    return 0;
  }
}
