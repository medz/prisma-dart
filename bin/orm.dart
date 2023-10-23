import 'dart:convert';
import 'dart:io';

import 'package:orm/generator_helper.dart';

final generator = createGenerator(
  onManifest: (config) => GeneratorManifest(
    prettyName: 'Prisma Dart Client',
    defaultOutput: '../lib/src/generated/prisma_client',
  ),
  onGenerate: (options) {
    File('dmmf.json').writeAsStringSync(
      json.encode(options.toJson()),
    );
  },
);

Future<void> main() => generator();
