# CRUD

This page describes how to perform CRUD operations with your generated Prisma Client API. CRUD is an acronym that stands for:

- [Create](#create)
- [Read](#read)
- [Update](#update)
- [Delete](#delete)

Refer to the [Client API Reference documentation](../references/client-api.md) for a complete list of all available methods.

## Example schema and provider

All examples are based on the following Prisma schema:

::: details Expand to view the schema (`schema.prisma`)

<<< @/../docs-example/prisma/schema.prisma

:::

::: details Expand to view the provider (`prisma.dart`)
<<< @/../docs-example/prisma.dart
:::

## Create

### Create a single record

The following query creates (`create`) a single record of the `User` model with two fields:

<<< @/../docs-example/codes/create_single_record.dart#snippet

::: details show query results

```
{id: 1, email: seven@odroe.com, name: Seven Du, role: USER}
```

:::

The user's `id` is automatically generated by the database.

### Create multiple records

The following `createMany` query creates multiple users and skips any duplicates ( `email`` must be unique):

<<< @/../docs-example/codes/create_multiple_records.dart#snippet

::: details show query results

```
{count: 3}
```

:::

::: tip

The `skipDuplicates` is not support when using **MongoDB** and **SQL Server**.

:::

### Create records and connect or create related records

See [Related queries -> Nested writes](./relation-queries.md#nested-writes) for information about creating a record and one or more related at the same time.

## Read

### Get record by ID or unique field

The following queries return a single record (`findUnique`) by ID or unique field:

::: code-group

<<< @/../docs-example/codes/get_record_by_id.dart#snippet
<<< @/../docs-example/codes/get_record_by_unique_field.dart#snippet

:::

### Get all records

The following `findMany` query return all `User` records:

<<< @/../docs-example/codes/get_all_records.dart#snippet

You cal also [Paginate you resules](./pagination).

### Get the first record that matches a specific criteria

The following ` findFirst`` query returns the most recently created  `User`` with at least one `post`` that has more than `100` likes:

1. Order users by descending ID (largest first) - the largest ID is the most recently created user.
2. Filter users by the existence of at least one post with more than 100 likes.

<<< @/../docs-example/codes/get_first_record_that_matches_criteria.dart#snippet

### Get a filtered list of records

Prisma Dart client supports [Filtering](./filtering-and-sorting) on record fields and related fields.

#### Filter by a single field value

The following query returns all `User` records with an email that ends in "odroe.com":

<<< @/../docs-example/codes/filter_by_single_field_value.dart#snippet

#### Filter by multiple field values

The following query users combination of operators to return users whser name start with `S` or role is `ADMIN`:

<<< @/../docs-example/codes/filter_by_multiple_field_values.dart#snippet

#### Filter by related record field values

The following query returns users with an email that domain is `odroe.com` and have at least one post (`somo`) that is not published:

<<< @/../docs-example/codes/filter_by_related_record_field_values.dart#snippet

See [Working with relations](./relation-queries) for more examples of filtering on related field values.

### Select a subset of fields

The following `findUnique` query uses `select` to return the `name` and `email` fields of a specific `User` record:

<<< @/../docs-example/codes/select_subset_of_fields.dart#snippet

For more information about including relations, refer to:

- [Select fields](./select-fields)
- [Relation queries](./relation-queries)

#### Select a subset of related record fields

The following query uses a nested select to return:

- The `User`'s `email` field
- The `likes` field of each `Post`

<<< @/../docs-example/codes/select_subset_of_related_record_fields.dart#snippet

### Include related records

The following query returns all `ADMIN` users and includes each user's posts in the result:

<<< @/../docs-example/codes/include_related_records.dart#snippet

For more information about including relations, see [Select fields -> Nested reads](./select-fields.md#nested-reads).

## Update

### Update a single record

The following query uses `update` to find and update a single `User` record by `email`:

<<< @/../docs-example/codes/update_single_record.dart#snippet

::: details show query results

```
{id: 1, email: seven@odroe.com, name: Seven Odroe, role: USER}
```

:::

### Update multiple records

The following query uses `updateMany` to update all User records `role` to `ADMIN` that contain `odroe.com` in their email:

<<< @/../docs-example/codes/update_multiple_records.dart#snippet

::: details show query results

```
{ count: 1 }
```

:::

### Update or create records

The following query uses `upsert` to update a `User` record with a specific `email` address, or create that `User` record if it does not exist:

<<< @/../docs-example/codes/update_or_create_record.dart#snippet

> From version 4.6.0, Prisma carries out upserts with database native SQL commands where possible.
>
> [Learn more](https://www.prisma.io/docs/orm/reference/prisma-client-reference#database-upserts)

#### Find or create

You can use Dart `extension` to create a `findOrCreate` method:

<<< @/../docs-example/codes/find_or_create_record.dart#extension

Now you can use `findOrCreate` method:

<<< @/../docs-example/codes/find_or_create_record.dart#snippet

::: warning

Prisma does not have a findOrCreate query. You can use upsert as a workaround. To make upsert behave like a findOrCreate method, provide an empty update parameter to upsert.

:::

### Update a number field

Use atomic number operations to update a number field **based on its current value** - for example, `increment` or `multiply`. The following query increments the `views` and `likes` fields by `1`:

<<< @/../docs-example/codes/update_number_field.dart#snippet

## Delete

### Delete a single record

The following query uses `delete` to delete a single `User` record:

<<< @/../docs-example/codes/delete_single_record.dart#snippet

Attempting to delete a user with one or more posts result in an error, as every Post requires an author - See 👉 [Cascading deletes](#cascading-deletes-deleting-related-records)

### Delete multiple records

The following query uses `deleteMany` to delete all `Use` records where `email` domain is `odroe.com`:

<<< @/../docs-example/codes/delete_multiple_records.dart#snippet

Attempting to delete a user with one or more posts result in an error, as every Post requires an author - See 👉 [Cascading deletes](#cascading-deletes-deleting-related-records)

### Delete all records

The following query uses `deleteMany` to delete all `User` records:

<<< @/../docs-example/codes/delete_all_records.dart#snippet

Be aware that this query will fail if the user has any related records (such as posts).
In this case, you need to [delete related records first](#cascading-deletes-deleting-related-records).

#### Cascading deletes (deleting related records)

The following query uses `delete` to delete a single `User` record:

<<< @/../docs-example/codes/delete_single_record.dart#snippet

However, the example schema includes a **required relation** between `Post` and `User`,
which means that you cannot delete a user with posts:

```text
The change you are trying to make would violate the required relation 'PostToUser' between the `Post` and `User` models.
```

To resolve this error, you can:

1. Make the relation optional:
   ```prisma
   model Post {
        id       Int   @id @default(autoincrement())
        author   User? @relation(fields: [authorId], references: [id]) // [!code ++]
        authorId Int? // [!code ++]
        author   User  @relation(fields: [authorId], references: [id]) // [!code --]
        authorId Int // [!code --]
   }
   ```
2. Change the author of the posts to another user before deleting the user.
3. Delete a user and all their posts with two separate queries in a transaction (all queries must succeed):
   ```dart
   await prisma.$transaction((prisma) async {
        await prisma.post.deleteMany();
        await prisma.user.deleteMany();
   });
   ```

## Unserializable query values

Prisma Client Dart supports the following unserializable query values:

```dart
final data = await prisma.user.findMany().unserialized();
```

**All models actions support `unserialized` method.**
