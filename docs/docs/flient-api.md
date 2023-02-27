## Fluent API

In Prisma client Dart, relationships are done using the Fluent API. This is significantly different from Prisma client JS/TS. Of course, this choice is also due to the limitations of the Dart language itself.

In Prisma, relations and additional statistics need to be done using the Fluent API.

### One to one

In the following example, we have a `User` model with a `Profile` model. The `Profile` model has a one-to-one relation with the `User` model.

```dart
final flent = prisma.user.findUniqueOrThrow(
  where: UserWhereUniqueInput(id: 1),
);

final profile = await flent.profile();
```

### One to many

In the following example, we have a `User` model with a `Post` model. The `Post` model has a one-to-many relation with the `User` model.

```dart
final flent = prisma.user.findUniqueOrThrow(
  where: UserWhereUniqueInput(id: 1),
);

final posts = await flent.posts();
```

### Count relation

In the following example, we have a `User` model with a `Post` model. The `Post` model has a one-to-many relation with the `User` model.

```dart

final flent = prisma.user.findUniqueOrThrow(
  where: UserWhereUniqueInput(id: 1),
);

final count = await flent.$count().posts();
```
