import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:io/ansi.dart';
import 'package:orm/orm.dart';

import 'src/commands/db_command.dart';
import 'src/commands/format_command.dart';
import 'src/commands/generate_command.dart';
import 'src/commands/init_command.dart';

Future<void> main(List<String> args) async {
  final CommandRunner<int> runner = CommandRunner<int>(executableNameWithColor,
      '${cyan.wrap('◭')} Prisma is a modern DB toolkit to query, migrate and model your database (https://github.com/odroe/orm.dart)');

  // Add commands.
  runner
    ..addCommand(FormatCommand())
    ..addCommand(InitCommand())
    ..addCommand(DbComment())
    ..addCommand(GenerateCommand());

  try {
    exitCode = await runner.run(args) ?? 0;
  } catch (e) {
    stderr.writeln(e);
    exitCode = 1;
  }

  stdout.write('\n');
  exit(exitCode);
}
