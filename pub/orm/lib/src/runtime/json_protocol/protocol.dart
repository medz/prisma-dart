import '../json_convertible.dart';
import '../prisma_enum.dart';
import '../prisma_union.dart';

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

  static groupBySerializer(dynamic value) {
    if (value is PrismaEnum) {
      return value.name;
    } else if (value is Iterable) {
      return value.map(groupBySerializer);
    } else if (value is PrismaUnion) {
      if (value.$1 != null) return groupBySerializer(value.$1);
      if (value.$2 != null) return groupBySerializer(value.$2);
    }

    return value;
  }

  static groupBySelectSerializer(dynamic value) {
    final by = groupBySerializer(value);
    final select = <String, bool>{};

    if (by is String) {
      select[by] = true;
    } else if (by is Iterable) {
      for (final item in by) {
        if (item is String) {
          select[item] = true;
        }
      }
    }

    return select.isEmpty ? null : select;
  }
}

enum JsonQueryAction {
  findUnique,
  findUniqueOrThrow,
  findFirst,
  findFirstOrThrow,
  findMany,
  createOne,
  createMany,
  createManyAndReturn,
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
