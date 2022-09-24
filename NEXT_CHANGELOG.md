## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

## Features

### Development runtime configuration.

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

#### Custom development runtime configuration

To customize the development runtime configuration file path, you can write in `pubspec.yaml`:

```yaml
prisma:
  development: custom.devrc
```
