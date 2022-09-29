## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

### Features

#### [Finalizer](https://api.flutter.dev/flutter/dart-core/Finalizer-class.html) for `PrismaClient`

The `PrismaClient` now has a finalizer that will close the underlying database connection when the client is garbage collected.

> **Note**: This feature is currently in preview state, you need to install `{next}` and above, and pass the `--preview=finalizer` option in the `generate` command to enable it. More information can be found in the [{next}@CLI](#cli) change log.

#### CLI

`generate` command now supports `--preview` option to generate client for preview features.

E.g.
```bash
dart run orm generate --preview=finalizer ## Enable finalizer feature for generated PrismaClient.
```
