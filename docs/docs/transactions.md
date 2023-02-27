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