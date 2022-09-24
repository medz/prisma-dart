# Prisma ORM simple example

## Getting started

> **Prerequisites**: Dart SDK `>=2.18.0 <3.0.0`

### 1. Edit the `.prismarc` file to match your database connection:

```
# Change this to your database connection string
DATABASE_URL = "postgres://seven@localhost:5432/demo?schema=public"
```

### 2. Run the `db push` command to create the database schema:

```bash
dart run orm db push
```

### 3. Run the `generate` command to generate the Prisma Client API:

```bash
dart run orm generate
```

### 4. Run `build_runner` to generate the model deserialize:

```bash
dart run build_runner build
```

## Model deserialize (Why run `build_runner build`?)

The `build_runner` is used to generate the model deserialize. The model deserialize is used to deserialize the database query result to the model instance.

## Example
```dart
import 'package:example/example.dart';

void main(List<String> args) async {
  // Create a prisma client instance
  final prisma = PrismaClient();

  // Find id equals 1 user
  final User? user = await prisma.user.findUnique(
    where: UserWhereUniqueInput(id: 1),
  );

  // Print user json map.
  print(user?.toJson());

  // Disconnect prisma client
  await prisma.$disconnect();
}
```

## Learn more

Try running the `dart run bin/simple.dart` command, which will insert a piece of data into the database.
