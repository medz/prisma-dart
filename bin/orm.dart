import 'package:orm/generator_helper.dart' hide Generator;

import 'src/generator.dart';

final generator = createGenerator(
  onManifest: (config) => GeneratorManifest(
    prettyName: 'Prisma Dart Client',
    defaultOutput: '../lib/src/generated/prisma_client',
  ),
  onGenerate: (options) => Generator(options).handle(),
);

Future<void> main() => generator();
