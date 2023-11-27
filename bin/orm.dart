/// Prisma Dart client generator
library prisma.generator;

import 'package:orm/prisma_generator_helper/prisma_generator_helper.dart';

import 'src/generator.dart';

Future<void> main() async {
  final client = PrismaDartClientGenerator();

  await generator(client);
}
