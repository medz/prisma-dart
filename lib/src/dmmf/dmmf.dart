import 'ast/datamodel.dart';
import 'ast/mappings.dart';
import 'ast/schema.dart';

/// Prisma data model meta format(DMMF).
class DMMF {
  /// The Data model AST
  final DataModel datamodel;

  /// The query engine API schema.
  final Schema schema;

  /// The operations map. Derived from the [schema].
  final Mappings mappings;

  const DMMF({
    required this.datamodel,
    required this.schema,
    required this.mappings,
  });

  factory DMMF.fromJson(Map json) {
    return DMMF(
      datamodel: DataModel.fromJson(json['datamodel']),
      schema: Schema.fromJson(json['schema']),
      mappings: Mappings.fromJson(json['mappings']),
    );
  }
}
