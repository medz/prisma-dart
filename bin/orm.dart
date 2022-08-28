import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:orm/version.dart';

import 'src/commands/db/db_command.dart';
import 'src/commands/format_command.dart';
import 'src/commands/init_command.dart';

/// The Prisma CLI executable name.
const String _executableName = r'dart run orm';

/// Prisma CLI description.
const String _description =
    ' ◭ Prisma CLI 🚀\nPrisma is a modern DB toolkit to query, migrate and model your database.\n More info: https://github.com/prismaorm/dart';

void main(List<String> args) async {
  // Create command runner.
  final CommandRunner runner = CommandRunner(_executableName, _description);

  // Add global options.
  runner.argParser.addFlag('version',
      abbr: 'v', negatable: false, help: 'Print CLI and engines version.');
  runner.argParser
      .addFlag('debug', negatable: false, help: 'Print debug information.');

  // Add commands.
  runner.addCommand(InitCommand());
  runner.addCommand(FormatCommand());
  runner.addCommand(DbCommand());

  // Get command result.
  final ArgResults results = runner.parse(args);

  // If version flag is set, print version and exit.
  if (results.wasParsed('version')) {
    return _printVersion();
  }

  // Run command.
  try {
    await runner.runCommand(results);
  } catch (e) {
    if (!results.wasParsed('debug')) {
      print(e);
      exit(1);
    }

    rethrow;
  }
}

/// Print CLI and engines version.
void _printVersion() {
  final String info = '''
  ${'Prisma CLI'.padRight(40)}$packageVersion
  ${'Prisma Binary Engines'.padRight(40)}$binaryVersion
  ${'Prisma Query C API'.padRight(40)}$capiVersion
  ''';

  print(info);
}
