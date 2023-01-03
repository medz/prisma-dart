import 'package:orm/dmmf.dart';
import 'package:orm/generator_helper.dart';

class GeneratorOptions {
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
  });
}
