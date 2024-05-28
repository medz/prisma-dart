import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final user = await prisma.user.findFirst(
      select: UserSelect(
        name: true,
        posts: PrismaUnion.$2(
          UserPostsArgs(
            select: PostSelect(title: true),
          ),
        ),
      ),
    );
    // #endregion snippet

    print(user);
  });

  providePrisma((prisma) async {
    // #region select-only-nested-posts-title
    final user = await prisma.user.findFirst(
      include: UserInclude(
        posts: PrismaUnion.$2(
          UserPostsArgs(
            select: PostSelect(title: true),
          ),
        ),
      ),
    );
    // #endregion select-only-nested-posts-title

    print(user);
  });
}
