---
title: Prisma Schema
---

# Prisma Schema

Prisma schema file is the main configuration file for Prisma. It is usually named `schema.prisma` and consists of the following sections:

[[toc]]

## Data source

Data sources determine how Prisma connects to your database and are represented by a `datasource` block in your Prisma schema file. Here's an example of a data source using `postgresql` as the database and containing a hard-coded connection string:

```prisma
generator client {
  provider = "dart run orm"
}

datasource db { // [!code focus]
  provider = "postgresql" // [!code focus]
  url      = "postgresql://johndoe:mypassword@localhost:5432/mydb?schema=public" // [!code focus]
} // [!code focus]

model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String?
}
```

## Generators

Prisma schema can have one or more generators, represented by a `generator` block:

```prisma
generator client { // [!code focus]
  provider = "dart run orm" // [!code focus]
} // [!code focus]

datasource db {
  provider = "postgresql"
  url      = "postgresql://johndoe:mypassword@localhost:5432/mydb?schema=public"
}

model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String?
}

```

::: tip

About more generators, see 👉 [Generators](https://www.prisma.io/docs/orm/prisma-schema/overview/generators)

:::

### Prisma Dart client: `dart run orm`

You need to specify the `provider` as `dart run orm` in the `generator` when you decide to use Prisma in your Dart project, so that Prisma can generate Dart code for you.

```prisma
generator client {
  provider = "dart run orm" // [!code focus]
}
```

#### Output directory

- `output`: The directory where the generated Dart code will be written to. Defaults to `./generated_dart_client/`.

> Relative paths are resolved relative to the directory of the Prisma schema file.

Change the output directory:

```prisma
generator client {
  provider = "dart run orm"
  output   = "../lib/src/generated/prisma_client" // [!code focus]
}
```

## Data model

Data models define the structure of your database tables. They are made up of `model`/`view`/`enum` blocks.

::: tip

The following sections only make a simple introduction. For more content derived from the data model, please refer to 👉 [Data Model](https://www.prisma.io/docs/orm/prisma-schema/data-model)

:::

### Model

Models are represented by a `model` block in your Prisma schema file. Here's an example of a `User` model:

```prisma

model User { // [!code focus]
  id    Int     @id @default(autoincrement()) // [!code focus]
  email String  @unique // [!code focus]
  name  String? // [!code focus]
  role  Role    @default(USER) // [!code focus]
} // [!code focus]

view UserDetail {
  id    Int
  name  String?
  postsCount Int
}

enum Role {
  USER
  ADMIN
}
```

### View

Views are represented by a `view` block in your Prisma schema file. Here's an example of a `UserDetail` view:

```prisma
model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String?
  role  Role    @default(USER)
}

view UserDetail { // [!code focus]
  id    Int // [!code focus]
  name  String? // [!code focus]
  postsCount Int // [!code focus]
} // [!code focus]

enum Role {
  USER
  ADMIN
}
```

::: danger

`view` is currently a preview feature and should not be used in production. Prisma Dart Client cannot guarantee the correctness of `view`.

About more views, see 👉 [Views](https://www.prisma.io/docs/orm/prisma-schema/data-model/views)

:::

### Enum

Enums are represented by an `enum` block in your Prisma schema file. Here's an example of a `Role` enum:

```prisma
model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String?
  role  Role    @default(USER) // [!code focus]
}

view UserDetail {
  id    Int
  name  String?
  postsCount Int
}

enum Role { // [!code focus]
  USER // [!code focus]
  ADMIN // [!code focus]
} // [!code focus]
```

## More

About more data sources, see 👉 Prisma [Data Source](https://www.prisma.io/docs/orm/prisma-schema/overview/data-sources) official documentation.
