class JsonQuery {
  final String? modelName;
  final JsonQueryAction action;
  final Map<String, dynamic> query;

  const JsonQuery({
    this.modelName,
    required this.action,
    required this.query,
  });
}

enum JsonQueryAction {
  findUnique,
  findUniqueOrThrow,
  findFirst,
  findFirstOrThrow,
  findMany,
  createOne,
  createMany,
  updateOne,
  updateMany,
  deleteOne,
  deleteMany,
  upsertOne,
  aggregate,
  groupBy,
  executeRaw,
  queryRaw,
  runCommandRaw,
  findRaw,
  aggregateRaw,
}
