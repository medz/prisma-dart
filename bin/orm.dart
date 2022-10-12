library prisma.cli;

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:orm/configure.dart';
import 'package:orm/version.dart';

import 'src/commands/db/db_command.dart';
import 'src/commands/format_command.dart';
import 'src/commands/generate_command.dart';
import 'src/commands/init_command.dart';
import 'src/commands/precache_command.dart';
import 'src/configure.dart';

/// The Prisma CLI executable name.
const String _executableName = r'dart run orm';

/// Prisma CLI description.
const String _description =
    ' ◭ Prisma CLI 🚀\nPrisma is a modern DB toolkit to query, migrate and model your database.\n More info: https://github.com/odroe/prisma-dart';

void main(List<String> args) async {
  bootstrap();

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
  runner.addCommand(GenerateCommand());
  runner.addCommand(PrecacheCommand());

  // Get command result.
  final ArgResults results = runner.parse(args);

  // If version flag is set, print version and exit.
  if (results.wasParsed('version')) {
    return _printVersion();
  }

  // Run command.
  try {
    await runner.runCommand(results);
  } catch (error) {
    print('');
    if (results.wasParsed('debug') ||
        configure.prisma(PrismaEnvironment.DEBUG) != null) {
      rethrow;
    }

    runner.printUsage();
    print('\n');
    print(_redTextWrapper(error.toString(), () => !_noColor));
    print('\n');
    exit(1);
  }
}

/// Red text if then terminal supports it.
String _redTextWrapper(String text, [bool Function()? condition]) {
  if (stdout.supportsAnsiEscapes && (condition == null || condition())) {
    return '\x1B[31m$text\x1B[0m';
  }

  return text;
}

/// No color.
bool get _noColor => configure.prisma(PrismaEnvironment.NO_COLOR);

/// Print CLI and engines version.
void _printVersion() {
  final String info = '''
  ${'Prisma CLI'.padRight(40)}$packageVersion
  ${'Prisma Binary Engines'.padRight(40)}$binaryVersion
  ${'Prisma Query C API'.padRight(40)}$capiVersion
  ''';

  print(info);
}

void bootstrap() {
  final String? executable = configure.developmentExecutable;

  // If executable is null, skip.
  if (executable == null) {
    return;
  }

  final List<String> arguments = configure.developmentArguments.toList();
  final ProcessResult result = Process.runSync(
    executable,
    arguments,
    includeParentEnvironment: true,
    stderrEncoding: utf8,
    stdoutEncoding: utf8,
  );

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  final Iterable<String> lines = result.stdout
      .toString()
      .split(RegExp(r'\r?\n'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty);
}
