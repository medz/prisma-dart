import 'dart:io';

import 'package:orm/generator_helper.dart';
import 'package:path/path.dart';

Future<void> main() async {
  final generator = Generator.stdio(stdin: stdin, stdout: stderr);

  generator.onManifest(manifest);
  generator.onGenerate(generate);

  await generator.listen();
}

Future<GeneratorManifest> manifest(GeneratorConfig config) async {
  return GeneratorManifest(
    prettyName: 'Prisma Binary',
    defaultOutput: join('prisma_client', 'prisma-query-engine'),
    requiresEngines: [EngineType.queryEngine],
  );
}

Future<void> generate(GeneratorOptions options) async {
  final path = options.binaryPaths.queryEngine?.entries.single.value;
  if (path == null) {
    throw Exception('No query engine binary found');
  }

  final output = options.generator.output!.value;

  await File(path).copy(output);
}
