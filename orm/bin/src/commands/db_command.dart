import 'package:args/command_runner.dart';
import 'package:orm/orm.dart';

import '../logger.dart';
import 'db/push_sub_command.dart';

class DbComment extends Command<int> {
  DbComment() {
    addSubcommand(PushSubCommand(_binaryEngine));
  }

  @override
  String get description => 'Manage your database schema and lifecycle';

  @override
  String get name => 'db';

  /// Engine options.
  EngineOptions get options => EngineOptions(
        version: engineVersion,
        platform: EnginePlatform.darwin,
        binary: BinaryType.migrationEngine,
      );

  /// Binary engine.
  BinaryEngine get _binaryEngine => BinaryEngine(
        options,
        onDownloadEvent: createOnDownloadProgress(options),
      );

  @override
  Future<int> run() async {
    printUsage();
    return 0;
  }
}
