# Select fields

By default, when a query returns records (as opposed to a count), the result includes the **default selection set**:

- **All** scalar fields defined in the Prisma schema (including enums)
- **None** of the relation fields defined in the Prisma schema

To customize the result:

- Use `select` to specify a subset of fields to include in the result.
- Use `include` to specify a subset of relation fields to include in the result.

## Example schema and provider

All examples are based on the following Prisma schema:

::: details Expand to view the schema (`schema.prisma`)

<<< @/../example/prisma/schema.prisma

:::

::: details Expand to view the provider (`prisma.dart`)
<<< @/../example/prisma.dart
:::

## Return the default selection set

The following query returns the default selection set (all scalar fields, no relations):

<<< @/../example/codes/get_record_by_id.dart#snippet

::: details Expand to view the result

```json
{
  "id": 1,
  "name": "Seven",
  "email": "seven@odroe.com",
  "role": "ADMIN"
}
```

:::

## Select specific fields

Use `select` to return a limited subset of fields instead of all fields. The following example returns the `email` and `name` fields only:

<<< @/../example/codes/select_subset_of_fields.dart#snippet

::: details Expand to view the result

```json
{
  "name": "Seven",
  "email": "seven@odroe.com"
}
```

:::

## Include relations and select relation fields

Use `include` to return a subset of relation fields. The following example returns the `name` field of the `User` record, and the `title` field of the `Post` relation:

<<< @/../example/codes/include_relation_fields.dart#snippet

::: details Expand to view the result

```json
{
  "name": "Seven",
  "posts": [
    {
      "title": "My first blog post"
    },
    {
      "title": "My second blog post"
    }
  ]
}
```

:::

The following query uses select within an `include`, and returns all user fields and each post's `title` field:

<<< @/../example/codes/include_relation_fields_with_select.dart#snippet

::: details Expand to view the result

```json
{
  "id": 1,
  "name": "Seven",
  "email": "seven@odroe.com",
  "role": "ADMIN",
  "posts": [
    {
      "title": "My first blog post"
    },
    {
      "title": "My second blog post"
    }
  ]
}
```

:::

For more information about querying relations, refer to the following documentation:

- [Include a relation (including all fields)](./relation-queries.md#include-all-fields-for-a-specific-relation)
- [Select specific relation fields](./relation-queries.md#select-specific-relation-fields)

## Relation count

you can [`include` or `select` a count of relations](./aggregation-grouping-summarizing#count-relations) alongside fields - for example, a user's post count.
