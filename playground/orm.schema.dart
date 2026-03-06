import 'package:orm/schema.dart';

@model
typedef User = ({
  @id String id,
  String email,
  DateTime createdAt,
  DateTime updatedAt,

  @Relation() List<Post> posts,
});

@model
typedef Post = ({
  @id String id,
  String title,
  String content,
  String authorId,

  DateTime createdAt,
  DateTime updatedAt,

  @Relation(fields: {'authorId'}) User author,
});
