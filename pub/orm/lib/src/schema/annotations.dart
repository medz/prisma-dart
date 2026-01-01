import 'package:meta/meta_meta.dart';

// ============================================
// Model Annotations
// ============================================

/// Model annotation for defining database models.
///
/// ```dart
/// @Model()
/// class User {
///   @ID()
///   external int id;
///
///   external String email;
/// }
/// ```
@Target({TargetKind.classType})
class Model {
  /// The map of the model in the database.
  /// If not specified, uses the class name.
  final String? map;

  const Model({this.map});
}

/// Model fragment for reusable field groups.
///
/// ```dart
/// @Fragment()
/// class Timestamps {
///   external DateTime createdAt;
///
///   @UpdatedAt()
///   external DateTime updatedAt;
/// }
///
/// @Model()
/// class User extends Timestamps {
///   @ID()
///   external int id;
/// }
/// ```
@Target({TargetKind.classType})
class Fragment {
  const Fragment();
}

/// Ignore annotation for models or fields.
///
/// Can be used on classes to ignore entire models,
/// or on fields to exclude them from generation.
///
/// ```dart
/// @Ignore()
/// @Model()
/// class TempModel {  // Entire model ignored
///   external int id;
/// }
///
/// @Model()
/// class User {
///   @ID()
///   external int id;
///
///   @Ignore()
///   external String? tempData;  // Field ignored
/// }
/// ```
@Target({TargetKind.classType, TargetKind.getter, TargetKind.field})
class Ignore {
  const Ignore();
}

// ============================================
// Field Annotations
// ============================================

/// Primary key annotation.
///
/// ```dart
/// @Model()
/// class User {
///   @ID()
///   external int id;
/// }
///
/// @Model()
/// class Post {
///   @ID()
///   external String slug;  // Non-int primary key
/// }
/// ```
@Target({TargetKind.getter, TargetKind.field})
class ID {
  const ID();
}

/// Unique constraint annotation.
///
/// ```dart
/// @Model()
/// class User {
///   @ID()
///   external int id;
///
///   @Unique()
///   external String email;
/// }
/// ```
@Target({TargetKind.getter, TargetKind.field})
class Unique {
  const Unique();
}

/// Auto-updated timestamp annotation.
///
/// Automatically updates the field to current timestamp on record update.
///
/// ```dart
/// @Model()
/// class Post {
///   @ID()
///   external int id;
///
///   external DateTime createdAt;
///
///   @UpdatedAt()
///   external DateTime updatedAt;
/// }
/// ```
@Target({TargetKind.getter, TargetKind.field})
class UpdatedAt {
  const UpdatedAt();
}

/// Relation configuration for explicit foreign key mapping.
///
/// ```dart
/// @Model()
/// class Post {
///   @ID()
///   external int id;
///
///   @Relation(fields: ['authorId'], references: ['id'])
///   external User author;
///   external int authorId;
/// }
/// ```
@Target({TargetKind.getter, TargetKind.field})
class Relation {
  /// Foreign key fields in this model.
  final List<String>? fields;

  /// Referenced fields in the related model.
  final List<String>? references;

  const Relation({this.fields, this.references});
}
