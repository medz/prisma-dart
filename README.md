Next-generation ORM for Dart Native & Flutter | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB

## What is it?

Prisma is a **next-generation ORM** that consists of these tools:

- **[Prisma CLI](https://pub.dev/packages/prisma_cli)** - A command line tool that allows you to create and manage your Prisma projects.
- **[Prisma Dart Runtime](https://pub.dev/packages/orm)** - A Dart package, that allows you to use the ORM in your Dart code.
- **[Prisma Query Engine](https://pub.dev/packages/prisma_query_engine)** - Prisma query engines wrapper:
  1. **Binary Engine** - Only for Dart Native. **❌ [@Ali Ammar](https://github.com/Ali1Ammar) Developing.**
  2. **Dynamic Library Engine** - Supported for Dart Native and Flutter. **❌ [@Seven Du](https://github.com/medz) Developing.**
  3. **Prisma Data Proxy Engint** - Supported all platforms. `❌ Waiting`


## TODO:

- [x] `format` command.
- [ ] `generate` command.
- [x] `init` command.
- [x] `db push` command.
- [ ] `db pull` command.
- [ ] Binary query engine
- [ ] dylib query engine - In Progressing (https://github.com/odroe/prisma/issues/1)
- [ ] Prisma data proxy

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
dart run rom init
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
dart run rom generate
```

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
  provider = "dart run orm generate"
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

The first step when using Prisma Client is installing its `orm_runtime`:

```bash
dart pub add orm_runtime
```

After you change your data model, you'll need to manually re-generate Prisma Client to ensure the code inside `lib/src/generated_prisma_client` get updated:

```bash
dart run orm generate
```

### Using Prisma Client to send queries to your database

Once the Prisma Client is generated, you can import it in your code and send queries to your database. This is what the setup code looks like.

Import and instantiate Prisma Client

```dart
import 'lib/src/generated_prisma_client/prisma_client.dart';

final PrismaClient prisma = PrismaClient();
```

Now you can start sending queries via the generated Prisma Client API, here are few sample queries. Note that all Prisma Client queries return plain old `Map<String, dynamic>`.

#### Retrieve all User records from the database

```dart
// Run inside `async` function
final allUsers = await prisma.user.findMany();
```

#### Include the posts relation on each returned User object

```dart
// Run inside `async` function
final allUsers = await prisma.user.findMany(
  include: UserInclude(
    posts: true,
  ),
);
```

#### Filter all Post records that contain "odore"

```dart
final filteredPosts = await prisma.post.findMany(
  where: PostFindManyWhereInput.or([
    PostFindManyWhereInput(
      title: StringContains("odore"),
    ),
    PostFindManyWhereInput(
      content: StringContains("odore"),
    ),
  ]),
);
```

#### Create a new User and a new Post record in the same query

```dart
final user = await prisma.user.create({
  data: UserCreateInput(
    name: 'Odore',
    email: 'hello@odore.com',
    posts: UserCreateWithPostInput(
      create: PostCreateInput(
        title: 'My first post',
        content: 'This is my first post',
      ),
    ),
  ),
});
```
