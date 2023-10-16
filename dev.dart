import 'package:orm/src/generator_helper/create_generator.dart';
import 'package:orm/src/generator_helper/types.dart';

final generator = createGenerator(
  onManifest: (config) => GeneratorManifest(defaultOutput: 'demo'),
  onGenerate: (options) {
    print(options.toJson());
  },
);

Future<void> main() => generator();
