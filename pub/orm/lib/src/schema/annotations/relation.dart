import 'package:meta/meta.dart';

enum ReferenceAction { noAction, restrict, cascade, setNull, setDefault }

@immutable
final class Relation {
  /// Defines the name of the relationship. In an m-n-relation,
  /// it also determines the name of the underlying relation table.
  final String? name;

  /// Defines a custom name for the foreign key in the database.
  final String? map;

  /// A list of fields of the model on the other side of the relation
  final Iterable<String> references;

  /// A list of fields of the current model
  final Iterable<String>? fields;

  /// Defines the referential action to perform when a referenced
  /// entry in the referenced model is being deleted.
  final ReferenceAction? onDelete;

  /// Defines the referential action to perform when a referenced
  /// entry in the referenced model is being updated.
  final ReferenceAction? onUpdate;

  @literal
  const Relation({
    required this.references,
    this.name,
    this.map,
    this.fields,
    this.onDelete,
    this.onUpdate,
  });
}
