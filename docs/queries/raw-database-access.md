# Raw database access

Although the model delegate API of Prisma Dart Client covers most database operations, in certain cases, you may need to directly access the database to perform SQL dialect-specific operations.

In the Prisma Dart Client, you access the `$raw` property to get a Raw Client instance of the current database connection. This client provides the following two methods:

- `$raw.query`
- `$raw.execute`

## `$raw.query`

Execute a raw query, for example:

```dart
final result = await prisma.$raw.query('SELECT * FROM "User"'); // PostgreSQL
```

## `$raw.execute`

Execute a raw query, for example:

```dart
final result = await prisma.$raw.execute('DELETE FROM "User"'); // PostgreSQL
```

## Parameters

`$raw.query` and `$raw.execute` support parameters, for example:

```dart
// PostgreSQL
final result = await prisma.$raw.query(
  'SELECT * FROM "User" WHERE "id" = \$1',
  [1],
);

// MySQL
final result = await prisma.$raw.query(
  'SELECT * FROM `User` WHERE `id` = ?',
  [1],
);
```

::: tip

SQL template strings vary depending on the database you are using, you should consult the documentation of the database you are using for details on the SQL dialect.

:::
