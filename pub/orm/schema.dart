import 'package:orm/schema.dart';

const public = Schema('public');

@public
@model
typedef User = ({@ID() int id, String email});

@public
@model
typedef Post = ({
  @ID() int id,
  String title,
  int userId,
  @Relation(references: {'id', 'title', 'userId'}) User user,
});
