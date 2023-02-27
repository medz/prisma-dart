# Aggregation

Prisma client allows you to `aggregate` on the `int` fields (such as `Int` and `Float`) of your models.
The following query returns the average age of all users:

```dart
final age = prisma.user.aggregate().$avg().age();

print('Average age: $age');
```

You can combine aggregation with filtering and ordering. For example, the following query returns the average age of users:

- Ordered by `age` ascending
- Where email contains `prisma.pub`
- Limited to the 10 users

```dart
final agregate = prisma.user.aggregate(
  where: UserWhereInput(
    email: StringFilter( contains: 'prisma.pub' ),
  ),
  orderBy: [
    UserOrderByWithRelationInput(age: OrderByArg.asc)
  ],
  take: 10,
);

final age = await agregate.$avg().age();

print('Average age: $age');
```

## APIs

- `$avg()` - Returns the average Fluent API
- `$count()` - Returns the count Fluent API
- `$max()` - Returns the maximum Fluent API
- `$min()` - Returns the minimum Fluent API
- `$sum()` - Returns the sum Fluent API

