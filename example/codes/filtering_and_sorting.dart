import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region 1
    await prisma.user.findMany(
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(endsWith: PrismaUnion.$1('@odroe.com')),
        ),
        posts: PostListRelationFilter(
          some: PostWhereInput(
            published: PrismaUnion.$2(true),
          ),
        ),
      ),
      include: UserInclude(
        posts: PrismaUnion.$2(
          UserPostsArgs(
            where: PostWhereInput(
              published: PrismaUnion.$2(true),
            ),
          ),
        ),
      ),
    );
    // #endregion 1

    // #region 2
    await prisma.post.findMany(
      where: PostWhereInput(
        content: PrismaUnion.$2(
          PrismaUnion.$2(const PrismaNull()),
        ),
      ),
    );
    // #endregion 2

    // #region 3
    await prisma.post.findMany(
      where: PostWhereInput(
        content: PrismaUnion.$1(
          StringNullableFilter(
            not: PrismaUnion.$2(
              PrismaUnion.$2(const PrismaNull()),
            ),
          ),
        ),
      ),
    );
    // #endregion 3

    // #region 4
    await prisma.user.findMany(
      where: UserWhereInput(
        posts: PostListRelationFilter(
          some: PostWhereInput(
            views: PrismaUnion.$1(
              IntFilter(gt: PrismaUnion.$1(10)),
            ),
          ),
        ),
      ),
    );
    // #endregion 4

    // #region 5
    await prisma.post.findMany(
      where: PostWhereInput(
        author: PrismaUnion.$2(
          PrismaUnion.$1(
            UserWhereInput(
              email: PrismaUnion.$1(
                StringFilter(contains: PrismaUnion.$1('odroe.com')),
              ),
            ),
          ),
        ),
      ),
    );
    // #endregion 5

    // #region 6
    await prisma.post.findMany(
      where: PostWhereInput(
        tags: StringNullableListFilter(
          has: PrismaUnion.$1('databases'), // [!code focus]
        ),
      ),
    );
    // #endregion 6

    // #region 7
    await prisma.user.findMany(
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(
            endsWith: PrismaUnion.$1('@odroe.com'),
            mode: QueryMode.insensitive, // [!code focus]
          ),
        ),
        name: PrismaUnion.$1(
          StringNullableFilter(
            equals: // [!code focus]
                PrismaUnion.$1('Seven Odroe'), // Default mode // [!code focus]
          ),
        ),
      ),
    );
    // #endregion 7

    // #region 8
    await prisma.user.findMany(
      orderBy: PrismaUnion.$1([
        UserOrderByWithRelationInput(role: SortOrder.desc),
        UserOrderByWithRelationInput(
          name: PrismaUnion.$1(SortOrder.desc),
        ),
      ]),
      include: UserInclude(
        posts: PrismaUnion.$2(
          UserPostsArgs(
            orderBy: PrismaUnion.$2(
              PostOrderByWithRelationInput(title: SortOrder.desc),
            ),
            select: PostSelect(title: true),
          ),
        ),
      ),
    );
    // #endregion 8

    // #region 9
    await prisma.post.findMany(
      orderBy: PrismaUnion.$2(
        PostOrderByWithRelationInput(
          author: UserOrderByWithRelationInput(
            email: SortOrder.asc,
          ),
        ),
      ),
    );
    // #endregion 9

    // #region 10
    await prisma.user.findMany(
      take: 10,
      orderBy: PrismaUnion.$2(
        UserOrderByWithRelationInput(
          posts: PostOrderByRelationAggregateInput(
            $count: SortOrder.desc,
          ),
        ),
      ),
    );
    // #endregion 10
  });
}
