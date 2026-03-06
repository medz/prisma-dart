import 'dart:collection';
import 'dart:convert';

import 'snapshot.dart';

String emitContractArtifact({
  required SchemaSnapshot schema,
  required GeneratorConfigSnapshot config,
}) {
  final runtimeProfile = _runtimeProfileForProvider(config.provider);
  final modelInfos = _indexModels(schema.models);

  final models = SplayTreeMap<String, Object?>();
  for (final modelInfo in modelInfos.values) {
    models[modelInfo.model.name] = <String, Object?>{
      'name': modelInfo.model.name,
      'table': _defaultTableName(modelInfo.model.name),
      'fields': modelInfo.scalarFieldNames,
      'idFields': modelInfo.idFields,
      'relations': _buildRelations(owner: modelInfo, modelInfos: modelInfos),
    };
  }

  final aliases = _buildAliases(modelInfos.values);
  final capabilities = runtimeProfile.capabilities;

  final canonical = <String, Object?>{
    'version': '1.0.0',
    'target': runtimeProfile.target,
    'models': models,
    'aliases': aliases,
    'capabilities': capabilities,
  };
  final hash = _stableHash(jsonEncode(canonical));

  final contract = <String, Object?>{
    'version': '1.0.0',
    'hash': hash,
    'target': runtimeProfile.target,
    'markerStorageHash': hash,
    'models': models,
    'aliases': aliases,
    'capabilities': capabilities,
  };

  final encoder = const JsonEncoder.withIndent('  ');
  return '${encoder.convert(contract)}\n';
}

SplayTreeMap<String, _SchemaModelInfo> _indexModels(
  List<SchemaModelDefinition> models,
) {
  final lookup = SplayTreeMap<String, _SchemaModelInfo>();
  for (final model in models) {
    final scalarFieldNames =
        model.fields
            .where((field) => _isScalarType(field.typeSource))
            .map((field) => field.name)
            .toList(growable: false)
          ..sort();
    final scalarFields = scalarFieldNames.toSet();
    final idFields =
        model.fields
            .where((field) => field.isId && scalarFields.contains(field.name))
            .map((field) => field.name)
            .toList(growable: false)
          ..sort();
    final inferredIdFields = idFields.isNotEmpty
        ? idFields
        : scalarFields.contains('id')
        ? const <String>['id']
        : const <String>[];

    lookup[model.name] = _SchemaModelInfo(
      model: model,
      scalarFields: scalarFields,
      scalarFieldNames: scalarFieldNames,
      idFields: inferredIdFields,
    );
  }
  return lookup;
}

SplayTreeMap<String, Object?> _buildAliases(Iterable<_SchemaModelInfo> models) {
  final aliases = SplayTreeMap<String, Object?>();
  for (final modelInfo in models) {
    final modelName = modelInfo.model.name;
    final lowerName = _lowercaseFirst(modelName);
    final table = _defaultTableName(modelName);
    final candidates = <String>[
      lowerName,
      _pluralize(lowerName),
      table,
      _pluralize(table),
    ];

    for (final candidate in candidates) {
      if (candidate.isEmpty || candidate == modelName) {
        continue;
      }
      if (aliases.containsKey(candidate)) {
        continue;
      }
      aliases[candidate] = modelName;
    }
  }
  return aliases;
}

SplayTreeMap<String, Object?> _buildRelations({
  required _SchemaModelInfo owner,
  required Map<String, _SchemaModelInfo> modelInfos,
}) {
  final relations = SplayTreeMap<String, Object?>();
  final modelNames = modelInfos.keys.toSet();

  for (final field in owner.model.fields) {
    if (_isScalarType(field.typeSource)) {
      continue;
    }

    final relationType = _parseRelationType(
      source: field.typeSource,
      modelNames: modelNames,
    );
    if (relationType == null) {
      continue;
    }

    final related = modelInfos[relationType.relatedModel];
    if (related == null) {
      continue;
    }

    final resolved = _resolveRelation(
      owner: owner,
      relationField: field,
      relationType: relationType,
      related: related,
    );
    if (resolved == null) {
      continue;
    }

    relations[field.name] = <String, Object?>{
      'name': _relationName(field),
      'relatedModel': relationType.relatedModel,
      'sourceFields': resolved.sourceFields,
      'targetFields': resolved.targetFields,
      'cardinality': resolved.cardinality,
    };
  }

  return relations;
}

_ResolvedRelation? _resolveRelation({
  required _SchemaModelInfo owner,
  required SchemaFieldDefinition relationField,
  required _RelationFieldType relationType,
  required _SchemaModelInfo related,
}) {
  final fromAnnotation = _resolveRelationFromAnnotation(
    owner: owner,
    relationField: relationField,
    relationType: relationType,
    related: related,
  );
  if (fromAnnotation != null) {
    return fromAnnotation;
  }

  if (relationType.isMany) {
    return _resolveToManyRelation(owner: owner, related: related);
  }

  return _resolveToOneRelation(
    owner: owner,
    relationField: relationField,
    related: related,
  );
}

