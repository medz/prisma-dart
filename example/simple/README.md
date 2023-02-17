# Simple example

This example shows how to use Prisma ORM for Dart.

## Setup

```bash
# Install dependencies
dart pub get

# Generate Prisma Client
npx prisma generate
dart run build_runner build
```

## Run

```bash
dart run lib/main.dart
```

## Output

```bash
$ dart run lib/simple.dart

{id: 1, createdAt: 2023-02-17T14:11:10.213Z, updatedAt: 2023-02-17T14:11:10.213Z, text: Hello World!}
```
