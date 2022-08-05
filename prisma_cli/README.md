◭ Prisma is a modern DB toolkit to query, migrate and model your database.

## What is it?

Prisma is a **next-generation ORM** that consists of these tools:

- **[Prisma CLI](https://pub.dev/packages/prisma_cli)** - A command line tool that allows you to create and manage your Prisma projects.
- **[Prisma Dart Runtime](https://pub.dev/packages/orm)** - A Dart package, that allows you to use the ORM in your Dart code.

## Commands

- `init`: Initialize a new Prisma project.
- `generate`: Generate a Prisma client.
- `db`: Manage your database schema and lifecycle.
- `format`: Format a Prisma schema.

### `db` Subcommands

- `push`: Push the state from your Prisma schema to your database.
- `pull`: Pull the state from your database to your Prisma schema.

## Console Executable

If you want to use the Prisma CLI from the command line, you can install it with:

```sh
dart pub global activate prisma_cli
```

Then you can use it like this:

```sh
prisma --help
```

### Command In Project

The global Prisma CLI is not required, you can add it to `dev_dependencies` in `pubspace.yaml` as follows:

```yaml
dev_dependencies:
  prisma_cli: any
```

Then you can use it like this:

```sh
dart run orm --help
```

## Commands TODO List:

- `init` - ✅
- `format` - ✅
- `db`:
  - `push` - ✅
  - `pull` - todo
- `generate` - processing
- `help` - ✅

## More Information

More about Prisma:

- [Prisma ORM for Dart](https://github.com/odroe/orm.dart)
- [Prisma Engines Website & Documentation](https://prisma.io/)
