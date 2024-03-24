---
title: Introduction
---

# Introduction

Welcome to the Prisma Dart Client, this documentation will help you get started quickly. If you encounter any problems during use, please submit them in [GitHub Discussions](https://github.com/medz/prisma-dart/discussions).

[[toc]]

## What is Prisma?

Prisma unlocks a new level of developer experience when working with databases thanks to its intuitive data model, automated migrations, type-safety & auto-completion.

[Learn more about Prisma](https://www.prisma.io/)

## What is Prisma Client Dart?

Prisma Client Dart is a Dart ORM that is published on [pub.dev](https://pub.dev/packages/orm) with the package name `orm`.
It uses [Prisma Engine](https://github.com/prisma/prisma-engines) as the data access layer and tries to keep the API as consistent as possible with [Prisma JS/TS Client](https://www.prisma.io/docs/orm/prisma-client).

::: details Why Prisma Client Dart package name is `orm`?

Because the package name `prisma` has been occupied, and the package has not been widely used and the author is no longer updating it.
When we released Prisma Dart Client, we contacted the author of the `prisma` package, but did not get a reply.

:::

::: tip

Prisma Client Dart is an open source project maintained by [Seven Du](https://github.com/medz). It allows you to use Prisma ORM in Dart. It is not directly related to [Prisma Data Inc.](https://prisma.io/), but it Is a member of the [Prisma ecosystem](https://www.prisma.io/ecosystem/). Thanks to the great open source community, thanks to the great Prisma ORM project.

:::

## Installation

Install Prisma Client Dart is very simple, Prisma is a Node.js project, so it is not a one-step process. If you encounter any problems during the installation process, you can submit a discussion in [GitHub Discussions](https://github.com/medz/prisma-dart/discussions).

### Prerequisites

- [Dart SDK](https://dart.dev/get-dart) `>=3.2.0 <4.0.0`
- [Prisma CLI](https://www.prisma.io) `>=5.7`
- [Node.js](https://nodejs.org/en/) `>=16.13`, See [Prisma CLI Prerequisites](https://www.prisma.io/docs/orm/reference/system-requirements) for more information.

### Install Node.js

Node.js provides official [installation programs](https://nodejs.org/en/download/) for most platforms.

### Install Prisma CLI

Please open your project directory, usually the directory where `pubspec.yaml` is located, if it is a Mono Repo project, then please open your project root directory.

> If you don't have a project yet, use `dart create` to create one.

Please run the following command to install Prisma CLI:

::: code-group

```bash [NPM]
npm install prisma
```

```bash [pnpm]
pnpm add prisma
```

```bash [Bun.js]
bun add prisma
```

:::

> Prisma Official installation documentation can be found here 👉 [Prisma CLI install](https://www.prisma.io/docs/orm/tools/prisma-cli#installation)

### Install `orm` (Prisma Client Dart)

Please run the following command to install `orm`:

```bash
dart pub add orm:4.0.2
```

Or add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  orm: ^4.0.2 // [!code focus]
```
