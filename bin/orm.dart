import 'dart:io';

import 'package:orm/generator_helper.dart';
import 'package:dart_style/dart_style.dart';
import 'package:orm/version.dart';
import 'package:path/path.dart';

import 'src/client/generate_client.dart';
import 'src/generate_dmmf.dart';
import 'src/types/generate_types.dart';
import 'src/write_dart_file.dart';

Future<void> main() async {
  final generator = Generator.stdio(stdin: stdin, stdout: stderr);

  generator.onManifest(manifest);
  generator.onGenerate(generate);

  await generator.listen();
}

Future<GeneratorManifest> manifest(GeneratorConfig config) async {
  return GeneratorManifest(
    prettyName: 'Prisma Dart Client',
    defaultOutput: 'prisma_client',
    version: 'v$version',
  );
}

Future<void> generate(GeneratorOptions options) async {
  final formatter = DartFormatter();

  await writeDartSpec(
    formatter: formatter,
    spec: generateDmmfLibrary(options.dmmf),
    path: join(options.generator.output!.value, 'dmmf.dart'),
  );

  await writeDartSpec(
    formatter: formatter,
    spec: generateTypesLibrary(options.dmmf),
    path: join(options.generator.output!.value, 'types.dart'),
  );

  await writeDartSpec(
    formatter: formatter,
    spec: generateClientLibrary(options.dmmf),
    path: join(options.generator.output!.value, 'client.dart'),
  );
}
