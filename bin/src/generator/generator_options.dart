import 'package:orm/dmmf.dart';
import 'package:orm/generator_helper.dart';

/// Generator preview features.
enum GeneratorPreviewFeatures {
  /// Finalizer
  finalizer(
      'finalizer', 'Enable finalizer feature for generated PrismaClient.'),

  /// Prisma client `$on` method.
  logging('logging', r'Enable `$on` method for generated PrismaClient.');

  /// Create a new [GeneratorPreviewFeatures] instace.
  const GeneratorPreviewFeatures(this.name, this.description);

  /// Preview features description.
  final String description;

  /// Preview features name.
  final String name;

  /// Resolve [GeneratorPreviewFeatures] from [name].
  static GeneratorPreviewFeatures fromName(String name) {
    return GeneratorPreviewFeatures.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
    );
  }

  /// Resolve [GeneratorPreviewFeatures] from [names].
  static Iterable<GeneratorPreviewFeatures> fromNames(List<String> names) {
    return names.map((e) => fromName(e)).toList();
  }
}

class GeneratorOptions {
  /// Generator preview features.
  final Iterable<GeneratorPreviewFeatures> previewFeatures;

  /// Schema DMMF document
  final Document dmmf;

  /// Generator config.
  final GeneratorConfig config;

  /// Prisma schema path
  final String schemaPath;

  /// Data sources
  final List<DataSource> datasources;

  /// Prisma schema string
  final String schema;

  /// Query Engine version
  final String version;

  /// Query engine executable
  final String executable;

  /// Is data proxy.
  final bool dataProxy;

  /// Prisma client output path.
  final String output;

  const GeneratorOptions({
    required this.config,
    required this.dataProxy,
    required this.datasources,
    required this.dmmf,
    required this.executable,
    required this.schema,
    required this.schemaPath,
    required this.version,
    required this.output,
    this.previewFeatures = const [],
  });
}
