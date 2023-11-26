# Prisma Dart client v4.0.0-alpha.0

To install Prisma Dart client v4.0.0-alpha.0 run:

```sh
# If you are using Dart
dart pub add orm:4.0.0-alpha.0

# Or if you are using Flutter
flutter pub add orm:4.0.0-alpha.0
```

To upgrade to Prisma Dart client v4.0.0-alpha.0, Please follow the [migration guide](#migration-guide-from-v3) and update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-alpha.0
```

[Read Prisma Dart Client v4.0.0-alpha.0 release notes on the Prisma Dart discussions](https://github.com/medz/prisma-dart/discussions/{id})

## What's Changed

- Whole project refactoring
- Remove any JSON serialization tool, now it's ready to use by just generating the client without any other dependencies and extra commands
- Switch from GraphQL protocol to JSON protocol
- Client takes a standalone Prisma engine instance
- Client and all input/output types are standalone and can be distributed to any Dart platform
- Add database field reference support
- Support `select` feature (incomplete, currently only support rough one-level Model fields)
- Support `include` feature (incomplete, currently only support rough one-level Model fields)
- `PrismaUnion` regression, now can structure nested inputs of multiple parameters via union
- `PrismaNull` regression, now support database `null` data setting
- DMMF, generator helpers regression, no need to depend on other packages, can directly use `orm` as the base package for developing Dart Prisma ecosystem packages
- Add `Decimal` type support (from [decimal package](https://pub.dev/package/decimal), exported by `orm` proxy)

## Migration Guide (from v3)

### Step 1: Update your `pubspec.yaml` file

```yaml
dependencies:
  orm: ^4.0.0-alpha.0
```

### Step 2: Update prisma schame

Previous generator configuration:

```prisma
generator DartClient {
  provider = "dart run orm"
}
```

Current generator configuration:

```prisma
generator DartClient {
  provider = "dart run orm:client"
}
```

If you have `orm` installed globally, `provider` can use `prisma-client-dart` directly:

```prisma
generator DartClient {
  provider = "prisma-client-dart"
}
```

### Step 3: Configure your engine (in `schema.prisma`)

```prisma
generator CopyQueryEngine {
  provider = "dart run orm:binary"
  // If you have `orm` installed globally, `provider` can use `prisma-engine-binary` directly:
  // provider = "prisma-engine-binary"
}
```

> Currently, `orm` only supports Prisma binary engine, other engines will be supported in future updates.

### Step 4: Generate client

```sh
npx prisma generate
```

### Setp 5: Update your code

Previous import use `[path]/prisma_client.dart`, now use `[path]/client.dart`:

Now the client will generate three files:

- `client.dart` - Client implementation (interact with Prisma engine)
- `types.dart` - All input/output types
- `dmmf.dart` - DMMF data structure

```dart
import 'package:orm/orm.dart';
import 'package:orm/engines/binary.dart';

// Your generated client path.
import '[path]/client.dart';

final prisma = PrismaClient(
  engine: BinaryEngine(
    url: 'file:./prisma/dev.db',
    // path: '/path/to/query-engine', // You generated engine path, if not set, will search in current directory.
  ),
);
```
