---
title: Overview
---

# What's Prisma Dart client?

Prisma Dart client is a Dart ORM for Prisma. It is a Dart implementation of the Prisma Client, which provides type-safe access to your database.

## Features

- **Type-safe**: Prisma Client is a query builder that’s tailored to your schema. We designed its API to be intuitive, both for SQL veterans and developers brand new to databases. The auto-completion helps you figure out your query without the need for documentation.
- **Human-readable**: Prisma schema is intuitive and lets you declare your database tables in a human-readable way — making your data modeling experience a delight. You define your models by hand or introspect them from an existing database.
- **Most Popular Databases**: Prisma works seamlessly across most popular databases and service providers. | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB.

## How it works?

Prisma Dart client 即是一个 Dart 实现的 Prisma client 运行时，也是一个 Prisma 的 Dart 客户端生成器。

Prisma Dart client is both a Dart implementation of the Prisma client runtime and a Prisma client generator for Dart.

你只需要在你的 `schema.prisma` 中添加一个 `generator` 即可：

```prisma
generator client {
  provider = "dart run orm"
}
```

You only need to add a `generator` in your `schema.prisma`:

```prisma
generator client {
  provider = "dart run orm"
}
```
