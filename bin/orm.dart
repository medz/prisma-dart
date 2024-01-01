import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/version.dart';
import 'package:path/path.dart';

import 'src/generator.dart';

void main() async {
  final app = GeneratorApp.stdio(stdin: stdin, stdout: stderr);
  app.onManifest(manifest);
  app.onGenerate(generate);

  await app.listen();
}

Future<GeneratorManifest> manifest(GeneratorConfig config) async {
  return GeneratorManifest(
    prettyName: 'Prisma Dart Client',
    defaultOutput: 'generated_dart_client',
    version: 'v$version',
  );
}

Future<void> generate(GeneratorOptions options) async {
  if (options.generator.output == null) {
    throw StateError('No output directory specified');
  }

  final generator = Generator(options);
  final libraries = generator.generate();
  final formatter = DartFormatter();

  for (final (filename, library) in libraries) {
    final emitter = DartEmitter.scoped(
      useNullSafetySyntax: true,
      orderDirectives: true,
    );
    final source = library.accept(emitter);
    final formated = formatter.format(source.toString());
    final output = await File(join(options.generator.output!.value, filename))
        .autoCreate();

    await output.writeAsString(formated);
  }
}

extension on File {
  Future<File> autoCreate() async {
    if (await exists()) {
      return this;
    }

    await parent.create(recursive: true);
    return create();
  }
}
