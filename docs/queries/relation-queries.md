# Relation queries

A key feature of Prisma Client is the ability to query relations between two or more models. Relation queries include:

[[toc]]

## Nested reads

Nested reads allow you to read related data from multiple tables in your database - such as a user and that user's posts. You can:

- Use `include` to include related records, such as a user's posts or profile, in the query response.
- Use a nested `select` to include specific fields from a related record. You can also nest `select` inside an `include`.

The following example returns a single user and that user's posts:

<<< @/../example/codes/nested_read.dart#snippet

### Include all fields for a specific relation

The following example returns a post and its author:

<<< @/../example/codes/post_with_author.dart#snippet

### Include deeply nested relations

You can nest `include` options to include relations of relations. The following example returns a user's posts, and each post's categories:

<<< @/../example/codes/user_with_posts_with_categories.dart#snippet

### Select specific relation fields

You can use a nested `select` to choose a subset of relation fields to return. For example, the following query returns the user's `name` and the `title` of each related post:

<<< @/../example/codes/user_with_posts_title.dart#snippet

You can also nest a `select` inside an `include` - the following example returns all User fields and the `title` field of each post:

<<< @/../example/codes/user_with_posts_title.dart#select-only-nested-posts-title

Note that you **cannot** use `select` and `include` on the same level. This means that if you choose to `include` a user's post and `select` each post's `title`, you cannot select only the user's `email`:

```dart
final user = await prisma.user.findFirst(
    select: UserSelect( // This won't work! // [!code error]
        email: true,
    ),
    include: UserInclude( // This won't work! // [!code error]
        posts: PrismaUnion.$2(
          UserPostsArgs(
            select: PostSelect(title: true),
          ),
        ),
    ),
);
```

Instead, use nested select options:

<<< @/../example/codes/user_with_posts_title.dart#snippet

## Relation count

