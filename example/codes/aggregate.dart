import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region 1
    final aggregate1 = await prisma.user.aggregate(
      select: AggregateUserSelect(
        $avg: PrismaUnion.$2(
          AggregateUserAvgArgs(
            select: UserAvgAggregateOutputTypeSelect(age: true),
          ),
        ),
      ),
    );
    print("Average age: ${aggregate1.$avg?.age}");
    // #endregion 1

    // #region 2
    final aggregate2 = await prisma.user.aggregate(
      select: AggregateUserSelect(
        $avg: PrismaUnion.$2(
          AggregateUserAvgArgs(
            select: UserAvgAggregateOutputTypeSelect(age: true),
          ),
        ),
      ),
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(contains: PrismaUnion.$1('hello')),
        ),
      ),
      take: 10,
    );
    print("Average age: ${aggregate2.$avg?.age}");
    // #endregion 2

    // #region 3
    await prisma.user.aggregate(
      select: AggregateUserSelect(
        $avg: PrismaUnion.$2(
          AggregateUserAvgArgs(
            select: UserAvgAggregateOutputTypeSelect(age: true),
          ),
        ),
        $count: PrismaUnion.$2(
          AggregateUserCountArgs(
            select: UserCountAggregateOutputTypeSelect(age: true),
          ),
        ),
      ),
    );
    // #endregion 3

    // #region 4
    await prisma.user.groupBy(
      by: PrismaUnion.$1([
        UserScalar.country,
      ]),
      select: UserGroupByOutputTypeSelect(
        country: true,
        $sum: PrismaUnion.$2(
          UserGroupByOutputTypeSumArgs(
            select: UserSumAggregateOutputTypeSelect(
              profileViews: true,
            ),
          ),
        ),
      ),
    );
    // #endregion 4

    // #region 5
    await prisma.user.groupBy(
      by: PrismaUnion.$2(UserScalar.country),
    );
    // #endregion 5

    // #region 6
    await prisma.user.groupBy(
      by: PrismaUnion.$1([
        UserScalar.country,
      ]),
      select: UserGroupByOutputTypeSelect(
        country: true,
        $sum: PrismaUnion.$2(
          UserGroupByOutputTypeSumArgs(
            select: UserSumAggregateOutputTypeSelect(
              profileViews: true,
            ),
          ),
        ),
      ),
      // [!code focus:6]
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(contains: PrismaUnion.$1('test')),
        ),
      ),
    );
    // #endregion 6

    // #region 7
    await prisma.user.groupBy(
      by: PrismaUnion.$1([
        UserScalar.country,
      ]),
      select: UserGroupByOutputTypeSelect(
        country: true,
        $sum: PrismaUnion.$2(
          UserGroupByOutputTypeSumArgs(
            select: UserSumAggregateOutputTypeSelect(
              profileViews: true,
            ),
          ),
        ),
      ),
      // [!code focus:10]
      having: UserScalarWhereWithAggregatesInput(
        profileViews: PrismaUnion.$1(
          IntWithAggregatesFilter(
            $avg: NestedFloatFilter(
              gt: PrismaUnion.$1(100),
            ),
          ),
        ),
      ),
    );
    // #endregion 7

    // #region 8
    await prisma.user.groupBy(
      by: PrismaUnion.$1([UserScalar.city]),
      select: UserGroupByOutputTypeSelect(
        city: true,
        $count: PrismaUnion.$2(
          UserGroupByOutputTypeCountArgs(
            select: UserCountAggregateOutputTypeSelect(
              city: true,
            ),
          ),
        ),
      ),
      orderBy: PrismaUnion.$2(
        UserOrderByWithAggregationInput(
          $count: UserCountOrderByAggregateInput(
            city: SortOrder.desc,
          ),
        ),
      ),
    );
    // #endregion 8

    // #region 9
    await prisma.user.groupBy(
      by: PrismaUnion.$1([UserScalar.country]),
      select: UserGroupByOutputTypeSelect(
        country: true,
        $sum: PrismaUnion.$2(
          UserGroupByOutputTypeSumArgs(
            select: UserSumAggregateOutputTypeSelect(
              profileViews: true,
            ),
          ),
        ),
      ),
      orderBy: PrismaUnion.$2(
        UserOrderByWithAggregationInput(
          $count: UserCountOrderByAggregateInput(
            country: SortOrder.desc,
          ),
        ),
      ),
      take: 2,
      skip: 2,
    );
    // #endregion 9
  });
}
