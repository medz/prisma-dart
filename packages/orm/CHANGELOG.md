## v5.3.1

* **fix**: Downgrade dart_style version.

## v5.3.0

To install Prisma ORM for Dart v5.3.0 run this command

```bash
dart pub add orm:^5.3.0
```

Otherwise, update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.3.0
```

### What's New

- **feat**: support `updateManyAndReturn`
- **engine**: upgrade `prisma-engines` to `6.2.0`

## v5.2.1

To install Prisma ORM for Dart v5.2.1 run this command

```bash
dart pub add orm:^5.2.1
```

Otherwise, update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.2.1
```

### What's New

- **bug**: Fixed an issue where unknown errors from the binary engine query were not being properly thrown as exceptions.

## v5.2.0

To install Prisma ORM for Dart v5.2.0 run this command

```bash
dart pub add orm:^5.2.0
```

Otherwise, update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.2.0
```

### What's Changed

- **BREAKING CHANGE**: Upgrade the Dart SDK min version to `^3.5.0`

## v5.1.1

To install Prisma ORM for Dart v5.1.1 run this command

```bash
dart pub add orm:^5.1.1
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.1.1
```

### What's Changed

- **fix**: primitive type fields cannot be nullable.

## v5.1.0

To install Prisma ORM for Dart v5.1.0 run this command

```bash
dart pub add orm:^5.1.0
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.1.0
```

### What's Changed

- **upstream**: Starting from Prisma v5.17.0, the new RAW raw SQL protocol has been enabled.
- **$raw**: Now `$raw.query` returns the correct data type front, instead of `dynamic`.
- **$raw**: `$raw.execute` now returns the number of rows affected as an `int`.
- **docs**: Removed param from docs that are no longer supported by the Prisma CLI

#### QueryRaw performance improvements

We’ve changed the response format of queryRaw to decrease its average size which reduces serialization CPU overhead.

When querying large data sets, we expect you to see improved memory usage and up to 2x performance improvements.

## ‼️Important Tips

Starting from version v5.1.0, only Prisma CLI v5.17.0 or higher is supported!

## v5.0.6

To install Prisma ORM for Dart v5.0.6 run this command

```bash
dart pub add orm:^5.0.6
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.0.6
```

### What's Changed

- **deps**: Upgrade the Dart SDK min version to `^3.4.0`
- **deps**: Upgrade `path` package version to `^1.9.0`
- **deps**: Upgrade `code_builder` package version to `^4.10.0`
- **docs**: Fixed generate via bun command for setup doc
- **fix**: Error of restarting the engine every time a query is made
