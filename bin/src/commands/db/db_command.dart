import 'package:args/command_runner.dart';

import 'subs/db_push_sub_command.dart';

class DbCommand extends Command {
  @override
  String get description => 'Manage your database schema and lifecycle';

  @override
  String get name => 'db';

  DbCommand() {
    addSubcommand(DbPushSubCommand());
  }

  @override
  void run() => printUsage();
}
