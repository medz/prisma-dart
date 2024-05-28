# Prisma Dart v4.2.0

To install Prisma Client for Dart v4.2.0 run:

```bash
dart pub add orm:4.2.0
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^4.2.0
```

# Prisma Dart v4.1.1

To install Prisma Client for Dart v4.1.1 run:

```bash
dart pub add orm:4.1.1
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^4.1.1
```

## What's Changed

* Fixed typo in Changelog | Priama -> Prisma by @saphalpdyl in https://github.com/medz/prisma-dart/pull/358
* fix(deps): update dependency webfetch to ^0.0.16 by @renovate in https://github.com/medz/prisma-dart/pull/359
* chore(deps): update dependency lints to v4 by @renovate in https://github.com/medz/prisma-dart/pull/362
* feat: Added docs of running on Docker by @kerimamansaryyev in https://github.com/medz/prisma-dart/pull/363
* fixes: #365; by @atharvapalaskar in https://github.com/medz/prisma-dart/pull/366

## New Contributors

* @saphalpdyl made their first contribution in https://github.com/medz/prisma-dart/pull/358
* @renovate made their first contribution in https://github.com/medz/prisma-dart/pull/359
* @kerimamansaryyev made their first contribution in https://github.com/medz/prisma-dart/pull/363
* @atharvapalaskar made their first contribution in https://github.com/medz/prisma-dart/pull/366

**Full Changelog**: https://github.com/medz/prisma-dart/compare/v4.1.0...orm-v4.1.1

# Prisma Client Dart v4.1.0

To install Prisma Client for Dart v4.1.0 run:

```bash
dart pub add orm:4.1.0
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.1.0
```

## What's Changed

- data model add `toJson` method by @medz in https://github.com/medz/prisma-dart/pull/352

# Prisma Client Dart v4.0.3

To install Prisma Client for Dart v4.0.3 run:

```bash
dart pub add orm:4.0.3
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.3
```

## What's Changed

- **Bug**: fix for `code_builder` not handling CRLF case

# Prisma Client Dart v4.0.2

To install Prisma Client for Dart v4.0.2 run:

```bash
dart pub add orm:4.0.2
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.2
```

## What's Changed

- **Bug**: Fixed the `Json` class not found in the generated code.

# Prisma Client Dart v4.0.1

To install Prisma Client for Dart v4.0.1 run:

```bash
dart pub add orm:4.0.1
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.1
```

## What's Changed

- **Bug**(Generator): Fixed duplicate enum field name is `name`.

# Prisma Client Dart v4.0.0

To install Prisma Client Dart v4.0.0 run:

```bash
dart pub add orm:4.0.0
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0
```

## What's Changed

