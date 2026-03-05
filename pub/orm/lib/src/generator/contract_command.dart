import 'dart:io';

import 'config_loader.dart';
import 'contract_emitter.dart';
import 'error.dart';
import 'schema_loader.dart';

const _defaultContractOutputPath = 'orm.contract.json';

int runContractEmitCommand({
  Directory? cwd,
  IOSink? out,
  IOSink? err,
  String? configPath,
  String? schemaPath,
  String? outputPath,
}) {
  final workingDirectory = cwd ?? Directory.current;
  final output = out ?? stdout;
  final error = err ?? stderr;

  try {
    final config = loadGeneratorConfig(
      cwd: workingDirectory,
      configPath: configPath,
      schemaOverridePath: schemaPath,
    );
    final schema = loadSchema(cwd: workingDirectory, config: config);
    final outputFile = _resolveOutputFile(
      cwd: workingDirectory,
      outputPath: outputPath,
    );

    final emitted = emitContractArtifact(schema: schema);
    outputFile.parent.createSync(recursive: true);
    outputFile.writeAsStringSync(emitted);

    output.writeln('Emitted contract artifact: ${outputFile.path}');
    return 0;
  } on GeneratorException catch (exception) {
    error.writeln(exception.formatForCli());
    return 1;
  } catch (exception) {
    error.writeln('Contract emit failed: Unexpected error.');
    error.writeln(exception);
    return 1;
  }
}

File _resolveOutputFile({required Directory cwd, required String? outputPath}) {
  final normalizedOutput = outputPath?.trim();
  if (normalizedOutput != null && normalizedOutput.isEmpty) {
    throw GeneratorException(
      'Contract emit option --output requires a non-empty path.',
      hint: 'Pass a non-empty file path to --output.',
    );
  }

  final configuredOutput = normalizedOutput ?? _defaultContractOutputPath;
  final configuredFile = File(configuredOutput);
  if (configuredFile.isAbsolute) {
    return configuredFile;
  }
  return File(_join(cwd.path, configuredOutput));
}

String _join(String base, String child) {
  if (base.endsWith(Platform.pathSeparator)) {
    return '$base$child';
  }
  return '$base${Platform.pathSeparator}$child';
}
