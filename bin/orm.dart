import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:orm/generator_helper.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart';

import 'src/client/generate_client.dart';
import 'src/generate_dmmf.dart';
import 'src/types/generate_types.dart';

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

Future<void> writeDartSpec({
  required DartFormatter formatter,
  required Spec spec,
  required String path,
}) async {
  final emitter = DartEmitter.scoped(
    useNullSafetySyntax: true,
    orderDirectives: true,
  );

  final file = File(path)..autoCreateSync();
  final dartSource = formatter.format('${spec.accept(emitter)}');

  await file.writeAsString(dartSource);
}

extension on File {
  void autoCreateSync() {
    if (existsSync()) return;

    createSync(recursive: true);
  }
}
