## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

### Breaking changes

#### Standalone Prisma client

Prisma client is now exported by orm package and exposes `fromEngine` constructor.

```dart
import 'package:orm/orm.dart';

final PrismaClient prisma = PrismaClient.fromEngine(...);
```

The generated prisma client now only extends model delegates, and creating a new Prisma client was changed from `PrismaClient()` to `createPrismaClient`:

Before:

```dart
final PrismaClient prisma = PrismaClient(...);
```

After:

```dart
final PrismaClient prisma = createPrismaClient(...);
```

### Remove preview feature

All previews will be removed and existing Previews will be marked as stable in this release.

> Preview will no longer be enabled in future releases, but release `*.preview.{num}` versions to mark

## New features

### Support `queryRaw` and `executeRaw` methods

Prisma client now supports `queryRaw` and `executeRaw` methods.

```dart
final PrismaClient prisma = createPrismaClient(...);

final List<Map<String, dynamic>> result = await prisma.$queryRaw('SELECT * FROM User');
final int affectedRows = await prisma.$executeRaw('DELETE FROM User');
```

### Input classes support `fromJson` method

All input classes now support `fromJson` method.

```dart
final UserCreateInput input = UserCreateInput.fromJson(...);
```
