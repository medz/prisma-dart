import '../json_convertible.dart';

class JsonQuery implements JsonConvertible<Map<String, dynamic>> {
  final String? modelName;
  final JsonQueryAction action;
  final Map<String, dynamic> query;

  const JsonQuery({
    this.modelName,
    required this.action,
    required this.query,
  });

  @override
  Map<String, dynamic> toJson() => {
        if (modelName != null) 'modelName': modelName!,
        'action': action.name,
        'query': query,
      };
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
