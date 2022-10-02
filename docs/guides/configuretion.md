# Configuretion

When developing, it is crucial to configure the Prisma ORM through a configuration file, which will simplify what we do when executing commands.

We use the Dart project directory as the `root` directory, and the following paths are loaded by default:

* `.prismarc` - Runtime configuration files, shared by CLI and Prisma client.
* `.env` - Dotenv file, shared by CLI and Prisma client.
* `prisma/schema.prisma` - Prisma schema file.

## Runtime Configureation

Runtime configuration allows you to additionally configure the Prisma client and Prisma CLI, which has the same effect as dotenv and is compatible with dotenv.

::: details So why not choose dotenv?
Because **[Runtime Configuration](https://pub.dev/packages/rc#configuration-schema)** is human understandable.
:::

By default, it will automatically search for the `.prismarc` file in the root directory of the Dart project. If you want to customize this file, you can edit `pubspec.yaml`:

::: info pubspec.yaml
```yaml{2}
prisma:
    prismarc: {You custom rc file path}
```
:::

## Dotenv

Maybe you don't like runtime configuration for some reason or your project is using dotenv, the program and Prisma ORM you want to configure in one place.

Prisma ORM loads the `.env` file in the root directory of your Dart project by default. To customize the dotenv file path, you can edit `pubspec.yaml`:

::: info pubspec.yaml
```yaml{2}
prisma:
    dotenv: {You custom dotenv file path}
```
:::

## Custom Prisma Schema

The default Prisma schema is located in `prisma/schema.prisma`, of course you can customize its location:

::: info pubspec.yaml
```yaml{2}
prisma:
    schema: {You custom prisma schema path}
```
:::

## Development runtime configuration

When using Prisma ORM to develop an app, you may want the development configuration to be inconsistent with the production environment (although this can be avoided by configuring the production environment separately), but there are always surprises.

For example, when we use Data Proxy, the client and CLI cannot be consistent, because the link address of Data Proxy cannot manage your database.

Now, you just need to add a `.dev.rc` to the root of your Dart project whose configuration will override the same configuration for prismarc and dotenv:

::: info .prismarc
```yaml
DATABASE_URL = prisma://{location}.prisma-data.com/?api_key={Your API key}
```
:::
::: info .dev.rc
```yaml
DATABASE_URL = postgres://user:password@localhost:5432/mydb
```
:::

For example in the configuration above, the actual CLI runtime uses `postgres://user:password@localhost:5432/mydb`, while in Prisma Client it uses `prisma://{location}.prisma-data.com/?api_key={Your API key}`.

### Custom development runtime configuration

To customize the development runtime configuration file path, you can write in `pubspec.yaml`:

::: info pubspec.yaml
```yaml{2}
prisma:
    development: {You custom development rc file path}
```
:::
