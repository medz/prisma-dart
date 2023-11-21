import 'dart:io';

import 'package:orm/generator_helper.dart';

import 'src/generate_types.dart';

Future<void> main() async {
  final generator = Generator.stdio(stdin: stdin, stdout: stderr);

  generator.onManifest(manifest);
  generator.onGenerate(generate);

  await generator.listen();
}

Future<GeneratorManifest> manifest(GeneratorConfig config) async {
  return GeneratorManifest(
    prettyName: 'Prisma Dart Client (binary)',
    defaultOutput: 'prisma_client',
    requiresEngines: [EngineType.queryEngine],
  );
}

Future<void> generate(GeneratorOptions options) async {
  final types = generateTypes(options.dmmf.schema);
}
