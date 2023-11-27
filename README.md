# Prisma ・ [![Pub Version](https://img.shields.io/pub/v/orm?label=latest)](https://pub.dev/packages/orm)[![GitHub license](https://img.shields.io/github/license/odroe/prisma-dart)](https://github.com/odroe/prisma-dart/blob/main/LICENSE)

Prisma (for Dart) is a **next-generation ORM** for Dart and Flutter.

- **Most Popular Databases**: Prisma supports PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB.
- **Type-safe**: Prisma Client is a query builder that’s tailored to your schema. We designed its API to be intuitive, both for SQL veterans and developers brand new to databases. The auto-completion helps you figure out your query without the need for documentation.
- **Human-readable**: Prisma schema is intuitive and lets you declare your database tables in a human-readable way — making your data modeling experience a delight. You define your models by hand or introspect them from an existing database.

👉 [Learn how to use Prisma ORM for Dart in your project](https://prisma.pub/docs/getting-started.html).

## Instanciation

This will add a like this to you packages `pubspec.yaml` (and run an implicit `dart pub get`):

```yaml
dependencies:
  orm: latest
```

## Sponsors

Prisma ORM for Dart is an [BSD-3 Clause licensed](LICENSE) open source project with its ongoing development made possible entirely by the support of these awesome backers. If you'd like to join them, please consider [sponsoring Odroe development](https://github.com/sponsors/odroe).

<p align="center">
  <a target="_blank" href="https://github.com/sponsors/odroe#sponsors">
    <img alt="sponsors" src="https://github.com/odroe/.github/raw/main/sponsors.svg">
  </a>
</p>

## Documentation

You can find the Prisma ORM for Dart [on the website](https://prisma.pub).

The documentation is divided into the following sections:

- [Getting Started](https://prisma.pub/docs/getting-started.html)
- [Configuration](https://prisma.pub/docs/configuration.html)
- [Logging](https://prisma.pub/docs/logging.html)
- [CRUD](https://prisma.pub/docs/crud.html)
- [Fluent API](https://prisma.pub/docs/fluent-api.html)

> You can improve it by sending pull requests to [`docs` folder in the `main` branch](https://github.com/odroe/prisma-dart/tree/main/docs).

## Examples

You can also find them in the [`example` folder in the `main` branch](https://github.com/odroe/prisma-dart/tree/main/example).

## Query engine support matrix

| Engine     | Dart Native | Dart Web | Flutter Native | Flutter Web |
| :--------- | :---------: | :------: | :------------: | :---------: |
| Binary     |     ✅      |    ❌    |       ❌       |     ❌      |
| Library    |     ✅      |    ❌    |       ✅       |     ❌      |
| Data Proxy |     ✅      |    ✅    |       ✅       |     ✅      |

> The `Library` engine has not been supported yet. If you are Rust developer, you can help us by contributing to the [Prisma Query Engine (C API)](https://github.com/odroe/prisma-query-c-api).

## Contributing

We welcome contributions! Please read our [contributing guide](CONTRIBUTING.md) to learn about our development process, how to propose bugfixes and improvements, and how to build and test your changes to Prisma.

Thank you to all the people who already contributed to Odroe!

[![Contributors](https://opencollective.com/openodroe/contributors.svg?width=890)](https://github.com/odroe/prisma-dart/graphs/contributors)

## Code of Conduct

This project has adopted the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). For more information see the [Code of Conduct FAQ](https://www.contributor-covenant.org/faq) or contact [hello@odroe.com](mailto:hello@odroe.com) with any additional questions or comments.

## Stay in touch

- [Website](https://prisma.pub)
- [Twitter](https://twitter.com/odroeinc)
- [Discord](https://discord.gg/r27AjtUUbV)
