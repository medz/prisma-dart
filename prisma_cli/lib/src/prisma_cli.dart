import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'commands/db/db_command.dart';
import 'commands/format_command.dart';
import 'commands/init_command.dart';
import 'version.dart';

/// The Prisma CLI executable name.
const String _executableName = r'dart run orm';

/// Prisma CLI description.
const String _description =
    ' ◭ Prisma CLI 🚀\nPrisma is a modern DB toolkit to query, migrate and model your database.\n More info: https://github.com/odroe/prisma';

/// Prisma CLI
class PrismaCLI {
  late final CommandRunner<int> _runner;

  /// Create a new Prisma CLI instance.
  PrismaCLI() {
    _runner = CommandRunner<int>(_executableName, _description)
      ..addCommand(InitCommand())
      ..addCommand(FormatCommand())
      ..addCommand(DbCommand());

    _runner.argParser.addFlag('version',
        abbr: 'v', negatable: false, help: 'Print CLI and engines version.');
  }

  /// Run Prisma CLI.
  Future<int> run(List<String> args) async {
    final ArgResults results = _runner.parse(args);

    if (results.wasParsed('version')) {
      return _printVersion();
    }

    final int? code = await _runner.runCommand(results);
    return code ?? 0;
  }

  /// Print CLI and engines version.
  Future<int> _printVersion() async {
    stdout.write('◭ Prisma CLI'.padRight(40));
    stdout.writeln(version);

    stdout.write('◭ Prisma Engines'.padRight(40));
    stdout.writeln(engineVersion);
    return 0;
  }
}
