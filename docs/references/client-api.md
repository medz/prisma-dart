---
title: References → Client API
---

# Client API reference

Prisma Client is an automatically generated database CRUD entry and is the main way for you to interact with the database.

## Default Constructor (Factory)

The code type of the default constructor is as follows:

```dart
class PrismaClient {
    factory PrismaClient({
        String? datasourceUrl,
        Map<String, String>? datasources
    }) {
        ...
    }
}
```

### Properties

| Property        | Type                   | Description    |
| --------------- | ---------------------- | -------------- |
| `datasourceUrl` | `String?`              | Datasource URL |
| `datasources`   | `Map<String, String>?` | Datasources    |

### Datasource

In Prisma Schema, `datasource <name>` is used to name a data source.

```prisma
datasource db {
  provider = "sqlite"
  url      = env("DATABASE_URL")
}
```

The `db` in the above is the name of the data source, which will be used to generate the constructor of Prisma Client.

```dart
final client = PrismaClient(datasources: {
  'db': 'sqlite://path/to/database.db',
});
```

::: tip

Usually, you don't need to specify it, it will automatically read it from `schema.prisma` when **generate**. After you officially compile, the actual connected database is not the database address specified in `datasource`, then you When initializing Prisma Client, the URL needs to be overwritten.

:::

### Datasource URL

Programmatically override the `datasource` block in `schema.prisma`.

### Property

| Option                     | Example                        | Description                 |
| -------------------------- | ------------------------------ | --------------------------- |
| Database connection string | `sqlite://path/to/database.db` | The database connection URL |

### Examples

```dart
final client = PrismaClient(
    datasourceUrl: 'sqlite://path/to/database.db'
);
```

## `PrismaClient.datamodel`

Prisma Client will generate `datamodel` at compile time, which is a static property that contains all models in Prisma Schema.

```dart
print(PrismaClient.datamodel);
```

## `$connect()`

This `$connect` is used to explicitly connect to the database.

::: tip

Usually you don't need to call it manually, Prisma Client will call it automatically the first time you call it. Of course calling it manually will speed up the first query of the database.

:::

## `$disconnect()`

This `$disconnect` is used to disconnect from the database.

::: warning

This is a method that must be called previously in your application to terminate the Prisma Engine process to close the database connection. If you don't call it, the Prisma Engine process will continue to run even if your app is planted.

:::

## `$raw`

`$raw` is used to execute raw SQL statements.

```dart
final result = await client.$raw.query('SELECT * FROM User');
```

### `$raw.query()`

`$raw.query` is used to execute SQL query statements. For usage, please refer to [Queries → Raw database access → `$raw.query`](../queries/raw-database-access.md#rawquery)

### `$raw.execute()`

`$raw.execute` is used to execute SQL execution statements. For usage, please refer to [Queries → Raw database access → `$raw.execute`](../queries/raw-database-access.md#rawexecute)

## `$transaction`

`$transaction` is used to perform transactions.

```dart
client.$transaction((client) async {
  await client.user.create(...);
  await client.post.create(...);
});
```

For more information about Transactions, please refer to [Queries → Transactions](../queries/transactions.md)

## `$metrics`

Prisma metrics give you detailed insights into how Prisma clients interact with your database. You can use this insight to help diagnose performance issues with your application.

### `$metrics.json()`

Retrieve metrics in JSON format.

```dart
final metrics = await client.$metrics.json();
```

For more information, please refer to [Prisma Official Docs → Metrics → JSON](https://www.prisma.io/docs/orm/prisma-client/observability-and-logging/metrics#retrieve-metrics-in-json-format)

### `$metrics.prometheus()`

Retrieve metrics in Prometheus format.

```dart
final metrics = await client.$metrics.prometheus();
```

For more information, please refer to [Prisma Official Docs → Metrics → Prometheus](https://www.prisma.io/docs/orm/prisma-client/observability-and-logging/metrics#retrieve-metrics-in-prometheus-format)

## `<model>` properties

Prisma Client owns all models and views defined using `model`/`view` blocks in `schema.prisma` and generates `<Model>Delegate` proxies for them.

```dart
final users = await client.user.findMany();
```

For Reference about Model Delegate, please refer to [Reference → Model Delegate](model-delegate.md)
