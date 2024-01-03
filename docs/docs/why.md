---
title: Why Prisma Dart client?
---

# Why Prisma Dart client?

在使用 Dart 开发应用程序时，我们总是需要链接到数据库的。而 Dart 并没有很好的 ORM 实现工具，我们使用现有的 Dart 数据库驱动总是要处理复杂的 SQL 语句，而且还要处理数据库的连接池，连接的释放等等问题。

When using Dart to develop applications, we always need to link to the database. And Dart does not have a good ORM implementation tool. We always have to deal with complex SQL statements when using existing Dart database drivers, and we also have to deal with database connection pools, connection release, and so on.

## Existing database issues

现存的 Dart 数据库工具包，大多数都是直接使用 SQL 语句来操作数据库，这样的话，我们就需要自己去处理 SQL 语句的拼接，参数的绑定，以及数据库连接的释放等等问题。

Most of the existing Dart database tool packages directly use SQL statements to operate the database, so we need to deal with SQL statement splicing, parameter binding, and database connection release.

而且，相对好用的数据库 ORM 总是为 Flutter 而专属开发，只能使用 SQLite 数据库，但依旧我们需要处理大量 SQL，返回的结果也不是类型安全的。

And, relatively easy-to-use database ORM is always exclusive to Flutter development, can only use the SQLite database, but we still need to deal with a lot of SQL, the returned results are not type-safe.

## Urgent problem-solving

为了解决这些问题，`orm` package 使用 Prisma 引擎，来为数据库生成好用且类型安全的 ORM 工具。

To solve these problems, the `orm` package uses the Prisma engine to generate easy-to-use and type-safe ORM tools for the database.
