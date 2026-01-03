import 'package:orm/schema.dart';

const public = Schema('public');

@public
@model
abstract class User {
  int get id;
  String get email;
}

@public
@model
abstract class Post {
  @ID()
  int get id;

  String get title;

  int get userId;

  @Relation(references: {"userId"})
  User get user;
}
