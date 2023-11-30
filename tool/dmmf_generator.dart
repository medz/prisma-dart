import 'dart:convert';
import 'dart:io';

import 'package:orm/generator_helper.dart';

Future<void> main() async {
  final generator = Generator.stdio(stdin: stdin, stdout: stderr);

  generator.onManifest(manifest);
  generator.onGenerate(generate);

  await generator.listen();
}

Future<GeneratorManifest> manifest(GeneratorConfig config) async {
  return GeneratorManifest(
    prettyName: 'Prisma DMMF',
    defaultOutput: 'dmmf.json',
  );
}

Future<void> generate(GeneratorOptions options) async {
  final dmmf = File(options.generator.output!.value);
  if (dmmf.existsSync()) {
    await dmmf.delete();
  }

  await dmmf.create(recursive: true);
  await dmmf.writeAsString(json.encode(options.dmmf.source));
}
