import 'package:orm/schema.dart';

@model
typedef User = ({@id String id, String email});

@model
typedef Post = ({
  @id String id,
  String title,
  String content,
  String authorId,

  @Relation(fields: {'authorId'}) User author,
});
