import 'package:args/command_runner.dart';
import 'package:orm/orm.dart';

class FormatCommand extends Command<int> {
  @override
  String get description => 'Format a Prisma schema.';

  @override
  String get name => 'format';

  @override
  Future<int> run() async {
    return 0;
  }
}
