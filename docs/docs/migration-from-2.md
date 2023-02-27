# Migration from 2.x

Migrating from `orm` 2.x version to `3.x` version.

## Schema

Update your `prisma/schema.prisma` file to use the new `generator` syntax.

```diff
generator client {
-  provider = "prisma-client-dart"
+  provider = "dart run rom"
}
```

## Logging

Update your `PrismaClient` parameters to use the new `PrismaClient` constructor.

```diff
final prisma = PrismaClient(
-   log: ...,
+   stdout: ...,
+   event: ...,
);

### If You is `2.6` version

```diff
final prisma = createPrismaClient(
-   log: ...,
+   stdout: ...,
+   event: ...,
);
```

## Prisma client datasources

```diff
final prisma = PrismaClient(
-     datasources: Datasources(
-         db: Datasource(url: '...'),
-     ),
+     datasources: { db: '...' },
);
```

### If You is `2.6` version

```diff
final prisma = createPrismaClient(
-     datasources: Datasources(
-         db: Datasource(url: '...'),
-     ),
+     datasources: { db: '...' },
);
```

## Add Prisma CLI to your project

```bash
npm i prisma
```

> See [Prisma CLI](https://www.prisma.io/docs/concepts/components/prisma-cli) for more information.

## Add `node_modules` to your `.gitignore` file

```diff
# .gitignore
+ node_modules/
```

## Regenerate you `.g.dart` files

```bash
dart run build_runner build
```

## Tips

Now binary stored in `node_modules/prisma/query-engine-<platform>`

Take macOS (Intel) as an example, store in `node_modules/prisma/query-engine-darwin`.
