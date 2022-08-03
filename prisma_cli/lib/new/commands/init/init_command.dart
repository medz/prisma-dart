import 'package:args/command_runner.dart';

class InitCommand extends Command<int> {
  InitCommand() {
    argParser.addOption(
      'url',
      help: 'Define a custom datasource url',
    );
    argParser.addOption(
      'datasource-provider',
      help: 'Define the datasource provider',
      allowed: [
        'postgresql',
        'mysql',
        'sqlite',
        'sqlserver',
        'mongodb',
        'cockroachdb',
      ],
      defaultsTo: 'postgresql',
    );
  }

  @override
  String get description => 'Setup Prisma for you project';

  @override
  String get name => 'init';
}
