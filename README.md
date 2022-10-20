# Prisma ・ [![Pub Version](https://img.shields.io/pub/v/orm?label=latest)](https://pub.dev/packages/orm)[![GitHub license](https://img.shields.io/github/license/odroe/prisma-dart)](https://github.com/odroe/prisma-dart/blob/main/LICENSE)[![test](https://github.com/odroe/prisma-dart/actions/workflows/test.yaml/badge.svg)](https://github.com/odroe/prisma-dart/actions/workflows/test.yaml)[![analyze](https://github.com/odroe/prisma-dart/actions/workflows/analyze.yaml/badge.svg)](https://github.com/odroe/prisma-dart/actions/workflows/analyze.yaml)

Prisma (for Dart) is a **next-generation ORM** for Dart and Flutter.

- **Most Popular Databases**: Prisma supports PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB.
- **Type-safe**: Prisma Client is a query builder that’s tailored to your schema. We designed its API to be intuitive, both for SQL veterans and developers brand new to databases. The auto-completion helps you figure out your query without the need for documentation.
- **Human-readable**: Prisma schema is intuitive and lets you declare your database tables in a human-readable way — making your data modeling experience a delight. You define your models by hand or introspect them from an existing database.

👉 [Learn how to use Prisma ORM for Dart in your project](https://prisma.pub/getting-started).

## Instanciation

This will add a like this to you packages `pubspec.yaml` (and run an implicit `dart pub get`):

```yaml
dependencies:
  orm: latest
```

## Documentation

You can find the Prisma ORM for Dart [on the website](https://prisma.pub).

The documentation is divided into the following sections:

 * [Getting Started](https://prisma.pub/getting-started)
 * [Concepts](https://prisma.pub/concepts)
 * [Guides](https://prisma.pub/guides)
 * [CLI Reference](https://prisma.pub/reference/cli)

> You can improve it by sending pull requests to [`docs` folder in the `main` branch](https://github.com/odroe/prisma-dart/tree/main/docs).

## Examples

We have several examples [on the website](https://prisma.pub/examples), you can also find them in the [`example` folder in the `main` branch](https://github.com/odroe/prisma-dart/tree/main/example).

## Query engine support matrix

| Engine | Version | Supported | Notes |
|--------|---------|-----------|-------|
| [Binary](https://www.prisma.io/docs/reference/api-reference/prisma-schema-reference#binarytargets-options) | `c875e43600dfe042452e0b868f7a48b817b9640b` | ✅ | Dart Native Only |
| [Library (C API)](https://github.com/odroe/prisma-query-c-api) | `0.0.1` | ❌ | Flutter (Except Web), Dart Native |
| [Data Proxy](https://prisma.pub/guides/preview-features#data-proxy) | `any | ✅ | All platforms (Flutter, Dart Native, Web) - Preview |

## Contributing

We welcome contributions! Please read our [contributing guide](CONTRIBUTING.md) to learn about our development process, how to propose bugfixes and improvements, and how to build and test your changes to Prisma.

## Code of Conduct

This project has adopted the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). For more information see the [Code of Conduct FAQ](https://www.contributor-covenant.org/faq) or contact [hello@odroe.com](mailto:hello@odroe.com) with any additional questions or comments.

## Stay in touch

* [Website](https://prisma.pub)
* [Twitter](https://twitter.com/odroeinc)
