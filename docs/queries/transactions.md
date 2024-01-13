# Transactions

Database transactions are a series of read/write operations that are guaranteed to either succeed or fail as a whole. In this chapter, we will cover:

[[toc]]

## Interactive Transactions

Use the `$transaction` method to execute a closure within a transaction. If any of the operations within the closure fail, the entire transaction will be rolled back:

<<< @/../example/transactions.dart#interactive

In the example above, you can try passing invalid data to `transfer` as any exception thrown will cause the transaction to be rolled back without affecting the data.

## Catching Exceptions/Errors

You may sometimes want to catch exceptions or errors within a transaction. You can do so using a `try/catch` statement:

<<< @/../example/transactions.dart#catch

## Isolation Levels

Prisma Dart client transactions support isolation levels (if the database supports them). By default, transactions use the database's default isolation level. To change the isolation level, use the `isolationLevel` parameter:

<<< @/../example/transactions.dart#isolation

Supported database isolation level matrix:

| Database    | Read Uncommitted | Read Committed | Repeatable Read | Serializable | Snapshot |
| ----------- | ---------------- | -------------- | --------------- | ------------ | -------- |
| PostgreSQL  | ✅               | ✅             | ✅              | ✅           | ❌       |
| MySQL       | ✅               | ✅             | ✅              | ✅           | ❌       |
| SQL Server  | ✅               | ✅             | ✅              | ✅           | ✅       |
| CockroachDB | ❌               | ❌             | ❌              | ✅           | ❌       |
| SQLite      | ❌               | ❌             | ❌              | ✅           | ❌       |

Default isolation levels:

| PostgresSQL    | MySQL           | SQL Server     | CockroachDB  | SQLite       |
| -------------- | --------------- | -------------- | ------------ | ------------ |
| Read Committed | Repeatable Read | Read Committed | Serializable | Serializable |

::: warning

The `TransactionIsolationLevel` enum exposes all the isolation levels supported by the Prisma Dart client. However, not all databases support all isolation levels. For example, SQLite only supports `Serializable` isolation level.

:::

::: details Database-specific information on isolation levels

See the following resources:

- [PostgreSQL](https://www.postgresql.org/docs/current/transaction-iso.html)
- [MySQL](https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html)
- [SQL Server](https://docs.microsoft.com/en-us/sql/t-sql/statements/set-transaction-isolation-level-transact-sql?view=sql-server-ver15)
- [CockroachDB](https://www.cockroachlabs.com/docs/stable/transactions#isolation-levels)
- [SQLite](https://www.sqlite.org/isolation.html)

:::

## Timeouts

When you use interactive transactions, in order to avoid long waiting times, you can set the transaction running time through the following two parameters:

- `maxWait` - The maximum time the client waits for a transaction from the database, default `2` seconds
- `timeout` - The maximum time an interactive transaction can run before being canceled or rolled back, default `5` seconds

<<< @/../example/transactions.dart#timeout

::: warning

You should use the timeout parameter with caution, keeping a transaction open for a long time can harm database performance and may even lead to deadlock. Try to avoid performing network requests and slow-performing queries within transaction functions. We recommend getting in and out as soon as possible!

:::

## Manual Transactions

Prisma Dart Client supports manual transactions, which means you can perform any number of operations within a transaction and then decide whether to commit or rollback the transaction.

<<< @/../example/transactions.dart#manual

Using `$transaction.start()` will return a new `PrismaClient` instance. All operations within the transaction should be performed on this instance. When you decide to commit or rollback the transaction, call `$transaction.commit()` or `$transaction.rollback()`.
