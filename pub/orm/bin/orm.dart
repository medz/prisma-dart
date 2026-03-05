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
      final parseResult = _parseGenerateArgs(commandArgs);
      if (parseResult.helpRequested) {
        _printGenerateHelp();
        exitCode = 0;
        return;
      }

      if (parseResult.errorMessage != null) {
        stderr.writeln(parseResult.errorMessage);
        _printGenerateHelp(stream: stderr);
        exitCode = 64;
        return;
      }

      final options = parseResult.options!;
      exitCode = runGenerateCommand(
        cwd: Directory.current,
        out: stdout,
        err: stderr,
        configPath: options.configPath,
        schemaPath: options.schemaPath,
        outputPath: options.outputPath,
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

_GenerateCliParseResult _parseGenerateArgs(List<String> args) {
  String? configPath;
  String? schemaPath;
  String? outputPath;

  for (var index = 0; index < args.length; index++) {
    final argument = args[index];
    if (_isHelp(argument)) {
      return const _GenerateCliParseResult.help();
    }

    if (!argument.startsWith('--')) {
      return _GenerateCliParseResult.error(
        'Unexpected arguments for generate: ${args.join(' ')}',
      );
    }

    final separatorIndex = argument.indexOf('=');
    var optionName = argument;
    String? optionValue;

    if (separatorIndex >= 0) {
      optionName = argument.substring(0, separatorIndex);
      optionValue = argument.substring(separatorIndex + 1);
    }

    if (!_isGenerateOption(optionName)) {
      return _GenerateCliParseResult.error(
        'Unexpected arguments for generate: ${args.join(' ')}',
      );
    }

    if (optionValue == null) {
      if (index + 1 >= args.length) {
        return _GenerateCliParseResult.error('Missing value for $optionName.');
      }

      final next = args[index + 1];
      if (_isHelp(next) || next.startsWith('--')) {
        return _GenerateCliParseResult.error('Missing value for $optionName.');
      }

      optionValue = next;
      index++;
    }

    if (optionValue.trim().isEmpty) {
      return _GenerateCliParseResult.error(
        'Option $optionName requires a non-empty path.',
      );
    }

    switch (optionName) {
      case '--config':
        configPath = optionValue;
        break;
      case '--schema':
        schemaPath = optionValue;
        break;
      case '--output':
        outputPath = optionValue;
        break;
    }
  }

  return _GenerateCliParseResult.success(
    _GenerateCliOptions(
      configPath: configPath,
      schemaPath: schemaPath,
      outputPath: outputPath,
    ),
  );
}

bool _isGenerateOption(String value) =>
    value == '--config' || value == '--schema' || value == '--output';

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
  sink.writeln('Usage: dart run orm generate [options]');
  sink.writeln('');
  sink.writeln('Options:');
  sink.writeln(
    '  --config <path>   Override config file path (default: orm.config.dart)',
  );
  sink.writeln('  --schema <path>   Override schema path from config.schema');
  sink.writeln('  --output <path>   Override output path from config.output');
  sink.writeln('');
  sink.writeln('Defaults from current working directory:');
  sink.writeln('  - config: orm.config.dart');
  sink.writeln(
    '  - schema: config.schema, or orm.schema.dart when config.schema is not set',
  );
  sink.writeln('');
  sink.writeln('Default output:');
  sink.writeln(
    '  - config.output, or lib/orm_client.g.dart when output is empty',
  );
}

final class _GenerateCliOptions {
  final String? configPath;
  final String? schemaPath;
  final String? outputPath;

  const _GenerateCliOptions({
    this.configPath,
    this.schemaPath,
    this.outputPath,
  });
}

final class _GenerateCliParseResult {
  final _GenerateCliOptions? options;
  final String? errorMessage;
  final bool helpRequested;

  const _GenerateCliParseResult._({
    this.options,
    this.errorMessage,
    this.helpRequested = false,
  });

  const _GenerateCliParseResult.success(_GenerateCliOptions options)
    : this._(options: options);

  const _GenerateCliParseResult.error(String errorMessage)
    : this._(errorMessage: errorMessage);

  const _GenerateCliParseResult.help() : this._(helpRequested: true);
}
