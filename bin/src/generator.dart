import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:orm/generator_helper.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

import 'generate_client.dart';

final generator = createGenerator(
  onManifest: (config) {
    return GeneratorManifest(
      prettyName: 'Prisma Dart Client',
      defaultOutput: '../lib/src/generated/prisma_client',
    );
  },
  onGenerate: (options) {
    final output = options.generator.output?.value;
    if (output == null) {
      throw Exception('No output path provided');
    }

    if (Directory(output).existsSync()) {
      Directory(output).deleteSync(recursive: true);
    }

    final Map<Reference, Library> libraries = generateClient(options);
    final formater = DartFormatter();

    for (final MapEntry(key: reference, value: library) in libraries.entries) {
      final emitter = DartEmitter.scoped(useNullSafetySyntax: true);
      final code = library.accept(emitter).toString();
      final filename = reference.url != null
          ? Uri.parse(reference.url!).path
          : '${reference.symbol!.snakeCase}.dart';

      final file = File(join(output, filename));
      if (file.existsSync()) {
        file.deleteSync();
      }
      file.createSync(recursive: true);
      file.writeAsStringSync(formater.format(code));
    }
  },
);
