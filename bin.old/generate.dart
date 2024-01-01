import 'dart:async';
import 'dart:io';

// import 'package:dart_style/dart_style.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/version.dart';
import 'package:path/path.dart';

import 'generate/client.dart';

void main() async {
  final app = Generator.stdio(stdin: stdin, stdout: stderr);

  app.onManifest(manifest);
  app.onGenerate(generate);

  await app.listen();
}

Future<GeneratorManifest> manifest(GeneratorConfig config) async {
  return GeneratorManifest(
    prettyName: 'Prisma Dart Client',
    defaultOutput: 'prisma_client',
    version: 'v$version',
  );
}

Future<void> generate(GeneratorOptions options) async {
  if (options.generator.output == null) {
    return print('No output directory specified');
  }

  final client = Client(options);
  await client.generate();

  final libraries = [
    ('client.dart', client.client.build()),
    ('model.dart', client.model.build()),
    ('prisma.dart', client.prisma.build()),
  ];

  final formatter = DartFormatter();
  for (final (path, library) in libraries) {
    final emitter = DartEmitter.scoped(
      useNullSafetySyntax: true,
      orderDirectives: true,
    );
    final file =
        await File(join(options.generator.output!.value, path)).autoCreate();
    final code = formatter.format(library.accept(emitter).toString());

    await file.writeAsString(code);
  }
}

extension on File {
  Future<File> autoCreate() async {
    if (await exists()) {
      return this;
    }

    return create(recursive: true);
  }
}
