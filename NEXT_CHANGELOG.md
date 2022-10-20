## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

### Major improvements

Refactor Prisma config (environment), starting from {next}, Prisma ORM for Dart no longer includes any third-party configurator.

> What about the `rc` package?
>
> The `rc` package was born for the Prisma ORM for Dart itself, and now the `rc` package has been refactored into a platform variable wrapper.

#### Production environment

The `.prismarc` file in the Dart project directory was loaded by default, and now `lib/prisma_configurator.dart` is loaded by default.

Previously configured Key in `pubspec.yaml` was `prismarc`, now it is `production`.

Before:
```yaml
prisma:
    prismarc: {path}
```

after:
```yaml
prisma:
    production: {path}
```

#### Development environment

The `.dev.rc` file was loaded by default, now it is `prisma/development.dart`.

#### Platform Environment

Prisma adaptively loads platform environment variables according to the current platform environment.

This means that the environment variables in the current system can be read in Dart VM, Flutter JIT, Dart JIT-compiled and Dart AOT-compiled. And it cannot be read in Dart Web and Flutter built app.

> Flutter built app is an exception, even though it supports `dart:io` but there is no environment variable for the build environment in it.

