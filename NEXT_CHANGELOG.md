## {next}

🌟 Help us spread the word about [Prisma ORM for Dart](https://github.com/odroe/prisma-dart) by starring the repo or [tweeting](https://twitter.com/intent/tweet?text=Check%20out%20the%20latest%20@prisma%20ORM%20for%20Dart%20release%20v{next}🚀%0D%0A%0D%0Ahttps://github.com/odroe/prisma-dart/releases/tag/{next}) about the release. 🌟

### Query Engines

 - **Data Proxy**: Remote client version updated to `4.7.1`.
 - **Binary**: Query engine version updated to `272861e07ab64f234d3ffc4094e32bd61775599c`.

### Bug Fixes

 - **DMMF**: The 'name' field of UniqueIndex should be nullable, not non-nullable as incorrectly defined. ([#77](https://github.com/odroe/prisma-dart/issues/76))

### Highlights

#### Interactive transactions are now Generally Available

Interactive transactions allow you to pass an async function into a $transaction, and execute any code you like between the individual Prisma Client queries. Once the application reaches the end of the function, the transaction is committed to the database. If your application encounters an error as the transaction is being executed, the function will throw an exception and automatically rollback the transaction.

##### Before

```prisma
generator client {
  provider = "prisma-client-dart"
  previewFeatures = ["interactiveTransactions"]
}
```

##### After

```prisma
generator client {
  provider = "prisma-client-dart"
}
```
