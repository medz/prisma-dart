# Filtering and Sorting

Prisma Dart Client supports filtering with the where query option, and sorting with the orderBy query option.

## Filtering

Prisma Client allows you to filter records on any combination of model fields, including related models, and supports a variety of filter conditions.

The following query:

- Returns all User records with
  - an email address that ends with `odore.com`
  - at least one published post (a relation query)
- Returns all User fields
- Includes all related Post records where `published` equals `true`

<<< @/../docs-example/codes/filtering_and_sorting.dart#1

### Filter on null fields

The following query returns all posts whose `content` field is `null`:

<<< @/../docs-example/codes/filtering_and_sorting.dart#2

Filter for non-null fields

The following query returns all posts whose `content` field is not `null`:

<<< @/../docs-example/codes/filtering_and_sorting.dart#3

### Filter on relations

Prisma Client supports filtering on related records. For example, in the following schema, a user can have many blog posts:

```prisma
model User {
  id    Int     @id @default(autoincrement())
  name  String?
  email String  @unique
  posts Post[] // User can have many posts // [!code ++]
}

model Post {
  id        Int     @id @default(autoincrement())
  title     String
  published Boolean @default(true)
  author    User    @relation(fields: [authorId], references: [id]) // [!code ++]
  authorId  Int // [!code ++]
}
```

The one-to-many relation between User and Post allows you to query users based on their posts - for example, the following query returns all users where at least one post (`some`) has more than 10 views:

<<< @/../docs-example/codes/filtering_and_sorting.dart#4

You can also query posts based on the properties of the author. For example, the following query returns all posts where the author's `email` contains `odroe.com`:

<<< @/../docs-example/codes/filtering_and_sorting.dart#5

### Filter on scalar lists / arrays

Scalar lists (for example `String[]`) have a special set of filter conditions - for example, the following query returns all posts where the `tags` array contains `databases`:

<<< @/../docs-example/codes/filtering_and_sorting.dart#6

### Case-insensitive filtering

Case-insensitive filtering is available as a feature for the PostgreSQL and MongoDB providers. MySQL, MariaDB and Microsoft SQL Server are case-insensitive by default, and do not require a Prisma Client feature to make case-insensitive filtering possible.

To use case-insensitive filtering, add the `mode` property to a particular filter and specify `insensitive`:

<<< @/../docs-example/codes/filtering_and_sorting.dart#7

More see 👉 [Case Insensitive](https://www.prisma.io/docs/orm/prisma-client/queries/case-sensitivity) official docs.

## Sorting

Use `orderBy` to sort a list of records or a nested list of records by a particular field or set of fields. For example, the following query returns all User records sorted by role and name, and each user's posts sorted by title:

<<< @/../docs-example/codes/filtering_and_sorting.dart#8

### Sort by relation

You can also sort by properties of a relation. For example, the following query sorts all posts by the author's email address:

<<< @/../docs-example/codes/filtering_and_sorting.dart#9

### Sort by relation aggregate value

you can sort by the **count of related records**,
For example, the following query sorts users by the number of related posts:

<<< @/../docs-example/codes/filtering_and_sorting.dart#10
