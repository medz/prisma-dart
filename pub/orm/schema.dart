import 'package:orm/schema.dart';

const public = Schema('public');

@public
@model
typedef User = ({@id int id, String email});

@public
@model
typedef Post = ({
  @id int id,
  String title,
  int userId,
  @Relation(references: {"userId"}) User user,
});
