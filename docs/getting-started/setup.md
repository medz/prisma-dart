# Setup

Install Prisma Dart Client, you need to create a `prisma/schema.prisma` file in your project. This file is the core file of Prisma, which defines your data model and database connection.

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
  orm: ^4.0.0-beta // [!code focus]
  // ...
dev_dependencies: ...
```

## Dot env file `.env`

The `.env` file is used to store environment variables. It should look like this:

```txt
# Environment variables declared in this file are automatically made available to Prisma.
# See the documentation for more detail: https://pris.ly/d/prisma-schema#accessing-environment-variables-from-the-schema

# Prisma supports the native connection string format for PostgreSQL, MySQL, SQLite, SQL Server, MongoDB and CockroachDB.
# See the documentation for all the connection string options: https://pris.ly/d/connection-strings
// [!code focus:2]
DATABASE_URL="postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public"
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

## Generating

Generate the Prisma Dart client by running the following command:

::: code-group

```bash [NPM]
npx prisma generate
```

```bash [pnpm]
pnpx prisma generate
```

```bash [Bun.js]
bun prisma generate
```

:::

This will generate the Prisma Dart client in your defined `output` directory.

> Default output directory is `prisma/generated_dart_client/`.

The following files will be generated:

- `client.dart` - The Prisma client implementation.
- `model.dart` - Your Prisma schema models, views and enums.
- `prisma.dart` - Auto-generated Prisma client types.

## Instantiating Prisma Client

You can instantiate the Prisma client by importing the generated `client.dart` file and calling the `PrismaClient` constructor:

```dart
import 'prisma/generated_dart_client/client.dart';
// [!code focus:2]
final prisma = PrismaClient();
```

## Recommended Usage

If you are using it in a command line application or an application that does not have error interception and will exit the process if an exception is thrown, we recommend wrapping it with the following structure:

```dart
final prisma = PrismaClient();

void main(List<String> args) async {
    try { // [!code focus:7]
        // Your code here
    } catch (e) {
        // Handle error here
    } finally {
        await prisma.$disconnect();
    }
}
```

::: tip Why need `try/catch` using `finally` wrapper?

Currently, the Prisma Dart client only supports **binary engine**. When you execute the first query or call `prisma.$connect()`, the client will automatically start the engine process. When you call `prisma.$disconnect()`, the client will automatically close the engine process.

If you don't wrap `try/catch` in your application, when your application throws an exception, the engine process will not be closed, which will cause the engine process to run until you manually close it in the process manager of the system.

> Currently, I have not found a good way to automatically close the engine process. If you have any suggestions, please feel free to [issue](https://github.com/medz/prisma-dart/issues/new) or create a [PR](https://github.com/medz/prisma-dart/pulls) for it.

:::
