## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

### New features

#### Support `OrThrow` methods

Prisma client now supports `OrThrow` methods.

```dart
final User user = await prisma.user.findUniqueOrThrow(...);
final Post post = await prisma.post.findFirstOrThrow(...);
```
