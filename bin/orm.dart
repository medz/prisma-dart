/// Prisma Dart client generator
library prisma.generator;

import 'package:prisma_generator_helper/prisma_generator_helper.dart';

import 'src/generator.dart';

Future<void> main() => generator(PrismaDartClientGenerator());
