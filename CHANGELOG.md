# Changelog

## [3.1.5](https://github.com/odroe/prisma-dart/compare/orm-v3.1.4...orm-v3.1.5) (2023-03-17)


### Bug Fixes

* **engine:** binary engine failed to clean up process, Thx [@blopker](https://github.com/blopker) ([afc29a7](https://github.com/odroe/prisma-dart/commit/afc29a7c80e767c49b0bf8345ce095dc389e5851))
* Missing Dart reserved keywords, Thx [@nikosportolos](https://github.com/nikosportolos) ([78c467b](https://github.com/odroe/prisma-dart/commit/78c467b4ce9811465a9791d5f5376011620ff130))

## [3.1.4](https://github.com/odroe/prisma-dart/compare/orm-v3.1.3...orm-v3.1.4) (2023-03-15)


### Bug Fixes

* fix retry strategy not as expected ([d327bcb](https://github.com/odroe/prisma-dart/commit/d327bcb492fbbffcb8566728ed2e98c10960400e)), closes [#161](https://github.com/odroe/prisma-dart/issues/161)

## [3.1.3](https://github.com/odroe/prisma-dart/compare/orm-v3.1.2...orm-v3.1.3) (2023-03-14)


### Bug Fixes

* **generator:** main rethrow error ([c536887](https://github.com/odroe/prisma-dart/commit/c536887de018f1f30c6712d670a78ee6b3772da4))
* **engine:** fix retry If failure, not as expected
* **engine:** fix binary engine status retries not as expected. Thanks [@blopker](https://github.com/blopker) on [#161](https://github.com/odroe/prisma-dart/issues/161)

## [3.1.2](https://github.com/odroe/prisma-dart/compare/v3.1.1...v3.1.2) (2023-03-11)


### Bug Fixes

* Fix and optimize startup ([253fb16](https://github.com/odroe/prisma-dart/commit/253fb16dd4d9e3c8b1f917e8d3c1246f95ad61d0))

## [3.1.1](https://github.com/odroe/prisma-dart/compare/v3.1.0...v3.1.1) (2023-03-10)


### Bug Fixes

* **client:** Fix missing error handler ([8a32b6d](https://github.com/odroe/prisma-dart/commit/8a32b6d86064303d29b2c208ea22371cd1975dbd))
* **generate:** Fix datasource failed to generate dataproxy client. ([8c5b7d7](https://github.com/odroe/prisma-dart/commit/8c5b7d79af750b7a6f9c4eaac0cc022fbbaafc13))

## [3.1.0](https://github.com/odroe/prisma-dart/compare/v3.0.2...v3.1.0) (2023-03-07)


### Features

* **generator:** Only support npm ([41adccb](https://github.com/odroe/prisma-dart/commit/41adccbfa2c18808727adb0fa433924b3d8cb20e))


### Bug Fixes

* **generator:** fix node package manager find index ([a50d88f](https://github.com/odroe/prisma-dart/commit/a50d88fd3fb21cd62176a6a7e3bd08371c43494d))
* **generator:** fix node package manager not found on Windows ([a233f59](https://github.com/odroe/prisma-dart/commit/a233f59b2da11293b84c6291d0bddfcd8869399f))
* **generator:** fix parse prisma version error on Windows ([7b16821](https://github.com/odroe/prisma-dart/commit/7b168215dda0cb6e0d1f1c38d7017b271e09ac8a))
* **generator:** fix yarn query Prisma version is not json output ([34b116c](https://github.com/odroe/prisma-dart/commit/34b116ca56166ac3b83b48f2df56cad5b3bedbb4))

## [3.0.2](https://github.com/odroe/prisma-dart/compare/v3.0.1...v3.0.2) (2023-03-06)


### Bug Fixes

* **engine:** fixed logger definitions is empty throw error ([4dc62f1](https://github.com/odroe/prisma-dart/commit/4dc62f1ebe2cde209d12ec5fc9044952201d722c))
* **generator:** fixed Windows  system cannot find the file specified ([6446739](https://github.com/odroe/prisma-dart/commit/64467396e6d1b6253f0e5b0bbc7f9f73a05257dc))

## [3.0.1](https://github.com/odroe/prisma-dart/compare/3.0.0...v3.0.1) (2023-03-05)


### Bug Fixes

* **client:** fixed prisma transaction type ([2cf52ad](https://github.com/odroe/prisma-dart/commit/2cf52add55538b00659d3460f17e38035d7da4b3))

## 3.0.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v3.0.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/3.0.0) about the release. 🌟

> **Note**: Migration from 2.x to 3.x guide is available [here](https://prisma.pub/docs/migration-from-2.html).

## 3.0.1-beta+0

No changes.

## 3.0.0-beta+3

### Bug Fixes

* generate: fixed model delegate resolve GraphQL top-level field (35ebc6a)

## 2.6.2

1. Fixed `DateTime` to `String` must be ISO8601 format error - [#103](https://github.com/odroe/prisma-dart/issues/103)
2. Fixed `PrismaNull` being serialized as `null` error.

## 2.6.1

1. Fixed generated freezed file has undefined class error - [#96](https://github.com/odroe/prisma-dart/issues/96)
2. generated Prisma Dart Client is now null-safe
3. Optimize the log parameter for `createPrismaClient`

## 2.6.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.6.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.6.0) about the release. 🌟

### New requirements

**Breaking change**: You are now asked to install the `freezed` package:

```
dart pub add freezed -d
```

### Breaking changes

**All input classes types will be reset!**

The Map input by forJson needs to follow the `freezed` rules, examples:

```dart
final PrismaNull $null = PrismaNull.fromJson({}); // An empty map must be entered to indicate PrismaNull

final UserWhereInput where = UserWhereInput.fromJson({
  'id': {
    'runtimeType': 'withInt', // The runtimeType must be entered, name is `UserWhereInput_id` factory name.
    'value': 1,
  },
});
```

`PrismaUnion` has been removed:

Before:

```dart
final data = UserCreateInput(
  name: PrismaUnion.zero("Seven"),
);
```

Now:

```dart
final data = CreateOneUserData.withUserCreateInput( // OR `withUserUncheckedCreateInput`
  UserCreateInput(
    name: "Seven",
  ),
);
```

> Note: `withUserCreateInput` and `withUserUncheckedCreateInput` are generated by `prisma_client.dart` file.

### Model delegates

All delegat methods input classes are now generated by `freezed` package， Example(create a user):

Before:

```dart
final user = await prisma.user.create(
  data: UserCreateInput(
    name: PrismaUnion.zero("Seven"),
  ),
);
```

Now:

```dart
final user = await prisma.user.create(
  data: CreateOneUserData.withUserUncheckedCreateInput(
    UserUncheckedCreateInput(
      name: 'Seven',
      email: 'seven@odroe.com',
    ),
  ),
);
```

### Seems like it's getting troublesome?

We are preparing to support more Prisma functions in the future, such as REF query.

In addition, we are preparing for the next Dart 3, and we expect that in Dart 3, there is no need to run additional commands before compilation to complete the serialization of input and output types.

> Since full input types are relatively cumbersome for web applications, we recommend using the fromJson method to create inputs.

Because the current input is the complete Prisma input type, it is expected to be improved in Dart 3. Currently, Dart 2 does not support union types. Our strategy is to create as many types as possible to meet all Prisma input requirements.

## 2.5.1

### Support `OrThrow` methods

Prisma client now supports `OrThrow` methods.

```dart
final User user = await prisma.user.findUniqueOrThrow(...);
final Post post = await prisma.post.findFirstOrThrow(...);
```

## 2.5.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.5.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.5.0) about the release. 🌟

### Breaking changes

#### Standalone Prisma client

Prisma client is now exported by orm package and exposes `fromEngine` constructor.

```dart
import 'package:orm/orm.dart';

final PrismaClient prisma = PrismaClient.fromEngine(...);
```

The generated prisma client now only extends model delegates, and creating a new Prisma client was changed from `PrismaClient()` to `createPrismaClient`:

Before:

```dart
final PrismaClient prisma = PrismaClient(...);
```

After:

```dart
final PrismaClient prisma = createPrismaClient(...);
```

### Remove preview feature

All previews will be removed and existing Previews will be marked as stable in this release.

> Preview will no longer be enabled in future releases, but release `*.preview.{num}` versions to mark

## New features

### Support `queryRaw` and `executeRaw` methods

Prisma client now supports `queryRaw` and `executeRaw` methods.

```dart
final PrismaClient prisma = createPrismaClient(...);

final List<Map<String, dynamic>> result = await prisma.$queryRaw('SELECT * FROM User');
final int affectedRows = await prisma.$executeRaw('DELETE FROM User');
```

### Input classes support `fromJson` method

All input classes now support `fromJson` method.

```dart
final UserCreateInput input = UserCreateInput.fromJson(...);
```

### Engines

1. Prisma binary engines version updated to `d6e67a83f971b175a593ccc12e15c4a757f93ffe`
2. Remote engines version updated to `4.8.0`

## 2.4.7

1. Now, Data proxy is stable.
2. Getting platforms is now supported by `prisma_get_platform`.

## 2.4.6

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.4.6🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.4.6) about the release. 🌟

### Query Engines

 - **Data Proxy**: Remote client version updated to `4.7.1`.
 - **Binary**: Query engine version updated to `272861e07ab64f234d3ffc4094e32bd61775599c`.

### Bug Fixes

 - **DMMF**: The 'name' field of UniqueIndex should be nullable, not non-nullable as incorrectly defined. ([#77](https://github.com/odroe/prisma-dart/issues/76))

### Highlights

#### Interactive transactions are now Generally Available

Interactive transactions allow you to pass an async function into a $transaction, and execute any code you like between the individual Prisma Client queries. Once the application reaches the end of the function, the transaction is committed to the database. If your application encounters an error as the transaction is being executed, the function will throw an exception and automatically rollback the transaction.

##### Before

```prisma
generator client {
  provider = "prisma-client-dart"
  previewFeatures = ["interactiveTransactions"]
}
```

##### Now

```prisma
generator client {
  provider = "prisma-client-dart"
}
```

## 2.4.5

- [Fix client generation with composite types](https://github.com/odroe/prisma-dart/pull/71)

## 2.4.4

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.4.4🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.4.4) about the release. 🌟

### Engines

- Update Prisma query engine to `694eea289a8462c80264df36757e4fdc129b1b32` (from `4.6.1`)
- Update Data Proxy remote prisma client to `4.6.1`
- Interactive Transactions for Prisma Data Proxy

### Generator

- Fix standard data type error calling fromJson

## 2.4.3

  * Fix `generate` command error format.

## 2.4.2

 * Fix `init` command generated SQLite database file url

## 2.4.1

### Bug Fixes

  * Fix JSON-RPC error code on error data is nullable - [#52](https://github.com/odroe/prisma-dart/issues/52)

## 2.4.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.4.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.4.0) about the release. 🌟

### Major improvements

Refactor Prisma config (environment), starting from 2.4.0, Prisma ORM for Dart no longer includes any third-party configurator.

> What about the `rc` package?
>
> The `rc` package was born for the Prisma ORM for Dart itself, and now the `rc` package has been refactored into a platform variable wrapper.

#### Production environment

The `.prismarc` file in the Dart project directory was loaded by default, and now `lib/prisma_configurator.dart` is loaded by default.

Previously configured Key in `pubspec.yaml` was `prismarc`, now it is `production`.

Before:
```yaml
prisma:
    prismarc: {path}
```

after:
```yaml
prisma:
    production: {path}
```

#### Development environment

The `.dev.rc` file was loaded by default, now it is `prisma/development.dart`.

#### Platform Environment

Prisma adaptively loads platform environment variables according to the current platform environment.

This means that the environment variables in the current system can be read in Dart VM, Flutter JIT, Dart JIT-compiled and Dart AOT-compiled. And it cannot be read in Dart Web and Flutter built app.

> Flutter built app is an exception, even though it supports `dart:io` but there is no environment variable for the build environment in it.

## 2.3.1

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.3.1🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.3.1) about the release. 🌟

### Features

#### Logging (Preview)

Prisma ORM for Dart now supports [logging](https://www.prisma.io/docs/concepts/components/prisma-client/working-with-prismaclient/logging) as a preview feature. That means, it might have some flaws, but we hope you'll try it out and provide feedback.

To enable logging, you need to set the `log` property on the `PrismaClient` constructor and `generate` command:

```bash
prisma generate --preview=logging
```

```dart
PrismaClient(
  log: [
    PrismaLogDefinition(
      level: PrismaLogLevel.query,
      emit: PrismaLogEvent.stdout,
    ),
  ],
)
```

##### Subscribe to log events

You can subscribe to log events to perform custom actions when a log occurs.

```dart
prisma.$on([PrismaLogLevel.query], (e) {
  print(e);
});
```

## 2.3.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.3.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.3.0) about the release. 🌟

### Features

#### Development runtime configuration.

When using Prisma ORM to develop an app, you may want the development configuration to be inconsistent with the production environment (although this can be avoided by configuring the production environment separately), but there are always surprises.

For example, when we use Data Proxy, the client and CLI cannot be consistent, because the link address of Data Proxy cannot manage your database.

Now, you just need to add a `.dev.rc` to the root of your Dart project whose configuration will override the same configuration for prismarc and dotenv:

```yaml
# .prismarc
DATABASE_URL: prisma://{location}.prisma-data.com/?api_key={Your API key}

# .dev.rc
DATABASE_URL: postgres://user:password@localhost:5432/mydb
```

For example in the configuration above, the actual CLI runtime uses `postgres://user:password@localhost:5432/mydb`, while in Prisma Client it uses `prisma://{location}.prisma-data.com/?api_key` ={Your API key}`.

##### Custom development runtime configuration

To customize the development runtime configuration file path, you can write in `pubspec.yaml`:

```yaml
prisma:
  development: custom.devrc
```

#### Data Proxy (Preview)

Great, Prisma Dart now supports Prisma Data Proxy to access your database!

you just need to run:

```bash
dart run orm generate --data-proxy --preview=data-proxy
```

It can also be turned on from runtime configuration or dotenv:

```bash
# Configuration file
PRISMA_GENERATE_DATAPROXY = true

# Command line
dart run orm generate --preview=data-proxy
```

##### Custom remote client version.

If the default remote client version is not what you want, you can fix it by configuring:

```bash
PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION = "4.3.1"
```

#### [Finalizer](https://api.flutter.dev/flutter/dart-core/Finalizer-class.html) for `PrismaClient`

The `PrismaClient` now has a finalizer that will close the underlying database connection when the client is garbage collected.

> **Note**: This feature is currently in preview state, you need to install `2.3.0` and above, and pass the `--preview=finalizer` option in the `generate` command to enable it. More information can be found in the [2.3.0@CLI](#cli) change log.

#### CLI

`generate` command now supports `--preview` option to generate client for preview features.

E.g.
```bash
# Enable finalizer feature for generated PrismaClient.
dart run orm generate --preview=finalizer
```

### Fixed bugs

* Runtime:
  * Known request error meta allow nullable - [#34](https://github.com/odroe/prisma-dart/issues/34), [twitter@NCavazzon#1574468691776999448](https://twitter.com/NCavazzon/status/1574468691776999448)
  * Fixed date time not serialized - [#34](https://github.com/odroe/prisma-dart/issues/34), [twitter@mizxamthegod#1574470423097610265](https://twitter.com/mizxamthegod/status/1574470423097610265)


## 2.2.3

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.2.3🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.2.3) about the release. 🌟

### Bug Fixes

1. Fixed debian/ubuntu system distro match - [#31](https://github.com/odroe/prisma-dart/issues/31)
2. Runtime - Fixed parse user facing error
3. CLI - Fixed check engine version binary incomplete


## 2.2.2

Fixed generate `schema` not working ([#29](https://github.com/odroe/prisma-dart/issues/29)

## 2.2.1

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.2.1🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.2.1) about the release. 🌟

### Major improvements

 Auto fix enum name and model name conflicts:
 ```prisma
 enum role {
  user
  admin
 }

 model user {
  id Int @id @default(autoincrement())
  role role
 }
 ```

Before this release, the above schema would result in a `role` enum and a `user` model. This is not valid in Dart, so we now auto fix the enum name to `Role` and the model name to `User`.

> Thanks to [@moepoi](https://github.com/moepoi)

### Bug fixes

1. Fixed `$transaction` options not being passed.
2. FIxed Using lowercase keywords in schema.prisma cannot generate clients correctly. - [#26](https://github.com/odroe/prisma-dart/issues/26)

## Other

* Update `code_builder` to `^4.3.0`.

## 2.2.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.2.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.2.0) about the release. 🌟

### Major improvements:

Input object Types without `PrismaUnion` wrapper, Before:
```dart
final User user = await prisma.user.create(
   data: PrismaUnion(
      zero: UserCreateInput(name: 'odroe'),
   ),
);
```
After:
```dart
final User user = await prisma.user.create(
   data: UserCreateInput(name: 'odroe'),
);
```

### Bug fixes:

- Nullable fields generating broken field implementations - [#23](https://github.com/odroe/prisma-dart/issues/23)

### Features:

- Add `precache` command, Populate the Prisma engines cache of binary artifacts.

## 2.1.3

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v2.1.3🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.1.3) about the release. 🌟

### Major improvements:

1. refactor `PrismaClientKnownRequestError`, Prisma Client throws a PrismaClientKnownRequestError exception if the query engine returns a known error related to the request - for example, a unique constraint violation. Reference 👉 [PrismaClientKnownRequestError](https://www.prisma.io/docs/reference/api-reference/error-reference#prismaclientknownrequesterror)
2. All exceptions on the client side will throw predictable errors，Reference 👉 [PrismaClientKnownRequestError](https://www.prisma.io/docs/reference/api-reference/error-reference)
3. `query_engine` renamed to `engine_core`

### Better error message

Take transaction errors as an example, before simply throwing `PrismaServerError` without any friendly prompts. Now:
```
PrismaClientUnknownRequestError:
Use the `prisma.$transaction()` API to run queries in a transaction.

Add the following to your `schema.prisma` file:

generator client {
  provider        = "prisma-client-js"
  previewFeatures = ["interactiveTransactions"]
}

Read more about transactions in our documentation:
 - https://github.com/odroe/prisma-dart#qa
 - https://www.prisma.io/docs/concepts/components/prisma-client/transactions#interactive-transactions-in-preview
```

If the engine is not found:
```
PrismaClientInitializationError:
  message: Could not find query engine binary for current platform "macos" in query-engine path.

This probably happens, because you built Prisma Client on a different platform.

Searched Locations:
  - /Users/seven/workspace/prisma/example
  - /Users/seven/workspace/prisma/example/.dart_tool/prisma
  - /Users/seven/workspace/prisma/example/prisma
  - /Users/seven/workspace/prisma/example/.dart_tool/pub/bin/example

You already added the platform "macos" to the "generator" block in the "schema.prisma" file as described in https://pris.ly/d/client-generator, but something went wrong. That's suboptimal.

Please create an issue at https://github.com/odroe/prisma-dart/issues/new
  errorCode: null
  clientVersion: 2.1.2
```

### `$transaction` options

`prisma.$transaction` now supports the following options:
```dart
final prisma = PrismaClient();
await prisma.$transaction((prisma) async {
   // ...
}, TransactionOptions(
   maxWait: 2000,
   timeout: 5000,
   isolationLevel: TransactionIsolationLevel.ReadUncommitted,
));
```

More details 👉 [Interactive transactions](https://www.prisma.io/docs/concepts/components/prisma-client/transactions#interactive-transactions-in-preview)

### Bug fixes

1. Fixed `packageVersion` not updating with version
2. Fixed binary query engine not automatically searching when `executable` is specified
2. Fixed binary query engine not automatically searching when specifying `PRISMA_QUERY_ENGINE_BINARY` environment variable

### Engines version

`c875e43600dfe042452e0b868f7a48b817b9640b`

## 2.1.2

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20Prisma%20ORM%20for%20Dart%20release%20v2.1.2🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.1.2) about the release. 🌟

### Bug fixes

- Fix the problem of repeated operation of the lookup runtime configuration
- Fix setting owerwrite datasources causing engine startup failure

### Refactor

Refactored to owerwrite datasources to convert to engine readable settings

## 2.1.1

Support custom runtime configuration.

## 2.1.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20Prisma%20ORM%20for%20Dart%20release%20v2.1.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.1.0) about the release. 🌟

### Major improvements:

#### Runtime configuration

Previously, use `prisma.yaml` to configure Prisma:
```yaml
environment:
   DATABASE_URL: postgres://user:password@localhost:5432/mydb
```

Now, we have introduced a new configuration method, **Runtime Configuration** compatible with dotenv format:
```
# .prismarc
DATABASE_URL=postgres://user:password@localhost:5432/mydb

# Database host
DATABASE_HOST=postgres://user:password@localhost:5432
DATABASE_URL=${DATABASE_HOST}/mydb
```

If you have dotenv in mind, you just need to add the database URL configuration to `.env`:
```dotenv
DATABASE_URL=postgres://user:password@localhost:5432/mydb
```

For more usage of runtime configuration, please see 👉 https://pub.dev/packages/rc

#### Custom configuration

Now, you can customize your prisma project configuration in `pubspec.yaml`:
```yaml
...
prisma:
   prismarc: path/a/b/c/custom.prismarc
   dotenv: path/a/b/c/custom.env
   schema: path/a/b/c/custom.prisma
...
```

| Parameter | Description | Default |
|---|:---| --- |
| `prismarc` | Custom runtime configuration path | `.prismarc` |
| `dotenv` | Custom dotenv path | `.env` |
| `schema` | Custom Prisma schema path | `prisma/schema.prisma` |


#### Custom engine path

Previously, the Prisma engine was downloaded into the `.dart_tool/prisma` directory, now you can customize it.

##### Custom engines path with runtime configuration

```
# Query binary engine
PRISMA_QUERY_ENGINE_BINARY(path) = custom-engines/query-engine

# Migration binary engine
PRISMA_MIGRATION_ENGINE_BINARY(path) = custom-engines/migration-engine

# Introspection binary engine
PRISMA_INTROSPECTION_ENGINE_BINARY(path) = custom-engines/introspection-engine

# Format binary engine
PRISMA_FMT_BINARY(path) = custom-engines/prisma-fmt
```

##### Custom engines path with dotenv

```
PRISMA_QUERY_ENGINE_BINARY=path/to/custom-engines/query-engine
PRISMA_MIGRATION_ENGINE_BINARY=path/to/custom-engines/migration-engine
PRISMA_INTROSPECTION_ENGINE_BINARY=path/to/custom-engines/introspection-engine
PRISMA_FMT_BINARY=path/to/custom-engines/prisma-fmt
```

#### Refactored `package:orm/configure.dart`

Previously, we have `package:orm/configure.dart` to configure Prisma, now we have refactored it to `package:orm/prisma.dart`:
```dart
import 'package:orm/configure.dart';

print(configure('DATABASE_URL'));
```

Now, you can use `package:orm/configure.dart` to configure Prisma:
```dart
import 'package:orm/configure.dart';

print(environment.DATABASE_URL);
```

### Bug fixes:

1. Fix map and throws binary errors - [#16](https://github.com/odroe/prisma-dart/pull/16)
2. Problems using Model with relation - [#14](https://github.com/odroe/prisma-dart/pull/14)

### Features:

1. Generator generate import support show.
2. Prisma CLI debug allow set to dotenv or runtime configuration.
3. Prisma CLI debug print stack trace.
