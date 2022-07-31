import 'dart:io';

import 'package:args/args.dart';

final ArgParser _argParser = ArgParser()
  ..addOption('schema', help: 'Custom path to your Prisma schema')
  ..addFlag('help', abbr: 'h', help: 'Show help', negatable: false);

void main(List<String> arguments) {
  final ArgResults result = _argParser.parse(arguments);

  if (result.wasParsed('help')) {
    return print(_argParser.usage);
  }

  Process;
}
