import 'src/datamodel.dart';
import 'src/mappings.dart';
import 'src/schema.dart';

/// Prisma data model meta format(DMMF).
class DMMF {
  /// The Data model AST
  final DataModel datamodel;

  /// The query engine API schema.
  final Schema schema;

  /// The operations map. Derived from the [schema].
  final Mappings mappings;

  /// The DMMF source.
  final Map<String, dynamic> source;

  const DMMF({
    required this.datamodel,
    required this.schema,
    required this.mappings,
    required this.source,
  });

  factory DMMF.fromJson(Map json) {
    return DMMF(
      datamodel: DataModel.fromJson(json['datamodel']),
      schema: Schema.fromJson(json['schema']),
      mappings: Mappings.fromJson(json['mappings']),
      source: json.cast(),
    );
  }
}
