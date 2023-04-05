# Transactions

Prisma (for Dart) only supports interactive transactions, Pass a function that can contain user code including Prisma Client queries, non-Prisma code and other control flow to be executed in a transaction.

## Interactive transactions

Interactive transactions are transactions that are executed in a single request. This means that you can use Prisma Client to execute queries inside the transaction.

### Example

The following example shows how to use interactive transactions:

```dart
final post = prisma.$transaction((prisma) async {
  // Create a post
  final post = await prisma.post.create({
    data: {
      title: 'Interactive transactions',
      content: 'This is an interactive transaction',
    },
  });

  // Update user posts count
  await prisma.user.update({
    where: { id: post.authorId },
    data: {
      posts: {
        increment: 1,
      },
    },
  });

  return post;
});
```

## Transaction API

Interaction transactions cannot achieve atomic transaction interaction, so we expose the following methods in the client:

- `$startTransaction()` - Starts a transaction
- `$commitTransaction()` - Commits a transaction
- `$rollbackTransaction()` - Rolls back a transaction

### Start a transaction

To start a transaction, use the `$startTransaction()` method:

```dart
final transaction = await prisma.$startTransaction();
```

### Commit a transaction

To commit a transaction, use the `$commitTransaction()` method:

```dart
await transaction.$commitTransaction();
```

### Rollback a transaction

To rollback a transaction, use the `$rollbackTransaction()` method:

```dart
await transaction.$rollbackTransaction();
```

### Example

The following example shows how to use the transaction API:

```dart
final transaction = await prisma.$startTransaction();

try {
  // Create a post
  final post = await transaction.post.create({
    data: PostCreateInput(
      title: 'Interactive transactions',
      content: 'This is an interactive transaction',
    ),
  });

  // Update user posts count
  await transaction.user.update({
    where: UserWhereUniqueInput(id: post.authorId),
    data: UserUpdateInput(
      posts: UserPostsInput(increment: 1),
    ),
  });

  await transaction.$commitTransaction();
} catch (e) {
  await transaction.$rollbackTransaction();
}
```
