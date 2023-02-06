import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:code_builder/code_builder.dart';

import 'generator/generator.dart';
import 'generator/prisma_info.dart';

/// Prisma Dart client generator
void main(Iterable<String> args) async {
  final parase = ArgParser();

  // Register the `ecosystem` option.
  parase.addOption(
    'package-manager',
    abbr: 'p',
    help: 'The NodeJS package manager to use.',
    allowed: ['npm', 'yarn', 'pnpm'],
    defaultsTo: 'npm',
  );

  // Register the `help` option.
  parase.addFlag(
    'help',
    abbr: 'h',
    help: 'Prints this help information.',
    negatable: false,
  );

  // Parse the arguments.
  final results = parase.parse(args);

  // Print the help information if requested.
  if (results['help'] as bool) return stdout.writeln(parase.usage);

  final info = PrismaInfo.lookup(results['package-manager']);

  final completer = Completer<Generator>();
  final library = Library((LibraryBuilder updates) async {
    final generator = await Generator.create(info: info, library: updates);
    completer.complete(generator);
  });
  final generator = await completer.future;

  print(generator.library);

  await generator.done();
}
