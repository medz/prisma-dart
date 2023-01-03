---
title: Getting started
---

# {{ $frontmatter.title }}

Before diving into how **Prisma ORM** is used in Dart & Flutter, let's learn how to use it in Dart applications.

::: tip
But there is a premise that you have already learned about the Dart related toolchain.
:::

## Prerequisites

Dart SDK: `>=2.18.0 <3.0.0`

## Installing

Depend on it.

```bash
dart pub add orm
```

::: info pubspec.yaml
This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):

```bash
dependencies:
    orm: latest
```

Alternatively, your editor might support `dart pub get` or `flutter pub get`. Check the docs for your editor to learn more.
:::

## Setup

Set up Prisma with the `init` command of the Prisma CLI:

```bash
dart run orm init --datasource-provider sqlite
```

This creates a new `prisma` directory with your Prisma schema file and configures **SQLite** as your database. You're now ready to model your data and create your database with some tables.

## Model your data

The Prisma schema provides an intuitive way to model data. Add the following models to your schema.prisma file:

::: info prisma/schema.prisma
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
:::

Models in the Prisma schema have two main purposes:

* Represent the tables in the underlying database
* Serve as foundation for the generated Prisma Client API

## Push database table

When you finish editing the `schema.prisma` heavy data table definition, you need to push it into the database to create these tables, relationships and indexes.

Run this command:

```bash
dart run orm db push
```

## Install `json_serializable` and `build_runner`

```bash
dart pub add json_serializable -d
dart pub add build_runner -d
```

::: warning  Client Model deserialize
Deserialization of data models is currently done using `json_annotation` and `json_serializable`.

> Whenever you run the `orm generate` command, you must run `build_runner build` for the Prisma client to work properly. For more information see 👉 [json_serializable](https://pub.dev/packages/json_serializable).
:::

## Generate client

The `generate` command generates assets like Prisma Client based on the generator and data model blocks defined in your `prisma/schema.prisma` file.

```bash
dart run orm generate
dart run build_runner build
```

## Explore Prisma client

The default Prisma client is located in `lib/prisma_client.dart`, just need this:

::: info lib/main.dart
```dart
import "prisma_client.dart";

final PrismaClient prisma = createPrismaClient();

void main() async {
    try {
     // ... you will write your Prisma Client queries here
    } catch(e) {
        print(e.toString());
    } finally {
        await prisma.$disconnect();
    }
}
```
:::

### Create a new User record

Let's start with a small query to create a new `User` record in the database and log the resulting object to the console. Add the following code to your `main.dart` file:

::: info lib/main.dart
```dart{7-13}
import "prisma_client.dart";

final PrismaClient prisma = createPrismaClient();

void main() async {
    try {
     final User user = await prisma.user.create(
        data: UserCreateInput(
            name: PrismaUnion.zero("Seven"),
            email: "seven@odroe.com",
        ),
     );
     print(user.toJson());
    } catch(e) {
        print(e.toString());
    } finally {
        await prisma.$disconnect();
    }
}
```
:::

Next, execute the script with the following command:

```bash
dart run lib/main.dart
```

::: details Results
```json
{ id: 1, email: 'seven@odroe.com', name: 'Seven' }
```
:::

Great job, you just created your first database record with Prisma Client! 🎉

### Retrieve all User records

Prisma Client offers various queries to read data from your database. In this section, you'll use the `findMany` query that returns all the records in the database for a given model.

Delete the previous Prisma Client query and add the new `findMany` query instead:

::: info lib/main.dart
```dart{7,8}
import "prisma_client.dart";

final PrismaClient prisma = createPrismaClient();

void main() async {
    try {
     final users = await prisma.user.findMany()
     print(users);
    } catch(e) {
        print(e.toString());
    } finally {
        await prisma.$disconnect();
    }
}
```
:::

Execute the script again:

```bash
dart run lib/main.dart
```

::: details Results
```json
[{ id: 1, email: 'seven@odroe.com', name: 'Seven' }]
```
:::

Notice how the single User object is now enclosed with square brackets in the console. That's because the findMany returned an array with a single object inside.



