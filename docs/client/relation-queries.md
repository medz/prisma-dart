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

<<< @/../example/codes/relation_count.dart#relation-count
