import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:io/ansi.dart';
import 'package:orm/orm.dart';

import 'src/commands/format_command.dart';

Future<void> main(List<String> args) async {
  final CommandRunner<int> runner = CommandRunner<int>(executableName,
      '${cyan.wrap('◭')} Prisma is a modern DB toolkit to query, migrate and model your database (https://github.com/odroe/orm.dart)');
  runner.addCommand(FormatCommand());

  exitCode = await runner.run(args) ?? 0;
  exit(exitCode);
}
