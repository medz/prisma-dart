# Grouping

Prisma client `groupBy` API allows you to group your data by a field or a combination of fields.

The following example groups all users by the `country` field and returns the total number of profile views for each country:

```dart
final groupsUsers = await prisma.user.groupBy(
  by: [UserScalarFieldEnum.country],
);

for (final group in groupsUsers) {
  print('Country: ${group.country}');
}
```

## Filter records with `where`

You can filter the records that are grouped by using the `where` argument:

```dart
final groupsUsers = await prisma.user.groupBy(
  by: [UserScalarFieldEnum.country],
  where: UserWhereInput(
    email: StringFilter( contains: 'prisma.pub' ),
  ),
);
```

## Filter groups with `having`

You can filter the groups that are returned by using the `having` argument:

```dart
final groupsUsers = await prisma.user.groupBy(
  by: [UserScalarFieldEnum.country],
  having: UserScalarWhereWithAggregatesInput(
    count: IntFilter( gt: 10 ),
  ),
);
```
