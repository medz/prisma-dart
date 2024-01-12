# Introduction

Prisma Dart client is an auto-generated and type-safe query builder for Dart.

**Read the [Prisma Dart Client Getting Started](../getting-started/) guide before reading the rest of this documentation.**

## Prerequisites

Make sure you include the `generator` section in your Prisma schema file and set the `provider` to `dart run orm`:

```prisma
generator client {
  provider = "dart run orm" // [!code focus]
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

final prisma = PrismaClient();
```

## Recommended Usage

If you are using it in a command line application or an application that does not have error interception and will exit the process if an exception is thrown, we recommend wrapping it with the following structure:

```dart
final prisma = PrismaClient();

void main(List<String> args) async {
    try {
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
