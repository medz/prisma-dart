import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import 'generator/generator.dart';
import 'generator/prisma_info.dart';

/// Prisma Dart client generator
void main(Iterable<String> args) async {
  final parase = ArgParser();

  parase.addOption(
    'npm',
    defaultsTo: 'npm',
    help: 'The npm executable.',
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

  final info = PrismaInfo.lookup(results['npm']);
  final completer = Completer<Generator>();
  Library((LibraryBuilder updates) {
    updates.name = 'prisma.client';
    completer.complete(Generator.create(info: info, library: updates));
  });
  final generator = await completer.future;

  // Build the library.
  try {
    generator.generate();
  } catch (e, s) {
    if (e is FormatterException) {
      print(e.message(color: true));
    }
    print(s);

    rethrow;
  }

  // Done.
  await generator.done();
}
