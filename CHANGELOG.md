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
   orm: 1.0.0
```

### Support transactions (preview)

Interactive transactions are a stable feature in Prisma For Dart, but a preview feature for the Prisma engine.
Interactive transactions are easier to handle for ORMs:

````dart
final result = prisma.$transaction((prisma) async {
   final user = await prisma.user.create({
     data: {
       name: 'Odore',
     },
   });
   final post = await prisma.post.create({
     data: {
       title: 'My first post',
       content: 'This is my first post',
       author: {
         connect: {
           id: user.id,
         },
       },
     },
   });

   return post;
}
````

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

## 2.0.0-dev.6

- Add model deserialize

## 2.0.0-dev.5

- Add `db pull` command, Pull your database schema to your Prisma schema.

## 2.0.0-dev.4

- Gendeate command is now available.
- Binary query engine is now available.
- Input object support json serialization.
- Model delegate generated GraphQL SDL.

## 2.0.0-dev.3

- Support transaction
- Add model delegate
