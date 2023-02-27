---
title: "What is Prisma (for Dart)?"
---

# What is Prisma (for Dart)?

Prisma (for Dart) is a **next-generation ORM** for Dart and Flutter.

- **Most Popular Databases**: Prisma supports PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB.
- **Type-safe**: Prisma Client is a query builder that’s tailored to your schema. We designed its API to be intuitive, both for SQL veterans and developers brand new to databases. The auto-completion helps you figure out your query without the need for documentation.
- **Human-readable**: Prisma schema is intuitive and lets you declare your database tables in a human-readable way — making your data modeling experience a delight. You define your models by hand or introspect them from an existing database.

## Developer Experience

Prisma ORM aims to provide a simple, type-safe, multi-database supported ORM for a great Dart backend development experience.

## Performance

Unlike Dart other connected databases, Prisma is a sane ORM.

- **Type-safe**

  Any input in your editor or IDE will be hinted at the parameter type, and even some editors or IDEs can use these hints for auto-completion.

- **Multi-database**

  Prisma ORM supports multiple databases, and you can migrate between different databases without modifying the code.

## What About Priama client Dart?

Priama client Dart is the Dart version of (Prisma ORM)(https://www.prisma.io), which is an ORM and also a Dart client for Prisma engines.

There are significant differences between Prisma client Dart and Prisma client JS/TS, but their APIs are as consistent as possible. From this, we can reuse most of the documentation content in [Priama Documentation](https://www.prisma.io/docs/).

## Does it have any flaws?

1. Due to the limitations of the Dart language, we cannot implement all the functions supported by Prisma in the Dart language, such as `select`, `include` and more input types, and we cannot achieve dynamic output type construction.

2. Need to rely on `build_runner` and `json_serializable` to complete the serialization and deserialization of the model, which will lead to some unnecessary dependencies and cumbersome construction steps.
