# Configuration

Prisma client Dart requires no other configuration, just configure the data model in the `schema.prisma` file, but there are always some options!

## Choose Node's package management tool

Prisma client Dart depends on Node's package management tool, because it needs to interact with Prisma CLI, so you need to choose a Node package management tool, currently supported package management tools are:

- npm
- yarn
- pnpm

You can configure it in the `schema.prisma` file:

```prisma
generator client {
   provider = "dart run orm --package-manager <package-manager>"
}
```

`--package-manager` is optional, the default value is `npm`, It also has an alias `-p`:

```prisma
generator client {
   provider = "dart run orm -p <package-manager>"
}
```

### Node package manager executable

If you have multiple versions of the Node package manager installed, or if you don't have the Node package manager installed globally. Please use the `-e` parameter to tell the generator:

```prisma
generator client {
   provider = "dart run orm -e <executable>"
}
```

Example:

```prisma
generator client {
   provider = "dart run orm -e node_modules/.bin/pnpm"
}
```

## About database connection

After the Prisma CLI initializes the project, there will be a `.env` file, which contains the configuration of the database connection. You can configure the database connection in this file:

```env
DATABASE_URL="postgresql://USER:PASSWORD@HOST:PORT/DATABASE?schema=SCHEMA"
```

However, Prisma client Dart does not support it, it is only used by Prisma CLI.

You can configure it in the `schema.prisma` file:

```prisma
datasource db {
   provider = "postgresql"
   url = "postgresql://USER:PASSWORD@HOST:PORT/DATABASE?schema=SCHEMA"
}
```

But it is not recommended to configure the database connection in the `schema.prisma` file, because it will expose the information of the database connection, you can use the `--define` parameter of Dart cli to configure the database connection:

```bash
dart run --define=DATABASE_URL="postgresql://USER:PASSWORD@HOST:PORT/DATABASE?schema=SCHEMA" bin/main.dart
```

and then use it in your code:

```dart
final prisma = PrismaClient(
   datasources: Datasources(
     db: const String.forEnvironment('DATABASE_URL'),
   ),
);
```

If you compiled your program, you can use `Platform.environment` of `dart:io` to get environment variables:

```dart
import 'dart:io';

final prisma = PrismaClient(
   datasources: Datasources(
     db: Platform.environment['DATABASE_URL'],
   ),
);
```

```bash
DATABASE_URL="postgresql://USER:PASSWORD@HOST:PORT/DATABASE?schema=SCHEMA" bin/main.exe
```

Of course, you have other options, such as [dotenv](https://pub.dev/packages/dotenv) and so on.
