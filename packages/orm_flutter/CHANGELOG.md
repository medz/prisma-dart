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
