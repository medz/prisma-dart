# Prisma Dart v5.0.1 & Flutter integration 0.1.1

To install Prisma ORM for Dart v5.0.1 run this command:

```bash
dart pub add orm:^5.0.1
```

or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.0.1
```

---

FLutter integration:

```yaml
dependencies:
  orm_flutter: ^0.1.1
```

* [**"Prisma Dart v4 -> v5 & Flutter integration" Upgrade Guides**](https://prisma.pub/getting-started/upgrade_guides.html)
* [**"Flutter Integration FAQ**](https://prisma.pub/getting-started/flutter.html#faq)

## What's Changed

* Remove the `isProxy` for `Prisma.validateDatasourceURL` utils.
* When building the client, automatically download the Prisma C-ABI engine if `engineType` is `flutter`.

**Full Changelog**: https://github.com/medz/prisma-dart/compare/orm-v5.0.0+orm_flutter-v0.1.0...orm-v5.0.1+orm_flutter-v0.1.1

# Prisma Dart v5.0.0 & Flutter integration 0.1.0

To install Prisma ORM for Dart v5.0.0 run this command:

```bash
dart pub add orm:^5.0.0
```

or update your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^5.0.0
```

---

FLutter integration:

```yaml
dependencies:
  orm_flutter: ^0.1.0
```

[**"Prisma Dart v4 -> v5 & Flutter integration" Upgrade Guides**](https://prisma.pub/getting-started/upgrade_guides.html)

## What's Changed

* refactor: throws prisma client errors
* refactor(engine): Refactoring binary engines
* refactor(client): add base client and client options
* feat(client): add `env` support
* feat(client): add logging
* refactor(Flutter integration): Refactoring the Flutter integration engine.

**Full Changelog**: https://github.com/medz/prisma-dart/compare/orm-v4.4.0...orm-v5.0.0+orm_flutter-v0.1.0
