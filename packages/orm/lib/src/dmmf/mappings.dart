class Mappings {
  final Iterable<ModelMapping> modelOperations;
  final OtherOperationMappings otherOperations;

  const Mappings({
    required this.modelOperations,
    required this.otherOperations,
  });

  factory Mappings.fromJson(Map json) {
    return Mappings(
      modelOperations: (json['modelOperations'] as Iterable)
          .map((e) => ModelMapping.fromJson(e)),
      otherOperations: OtherOperationMappings.fromJson(json['otherOperations']),
    );
  }
}

class OtherOperationMappings {
  final Iterable<String> read;
  final Iterable<String> write;

  const OtherOperationMappings({
    required this.read,
    required this.write,
  });

  factory OtherOperationMappings.fromJson(Map json) {
    return OtherOperationMappings(
      read: (json['read'] as Iterable).cast(),
      write: (json['write'] as Iterable).cast(),
    );
  }
}

class ModelMapping {
  final String model;
  final String plural;
  final Map<ModelAction, String> actions;

  const ModelMapping({
    required this.model,
    required this.plural,
    required this.actions,
  });

  factory ModelMapping.fromJson(Map json) {
    final entries = ModelAction.values
        .map((e) {
          return switch (json[e.name] ?? json['${e.name}One']) {
            String name => MapEntry<ModelAction, String>(e, name),
            _ => null,
          };
        })
        .where((e) => e != null)
        .whereType<MapEntry<ModelAction, String>>();

    return ModelMapping(
      model: json['model'],
      plural: json['plural'] ?? json['model'],
      actions: Map.fromEntries(entries),
    );
  }
}

enum ModelAction {
  findUnique,
  findUniqueOrThrow,
  findFirst,
  findFirstOrThrow,
  findMany,
  create,
  createMany,
  createManyAndReturn,
  update,
  updateMany,
  upsert,
  delete,
  deleteMany,
  groupBy,
  count,
  aggregate,
  findRaw,
  aggregateRaw,
}
