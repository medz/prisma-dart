# Upgrade Guides

## Prisma Dart v4 -> v5 & Flutter integration

Upgrading from Prisma Dart v4 to v5 is relatively simple. Although it is a major version change, there are no changes to user APIs.

### `engineType` in Prisma schema

Now, in the Flutter integration, you tell the generator that you want to generate a client for Flutter:

```prisma
generator client {
  provider   = "dart run orm"
  output     = "../lib/_generated_prisma_client"
  engineType = "flutter" // [!code focus]
}
```

### `PrismaClient`

Major changes to Prisma Client:

1. Changed from an isolated type to a self-dependent type with `Class PrismaClient extends BasePrismaClient<PrismaClient>`.
2. Deprecated `PrismaClient.use` method.

Before:

```dart
final prisma = PrismaClient.use((schema, datasoruce) {
    /// Your codes, create engine and returns.
});
```

Now:

```dart
final engine = ...; // You created engine instance.
final prisma = PrismaClient(engine: engine);
```

### Logging

Previously, we relied on the `logging` package for logging. Then you needed to listen for the logs and output them yourself.

Now, Prisma Dart implements the same logging as the Prisma TS/JS client.

For more logging information, see 👉 [Prisma Logging](https://www.prisma.io/docs/orm/prisma-client/observability-and-logging/logging).

#### Output to console

Before:

```dart
import 'package:loging/loging.dart';

Logger.root.onRecore.listen((log) {
    print(log.message);
});
```

Now:

```dart
final prisma = PrismaClient(
    log: {
        (LogLevel.query, LogEmit.stdout),
        // ... More level configs
    },
);
```

#### Log event

Before:

```dart
import 'package:loging/loging.dart';

Logger.root.onRecore.listen((log) {
    //... You custon.
});
```

Now:

```dart
final prisma = PrismaClient(
    log: {
        (LogLevel.query, LogEmit.event),
        // ... More level configs
    },
);

prisma.$on(LogLevel.query, (event) {
    // ...
});
```
