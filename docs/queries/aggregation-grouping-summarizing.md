# Aggregation, grouping, and summarizing

Prisma Dart Client allows you to count records, aggregate number fields, and select distinct field values.

## Aggregate

Prisma Dart Client allows you to `aggregate` on the **number** fields (such as `Int` and `Float`) of a model. The following query returns the average age of all users:

<<< @/../docs-example/codes/aggregate.dart#1

You can combine aggregation with filtering and ordering. For example, the following query returns the average age of users:

- Ordered by `age` ascending
- Where `email` contains `hello`
- Limited to the 10 users

<<< @/../docs-example/codes/aggregate.dart#2

### Aggregate values are nullable

aggregations on **nullable fields** can return a `num` or `null`.
This excludes `$count` which always returns 0 if no records are found.

Consider the following query, where `age` is nullable in the schema:

<<< @/../docs-example/codes/aggregate.dart#3

The query returns `{ _avg: { age: null } }` in either of the following scenarios:

- There are no users
- The value of every user's `age` field is `null`

This allows you to differentiate between the true aggregate value (which could be zero) and no data.

## Group by

Prisma Datr client `groupBy` allows you to **group records** by one or more field values - such as `country`, or `country` and `city` and **perform aggregations** each group, such as finding the average age of people living in a particular city.

The following example groups all users by the `country` field and returns the total number of profile views for each country:

<<< @/../docs-example/codes/aggregate.dart#4

If you have a single element in the by option, you can use the following shorthand syntax to express your query:

<<< @/../docs-example/codes/aggregate.dart#5

### `groupBy` and filtering

`groupBy` supports two levels of filtering: `where` and `having`.

#### Filter records with `where`

Use `where` to filter all records **before grouping**.
The following example groups users by country and sums profile views, but only includes users where the email address contains `test`:

<<< @/../docs-example/codes/aggregate.dart#6

#### Filter groups with `having`

Use `having` to filter entire groups by an aggregate value such as the sum or average of a field, not individual records - for example, only return groups where the average profileViews is greater than 100:

<<< @/../docs-example/codes/aggregate.dart#7

### `groupBy` and ordering

The following constraints apply when you combine `groupBy` and `orderBy`:

- You can `orderBy` fields that are present in `by`
- You can `orderBy` aggregate
- If you use `skip` and/or `take` with `groupBy`, you must also include `orderBy` in the query

#### Order by aggregate group

The following example sorts each `city` group by the number of users in that group (largest group first):

<<< @/../docs-example/codes/aggregate.dart#8

#### Order by field

The following query orders groups by country, skips the first two groups, and returns the 3rd and 4th group:

<<< @/../docs-example/codes/aggregate.dart#9
