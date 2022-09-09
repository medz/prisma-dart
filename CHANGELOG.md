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
