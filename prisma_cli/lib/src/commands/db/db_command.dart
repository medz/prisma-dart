import 'package:args/command_runner.dart';

import 'db_push_sub_command.dart';

class DbCommand extends Command<int> {
  @override
  String get description => 'Manage your database schema and lifecycle';

  @override
  String get name => 'db';

  DbCommand() {
    addSubcommand(DbPushSubCommand());
  }

  @override
  Future<int> run() async {
    printUsage();
    return 0;
  }
}
