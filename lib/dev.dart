import 'src/generator_helper/create_generator.dart';

final generator = createGenerator(
  onManifest: (c) => 2,
  onGenerate: (o) => 1,
);

Future<void> main() => generator();
