# Perview Features

Here we will introduce the unique preview features of Prisma ORM for Dart, because we do not support the experimental features of Prisma in theory.

## Data Proxy

The Data Proxy provides database connection management and pooling for Prisma applications. By using the Data Proxy, your application can seamlessly scale up while maintaining predictable database performance, by limiting the number of total connections used.

::: tip
To know more visit 👉 [Prisma Data Platform](https://www.prisma.io/docs/data-platform)
:::

### Generate it

Use the `genterate` command to add both the `--data-proxy` and `--preview=data-proxy` parameters:

```bash
dart run orm generate --data-proxy --preview=data-proxy
```

It can also be turned on from runtime configuration or dotenv:

::: info .prismarc
```yaml
PRISMA_GENERATE_DATAPROXY = true
```

Always generate a Prisma client for the Data Proxy engine.
:::

```
dart run orm generate --preview=data-proxy
```

### Remote Prisma Client Version

If the default remote client version is not what you want, you can fix it by configuring:

::: info .prismarc
```yaml
PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION = "4.3.1"
```
:::

### Local Management Database

Using the Data Proxy Prisma client, `DATABASE_URL` is configured as `prisma://{location}.prisma-data.com/?api_key={Your API key}`, it does not support connecting to the database to manage the database.

So we need development-time configuration to do it:

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

## [Finalizer](https://api.flutter.dev/flutter/dart-core/Finalizer-class.html) for Prisma Client

The `PrismaClient` now has a finalizer that will close the underlying database connection when the client is garbage collected.

This feature is currently in preview state, you need to install `2.3.0` and above, and pass the `--preview=finalizer` option in the `generate` command to enable it, E.g.

```bash
dart run orm generate --preview=finalizer
```

## Logging

Prisma ORM for Dart now supports [logging](https://www.prisma.io/docs/concepts/components/prisma-client/working-with-prismaclient/logging) as a preview feature. That means, it might have some flaws, but we hope you'll try it out and provide feedback.

To enable logging, you need to set the `log` property on the `PrismaClient` constructor and `generate` command:

```bash
dart run orm generate --preview=logging
```

```dart
PrismaClient(
  log: [
    PrismaLogDefinition(
      level: PrismaLogLevel.query,
      emit: PrismaLogEvent.stdout,
    ),
  ],
)
```

### Subscribe to log events

You can subscribe to log events to perform custom actions when a log occurs.

```dart
prisma.$on([PrismaLogLevel.query], (e) {
  print(e);
});
```

### Difference

1. Prisma TS/JS client `log` has multi-type input, but Dart client only supports `PrismaLogDefinition` type because Dart does not support multi-type input.
2. Prisma TS/JS client `$on` can only subscribe to a single event, or all at once. But Dart clients can subscribe to multiple events.
3. Prisma TS/JS client log input is Object, Dart client try to satisfy [Event types](https://www.prisma.io/docs/reference/api-reference/prisma-client-reference#event-types) Cases are wrapped with `Exception`.
