// ignore_for_file: file_names

import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) => providePrisma((prisma) async {
      // #region relation-count
      final relationCount = await prisma.user.findMany(
        include: UserInclude(
          $count: PrismaUnion.$2(
            UserCountArgs(
              select: UserCountOutputTypeSelect(posts: true),
            ),
          ),
        ),
      );
      // #endregion relation-count
      print(relationCount);

      // #region filter-list-of-relations
      final filterListOfRelations = await prisma.user.findFirst(
        select: UserSelect(
          posts: PrismaUnion.$2(
            UserPostsArgs(
              where: PostWhereInput(
                published: PrismaUnion.$2(false),
              ),
              orderBy: PrismaUnion.$2(
                PostOrderByWithRelationInput(
                  title: SortOrder.asc,
                ),
              ),
              select: PostSelect(title: true),
            ),
          ),
        ),
      );
      // #endregion filter-list-of-relations
      print(filterListOfRelations);

      // #region filter-list-of-relations-include
      final filterListOfRelationsInclude = await prisma.user.findFirst(
        include: UserInclude(
          posts: PrismaUnion.$2(
            UserPostsArgs(
              where: PostWhereInput(
                published: PrismaUnion.$2(false),
              ),
              orderBy: PrismaUnion.$2(
                PostOrderByWithRelationInput(
                  title: SortOrder.asc,
                ),
              ),
            ),
          ),
        ),
      );
      // #endregion filter-list-of-relations-include
      print(filterListOfRelationsInclude);

      // #region create-a-related-record
      final createRelatedRecord = await prisma.user.create(
        data: PrismaUnion.$1(
          UserCreateInput(
            email: "elsa@examole.com",
            name: PrismaUnion.$1("Elsa"),
            posts: PostCreateNestedManyWithoutAuthorInput(
              create: PrismaUnion.$2(
                PrismaUnion.$1([
                  PostCreateWithoutAuthorInput(
                    title: "Join the Resistance",
                  ),
                  PostCreateWithoutAuthorInput(
                    title: "Join the Resistance 2",
                  ),
                ]),
              ),
            ),
          ),
        ),
        include: UserInclude(
          posts: PrismaUnion.$1(true),
        ),
      );
      // #endregion create-a-related-record
      print(createRelatedRecord);

      // #region code1
      await prisma.user.create(
        data: PrismaUnion.$1(
          UserCreateInput(
            email: "vv@prisma.pub",
            name: PrismaUnion.$1("Vivian"),
            posts: PostCreateNestedManyWithoutAuthorInput(
              create: PrismaUnion.$2(
                PrismaUnion.$1([
                  PostCreateWithoutAuthorInput(
                    title: "Join the Resistance",
                    categories: CategoryCreateNestedManyWithoutPostsInput(
                      create: PrismaUnion.$1(
                        CategoryCreateWithoutPostsInput(name: "Easy cooking"),
                      ),
                    ),
                  ),
                  PostCreateWithoutAuthorInput(
                    title: "Join the Resistance 2",
                  ),
                ]),
              ),
            ),
          ),
        ),
        include: UserInclude(
          posts: PrismaUnion.$2(
            UserPostsArgs(
              include: PostInclude(
                categories: PrismaUnion.$1(true),
              ),
            ),
          ),
        ),
      );
      // #endregion code1

      // #region code2
      await prisma.user.create(
        data: PrismaUnion.$1(
          UserCreateInput(
            email: "saanvi@examole.com",
            posts: PostCreateNestedManyWithoutAuthorInput(
              createMany: PostCreateManyAuthorInputEnvelope(
                data: PrismaUnion.$2([
                  PostCreateManyAuthorInput(title: "My first post"),
                  PostCreateManyAuthorInput(title: "My second post"),
                ]),
              ),
            ),
          ),
        ),
        include: UserInclude(
          posts: PrismaUnion.$1(true),
        ),
      );
      // #endregion code2

      // #region code3
      await prisma.user.createMany(
        data: PrismaUnion.$2([
          UserCreateManyInput(
            email: "yewande@a.com",
            name: PrismaUnion.$1("Yewande"),
            // posts: ... // Not possible to create posts! Type-safe, not `posts` field on `UserCreateManyInput`
          ),
          UserCreateManyInput(
            email: "noor@a.com",
            name: PrismaUnion.$1("Noor"),
            // posts: ... // Not possible to create posts! Type-safe, not `posts` field on `UserCreateManyInput`
          ),
        ]),
      );
      // #endregion code3

      // #region code4
      await prisma.user.create(
        data: PrismaUnion.$1(
          UserCreateInput(
            email: 'vlad@prisma.pub',
            posts: PostCreateNestedManyWithoutAuthorInput(
              connect: PrismaUnion.$2([
                PostWhereUniqueInput(id: 1),
                PostWhereUniqueInput(id: 2),
                PostWhereUniqueInput(id: 3),
                // ... More `PostWhereUniqueInput` objects
              ]),
            ),
          ),
        ),
        include: UserInclude(
          posts: PrismaUnion.$1(true),
        ),
      );
      // #endregion code4

      // #region code5
      await prisma.user.update(
        where: UserWhereUniqueInput(id: 9),
        data: PrismaUnion.$1(
          UserUpdateInput(
            posts: PostUpdateManyWithoutAuthorNestedInput(
              connect: PrismaUnion.$1(
                PostWhereUniqueInput(id: 11),
              ),
            ),
          ),
        ),
        include: UserInclude(
          posts: PrismaUnion.$1(true),
        ),
      );
      // #endregion code5

      // #region code6
      await prisma.post.create(
        data: PrismaUnion.$1(
          PostCreateInput(
            title: "My first post",
            author: UserCreateNestedOneWithoutPostsInput(
              connectOrCreate: UserCreateOrConnectWithoutPostsInput(
                where: UserWhereUniqueInput(email: "viola@prisma.io"),
                create: PrismaUnion.$1(
                  UserCreateWithoutPostsInput(
                    email: "viola@prisma.io",
                    name: PrismaUnion.$1("Viola"),
                  ),
                ),
              ),
            ),
          ),
        ),
        include: PostInclude(
          author: PrismaUnion.$1(true),
        ),
      );
      // #endregion code6

      // #region code7
      await prisma.user.update(
        where: UserWhereUniqueInput(id: 10),
        data: PrismaUnion.$1(
          UserUpdateInput(
            posts: PostUpdateManyWithoutAuthorNestedInput(
              disconnect: PrismaUnion.$2([
                PostWhereUniqueInput(id: 11),
                PostWhereUniqueInput(id: 12),
              ]),
            ),
          ),
        ),
        include: UserInclude(
          posts: PrismaUnion.$1(true),
        ),
      );
      // #endregion code7

      // #region code8
      await prisma.post.update(
        where: PostWhereUniqueInput(id: 11),
        data: PrismaUnion.$1(
          PostUpdateInput(
            author: UserUpdateOneWithoutPostsNestedInput(
              disconnect: PrismaUnion.$1(true),
            ),
          ),
        ),
        include: PostInclude(
          author: PrismaUnion.$1(true),
        ),
      );
      // #endregion code8

      // #region code9
      await prisma.user.update(
        where: UserWhereUniqueInput(id: 10),
        data: PrismaUnion.$1(
          UserUpdateInput(
            posts: PostUpdateManyWithoutAuthorNestedInput(
              set: PrismaUnion.$2([]),
            ),
          ),
        ),
      );
      // #endregion code9

      // #region code10
      await prisma.user.update(
        where: UserWhereUniqueInput(id: 10),
        data: PrismaUnion.$1(
          UserUpdateInput(
            posts: PostUpdateManyWithoutAuthorNestedInput(
              deleteMany: PrismaUnion.$1(
                PostScalarWhereInput(),
              ),
            ),
          ),
        ),
      );
      // #endregion code10

      // #region code11
      await prisma.user.update(
        where: UserWhereUniqueInput(id: 10),
        data: PrismaUnion.$1(
          UserUpdateInput(
            posts: PostUpdateManyWithoutAuthorNestedInput(
              deleteMany: PrismaUnion.$1(
                PostScalarWhereInput(
                  published: PrismaUnion.$2(false),
                ),
              ),
            ),
          ),
        ),
      );
      // #endregion code11

      // #region code12
      await prisma.user.update(
        where: UserWhereUniqueInput(id: 10),
        data: PrismaUnion.$1(
          UserUpdateInput(
            posts: PostUpdateManyWithoutAuthorNestedInput(
              deleteMany: PrismaUnion.$2([
                PostScalarWhereInput(id: PrismaUnion.$2(11)),
                PostScalarWhereInput(id: PrismaUnion.$2(7)),
              ]),
            ),
          ),
        ),
      );
      // #endregion code12

      // #region code13
      await prisma.user.update(
        where: UserWhereUniqueInput(id: 10),
        data: PrismaUnion.$1(
          UserUpdateInput(
            posts: PostUpdateManyWithoutAuthorNestedInput(
              updateMany: PrismaUnion.$1(
                PostUpdateManyWithWhereWithoutAuthorInput(
                  where: PostScalarWhereInput(
                    published: PrismaUnion.$2(true),
                  ),
                  data: PrismaUnion.$1(
                    PostUpdateManyMutationInput(
                      published: PrismaUnion.$1(false),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      // #endregion code13

      // #region code14
      await prisma.user.findMany(
        where: UserWhereInput(
          posts: PostListRelationFilter(
            none: PostWhereInput(
              views: PrismaUnion.$1(
                IntFilter(gt: PrismaUnion.$1(100)),
              ),
            ),
            every: PostWhereInput(
              likes: PrismaUnion.$1(
                IntFilter(lte: PrismaUnion.$1(50)),
              ),
            ),
          ),
        ),
      );
      // #endregion code14

      // #region code15
      await prisma.post.findMany(
        where: PostWhereInput(
          author: PrismaUnion.$1(
            UserNullableRelationFilter(
              isNot: PrismaUnion.$1(
                UserWhereInput(
                  name: PrismaUnion.$2(
                    PrismaUnion.$1("Bob"),
                  ),
                ),
              ),
              $is: PrismaUnion.$1(
                UserWhereInput(
                  age: PrismaUnion.$1(
                    IntNullableFilter(
                      gt: PrismaUnion.$1(40),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      // #endregion code15

      // #region code16
      await prisma.user.findMany(
        where: UserWhereInput(
          posts: PostListRelationFilter(
            none: PostWhereInput(),
          ),
        ),
      );
      // #endregion code16

      // #region code17
      await prisma.post.findMany(
        where: PostWhereInput(
          author: PrismaUnion.$2(
            PrismaUnion.$2(const PrismaNull()),
          ),
        ),
      );
      // #endregion code17

      // #region code18
      await prisma.user.findMany(
        where: UserWhereInput(
          posts: PostListRelationFilter(
            some: PostWhereInput(),
          ),
        ),
      );
      // #endregion code18
    });