you can [`include` or `select` a count of relations](./aggregation-grouping-summarizing#count-relations) alongside fields - for example, to return a user for example, a user's post count:

<<< @/../example/codes/relation-queries.dart#relation-count

## Filter a list of relations

When you use `select` or `include` to return a subset of the related data, you can **filter and sort the list of relations** inside the `select` or `include`.

For example, the following query returns all users and a list of titles of the unpublished posts associated with each user:

<<< @/../example/codes/relation-queries.dart#filter-list-of-relations

You can also write the same query using `include` as follows:

<<< @/../example/codes/relation-queries.dart#filter-list-of-relations-include

## Nested writes

A nested write allows you to write **relational data** to your database in **a single transaction**.

Nested writes:

- Provide **transactional guarantees** for creating, updating or deleting data across multiple tables in a single Prisma Client query. If any part of the query fails (for example, creating a user succeeds but creating posts fails), Prisma Client rolls back all changes.
- Support any level of nesting supported by the data model.
- Are available for relation fields when using the model's create or update query. The following section shows the nested write options that are available per query.

### Create a related record

You can create a record and one or more related records at the same time. The following query creates a User record and two related Post records:

<<< @/../example/codes/relation-queries.dart#create-a-related-record

### Create a single record and multiple related records

There are two ways to create or update a single record and multiple related records - for example, a user with multiple posts:

- Use a nested `create` query to create the related records.
- Use a nested `createMany` query to create the related records.

Each technique has pros and cons:

| Feature                               | `crteate` | `createMany` | Description                                                                                                                                                                                  |
| ------------------------------------- | --------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Creates one record at a time          | ✅        | ❌           | Potentially less performant.                                                                                                                                                                 |
| Creates all records in one query      | ❌        | ✅           | Potentially more performant.                                                                                                                                                                 |
| Supports nesting additional relations | ✅        | ❌ `*`       | For example, you can create a user, several posts, and several comments per post in one query. ` *` You can manually set a foreign key in a has-one relation - for example: `{ authorId: 9}` |
| Supports skipping duplicate records   | ❌        | ❌           | Use `skipDuplicates` query option.                                                                                                                                                           |
| Supports has-many relations           | ✅        | ✅           | For example, you can create a user and multiple posts (one user has many posts)                                                                                                              |
| Supports many-to-many relations       | ✅        | ❌           | For example, you can create a post and several categories (one post can have many categories, and one category can have many posts)                                                          |

The following query uses nested `create` to create:

- One user
- Two posts for that user
- One post category for each post

The example uses a nested `include` include all posts and post categories:

<<< @/../example/codes/relation-queries.dart#code1

The following query uses a nested `createMany` to create:

- One user
- Two posts for that user

The example uses a nested `include` to include all posts:

<<< @/../example/codes/relation-queries.dart#code2

> **NOTE**: It is **not possible** to nest an additional `create` or `createMany` inside the highlighted query, which means that you cannot create a user, posts, and post categories at the same time.

### Create multiple records and multiple related records

You cannot access relations in a `createMany` query, which means that you cannot create multiple users and multiple posts in a single nested write. The following is **not possible**:

<<< @/../example/codes/relation-queries.dart#code3

### Connect multiple records

The following query creates (`create`) a new `User` record and connects that record (`connect`) to three existing posts:

<<< @/../example/codes/relation-queries.dart#code4

::: info

Prisma Client throws an exception if any of the post records cannot be found:

```
connect: [{ id: 1 }, { id: 2 }, { id: 3 }]
```

:::

### Connect a single record

You can `connect` an existing record to a new or existing user.
The following query connects an existing post (`id: 11`) to an existing user (`id: 9`)

<<< @/../example/codes/relation-queries.dart#code5

### Connect or create a record

If a related record may or may not already exist, use `connectOrCreate` to connect the related record:

> Connect a User with the email address viola@prisma.io or
> Create a new User with the email address viola@prisma.io if the user does not already exist

<<< @/../example/codes/relation-queries.dart#code6

### Disconnect a related record

To `disconnect` one out of a list of records (for example, a specific blog post) provide the ID or unique identifier of the record(s) to disconnect:

<<< @/../example/codes/relation-queries.dart#code7

To `disconnect` one record (for example, a post's author), use `disconnect: PrismaUnion.$1(true)`:

<<< @/../example/codes/relation-queries.dart#code8

### Disconnect all related records

To `disconnect` all related records in a one-to-many relation (a user has many posts),
`set` the relation to an empty list as shown:

<<< @/../example/codes/relation-queries.dart#code9

### Delete all related records

Delete all related `Post` records for a specific `User`:

<<< @/../example/codes/relation-queries.dart#code10

### Delete specific related records

Update a user by deleting all unpublished posts:

<<< @/../example/codes/relation-queries.dart#code11

Update a user by deleting specific posts:

<<< @/../example/codes/relation-queries.dart#code12

### Update all related records (or filter)

You can use a nested `updateMany` to update all related records for a particular user. The following query unpublishes all posts for a specific user:

<<< @/../example/codes/relation-queries.dart#code13

## Relation filters

### Filter on "-to-many" relations

Prisma Client provides the `some`, `every` and `none` options to filter records by the properties of related records on the "-to-many" side of the relation. For example, filtering users based on properties of their posts.

For example:

| Requirement                                                                 | Query option to use                 |
| --------------------------------------------------------------------------- | ----------------------------------- |
| "I want a list of every User that has at least one unpublished Post record" | `some` posts are unpublished        |
| "I want a list of every User that has no unpublished Post records"          | `none` of the posts are unpublished |
| "I want a list of every User that has only unpublished Post records"        | `every` post is unpublished         |

For example, the following query returns User that meet the following criteria:

- No posts with more than 100 views
- All posts have less than, or equal to 50 likes

<<< @/../example/codes/relation-queries.dart#code14

### Filter on "-to-one" relations

Prisma Dart Client provides the `$is` and `isNot` options to filter records by the properties of related records on the "-to-one" side of the relation. For example, filtering posts based on properties of their author.

For example, the following query returns all posts that meet the following criteria:

- Author's name is not Bob
- Author is older than 40

<<< @/../example/codes/relation-queries.dart#code15

### Filter on absence of "-to-many" records

For example, the following query uses `none` return all users that have zero posts:

<<< @/../example/codes/relation-queries.dart#code16

### Filter on absence of "-to-one" relations

The following query returns all posts that don't have an author relation:

<<< @/../example/codes/relation-queries.dart#code17

### Filter on presence of related records

The following query returns all users with at least one post:

<<< @/../example/codes/relation-queries.dart#code18
