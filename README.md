# Prisma Client Dart

[![Test](https://github.com/medz/prisma-dart/actions/workflows/test.yml/badge.svg)](https://github.com/medz/prisma-dart/actions/workflows/test.yml)
[![Pub Version](https://img.shields.io/pub/v/orm?include_prereleases)](https://pub.dev/packages/orm)
[![GitHub License](https://img.shields.io/github/license/medz/prisma-dart)](https://github.com/medz/prisma-dart/blob/main/LICENSE)
[![Docs website](https://img.shields.io/badge/docs-prisma.pub-brightgreen)](https://prisma.pub/)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/medz?label=github%20sponsors)](https://github.com/sponsors/medz)
[![Open Collective sponsors](https://img.shields.io/opencollective/sponsors/openodroe?label=open%20collective)](https://opencollective.com/openodroe)
[![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/shiweidu)
](https://twitter.com/shiweidu)
[![Discord](https://img.shields.io/discord/1035043284457881620?label=discord)](https://discord.gg/ms2X9TQMR8)

Prisma Client Dart is an auto-generated type-safe ORM. It uses Prisma Engine as the data access layer and is as consistent as possible with the Prisma Prisma Client JS/TS APIs.

👉 [Learn how to use Prisma ORM for Dart in your project](https://prisma.pub/).

```dart
import 'package:orm/orm.dart';

final client = PrismaClient();

main() {
  final users = await client.user.findMany();
}
```

> [!TIP]
> Prisma Client Dart is an open source project developed and maintained by [Seven Du](https://github.com/medz), which allows you to use Prisma ORM in the Dart language. **Prisma is Next-generation Node.js and TypeScript ORM**.
>
> If your back-end project uses Node.js or Bun.js, it is highly recommended that you take a look 👉 [Prisma ORM Official](https://prisma.io/)
>
> Other language implementations in community 👉 [Prisma Ecosystem](https://www.prisma.io/ecosystem/).

## Installation

This will add a like this to you packages `pubspec.yaml` (and run an implicit `dart pub get`):

```yaml
dependencies:
  orm: 4.0.0-beta.3
```

Or you can run the following command:

```bash
dart pub add orm:4.0.0-beta.3
```

## Sponsors

Prisma Client Dart is an [BSD-3 Clause licensed](https://github.com/medz/prisma-dart/blob/main/LICENSE) open source project with its ongoing development made possible entirely by the support of these awesome backers. If you'd like to join them, please consider [sponsoring Seven(@medz)](https://github.com/sponsors/medz) or [Odroe](https://opencollective.com/openodroe) on GitHub.

<p align="center">
  <a target="_blank" href="https://github.com/sponsors/odroe#sponsors">
    <img alt="sponsors" src="https://github.com/odroe/.github/raw/main/sponsors.svg">
  </a>
</p>

## Documentation

You can find the Prisma Client Dart [on the website](https://prisma.pub).

The documentation is divided into the following sections:

- [Getting Started](https://prisma.pub/getting-started/)
  - [Setup & Configuration](https://prisma.pub/getting-started/setup.html)
  - [Prisma Schema](https://prisma.pub/getting-started/schema.html)
- Queries
  - [CRUD](https://prisma.pub/queries/crud.html)
  - [Select Fields](https://prisma.pub/queries/select-fields.html)
  - [Relation queries](https://prisma.pub/queries/relation-queries.html)
  - [Filtering and Sorting](https://prisma.pub/queries/filtering-and-sorting.html)
  - [Pagination](https://prisma.pub/queries/pagination.html)
  - [Aggregation, grouping, and summarizing](https://prisma.pub/queries/aggregation-grouping-summarizing.html)
  - [Transactions](https://prisma.pub/queries/transactions.html)
  - [Raw database access](https://prisma.pub/queries/raw-database-access.html)

> You can improve it by sending pull requests to [`docs` folder in the `main` branch](https://github.com/odroe/prisma-dart/tree/main/docs).

## Examples

You can also find them in the [`example` folder in the `main` branch](https://github.com/odroe/prisma-dart/tree/main/example).

## Query engine support matrix

| Engine     | Dart Native | Dart Web | Flutter Native | Flutter Web |
| :--------- | :---------: | :------: | :------------: | :---------: |
| Binary     |     ✅      |    ❌    |       ❌       |     ❌      |
| Library    |     ✅      |    ❌    |       ✅       |     ❌      |
| Data Proxy |     ✅      |    ✅    |       ✅       |     ✅      |

## Contributing

We welcome contributions! Please read our [contributing guide](CONTRIBUTING.md) to learn about our development process, how to propose bugfixes and improvements, and how to build and test your changes to Prisma.

Thank you to all the people who already contributed to Odroe!

[![Contributors](https://opencollective.com/openodroe/contributors.svg?width=890)](https://github.com/odroe/prisma-dart/graphs/contributors)

## Code of Conduct

This project has adopted the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). For more information see the [Code of Conduct FAQ](https://www.contributor-covenant.org/faq) or contact [hello@odroe.com](mailto:hello@odroe.com) with any additional questions or comments.