_ResolvedRelation? _resolveRelationFromAnnotation({
  required _SchemaModelInfo owner,
  required SchemaFieldDefinition relationField,
  required _RelationFieldType relationType,
  required _SchemaModelInfo related,
}) {
  final annotation = relationField.relation;
  if (annotation == null) {
    return null;
  }

  final sourceFields = annotation.fields?.toList(growable: false);
  sourceFields?.sort();
  final targetFields = annotation.references?.toList(growable: false);
  targetFields?.sort();

  if (sourceFields != null && targetFields != null) {
    if (sourceFields.length != 1 || targetFields.length != 1) {
      return null;
    }
    if (!owner.scalarFields.contains(sourceFields.single)) {
      return null;
    }
    if (!related.scalarFields.contains(targetFields.single)) {
      return null;
    }

    return _ResolvedRelation(
      sourceFields: sourceFields,
      targetFields: targetFields,
      cardinality: relationType.cardinality,
    );
  }

  if (sourceFields != null && targetFields == null) {
    if (sourceFields.length != 1 ||
        !owner.scalarFields.contains(sourceFields.single)) {
      return null;
    }

    final targetField = related.singleIdField;
    if (targetField == null || !related.scalarFields.contains(targetField)) {
      return null;
    }

    return _ResolvedRelation(
      sourceFields: sourceFields,
      targetFields: <String>[targetField],
      cardinality: relationType.cardinality,
    );
  }

  if (sourceFields == null && targetFields != null && relationType.isMany) {
    if (targetFields.length != 1 ||
        !related.scalarFields.contains(targetFields.single)) {
      return null;
    }

    final sourceField = owner.singleIdField;
    if (sourceField == null || !owner.scalarFields.contains(sourceField)) {
      return null;
    }

    return _ResolvedRelation(
      sourceFields: <String>[sourceField],
      targetFields: targetFields,
      cardinality: relationType.cardinality,
    );
  }

  if (sourceFields == null && targetFields != null && !relationType.isMany) {
    if (targetFields.length != 1 ||
        !related.scalarFields.contains(targetFields.single)) {
      return null;
    }

    return _resolveToOneRelation(
      owner: owner,
      relationField: relationField,
      related: related,
      targetField: targetFields.single,
    );
  }

  return null;
}

_ResolvedRelation? _resolveToOneRelation({
  required _SchemaModelInfo owner,
  required SchemaFieldDefinition relationField,
  required _SchemaModelInfo related,
  String? targetField,
}) {
  final resolvedTarget = targetField ?? related.singleIdField;
  if (resolvedTarget == null ||
      !related.scalarFields.contains(resolvedTarget)) {
    return null;
  }

  final sourceSuffix = _uppercaseFirst(resolvedTarget);
  final sourceFieldCandidates = <String>[
    if (relationField.name.isNotEmpty) '${relationField.name}Id',
    '${_lowercaseFirst(related.model.name)}Id',
    '${related.model.name}Id',
    if (resolvedTarget != 'id' && relationField.name.isNotEmpty)
      '${relationField.name}$sourceSuffix',
    if (resolvedTarget != 'id')
      '${_lowercaseFirst(related.model.name)}$sourceSuffix',
    if (resolvedTarget != 'id') '${related.model.name}$sourceSuffix',
  ];

  final sourceField = _findFirstExistingField(
    candidates: sourceFieldCandidates,
    available: owner.scalarFields,
  );
  if (sourceField == null) {
    return null;
  }

  return _ResolvedRelation(
    sourceFields: <String>[sourceField],
    targetFields: <String>[resolvedTarget],
    cardinality: 'one',
  );
}

_ResolvedRelation? _resolveToManyRelation({
  required _SchemaModelInfo owner,
  required _SchemaModelInfo related,
}) {
  final sourceField = owner.singleIdField;
  if (sourceField == null || !owner.scalarFields.contains(sourceField)) {
    return null;
  }

  final targetSuffix = _uppercaseFirst(sourceField);
  final targetFieldCandidates = <String>[
    '${_lowercaseFirst(owner.model.name)}Id',
    '${owner.model.name}Id',
    if (sourceField != 'id')
      '${_lowercaseFirst(owner.model.name)}$targetSuffix',
    if (sourceField != 'id') '${owner.model.name}$targetSuffix',
  ];

  final targetField = _findFirstExistingField(
    candidates: targetFieldCandidates,
    available: related.scalarFields,
  );
  if (targetField == null) {
    return null;
  }

  return _ResolvedRelation(
    sourceFields: <String>[sourceField],
    targetFields: <String>[targetField],
    cardinality: 'many',
  );
}

