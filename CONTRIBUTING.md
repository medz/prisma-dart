# Welcome to Prisma ORM (for Dart) contributing guide

We're glad you've read this far and look forward to making this project a success!

Here are some important references for this project:

- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Prisma docs](https://www.prisma.io/docs/)
- [Prisma engines](https://github.com/prisma/prisma-engines)

## How to contribute

This project is divided into two parts:

1. binary
2. library

### Binary

The Binary part is the generator for Prisma CLI, which is located in the `bin` directory of the project. If you plan to fix or change generator logic, your changes will be made in this directory.

### Library

Here will be the implementation part of the Prisma client, which covers many auxiliary methods and the Prisma engine client.

## Reporting a bug

Reporting a bug is also a contribution to the project, but it is not the same as fixing a bug. If you find a bug, please report it in the [issue](https://github.com/medz/prisma-dart/issues) section.

## Testing

We write the test code in the `test` directory and in the `*_test.dart` obvious way, the current test code is not sound, if it can help us better test this project.

## Branching rules

The `main` branch is the stable branch of the current version, we do not set up a development branch. For new changes and fixes in the future we use the experience branch to develop, and then merge it into the main branch when appropriate.

So you don't have to worry about creating a PR to `main` breaking it. Because if your PR is not compatible with the current version, we will merge it again at the right time, and it is also possible to release a test version of a future version through the PR.
