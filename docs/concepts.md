# Concepts

The components of the concept documentation you can access 👉 [Prisma Concepts](https://prisma.io/docs/concepts).

Because Prisma ORM for Dart is modeled after the official Prisma TS/JS client, the components and APIs of Prisma are very similar to the official one.

However, due to language differences, the following are different parts, please check them carefully:

[[toc]]

## (Unsupported) - Relation queries

The Dart language does not have dynamic paradigm computation capabilities. If we want to achieve type safety and editor auto-completion and editor hints, we must use class-style parameters as input and output.

This also prevents us from completing the functions of `select` and `include`.

## (Inconsistent) - Generators

Prisma official CLI allows specifying a different NPM package name or command in an environment variable to be used as a `provider`.

However, Prisma ORM for Dart is specially developed for Dart language, so we don't look for providers, and as long as any provider value is `prisma-client-dart` we generate Prisma client.

## (Unsupported) - Preview features

All experimental features are theoretically not supported in Prisma ORM for Dart, we need to gradually add stable features that already exist to guide the development direction of Prisma ORM for Dart.

## (Inconsistent) - Interactive transactions

Although Interactive transactions is a preview feature in the Prisma official client, it must be enabled by Prisma ORM for Dart.

The reason is also very simple, because of Dart syntax limitations, we cannot complete batch queries and Interactive transactions in the same method. In the long run, we must choose Interactive transactions to achieve a better experience.

Interactive transactions Before Prisma officially announces it as a stable feature, you always need to declare it in the Prisma schema:

::: info schema.prisma
```prisma
generator client {
  // ...
  previewFeatures = ["interactiveTransactions"]
}
```
:::

## (Unsupported) - Prisma Migrate

Because Prisma Migrate is complex and changeable, we have not yet determined the official development direction of Prisma for Migrate, coupled with our lack of staff (community contributions are welcome), we do not support it for the time being.

## (Unsupported) - Prisma Studio

Prisma Studio is not an open source product and we cannot support it.

