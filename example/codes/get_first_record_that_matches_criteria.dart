import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final user = await prisma.user.findFirst(
      where: UserWhereInput(
        posts: PostListRelationFilter(
          some: PostWhereInput(
            likes: PrismaUnion.$1(
              IntFilter(gt: PrismaUnion.$1(100)),
            ),
          ),
        ),
      ),
      orderBy: PrismaUnion.$2(
        UserOrderByWithRelationInput(id: SortOrder.desc),
      ),
    );
    // #endregion snippet

    print(user);
  });
}