- **Bug**: Fixed list of primitive type not parsing correctly (https://github.com/medz/prisma-dart/issue/331)

# Prisma Client Dart v4.0.0-beta.3

To install Prisma Client Dart v4.0.0-beta.3 run:

```bash
dart pub add orm:4.0.0-beta.3
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-beta.3
```

## What's Changed

- **Bug**: Fixed list of enum not parsing correctly (https://github.com/medz/prisma-dart/issues/329)

## Credits

- @lucasvaudey
- @NeroSong

# Prisma Client Dart v4.0.0-beta.2

To install Prisma Client Dart v4.0.0-beta.2 run:

```bash
dart pub add orm:4.0.0-beta.2
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-beta.2
```

## What's Changed

1. **Bug**: Use relative paths to execute the engine.

# Prisma Client Dart v4.0.0-beta.1

To install Prisma Client Dart v4.0.0-beta.1 run:

```bash
dart pub add orm:4.0.0-beta.1
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-beta.1
```

## What's Changed

- fix relations are throwing error when you use include, https://github.com/medz/prisma-dart/issues/324

## Thanks

@kidusdev

# Prisma Client Dart v4.0.0-beta

To install Prisma Client Dart v4.0.0-beta run:

```bash
dart pub add orm:4.0.0-beta
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-beta
```

## What's Changed

The **first Beta version is released**. This version is a major version. We will conduct a lot of testing on this version to ensure the stability of this version.
In addition, there are no actual code updates in this version, the documentation brings updates to the API Reference:

1. [Client API Reference](https://prisma.pub/references/client-api.html)
2. [Model Delegate API Reference](https://prisma.pub/references/model-delegate.html)

# Prisma Dart client v4.0.0-alpha.5

To install Prisma Dart client v4.0.0-alpha.5 run:

```sh
dart pub add orm:4.0.0-alpha.5
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-alpha.5
```

## What's Changed

1. **FIX** fix transaction isolation level not expected.

# Prisma Dart client v4.0.0-alpha.4

To install Prisma Dart client v4.0.0-alpha.4 run:

```sh
dart pub add orm:4.0.0-alpha.4
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-alpha.4
```

## What's Changed

1. **OPTIMIZATION** Prisma Dart client generator outputs more user-friendly error messages that help you know where the problem lies.
2. **REFACTOR** Adjust src code storage structure.
3. **FIX** Rethrow start error
4. **FIX** Fix input types required multiple fields.
5. **FIX** Fix relation count not arguments in include.

# Prisma Dart client v4.0.0-alpha.3

To install Prisma Dart client v4.0.0-alpha.3 run:

```sh
dart pub add orm:4.0.0-alpha.3
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-alpha.3
```

## What's Changed

1. Dump `webfetch` to `0.0.14` version.
2. Fixed using a model name with an underscore (`_`) in `schema.prisma` causing the generator to fail.

# Prisma Dart client v4.0.0-alpha.2

To install Prisma Dart client v4.0.0-alpha.2 run:

```sh
dart pub add orm:4.0.0-alpha.2
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-alpha.2
```

## What's Changed

1. Change Dart SDK version to `^3.2.0`
2. Support **RAW** query and execute feature, See [Raw queries](#raw-queries)

## Raw queries

You can use `$raw` to execute raw queries

### `$raw.query`

Execute a raw query, for example:

```dart
final result = await prisma.$raw.query('SELECT * FROM "User"'); // PostgreSQL
```

### `$raw.execute`

Execute a raw query, for example:

```dart
final result = await prisma.$raw.execute('DELETE FROM "User"'); // PostgreSQL
```

### Parameters

`$raw.query` and `$raw.execute` support parameters, for example:

```dart
// PostgreSQL
final result = await prisma.$raw.query(
  'SELECT * FROM "User" WHERE "id" = \$1',
  [1],
);

// MySQL
final result = await prisma.$raw.query(
  'SELECT * FROM `User` WHERE `id` = ?',
  [1],
);
```

> SQL template string see your used database.

# Prisma Dart client v4.0.0-alpha.1

To install Prisma Dart client v4.0.0-alpha.0 run:

```sh
dart pub add orm:4.0.0-alpha.1
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-alpha.1
```

## What's Changed

1. Refactor the entire client generator
2. `PrismaClient` is now generated by the generator
3. Ability to operate transactions on your own
4. Use binary engine by default
5. Supports full select and include features.

# Prisma Dart client v4.0.0-alpha.0

To install Prisma Dart client v4.0.0-alpha.0 run:

```sh
# If you are using Dart
dart pub add orm:4.0.0-alpha.0

# Or if you are using Flutter
flutter pub add orm:4.0.0-alpha.0
```

To upgrade to Prisma Dart client v4.0.0-alpha.0, Please follow the [announcements](https://github.com/medz/prisma-dart/discussions/292) and update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: 4.0.0-alpha.0
```

[Read Prisma Dart Client v4.0.0-alpha.0 release notes on the Prisma Dart discussions](https://github.com/medz/prisma-dart/discussions/292)

## What's Changed

- Whole project refactoring
- Remove any JSON serialization tool, now it's ready to use by just generating the client without any other dependencies and extra commands
- Switch from GraphQL protocol to JSON protocol
- Client takes a standalone Prisma engine instance
- Client and all input/output types are standalone and can be distributed to any Dart platform
- Add database field reference support
- Support `select` feature (incomplete, currently only support rough one-level Model fields)
- Support `include` feature (incomplete, currently only support rough one-level Model fields)
- `PrismaUnion` regression, now can structure nested inputs of multiple parameters via union
- `PrismaNull` regression, now support database `null` data setting
- DMMF, generator helpers regression, no need to depend on other packages, can directly use `orm` as the base package for developing Dart Prisma ecosystem packages
- Add `Decimal` type support (from [decimal package](https://pub.dev/package/decimal), exported by `orm` proxy)