String? _findFirstExistingField({
  required Iterable<String> candidates,
  required Set<String> available,
}) {
  final seen = <String>{};
  for (final candidate in candidates) {
    final normalized = candidate.trim();
    if (normalized.isEmpty || !seen.add(normalized)) {
      continue;
    }
    if (available.contains(normalized)) {
      return normalized;
    }
  }
  return null;
}

_RelationFieldType? _parseRelationType({
  required String source,
  required Set<String> modelNames,
}) {
  var value = source.trim().replaceAll(RegExp(r'\s+'), '');
  if (value.endsWith('?')) {
    value = value.substring(0, value.length - 1);
  }

  var isMany = false;
  final listMatch = RegExp(r'^List<(.+)>$').firstMatch(value);
  if (listMatch != null) {
    isMany = true;
    value = listMatch.group(1)!;
    if (value.endsWith('?')) {
      value = value.substring(0, value.length - 1);
    }
  }

  if (!modelNames.contains(value)) {
    return null;
  }

  return _RelationFieldType(relatedModel: value, isMany: isMany);
}

_RuntimeProfile _runtimeProfileForProvider(String? provider) {
  switch (provider) {
    case 'sqlite':
      return const _RuntimeProfile(
        target: 'sql-family',
        capabilities: <String, Object?>{
          'includeSingleQuery': false,
          'mutationReturning': false,
        },
      );
    default:
      return const _RuntimeProfile(
        target: 'generic',
        capabilities: <String, Object?>{
          'includeSingleQuery': false,
          'mutationReturning': true,
        },
      );
  }
}

bool _isScalarType(String source) {
  final parsed = _normalizeType(source);
  return switch (parsed) {
    'String' || 'int' || 'double' || 'num' || 'bool' || 'DateTime' => true,
    'Object' || 'dynamic' => true,
    _ when parsed.startsWith('Map<') => true,
    _ => false,
  };
}

String _normalizeType(String source) {
  var value = source.trim().replaceAll(RegExp(r'\s+'), '');
  if (value.endsWith('?')) {
    value = value.substring(0, value.length - 1);
  }
  final listMatch = RegExp(r'^List<(.+)>$').firstMatch(value);
  if (listMatch != null) {
    value = listMatch.group(1)!;
    if (value.endsWith('?')) {
      value = value.substring(0, value.length - 1);
    }
  }
  return value;
}

String _pluralize(String value) {
  if (value.isEmpty || value.endsWith('s')) {
    return value;
  }
  return '${value}s';
}

String _defaultTableName(String modelName) {
  if (modelName.isEmpty) {
    return modelName;
  }
  return _pluralize(_lowercaseFirst(modelName));
}

String _lowercaseFirst(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value[0].toLowerCase() + value.substring(1);
}

String _uppercaseFirst(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value[0].toUpperCase() + value.substring(1);
}

String _stableHash(String value) {
  var hash = 0xcbf29ce484222325;
  const prime = 0x100000001b3;
  const mask = 0xffffffffffffffff;
  for (final byte in utf8.encode(value)) {
    hash ^= byte;
    hash = (hash * prime) & mask;
  }
  final hex = hash.toUnsigned(64).toRadixString(16).padLeft(16, '0');
  return 'c$hex';
}

String _relationName(SchemaFieldDefinition field) {
  final configured = field.relation?.name?.trim();
  if (configured == null || configured.isEmpty) {
    return field.name;
  }
  return configured;
}

final class _RuntimeProfile {
  final String target;
  final Map<String, Object?> capabilities;

  const _RuntimeProfile({required this.target, required this.capabilities});
}

final class _SchemaModelInfo {
  final SchemaModelDefinition model;
  final Set<String> scalarFields;
  final List<String> scalarFieldNames;
  final List<String> idFields;

  const _SchemaModelInfo({
    required this.model,
    required this.scalarFields,
    required this.scalarFieldNames,
    required this.idFields,
  });

  String? get singleIdField {
    if (idFields.length != 1) {
      return null;
    }
    return idFields.single;
  }
}

final class _RelationFieldType {
  final String relatedModel;
  final bool isMany;

  const _RelationFieldType({required this.relatedModel, required this.isMany});

  String get cardinality => isMany ? 'many' : 'one';
}

final class _ResolvedRelation {
  final List<String> sourceFields;
  final List<String> targetFields;
  final String cardinality;

  const _ResolvedRelation({
    required this.sourceFields,
    required this.targetFields,
    required this.cardinality,
  });
}
