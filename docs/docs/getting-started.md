---
title: Getting Started
description: Learn how to get started with Prisma Dart client.
---

# Getting Started

This article will show you how to get started with Prisma Dart client.

- [Installation](/docs/installation)

## Model Schema Definition

首先，你应该定义你的数据模型，你可以使用 Prisma schema 来定义你的数据模型，Prisma schema 是一个 DSL 语言，它可以让你定义你的数据模型，以及生成你的数据库迁移脚本。

First, you should define your data model. You can use Prisma schema to define your data model. Prisma schema is a DSL language that allows you to define your data model and generate your database migration scripts.

```prisma
model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String?
  published Boolean  @default(false)
  author    User?    @relation(fields: [authorId], references: [id])
  authorId  Int?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

相关资料请参阅 👉 (Prisma Schema Documentation)[https://www.prisma.io/docs/orm/prisma-schema].

For more information, see 👉 (Prisma Schema Documentation)[https://www.prisma.io/docs/orm/prisma-schema].

## Generate client

现在，我们允许下面的命令来生成 Prisma Dart client:

Now, we allow the following command to generate Prisma Dart client:

```bash
npx prisma generate
```

> **NOTE**: 如果你没有定义适合 Dart 的生成器，请阅读 👉 [Installation](/docs/installation)

> **NOTE**: If you don't have a generator suitable for Dart, please read 👉 [Installation](/docs/installation)

## Usage

默认情况下，你的 Prisma Dart client 代码会被生成到 `prisma/generated_dart_client/` 目录下，你可以在你的 Dart 项目中使用它。

By default, your Prisma Dart client code will be generated to the `prisma/generated_dart_client/` directory, which you can use in your Dart project.

```dart
import 'prisma/generated_dart_client/client.dart';
import 'prisma/generated_dart_client/model.dart';
import 'prisma/generated_dart_client/prisma.dart';
```

- `client.dart`: 客户端运行时
- `model.dart`: 数据模型生成的 Dart 类和 Enum.
- `prisma.dart`: 用于客户端的输入和输出类型

- `client.dart`: Client runtime
- `model.dart`: Dart classes and enums generated from your data model.
- `prisma.dart`: Input and output types for the client

## Connect to database

在使用 Prisma Dart client 之前，你需要先连接到数据库，你可以使用 `PrismaClient` 类来连接到数据库。

Before using Prisma Dart client, you need to connect to the database first. You can use the `PrismaClient` class to connect to the database.

```dart
final prisma = PrismaClient();

await prisma.$connect();
```

`$connect` 是可选的，如果你没有调用它，客户端会在第一个查询发送前自动连接到数据库。

`$connect` is optional. If you don't call it, the client will automatically connect to the database before sending the first query.

## Example

::: code-group

```dart [main.dart]
import 'dart:io';
import 'package:orm/orm.dart';

import 'prisma/generated_dart_client/client.dart';
import 'prisma/generated_dart_client/model.dart';
import 'prisma/generated_dart_client/prisma.dart';

void main() async {
  final prisma = PrismaClient();
  try {
    final user = await prisma.user.findFirstOrThrow(
      select: UserSelect(
        id: true,
        name: true,
        $count: PrismaUnion.$1(true),
      ),
    );

    print(
        'Fond user ${user.name} (ID: ${user.id}), Total posts: ${user.$count?.posts}');
  } finally {
    await prisma.$disconnect();
    exit(0);
  }
}
```

```log [outout]
Found user Seven (ID: 1), Total posts: 2
```

:::
