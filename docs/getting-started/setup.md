---
title: Setup
---

# Setup

安装 Prisma Dart Client 完成后，你需要在你的项目中创建一个 `prisma/schema.prisma` 文件，这个文件是 Prisma 的核心文件，它定义了你的数据模型和数据库连接。

::: code-group

```bash [NPM]
npx prisma init --generator-provider="dart run orm"
```

```bash [pnpm]
pnpx prisma init --generator-provider="dart run orm"
```

```bash [Bun.js]
bun prisma init --generator-provider="dart run orm"
```

:::

`--datasource-provider` Option is not required, because Prisma Dart Client will automatically generate the `datasource` configuration for you:

| Provider      | description                       | Example                                             |
| ------------- | --------------------------------- | --------------------------------------------------- |
| `postgresql`  | Initialize a PostgreSQL database  | `npx prisma init --datasource-provider=postgresql`  |
| `mysql`       | Initialize a MySQL database       | `npx prisma init --datasource-provider=mysql`       |
| `sqlite`      | Initialize a SQLite database      | `npx prisma init --datasource-provider=sqlite`      |
| `sqlserver`   | Initialize a SQL Server database  | `npx prisma init --datasource-provider=sqlserver`   |
| `mongodb`     | Initialize a MongoDB database     | `npx prisma init --datasource-provider=mongodb`     |
| `cockroachdb` | Initialize a CockroachDB database | `npx prisma init --datasource-provider=cockroachdb` |

Initiated, the following files will appear in your project directory:

```diff
...
├── prisma // [!code ++]
│   └─── schema.prisma // [!code ++]
└─── .env // [!code ++]
```

## Dart project dependencies

Your project's `pubspec.yaml` file should look like this:

```yaml
name: your_project_name
description: your_project_description
dependencies:
  orm: ^4.0.0-alpha.3 // [!code focus]
  // ...
dev_dependencies: ...
```

## Dot env file `.env`

The `.env` file is used to store environment variables. It should look like this:

```env
# Environment variables declared in this file are automatically made available to Prisma.
# See the documentation for more detail: https://pris.ly/d/prisma-schema#accessing-environment-variables-from-the-schema

# Prisma supports the native connection string format for PostgreSQL, MySQL, SQLite, SQL Server, MongoDB and CockroachDB.
# See the documentation for all the connection string options: https://pris.ly/d/connection-strings

DATABASE_URL="postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public" // [!code focus]
```

## Prisma schema file `prisma/schema.prisma`

Initialised, the `prisma/schema.prisma` file should look like this:

```prisma
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
  provider = "dart run orm" // [!code focus]
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}
```
