# CRUD

The page describes how to use CRUD operations with your generated Prisma client API.

CRUD is an acronym for Create, Read, Update, Delete. It's a common set of operations that you need to perform on your data. The Prisma client API exposes methods for each of these operations.

## Example schema

For the examples below, we'll use the following model:

```prisma
model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String
  posts Post[]
}

model Post {
  id        Int     @id @default(autoincrement())
  title     String
  published Boolean @default(false)
  author    User    @relation(fields: [authorId], references: [id])
  authorId  Int
}
```

## Create

### Create a single record

The following example creates a single `User` record:

```dart
final user = await prisma.user.create(
  data: UserCreateInput(
    email: 'hello@odroe.com',
    name: 'Odroe',
  ),
);
```

### Create multiple records

The following `createMany` API query creates multiple `User` records and skips any duplicates (based on the `email` field):

```dart
final affectedRowsOutput = await prisma.user.createMany(
  data: [
    UserCreateManyInput(name: 'Alice',email: 'alice@prisma.pub'),
    UserCreateManyInput(name: 'Bob',email: 'bob@prisma.pub'),
    UserCreateManyInput(name: 'Bobo',email: 'bob@prisma.pub'), // duplicate email
  ],
  skipDuplicates: true,
);

print(affectedRowsOutput.count); // 2
```

## Read

### Get a record by ID or unique identifier

The following queries return a single `User` by ID or unique identifier:

```dart
// By ID
final user = await prisma.user.findUnique(
  where: UserWhereUniqueInput(id: 1),
);

// By unique identifier
final user = await prisma.user.findUnique(
  where: UserWhereUniqueInput(email: 'bob@prisma.pub'),
);
```

### Get record by compound ID or compound unique identifier

The following examples demonstrate how to retrieve records by a compound ID or unique identifier, defined by `@@id`  or `@@unique`.

The following Prisma model defines a compound ID:

```prisma
model TimePeriod {
  year    Int
  quarter Int
  total   Decimal

  @@id([year, quarter])
}
```

To retrieve a time period by this compound ID, use the generated year_quarter field, which follows the `fieldName1_fieldName2` pattern:

```dart
final timePeriod = await prisma.timePeriod.findUnique(
  where: TimePeriodWhereUniqueInput(
    year_quarter: TimePeriodYearQuarterCompoundUniqueInput(year: 2020, quarter: 1),
  ),
);
```

The following Prisma model defines a compound unique identifier with a custom name (`timePeriodId`)

```prisma
model TimePeriod {
  year    Int
  quarter Int
  total   Decimal

  @@unique(fields: [year, quarter], name: "timePeriodId")
}
```

To retrieve a time period by this unique identifier, use the custom `timePeriodId` field:

```dart
final timePeriod = await prisma.timePeriod.findUnique(
  where: TimePeriodWhereUniqueInput(
    timePeriodId: TimePeriodTimePeriodIdCompoundUniqueInput(year: 2020, quarter: 1),
  ),
);
```

### Get all records

The following `findMany` query returns all User records:

```dart
final users = await prisma.user.findMany();
```

## Update

### Update a single record

The following example updates a single `User` record:

```dart
final user = await prisma.user.update(
  where: UserWhereUniqueInput(id: 1),
  data: UserUpdateInput(name: 'Alice'),
);
```

### Update multiple records

The following `updateMany` API query updates multiple `User` records:

```dart
final affectedRowsOutput = await prisma.user.updateMany(
  where: UserWhereInput(name: 'Bob'),
  data: UserUpdateInput(name: 'Bobo'),
);

print(affectedRowsOutput.count); // 2
```

### Update or create a record

The following `upsert` API query updates a `User` record if it exists, or creates a new one if it doesn't:

```dart
final user = await prisma.user.upsert(
  where: UserWhereUniqueInput(email: 'bob@prisma.pub'),
  create: UserCreateInput(name: 'Bob', email: 'bob@prisma.pub'),
  update: UserUpdateInput(name: 'Bob'),
),

print(user.name); // Bob
```

## Delete

### Delete a single record

The following example deletes a single `User` record:

```dart
final user = await prisma.user.delete(
  where: UserWhereUniqueInput(id: 1),
);
```

### Delete multiple records

The following `deleteMany` API query deletes multiple `User` records:

```dart
final affectedRowsOutput = await prisma.user.deleteMany(
  where: UserWhereInput(name: 'Bob'),
);
```

### Delete all records

The following `deleteMany` API query deletes all `User` records:

```dart
final affectedRowsOutput = await prisma.user.deleteMany();
```

## Throw on not found

By default, the Prisma client API returns `null` when a record is not found.

If you want to throw an error instead, you can use the `<operation>OrThrow` API query. For example, the following `findUniqueorThrow` query throws an error if the record is not found:

```dart
final user = await prisma.user.findUniqueOrThrow(
  where: UserWhereUniqueInput(id: 1),
);
```

Supported operations:

- `findUniqueOrThrow`
- `findFirstOrThrow`
