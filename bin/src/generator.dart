import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:orm/generator_helper.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

import 'generate_client.dart';

const inlineOutputPath = '../lib/src/generated/prisma_client';
const packageOutputPath = 'client';

final generator = createGenerator(
  onManifest: (config) {
    return GeneratorManifest(
      prettyName: 'Prisma Dart Client',
      defaultOutput: config.config.outputPackageName == null
          ? inlineOutputPath
          : packageOutputPath,
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

    final Map<Reference, Library> libraries = {};
    generateClient(libraries, options);

    final package = options.generator.config.outputPackageName;
    // if (package != null) {
    //   Directory(join(output, 'lib', 'src')).createSync(recursive: true);
    // }

    final formater = DartFormatter();
    for (final MapEntry(key: reference, value: library) in libraries.entries) {
      final emitter = DartEmitter.scoped(useNullSafetySyntax: true);
      final code = library.accept(emitter).toString();
      final root = package != null ? join(output, 'lib', 'src') : output;
      final filename = reference.url != null
          ? Uri.parse(reference.url!).path
          : '${reference.symbol!.snakeCase}.dart';

      final file = File(join(root, filename));
      if (file.existsSync()) {
        file.deleteSync();
      }
      file.createSync(recursive: true);
      file.writeAsStringSync(formater.format(code));
    }
  },
);
