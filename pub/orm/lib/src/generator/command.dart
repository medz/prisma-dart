import 'dart:io';

import 'client_emitter.dart';
import 'config_loader.dart';
import 'error.dart';
import 'schema_loader.dart';

int runGenerateCommand({
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
      outputOverridePath: outputPath,
    );
    final schema = loadSchema(cwd: workingDirectory, config: config);
    final outputFile = _resolveOutputFile(
      cwd: workingDirectory,
      configuredOutputPath: config.outputPath,
    );

    final generated = emitTypedClient(schema: schema);

    outputFile.parent.createSync(recursive: true);
    outputFile.writeAsStringSync(generated);

    output.writeln('Generated typed client: ${outputFile.path}');
    return 0;
  } on GeneratorException catch (exception) {
    error.writeln(exception.formatForCli());
    return 1;
  } catch (exception) {
    error.writeln('Generate failed: Unexpected error.');
    error.writeln(exception);
    return 1;
  }
}

File _resolveOutputFile({
  required Directory cwd,
  required String configuredOutputPath,
}) {
  final configuredFile = File(configuredOutputPath);
  if (configuredFile.isAbsolute) {
    return configuredFile;
  }

  return File(_join(cwd.path, configuredOutputPath));
}

String _join(String base, String child) {
  if (base.endsWith(Platform.pathSeparator)) {
    return '$base$child';
  }
  return '$base${Platform.pathSeparator}$child';
}
