# Getting Started

The quickstart will help create a new project from scratch so you can start using Prisma.

If you already have a project, please start with [2. Install Prisma CLI](#_2-install-prisma-cli).

<iframe width="560" height="315" src="https://www.youtube.com/embed/kMKyA_KEwV0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

> - [Watch at YouYube](https://www.youtube.com/embed/kMKyA_KEwV0)
> - [Watch at Bilibili](https://www.bilibili.com/video/BV1224y1t7Z5/)

## 1. Create a new Dart project

First, you need to create a new Dart project. If you are not familiar with Dart, you can refer to [Official Dart Documentation](https://dart.dev/get-dart).

```bash
dart create hello
```

## 2. Install Prisma CLI

Prisma CLI is a command-line tool officially provided by Prisma for managing Prisma projects. It helps you generate Prisma clients, generate the models required by Prisma clients, and perform database migrations.

```bash
npm i prisma
```

> Since Prisma CLI is a Node.js application, you need to have Node.js installed. If you are not familiar with Node.js, you can refer to [Node.js official documentation](https://nodejs.org/en/).
>
> Also, you need to add the `node_modules` directory to your `.gitignore` file to avoid committing the `node_modules` directory to the Git repository.

## 3. Initialize the Prisma project

A Prisma project is a project that contains the Prisma client and the models required by the Prisma client. You can initialize a Prisma project using the Prisma CLI.

```bash
npx prisma init
```

You will get a `.env` file that contains configuration information for the Prisma project.

```bash
DATABASE_URL="postgresql://USER:PASSWORD@HOST:PORT/DATABASE?schema=SCHEMA"
```

Please replace `USER`, `PASSWORD`, `HOST`, `PORT`, `DATABASE` and `SCHEMA` with your database information.

and a `prisma/schema.prisma` file containing the models required by the Prisma client.

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url = env("DATABASE_URL")
}
```

## 4. Install Prisma client Dart

Prisma client Dart is a Dart version of the Prisma client for interacting with the Prisma engine.

```bash
dart pub add orm
```

## 5. Modify the `generator` configuration in the `schema.prisma` file

```prisma
generator client {
  provider = "dart run orm"
}
```

## 6. Add data model

Add the data model in the `schema.prisma` file.

```prisma
model User {
   id Int @id @default(autoincrement())
   name String
   email String @unique
}
```

## 7. Push the model to the database

```bash
npx prisma db push
```

## 8. Install `build_runner` and `json_serializable`

```bash
dart pub add build_runner -d # required
dart pub add json_serializable -d # required
dart pub add json_annotation # optional, but recommended
```

## 9. Generate Prisma client

```bash
npx prisma generate
dart run build_runner build
```

## 10. Using the Prisma Client

```dart
import 'package:orm/logger.dart';

import 'prisma_client.dart';

final prisma = PrismaClient(
   stdout: Event.values, // print all events to the console
   datasources: Datasources(
     db: 'postgresql://USER:PASSWORD@HOST:PORT/DATABASE?schema=SCHEMA',
   ),
);

main() async {
   try {
     final user = await prisma.user.create(
       data: UserCreateInput(
         name: 'Alice',
         email: 'alice@prisma.pub',
       ),
     );

     print(user);
   } finally {
     await prisma. $disconnect();
   }
}
```
