import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final users = await prisma.user.findMany(
      include: UserInclude(
        posts: PrismaUnion.$2(
          UserPostsArgs(
            select: PostSelect(title: true),
          ),
        ),
      ),
    );
    // #endregion snippet

    print(users);
  });
}
