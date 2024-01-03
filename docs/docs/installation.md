---
title: Installation
description: How to install Prisma Dart client.
---

# Installation

本文将介绍如何安装 Prisma Dart client 到你的 Dart 项目中。

This article will show you how to install Prisma Dart client into your Dart project.

## 先决条件 Pre-requisites

由于 Prisma 的 C ABI 引擎尚未发布，目前我们只能使用 Prisma CLI 来生成 Prisma Dart client，并且使用二进制引擎。由于 Prisma 是 Node.js 生态的工具，所以我们需要安装 (Node.js)[https://nodejs.org].

- (Node.js)(https://nodejs.org)
- Dart SDK: `>=3.1.0 <4.0.0`

安装 Prisma CLI:

Install Prisma CLI:

```bash
npm install prisma
```

然后使用 `npx prisma init` 来初始化你的 Prisma 项目。

Then use `npx prisma init` to initialize your Prisma project.

## 安装 Install

在你的 Dart 项目中，使用 `pub` 来安装 Prisma Dart client，由于 Prisma Dart CLI 有一个非常好记的包名 `orm`，所以你可以使用下面的命令来安装：

In your Dart project, use `pub` to install Prisma Dart client. Since Prisma Dart CLI has a very easy-to-remember package name `orm`, you can use the following command to install:

```bash
dart pub add orm:4.0.0-alpha.1
```

## 生成器 Generator

在你的 `schema.prisma` 中添加一个 `generator`，如果你的项目仅仅用于 Dart 那么修改也可以：

Add a `generator` in your `schema.prisma`, if your project is only used for Dart, then the modification is also possible:

```prisma
generator client {
  provider = "dart run orm"
}
```
