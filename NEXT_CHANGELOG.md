## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

### Features

#### Logging (Preview)

Prisma ORM for Dart now supports [logging](https://www.prisma.io/docs/concepts/components/prisma-client/working-with-prismaclient/logging) as a preview feature. That means, it might have some flaws, but we hope you'll try it out and provide feedback.

To enable logging, you need to set the `log` property on the `PrismaClient` constructor and `generate` command:

```bash
prisma generate --preview=logging
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

##### Subscribe to log events

You can subscribe to log events to perform custom actions when a log occurs.

```dart
prisma.$on([PrismaLogLevel.query], (e) {
  print(e);
});
```
