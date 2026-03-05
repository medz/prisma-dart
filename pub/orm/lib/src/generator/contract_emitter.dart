import 'dart:collection';
import 'dart:convert';

import 'snapshot.dart';

String emitContractArtifact({required SchemaSnapshot schema}) {
  final models = SplayTreeMap<String, Object?>();
  for (final model in schema.models) {
    final scalarFields =
        model.fields
            .where((field) => _isScalarType(field.typeSource))
            .map((field) => field.name)
            .toList(growable: false)
          ..sort();
    models[model.name] = <String, Object?>{
      'name': model.name,
      'table': _defaultTableName(model.name),
      'fields': scalarFields,
      'relations': const <String, Object?>{},
    };
  }

  final canonical = <String, Object?>{
    'version': '1.0.0',
    'target': 'generic',
    'models': models,
  };
  final canonicalJson = jsonEncode(canonical);
  final hash = _stableHash(canonicalJson);

  final contract = <String, Object?>{
    'version': '1.0.0',
    'hash': hash,
    'target': 'generic',
    'markerStorageHash': hash,
    'models': models,
    'aliases': const <String, Object?>{},
    'capabilities': const <String, Object?>{
      'includeSingleQuery': false,
      'mutationReturning': true,
    },
  };

  final encoder = const JsonEncoder.withIndent('  ');
  return '${encoder.convert(contract)}\n';
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

String _defaultTableName(String modelName) {
  if (modelName.isEmpty) {
    return modelName;
  }
  final lower = modelName[0].toLowerCase() + modelName.substring(1);
  if (lower.endsWith('s')) {
    return lower;
  }
  return '${lower}s';
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
