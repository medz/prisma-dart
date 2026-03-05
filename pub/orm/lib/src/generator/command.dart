import 'dart:io';

import 'client_emitter.dart';
import 'config_loader.dart';
import 'error.dart';
import 'schema_loader.dart';

int runGenerateCommand({Directory? cwd, IOSink? out, IOSink? err}) {
  final workingDirectory = cwd ?? Directory.current;
  final output = out ?? stdout;
  final error = err ?? stderr;

  try {
    final config = loadGeneratorConfig(cwd: workingDirectory);
    final schema = loadSchema(cwd: workingDirectory, config: config);
    final outputFile = _resolveOutputFile(
      cwd: workingDirectory,
      configuredOutputPath: config.outputPath,
    );

    final schemaImportPath = _relativeImportPath(
      fromDirectoryPath: outputFile.parent.path,
      targetFilePath: schema.schemaFile.path,
    );

    final generated = emitTypedClient(
      schema: schema,
      schemaImportPath: schemaImportPath,
    );

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

String _relativeImportPath({
  required String fromDirectoryPath,
  required String targetFilePath,
}) {
  final fromSegments = _pathSegments(fromDirectoryPath);
  final targetSegments = _pathSegments(targetFilePath);

  var commonLength = 0;
  while (commonLength < fromSegments.length &&
      commonLength < targetSegments.length &&
      fromSegments[commonLength] == targetSegments[commonLength]) {
    commonLength += 1;
  }

  final upwardCount = fromSegments.length - commonLength;
  final segments = <String>[
    ...List<String>.filled(upwardCount, '..'),
    ...targetSegments.sublist(commonLength),
  ];

  if (segments.isEmpty) {
    return './${File(targetFilePath).uri.pathSegments.last}';
  }

  return segments.join('/');
}

List<String> _pathSegments(String path) {
  final normalized = path.replaceAll('\\', '/');
  return normalized.split('/').where((segment) => segment.isNotEmpty).toList();
}

String _join(String base, String child) {
  if (base.endsWith(Platform.pathSeparator)) {
    return '$base$child';
  }
  return '$base${Platform.pathSeparator}$child';
}
