---
title: Flutter Integration
---

# Flutter Integration

Prisma ORM for Dart allows you to integrate it in Flutter Project.

## Platform Support

| Platform | Support | Nots |
|------|------|------|
| iOS | ✅ | |
| Android | 🚧 | Working... |
| macOS | ❌ | Prisma C-ABI not support |
| Linux | ❌ | Prisma C-ABI not support |
| Windows | ❌ | Prisma C-ABI not support |
| Web | ❌ | No plans at the moment |

## Database Support

| Database | Suppoprt | Notes |
|------|------|------|
| Sqlite | ✅ | |
| MySQL/MariaDB | ❌ | Prisma C-ABI not support |
| PostgreSQL | ❌ | Prisma C-ABI not support |
| MongoDB | ❌ | Prisma C-ABI not support |
| Microsoft SQL Server | ❌ | Prisma C-ABI not support |
| CockroachDB | ❌ | Prisma C-ABI not support |

## Installation

You should first read the [Installation Documentation](./index.md#installation), and [Setup Prisma ORM](./setup.md) of the `orm` package.

Now, let’s install the `prisma_flutter` package, you can use the command line:

```bash
flutter pub add prisma_flutter
```

Or edit your Flutter project’s `pubspce.yaml` file:

```yaml
dependencies:
   prisma_flutter: latest
```

## Integration

In the regular method of `orm`, we use `PrismaClient(...)` to create the client, but this does not work in Flutter, so we now use the `PrismaClient.use` method to create the client:

```dart
import '<You generated client path>/client.dart';

final prisma = PrismaClient.use((schema, datasources) {
     final dbFilePath = "<You custon db file path>";

     return engine = PrismaFlutterEngine(schema: schema, datasources: {
         ...datasources,
         'db': 'file:$dbFilePath',
         // ...More options
     });
});
```

> Note: In Flutter, the client will not automatically connect to the database, and you need to manually call `prisma.$connect()` to establish a connection with the database.

## Migrations

Unlike server-side, databases in Flutter are not typically handled by you in the Prisma CLI before building.

### Create migration file

::: code-group

```bash [Bun.js]
bun prisma migrate dev
```

```bash [NPM]
npx prisma migrate dev
```

```bash [pnpm]
pnpx prisma migrate dev
```

:::

> Notes: By default it is created in the `prisma/migrations/` folder.

### Set migration files to flutter assets

Now, let's edit your `pubspec.yaml`:

```yaml
flutter:
   assets:
     - prisma/migrations/ # Migrations root dir
     - prisma/migrations/<dir>/ # Set first migration files dir
     # ... More assets
```

> Notes: Each migration folder generated using the `prisma migrate dev` command needs to be added.

### Run migration

```dart
final engine = PrismaFlutterEngine(...);

await engine.applyMigrations(
     path: 'prisma/migrations/', // Your define in `flutter.assets` .igrations root dir
);
```

> Notes:
>
> In addition to using `flutter.assets`, you can customize `AssetBundle` to achieve:
> ```dart
> await engine.applyMigrations(
>   path: '<Your migration dir prefix>',
>   bundle: <You custon bundle>,
> );
> ```
>
> **Also, `engine.applyMigrations` may throw exceptions. This is usually caused by your destructive changes to the migration files, and you should handle this yourself. The most common method is to delete the database file after throwing the exception, and then rerun the migration.**
>
> If you are adding a new migration, there will be almost no problems.

## Complete integration example

In this Example, we will install these packages:

- [`path`](https://pub.dev/packages/path)
- [`path_provider`](https://pub.dev/packages/path_provider)

We install the database in the `<Application Support Directory>/database.sqlite` location and then use `flutter.assets` to run the migration

::: code-group

```dart [lib/prisma.dart]
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prisma_flutter/prisma_flutter.dart';

import '_generated_prisma_client/client.dart';

late final PrismaClient prisma;

Future<void> initPrismaClient() async {
   WidgetsFlutterBinding.ensureInitialized();

   final supportDir = await getApplicationSupportDirectory();
   final database = join(supportDir.path, 'database.sqlite');

   late final PrismaFlutterEngine engine;
   prisma = PrismaClient.use((schema, datasources) {
     return engine = PrismaFlutterEngine(schema: schema, datasources: {
       ...datasources,
       'db': 'file:$database',
     });
   });

   await prisma.$connect();
   await engine.applyMigrations(path: 'prisma/migrations');
}
```

```dart [lib/main.dart]
import 'prisma.dart';

Future<void> main() async {
     await initPrismaClient();

     // ...
}
```

:::

## Example App

We provide you with a demo App that integrates Prisma ORM in Flutter 👉 [Flutter with ORM](https://github.com/medz/prisma-dart/tree/main/examples/flutter_with_orm)
