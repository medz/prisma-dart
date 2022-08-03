import 'package:args/command_runner.dart';

class FormatCommand extends Command<int> {
  FormatCommand() {
    argParser.addOption(
      'schema',
      help: 'Schema file path.',
      valueHelp: 'path',
    );
  }

  @override
  String get description => 'Format a Prisma schema.';

  @override
  String get name => 'format';

  @override
  Future<int> run() async {
    return 0;
  }
}
