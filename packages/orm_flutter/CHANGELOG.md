## v0.5.1

chore: update `orm_flutter_ffi` to `v0.0.3` version

## v0.5.0

To install Prisma Flutter Integration v0.5.0 run this command

```bash
dart pub add orm_flutter:^0.5.0
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm_flutter: ^0.5.0
```

### What's New

- Upgrade Prisma CABI engine to `v6.0.0`
- Support Swift Package Manager

## v0.4.0

To install Prisma Flutter Integration v0.4.0 run this command

```bash
dart pub add orm_flutter:^v0.4.0
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm_flutter: ^0.4.0
```

### What's New

- **upstream**: Upgrade `orm` package to `v5.2.1` version
- **BREAKING CHANGE**: Engine is no longer implemented internally, only forwards platform-specific implementations, with iOS and Android support currently implemented.

### Optimizations

Now `orm_flutter` no longer implements the engine itself, but forwards platform-specific engine implementations.

Implemented `orm_flutter_ffi` for Prisma query engine (CABI) implementation:
  - `orm_flutter_android`: Dynamic library for Android platform.
  - `orm_flutter_ios`: Dynamic library for iOS platform.

## v0.3.1

To install Prisma Flutter Integration v0.3.1 run this command

```bash
dart pub add orm_flutter:^0.3.1
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm_flutter: ^0.3.1
```

### What's New

- **bug**: Fixed an issue where a transaction was not committed, Thx @Joschiller REF [#443](https://github.com/medz/prisma-dart/issues/443)
- **upstream**: Upgrade CABI engine to `bf0e5e8a04cada8225617067eaa03d041e2bba36` (v5.21.1)

### Notes

After upgrading the `orm_flutter` version, please run the `flutter clean` command.

## v0.3.0

### What's Changed

- **BREAKING CHANGE**: Upgrade the Dart SDK min version to `^3.5.0`

## v0.2.0

To install Prisma Flutter Integration v0.2.0 run this command

```bash
dart pub add orm_flutter:^0.2.0
```

Or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm_flutter: ^0.2.0
```

### What's Changed

- **deps**: Upgrade the `webfetch` to `^0.1.0` version
- **upstream**: Adapt the `orm` package `5.0.*` version
