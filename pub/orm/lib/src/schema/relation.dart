import 'package:meta/meta.dart';

/// Actions for referential integrity on update/delete.
enum ReferenceAction {
  /// Do not perform any action.
  noAction,

  /// Reject the update/delete if dependent rows exist.
  restrict,

  /// Propagate the update/delete to dependent rows.
  cascade,

  /// Set the foreign key to NULL.
  setNull,

  /// Set the foreign key to its default value.
  setDefault,
}

/// Annotation describing a relation between models.
@immutable
final class Relation {
  /// Defines the name of the relationship. In an m-n-relation,
  /// it also determines the name of the underlying relation table.
  final String? name;

  /// Defines a custom name for the foreign key in the database.
  final String? map;

  /// A list of fields of the model on the other side of the relation
  final Set<String> references;

  /// A list of fields of the current model
  final Set<String>? fields;

  /// Defines the referential action to perform when a referenced
  /// entry in the referenced model is being deleted.
  final ReferenceAction? onDelete;

  /// Defines the referential action to perform when a referenced
  /// entry in the referenced model is being updated.
  final ReferenceAction? onUpdate;

  @literal
  /// Creates a relation annotation describing a model relationship.
  const Relation({
    required this.references,
    this.name,
    this.map,
    this.fields,
    this.onDelete,
    this.onUpdate,
  });
}
