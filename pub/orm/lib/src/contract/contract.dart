import 'package:meta/meta.dart';

enum RelationCardinality { one, many }

@immutable
final class ModelRelationContract {
  final String name;
  final String relatedModel;
  final List<String> sourceFields;
  final List<String> targetFields;
  final RelationCardinality cardinality;

  ModelRelationContract({
    required this.name,
    required this.relatedModel,
    required List<String> sourceFields,
    required List<String> targetFields,
    this.cardinality = RelationCardinality.many,
  }) : sourceFields = List<String>.unmodifiable(sourceFields),
       targetFields = List<String>.unmodifiable(targetFields);
}

@immutable
final class ContractDefinitionException implements Exception {
  final String code;
  final String message;
  final Map<String, Object?> details;

  ContractDefinitionException({
    required this.code,
    required this.message,
    this.details = const <String, Object?>{},
  });

  @override
  String toString() {
    if (details.isEmpty) {
      return 'ContractDefinitionException[$code]: $message';
    }
    return 'ContractDefinitionException[$code]: $message | details=$details';
  }
}

@immutable
final class ModelContract {
  final String name;
  final String table;
  final Set<String> fields;
  final List<String> idFields;
  final Map<String, ModelRelationContract> relations;

  ModelContract({
    required this.name,
    required this.table,
    required Set<String> fields,
    List<String>? idFields,
    Map<String, ModelRelationContract> relations =
        const <String, ModelRelationContract>{},
  }) : fields = Set.unmodifiable(fields),
       idFields = List<String>.unmodifiable(
         idFields ?? (fields.contains('id') ? const <String>['id'] : const <String>[]),
       ),
       relations = Map<String, ModelRelationContract>.unmodifiable(relations);
}

@immutable
final class ContractCapabilities {
  final bool includeSingleQuery;
  final bool mutationReturning;

  const ContractCapabilities({
    this.includeSingleQuery = false,
    this.mutationReturning = true,
  });
}

@immutable
final class OrmContract {
  final String version;
  final String hash;
  final String target;
  final String markerStorageHash;
  final String? profileHash;
  final Map<String, ModelContract> models;
  final Map<String, String> aliases;
  final ContractCapabilities capabilities;

  OrmContract({
    required this.version,
    required this.hash,
    this.target = 'generic',
    String? markerStorageHash,
    this.profileHash,
    required Map<String, ModelContract> models,
    Map<String, String> aliases = const {},
    this.capabilities = const ContractCapabilities(),
  }) : markerStorageHash = markerStorageHash ?? hash,
       models = Map.unmodifiable(models),
       aliases = Map.unmodifiable(aliases) {
    _validateModelIdFields(this.models);
    _validateRelations(this.models);
  }

  bool hasModel(String key) => resolveModel(key) != null;

  String? resolveModel(String key) {
    final candidates = <String>{
      key,
      _uppercaseFirst(key),
      _lowercaseFirst(key),
    };

    if (key.endsWith('s') && key.length > 1) {
      final singular = key.substring(0, key.length - 1);
      candidates.addAll(<String>{
        singular,
        _uppercaseFirst(singular),
        _lowercaseFirst(singular),
      });
    }

    for (final candidate in candidates) {
      if (models.containsKey(candidate)) {
        return candidate;
      }

      final alias = aliases[candidate];
      if (alias != null && models.containsKey(alias)) {
        return alias;
      }
    }

    return null;
  }

  ModelContract? modelByKey(String key) {
    final model = resolveModel(key);
    if (model == null) {
      return null;
    }
    return models[model];
  }
}

void _validateRelations(Map<String, ModelContract> models) {
  for (final model in models.values) {
    for (final relation in model.relations.values) {
      if (relation.sourceFields.isEmpty || relation.targetFields.isEmpty) {
        throw ContractDefinitionException(
          code: 'CONTRACT.RELATION_FIELDS_EMPTY',
          message: 'Relation fields cannot be empty.',
          details: <String, Object?>{
            'model': model.name,
            'relation': relation.name,
          },
        );
      }

      if (relation.sourceFields.length != relation.targetFields.length) {
        throw ContractDefinitionException(
          code: 'CONTRACT.RELATION_FIELD_COUNT_MISMATCH',
          message:
              'Relation sourceFields and targetFields must have the same length.',
          details: <String, Object?>{
            'model': model.name,
            'relation': relation.name,
            'sourceFieldCount': relation.sourceFields.length,
            'targetFieldCount': relation.targetFields.length,
          },
        );
      }

      for (final sourceField in relation.sourceFields) {
        if (model.fields.contains(sourceField)) {
          continue;
        }
        throw ContractDefinitionException(
          code: 'CONTRACT.RELATION_SOURCE_FIELD_MISSING',
          message:
              'Relation source field "$sourceField" does not exist on model "${model.name}".',
          details: <String, Object?>{
            'model': model.name,
            'relation': relation.name,
            'field': sourceField,
          },
        );
      }

      final related = models[relation.relatedModel];
      if (related == null) {
        throw ContractDefinitionException(
          code: 'CONTRACT.RELATION_TARGET_MODEL_MISSING',
          message:
              'Relation target model "${relation.relatedModel}" does not exist.',
          details: <String, Object?>{
            'model': model.name,
            'relation': relation.name,
            'relatedModel': relation.relatedModel,
          },
        );
      }

      for (final targetField in relation.targetFields) {
        if (related.fields.contains(targetField)) {
          continue;
        }
        throw ContractDefinitionException(
          code: 'CONTRACT.RELATION_TARGET_FIELD_MISSING',
          message:
              'Relation target field "$targetField" does not exist on model "${relation.relatedModel}".',
          details: <String, Object?>{
            'model': model.name,
            'relation': relation.name,
            'relatedModel': relation.relatedModel,
            'field': targetField,
          },
        );
      }
    }
  }
}

void _validateModelIdFields(Map<String, ModelContract> models) {
  for (final model in models.values) {
    if (model.idFields.isEmpty) {
      continue;
    }

    final uniqueIdFields = model.idFields.toSet();
    if (uniqueIdFields.length != model.idFields.length) {
      throw ContractDefinitionException(
        code: 'CONTRACT.ID_FIELDS_DUPLICATE',
        message: 'Model idFields cannot contain duplicates.',
        details: <String, Object?>{
          'model': model.name,
          'idFields': model.idFields,
        },
      );
    }

    for (final field in model.idFields) {
      if (model.fields.contains(field)) {
        continue;
      }
      throw ContractDefinitionException(
        code: 'CONTRACT.ID_FIELD_MISSING',
        message:
            'Model id field "$field" does not exist on model "${model.name}".',
        details: <String, Object?>{
          'model': model.name,
          'field': field,
          'idFields': model.idFields,
        },
      );
    }
  }
}

String _uppercaseFirst(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value[0].toUpperCase() + value.substring(1);
}

String _lowercaseFirst(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value[0].toLowerCase() + value.substring(1);
}
