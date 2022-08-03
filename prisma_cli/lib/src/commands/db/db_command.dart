import 'package:args/command_runner.dart';

class DbCommand extends Command<int> {
  @override
  String get description => 'Manage your database schema and lifecycle';

  @override
  String get name => 'db';

  @override
  Future<int> run() async {
    printUsage();
    return 0;
  }
}
