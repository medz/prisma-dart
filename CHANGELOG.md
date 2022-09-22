## 2.2.2

Fixed generate `schema` not working ([#29](https://github.com/odroe/prisma-dart/issues/29)

## 2.2.1

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.2.1🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.2.1) about the release. 🌟

### Major improvements

 Auto fix enum name and model name conflicts:
 ```prisma
 enum role {
  user
  admin
 }

 model user {
  id Int @id @default(autoincrement())
  role role
 }
 ```

Before this release, the above schema would result in a `role` enum and a `user` model. This is not valid in Dart, so we now auto fix the enum name to `Role` and the model name to `User`.

> Thanks to [@moepoi](https://github.com/moepoi)

### Bug fixes

1. Fixed `$transaction` options not being passed.
2. FIxed Using lowercase keywords in schema.prisma cannot generate clients correctly. - [#26](https://github.com/odroe/prisma-dart/issues/26)

## Other

* Update `code_builder` to `^4.3.0`.

## 2.2.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.2.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.2.0) about the release. 🌟

### Major improvements:

Input object Types without `PrismaUnion` wrapper, Before:
```dart
final User user = await prisma.user.create(
   data: PrismaUnion(
      zero: UserCreateInput(name: 'odroe'),
   ),
);
```
After:
```dart
final User user = await prisma.user.create(
   data: UserCreateInput(name: 'odroe'),
);
```

### Bug fixes:

- Nullable fields generating broken field implementations - [#23](https://github.com/odroe/prisma-dart/issues/23)

### Features:

- Add `precache` command, Populate the Prisma engines cache of binary artifacts.

## 2.1.3

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.1.3🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.1.3) about the release. 🌟

### Major improvements:

1. refactor `PrismaClientKnownRequestError`, Prisma Client throws a PrismaClientKnownRequestError exception if the query engine returns a known error related to the request - for example, a unique constraint violation. Reference 👉 [PrismaClientKnownRequestError](https://www.prisma.io/docs/reference/api-reference/error-reference#prismaclientknownrequesterror)
2. All exceptions on the client side will throw predictable errors，Reference 👉 [PrismaClientKnownRequestError](https://www.prisma.io/docs/reference/api-reference/error-reference)
3. `query_engine` renamed to `engine_core`

### Better error message

Take transaction errors as an example, before simply throwing `PrismaServerError` without any friendly prompts. Now:
```
PrismaClientUnknownRequestError:
Use the `prisma.$transaction()` API to run queries in a transaction.

Add the following to your `schema.prisma` file:

generator client {
  provider        = "prisma-client-js"
  previewFeatures = ["interactiveTransactions"]
}

Read more about transactions in our documentation:
 - https://github.com/odroe/prisma-dart#qa
 - https://www.prisma.io/docs/concepts/components/prisma-client/transactions#interactive-transactions-in-preview
```

If the engine is not found:
```
PrismaClientInitializationError:
  message: Could not find query engine binary for current platform "macos" in query-engine path.

This probably happens, because you built Prisma Client on a different platform.

Searched Locations:
  - /Users/seven/workspace/prisma/example
  - /Users/seven/workspace/prisma/example/.dart_tool/prisma
  - /Users/seven/workspace/prisma/example/prisma
  - /Users/seven/workspace/prisma/example/.dart_tool/pub/bin/example

You already added the platform "macos" to the "generator" block in the "schema.prisma" file as described in https://pris.ly/d/client-generator, but something went wrong. That's suboptimal.

Please create an issue at https://github.com/odroe/prisma-dart/issues/new
  errorCode: null
  clientVersion: 2.1.2
```

### `$transaction` options

`prisma.$transaction` now supports the following options:
```dart
final prisma = PrismaClient();
await prisma.$transaction((prisma) async {
   // ...
}, TransactionOptions(
   maxWait: 2000,
   timeout: 5000,
   isolationLevel: TransactionIsolationLevel.ReadUncommitted,
));
```

More details 👉 [Interactive transactions](https://www.prisma.io/docs/concepts/components/prisma-client/transactions#interactive-transactions-in-preview)

### Bug fixes

1. Fixed `packageVersion` not updating with version
2. Fixed binary query engine not automatically searching when `executable` is specified
2. Fixed binary query engine not automatically searching when specifying `PRISMA_QUERY_ENGINE_BINARY` environment variable

### Engines version

`c875e43600dfe042452e0b868f7a48b817b9640b`

## 2.1.2

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20Prisma%20ORM%20for%20Dart%20release%20v2.1.2🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.1.2) about the release. 🌟

### Bug fixes

- Fix the problem of repeated operation of the lookup runtime configuration
- Fix setting owerwrite datasources causing engine startup failure

### Refactor

Refactored to owerwrite datasources to convert to engine readable settings

## 2.1.1

Support custom runtime configuration.

## 2.1.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20Prisma%20ORM%20for%20Dart%20release%20v2.1.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.1.0) about the release. 🌟

### Major improvements:

#### Runtime configuration

Previously, use `prisma.yaml` to configure Prisma:
```yaml
environment:
   DATABASE_URL: postgres://user:password@localhost:5432/mydb
```

Now, we have introduced a new configuration method, **Runtime Configuration** compatible with dotenv format:
```
# .prismarc
DATABASE_URL=postgres://user:password@localhost:5432/mydb

# Database host
DATABASE_HOST=postgres://user:password@localhost:5432
DATABASE_URL=${DATABASE_HOST}/mydb
```

If you have dotenv in mind, you just need to add the database URL configuration to `.env`:
```dotenv
DATABASE_URL=postgres://user:password@localhost:5432/mydb
```

For more usage of runtime configuration, please see 👉 https://pub.dev/packages/rc

#### Custom configuration

Now, you can customize your prisma project configuration in `pubspec.yaml`:
```yaml
...
prisma:
   prismarc: path/a/b/c/custom.prismarc
   dotenv: path/a/b/c/custom.env
   schema: path/a/b/c/custom.prisma
...
```

| Parameter | Description | Default |
|---|:---| --- |
| `prismarc` | Custom runtime configuration path | `.prismarc` |
| `dotenv` | Custom dotenv path | `.env` |
| `schema` | Custom Prisma schema path | `prisma/schema.prisma` |


#### Custom engine path

Previously, the Prisma engine was downloaded into the `.dart_tool/prisma` directory, now you can customize it.

##### Custom engines path with runtime configuration

```
# Query binary engine
PRISMA_QUERY_ENGINE_BINARY(path) = custom-engines/query-engine

# Migration binary engine
PRISMA_MIGRATION_ENGINE_BINARY(path) = custom-engines/migration-engine

# Introspection binary engine
PRISMA_INTROSPECTION_ENGINE_BINARY(path) = custom-engines/introspection-engine

# Format binary engine
PRISMA_FMT_BINARY(path) = custom-engines/prisma-fmt
```

##### Custom engines path with dotenv

```
PRISMA_QUERY_ENGINE_BINARY=path/to/custom-engines/query-engine
PRISMA_MIGRATION_ENGINE_BINARY=path/to/custom-engines/migration-engine
PRISMA_INTROSPECTION_ENGINE_BINARY=path/to/custom-engines/introspection-engine
PRISMA_FMT_BINARY=path/to/custom-engines/prisma-fmt
```

#### Refactored `package:orm/configure.dart`

Previously, we have `package:orm/configure.dart` to configure Prisma, now we have refactored it to `package:orm/prisma.dart`:
```dart
import 'package:orm/configure.dart';

print(configure('DATABASE_URL'));
```

Now, you can use `package:orm/configure.dart` to configure Prisma:
```dart
import 'package:orm/configure.dart';

print(environment.DATABASE_URL);
```

### Bug fixes:

1. Fix map and throws binary errors - [#16](https://github.com/odroe/prisma-dart/pull/16)
2. Problems using Model with relation - [#14](https://github.com/odroe/prisma-dart/pull/14)

### Features:

1. Generator generate import support show.
2. Prisma CLI debug allow set to dotenv or runtime configuration.
3. Prisma CLI debug print stack trace.

## 2.0.1

### CLI

1. Fixed model relation deserialization is a must - [#7](https://github.com/odroe/prisma-dart/issues/7)

### Runtime

1. Fixed Create throws assertion error - [#10](https://github.com/odroe/prisma-dart/issues/10)
2. Fixed UTF-8 decoding error - [#11](https://github.com/odroe/prisma-dart/issues/11)

## 2.0.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20Prisma%20ORM%20for%20Dart%20release%20v2.0.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.0.0) about the release. 🌟

### Major improvements:

### All packages merged into one

We have reasonably integrated all the packages we split before, before:
```yaml
dependencies:
   orm: 1.0.0
dev_dependencies:
   prisma_cli: 1.0.0
```
Now:
```yaml
dependencies:
   orm: 2.0.0
```

### Support transactions (preview)

Interactive transactions are a stable feature in Prisma For Dart, but a preview feature for the Prisma engine.
Interactive transactions are easier to handle for ORMs:

```dart
final result = await prisma.$transaction((prisma) async {
   final user = await prisma.user.create(...);
   final post = await prisma.post.create(...);

   return post;
}
```

### CLI

- Added `db pull` function
- Complete refactoring of `generate` command
- Built-in RPC engine service refactoring
- The binary download engine supports the verification version, and the marked version will be downloaded automatically when the engine is updated

### Runtime

- Added GraphQL SDL generation
- Added `prisma.$connect()` method
- Added `prisma.$disconnect()` method
- Refactored engine interface and entry parameters
