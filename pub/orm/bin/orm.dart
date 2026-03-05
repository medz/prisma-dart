import 'dart:io';

import 'package:orm/orm.dart';

void main(List<String> args) {
  if (args.isEmpty || _isHelp(args.first)) {
    _printUsage();
    exitCode = args.isEmpty ? 64 : 0;
    return;
  }

  final command = args.first;
  final commandArgs = args.sublist(1);

  switch (command) {
    case 'generate':
      if (commandArgs.isNotEmpty && _isHelp(commandArgs.first)) {
        _printGenerateHelp();
        exitCode = 0;
        return;
      }

      if (commandArgs.isNotEmpty) {
        stderr.writeln(
          'Unexpected arguments for generate: ${commandArgs.join(' ')}',
        );
        _printGenerateHelp(stream: stderr);
        exitCode = 64;
        return;
      }

      exitCode = runGenerateCommand(
        cwd: Directory.current,
        out: stdout,
        err: stderr,
      );
      return;
    default:
      stderr.writeln('Unknown command: $command');
      _printUsage(stream: stderr);
      exitCode = 64;
  }
}

bool _isHelp(String value) =>
    value == '--help' || value == '-h' || value == 'help';

void _printUsage({IOSink? stream}) {
  final sink = stream ?? stdout;
  sink.writeln('ORM CLI');
  sink.writeln('Usage: dart run orm <command>');
  sink.writeln('');
  sink.writeln('Commands:');
  sink.writeln(
    '  generate    Generate typed client from orm.config.dart and schema',
  );
  sink.writeln('');
  sink.writeln('Run `dart run orm generate --help` for generate details.');
}

void _printGenerateHelp({IOSink? stream}) {
  final sink = stream ?? stdout;
  sink.writeln('Generate typed client.');
  sink.writeln('Usage: dart run orm generate');
  sink.writeln('');
  sink.writeln('Input files from current working directory:');
  sink.writeln('  - orm.config.dart');
  sink.writeln(
    '  - schema path from config.schema, or orm.schema.dart by default',
  );
  sink.writeln('');
  sink.writeln('Output:');
  sink.writeln('  - config.output, or lib/orm_client.g.dart by default');
}
