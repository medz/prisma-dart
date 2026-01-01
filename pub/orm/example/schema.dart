// example/schema.dart
// This file is purely declarative and does not participate in runtime logic.
// It's similar to Prisma schema but written in Dart.
import 'package:orm/schema.dart';

// ============================================
// Reusable Fragments
// ============================================

@Fragment()
class Timestamps {
  external DateTime createdAt;

  @UpdatedAt()
  external DateTime updatedAt;
}

// ============================================
// Models
// ============================================

@Model()
class User extends Timestamps {
  @ID()
  external int id;

  @Unique()
  external String email;

  external String? name;
  external String? avatar;

  // Default values using getters
  String get role => 'user';
  bool get isActive => true;

  // One-to-many relationships (type inference)
  external List<Post> posts;
  external List<Comment> comments;

  // One-to-one relationship
  external Profile? profile;
}

@Model()
class Profile {
  @ID()
  external int id;

  external String? bio;
  external String? website;

  // Explicit relation configuration
  @Relation(fields: ['userId'], references: ['id'])
  external User user;
  external int userId;
}

@Model()
class Post extends Timestamps {
  @ID()
  external int id;

  external String title;
  external String content;

  bool get published => false;

  // Author relationship
  @Relation(fields: ['authorId'], references: ['id'])
  external User author;
  external int authorId;

  // Many-to-many relationships
  external List<Category> categories;
  external List<Comment> comments;

  @Ignore()
  external String? tempData; // Not generated in client
}

@Model()
class Comment extends Timestamps {
  @ID()
  external int id;

  external String content;

  @Relation(fields: ['authorId'], references: ['id'])
  external User author;
  external int authorId;

  @Relation(fields: ['postId'], references: ['id'])
  external Post post;
  external int postId;
}

@Model()
class Category {
  @ID()
  external int id;

  @Unique()
  external String name;

  external String? description;

  // Many-to-many
  external List<Post> posts;
}

// ============================================
// Composite Primary Key Example
// ============================================

@Model()
class PostCategory {
  @ID()
  external int postId;

  @ID()
  external int categoryId;

  external Post post;
  external Category category;

  DateTime get assignedAt => DateTime.now();
}

// ============================================
// Enum Support
// ============================================

enum Role { user, admin, moderator }

@Model()
class Admin {
  @ID()
  external int id;

  external String email;
  external Role role; // Enum type
}

// ============================================
// Ignored Model Example
// ============================================

@Ignore()
@Model()
class TempModel {
  @ID()
  external int id;

  external String data;
}
