import 'package:args/command_runner.dart';

class FormatCommand extends Command<int> {
  @override
  String get description => 'Format a Prisma schema.';

  @override
  String get name => 'format';
}
