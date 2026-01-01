import 'package:orm/schema.dart';

@Schema()
mixin PublicSchema implements Schema {
  @override
  String get schema => 'public';
}

@Model()
abstract class User with PublicSchema {
  int get id;
  String get email;
}

@Model()
abstract class Post with PublicSchema {
  int get id;
  String get title;
  int get userId;

  @Relation<Post, User>(
    references: {.userId},
    onUpdate: .cascade,
    onDelete: .setNull,
  )
  User get user;
}
