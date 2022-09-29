## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

### Features

#### Development runtime configuration.

When using Prisma ORM to develop an app, you may want the development configuration to be inconsistent with the production environment (although this can be avoided by configuring the production environment separately), but there are always surprises.

For example, when we use Data Proxy, the client and CLI cannot be consistent, because the link address of Data Proxy cannot manage your database.

Now, you just need to add a `.dev.rc` to the root of your Dart project whose configuration will override the same configuration for prismarc and dotenv:

```yaml
# .prismarc
DATABASE_URL: prisma://{location}.prisma-data.com/?api_key={Your API key}

# .dev.rc
DATABASE_URL: postgres://user:password@localhost:5432/mydb
```

For example in the configuration above, the actual CLI runtime uses `postgres://user:password@localhost:5432/mydb`, while in Prisma Client it uses `prisma://{location}.prisma-data.com/?api_key` ={Your API key}`.

##### Custom development runtime configuration

To customize the development runtime configuration file path, you can write in `pubspec.yaml`:

```yaml
prisma:
  development: custom.devrc
```

#### Data Proxy

Great, Prisma Dart now supports Prisma Data Proxy to access your database!

you just need to run:

```bash
dart run orm generate --data-proxy
```

It can also be turned on from runtime configuration or dotenv:

```
PRISMA_GENERATE_DATAPROXY = true
```

##### Custom remote client version.

If the default remote client version is not what you want, you can fix it by configuring:

```
PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION = "4.3.1"
```

#### [Finalizer](https://api.flutter.dev/flutter/dart-core/Finalizer-class.html) for `PrismaClient`

The `PrismaClient` now has a finalizer that will close the underlying database connection when the client is garbage collected.

> **Note**: This feature is currently in preview state, you need to install `{next}` and above, and pass the `--preview=finalizer` option in the `generate` command to enable it. More information can be found in the [{next}@CLI](#cli) change log.

#### CLI

`generate` command now supports `--preview` option to generate client for preview features.

E.g.
```bash
dart run orm generate --preview=finalizer ## Enable finalizer feature for generated PrismaClient.
```
