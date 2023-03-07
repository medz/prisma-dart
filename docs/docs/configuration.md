# Configuration

Prisma client Dart requires no other configuration, just configure the data model in the `schema.prisma` file, but there are always some options!

## NPM executable

By default, you are not required to specify the path to the npm executable. We will search in the global `$PATH`.

If your NPM is not installed globally (after installing NodeJS globally, NPM is available globally), then you need to tell the generator the path of NPM:

```prisma
generator client {
   provider = "dart run orm --npm=<path>"
}
```

## Prisma client output

By default, the generated Prisma client Dart code will be placed in the `lib/prisma_client.dart` file.

You can change the output path by configuring the `output` option:

::: code-group

```prisma [Generage into directory]
generator client {
   provider = "dart run orm"
   output = "../lib/generated" // Output path is `lib/generated/prisma_client.dart`
}
```

```prisma [Generage into file]
generator client {
   provider = "dart run orm"
   output = "../lib/custom_generated.dart" // Output path is `lib/custom_generated.dart
}
```

:::

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
