Next-generation ORM for Dart Native & Flutter | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB.

[![Pub Version](https://img.shields.io/pub/v/orm?label=latest)](https://pub.dev/packages/orm)
[![GitHub license](https://img.shields.io/github/license/odroe/prisma-dart)](https://github.com/odroe/prisma-dart/blob/main/LICENSE)

## What is it?

Prisma is a **next-generation ORM** that consists of these tools:

- **Prisma CLI** - A command line tool that allows you to create and manage your Prisma projects.
- **Prisma Dart Runtime** - A Dart package, that allows you to use the ORM in your Dart code.
- **Prisma Query Engine** - Prisma query engines wrapper:
  1. **Binary Engine** - Only for Dart Native.
  2. **Dynamic Library Engine** - Supported for Dart Native and Flutter Native. `❌ Waiting`
  3. **Prisma Data Proxy Engint** - Supported all platforms. `❌ Waiting` See [Add Data proxy engine support](https://github.com/odroe/prisma-dart/issues/22).

## Getting started

> **Prerequisites**: Dart SDK `>=2.17.6 <3.0.0`

### 1. Create Dart project and setup Prisma

As a first step, create a simple dart console project

```bash
dart create hello
cd hello
```

Next, add `orm` package to your project.

```bash
dart pub add orm
```

Then, initialize ORM.

```bash
dart run orm init
```

### 2. Model your data in the Prisma schema

The Prisma schema provides an intuitive way to model data. Add the following models to your schema.prisma file:

```prisma
model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String?
  posts Post[]
}

model Post {
  id        Int     @id @default(autoincrement())
  title     String
  content   String?
  published Boolean @default(false)
  author    User    @relation(fields: [authorId], references: [id])
  authorId  Int
}
```

Models in the Prisma schema have two main purposes:

- Represent the tables in the underlying database
- Serve as foundation for the generated Prisma Client API

### 3. Generate the Prisma Client API

```bash
dart run orm generate
dart run build_runner build
```

## Model deserialize (Why run `build_runner build`?)

Deserialization of data models is currently done using `json_annotation` and `json_serializable`.

> **Note** There are currently no plans to remove `json_annotation`, because `json_annotation` works very well and we currently do not have the ability to do the development work of deserialization ourselves.

Whenever you run the `orm generate` command, you must run `build_runner build` for the Prisma client to work properly. For more information see 👉 [json_serializable](https://pub.dev/packages/json_serializable).

## The Prisma schema

Every project that uses a tool from the Prisma toolkit starts with a [Prisma schema file](https://www.prisma.io/docs/concepts/components/prisma-schema). The Prisma schema allows developers to define their application models in an intuitive data modeling language. It also contains the connection to a database and defines a generator:

```prisma
// Data source
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// Generator
generator client {
  provider        = "prisma-client-dart"
  previewFeatures = ["interactiveTransactions"]
}

// Data model
model Post {
  id        Int     @id @default(autoincrement())
  title     String
  content   String?
  published Boolean @default(false)
  author    User?   @relation(fields:  [authorId], references: [id])
  authorId  Int?
}

model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String?
  posts Post[]
}
```

In this schema, you configure three things:

- **Data source** - Specifies your database connection (via an environment variable)
- **Generator** - Indicates that you want to generate Prisma Client
- **Data model** - Defines your application models

## Accessing your database with Prisma Client

### Generating Prisma Client

Run the following command to generate Prisma Client:

```bash
dart run orm generate
dart run build_runner build
```

### Using Prisma Client to send queries to your database

Once the Prisma Client is generated, you can import it in your code and send queries to your database. This is what the setup code looks like.

Import and instantiate Prisma Client

```dart
import 'prisma_client.dart';

final PrismaClient prisma = PrismaClient();
```

Now you can start sending queries via the generated Prisma Client API, here are few sample queries.

#### Retrieve all User records from the database

```dart
// Run inside `async` function
final List<User> allUsers = await prisma.user.findMany();
```

#### Filter all Post records that contain "odore"

```dart
final List<User> filteredPosts = await prisma.post.findMany(
  where: PostFindManyWhereInput(
    OR: [
      PostFindManyWhereInput(
        title: StringFilter(equals: "odore"),
      ),
      PostFindManyWhereInput(
        content: StringFilter(equals: "odore"),
      ),
    ],
  ),
);
```

#### Create a new User and a new Post record in the same query

```dart
final User user = await prisma.user.create(
  data: UserCreateInput(
    name: 'Odroe',
    posts: PostCreateNestedManyWithoutAuthorInput(
      create: [
        PostCreateWithoutAuthorInput(
          title: 'Hello World',
          content: 'This is my first post',
          published: true,
        ),
      ],
    ),
  ),
);
```

## Q&A

Q: Why does the Prisma query engine process still exist in the program process after I close it?

A: Prisma engine startup is automatic, but shutdown is not, you need to call `$disconnect` at the end of your program shutdown to stop the engine process.

Q: Why do I get an error when I run a transaction?

A: Because the official version of Prisma is still in preview for interactive transactions, you need to add `previewFeatures = ["interactiveTransactions"]` to the generator of `schema.prisma`, the files created by `orm init` have been added by default.
