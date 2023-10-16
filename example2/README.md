# Example

The example is a simple command-line application that uses the `orm` package to
connect to a database and perform some basic operations.

## Git clone the repository

```bash
git clone https://github.com/odroe/prisma-dart &&
cd prisma-dart
```

## Install dependencies

```bash
npm install
dart pub get
```

## Generate client and push database schema

```bash
npx prisma db push
dart run build_runner build
```

## Run the example

```bash
dart run example/main.dart
```

### Documentation

- [Prisma Official Documentation](https://www.prisma.io/docs/)
- [The `orm` package (Prisma ORM for Dart)](https://prisma.pub/)
