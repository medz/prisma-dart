# Raw database access

Prisma Client supports the option of sending raw queries to your database. You may wish to use raw queries if:

- you want to run a heavily optimized query
- you require a feature that Prisma Client does not yet support

## Querying with raw SQL

The `$queryRaw` method allows you to send raw SQL queries to your database. The method returns a `dynamic` object, which contains the raw data returned by the database.

The following example shows how to use `$queryRaw` to query the `User` table:

```dart
final result = await prisma.$queryRaw('SELECT * FROM "User"');
```

The `result` object contains the raw data returned by the database. The data is returned as a list of maps, where each map represents a row in the result set.

```json
[
  {
    "id": "ck8q3z7x0000k0a99x0j9z8xu",
    "name": "Alice",
    "email": "alice@prisma.pub",
    "age": 42
  },
  {
    "id": "ck8q3z7x0000l0a99x0j9z8xv",
    "name": "Bob",
    "email": "bob@prisma.pub",
    "age": 69
  }
]
```

## Executing raw SQL

The `$executeRaw` method allows you to send raw SQL queries to your database. The method returns a `int` count of the number of rows affected by the query.

The following example shows how to use `$executeRaw` to delete all users from the `User` table:

```dart
final result = await prisma.$executeRaw('DELETE FROM "User"');
```

## Querying with raw database parameters

> **Note**: The example below uses PostgreSQL syntax.

The `$queryRaw` or `$executeRaw` method allows you to send raw SQL queries to your database. The method returns a `dynamic` object, which contains the raw data returned by the database.

The following example shows how to use `$queryRaw` to query the `User` table:

```dart

final result = await prisma.$queryRaw(
  r'SELECT * FROM "User" WHERE "name" = $1',
  ['Alice'],
);
```

The `result` object contains the raw data returned by the database. The data is returned as a list of maps, where each map represents a row in the result set.

```json
[
  {
    "id": "ck8q3z7x0000k0a99x0j9z8xu",
    "name": "Alice",
    "email": "alice@prisma.pub",
    "age": 42
  }
]
```