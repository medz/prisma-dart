## 2.0.1

### CLI

1. Fixed model relation deserialization is a must - [#7](https://github.com/odroe/prisma-dart/issues/7)

### Runtime

1. Fixed Create throws assertion error - [#10](https://github.com/odroe/prisma-dart/issues/10)
2. Fixed UTF-8 decoding error - [#11](https://github.com/odroe/prisma-dart/issues/11)

## 2.0.0

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [Tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20Prisma%20ORM%20for%20Dart%20release%20v2.0.0🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/2.0.0) about the release. 🌟

### Major improvements:

### All packages merged into one

We have reasonably integrated all the packages we split before, before:
```yaml
dependencies:
   orm: 1.0.0
dev_dependencies:
   prisma_cli: 1.0.0
```
Now:
```yaml
dependencies:
   orm: 2.0.0
```

### Support transactions (preview)

Interactive transactions are a stable feature in Prisma For Dart, but a preview feature for the Prisma engine.
Interactive transactions are easier to handle for ORMs:

```dart
final result = await prisma.$transaction((prisma) async {
   final user = await prisma.user.create(...);
   final post = await prisma.post.create(...);

   return post;
}
```

### CLI

- Added `db pull` function
- Complete refactoring of `generate` command
- Built-in RPC engine service refactoring
- The binary download engine supports the verification version, and the marked version will be downloaded automatically when the engine is updated

### Runtime

- Added GraphQL SDL generation
- Added `prisma.$connect()` method
- Added `prisma.$disconnect()` method
- Refactored engine interface and entry parameters
