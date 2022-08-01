import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:io/ansi.dart';

import 'src/commands/format_command.dart';

Future<void> main(List<String> args) async {
  final CommandRunner<int> runner = CommandRunner<int>(green.wrap('orm')!,
      '${cyan.wrap('◭')} Prisma is a modern DB toolkit to query, migrate and model your database (github.com/odroe/orm.dart)');
  runner.addCommand(FormatCommand());

  exitCode = await runner.run(args) ?? 0;
}
