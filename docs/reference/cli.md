---
title: Prisma CLI reference
description: This document describes the Prisma CLI commands, arguments, and options.
---

# {{ $frontmatter.title }}

{{ $frontmatter.description }}

## Usage

```bash
dart run orm <command> [arguments]
```

::: info Results
```bash
 ◭ Prisma CLI 🚀
Prisma is a modern DB toolkit to query, migrate and model your database.
 More info: https://github.com/odroe/prisma-dart

Usage: dart run orm <command> [arguments]

Global options:
-h, --help       Print this usage information.
-v, --version    Print CLI and engines version.
    --debug      Print debug information.

Available commands:
  db         Manage your database schema and lifecycle
  format     Format a Prisma schema.
  generate   Generate artifacts
  init       Setup Prisma for you project
  precache   Populate the Prisma engines cache of binary artifacts.

Run "dart run orm help <command>" for more information about a command.
```
:::

## `-v` or `--version`

```bash
dart run orm -v
```

::: details Results
```bash
Prisma CLI                              2.3.0
Prisma Binary Engines                   c875e43600dfe042452e0b868f7a48b817b9640b
Prisma Query C API                      0.0.1
```
:::

## init

Bootstraps a fresh Prisma project within the current directory.

The `init` command does not interpret any existing files. Instead, it creates a `prisma` directory containing a bare-bones `schema.prisma` file within your current directory.

### Arguments

| Argument | Required | Description | Default |
|----------|----------|-------------|---------|
| `--url` | No | Define a custom datasource url. |  |
| `--datasource-provider` | No | Define the datasource provider, More see [supported databases](https://www.prisma.io/docs/reference/database-reference/supported-databases). | `postgresql` |

## generate

The `generate` command generates assets like Prisma Client based on the generator and data model blocks defined in your `prisma/schema.prisma` file.

### Prerequisites

To use the `generate` command, you must add a generator definition in your `schema.prisma` file. The `prisma-client-dart` generator, used to generate Prisma Client, can be added by including the following in your `schema.prisma` file:

```prisma
generator client {
  provider = "prisma-client-dart"
}
```

### Arguments

| Argument | Required | Description | Default |
|----------|----------|-------------|---------|
| `--schema` | No | Custom path to your Prisma schema | `prisma/schema.prisma` |
| `--[no-]data-proxy` | No | Enable the generated Prisma client to use the Data Proxy | `--no-data-proxy` |

## format

Formats the Prisma schema file, which includes validating, formatting, and persisting the schema.

### Arguments

| Argument | Required | Description | Default |
|----------|----------|-------------|---------|
| `--schema` | No | Custom path to your Prisma schema | `prisma/schema.prisma` |

## precache

Populate the Prisma engines cache of binary artifacts.

### Arguments

| Argument | Required | Description | Default |
|----------|----------|-------------|---------|
| `-t`, `--type` | No | Prisma engines types. | `[query, migration, introspection, format]`


## db pull

Pull the state from the database to the Prisma schema using introspection.

### Arguments

| Argument | Required | Description | Default |
|----------|----------|-------------|---------|
| `--schema` | No | Custom path to your Prisma schema | `prisma/schema.prisma` |
| `--composite-type-depth` | No | Specify the depth for introspecting composite types | `-1` |
| `--[no-]force` | No | Ignore current Prisma schema file | |
| `--[no-]print` | No | Print the introspected Prisma schema to stdout | |

## db push

Push the state from your Prisma schema to your database.

### Arguments

| Argument | Required | Description | Default |
|----------|----------|-------------|---------|
| `--schema` | No | Custom path to your Prisma schema | `prisma/schema.prisma` |
| `--[no-]force-reset` | No | Force a reset of the database before push | |
