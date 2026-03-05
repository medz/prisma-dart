import 'snapshot.dart';

String emitTypedClient({
  required SchemaSnapshot schema,
  required String schemaImportPath,
}) {
  final buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
    ..writeln('// ignore_for_file: unused_import')
    ..writeln()
    ..writeln("import 'package:orm/orm.dart';")
    ..writeln("import '$schemaImportPath';")
    ..writeln();

  for (final model in schema.models) {
    buffer
      ..writeln(_emitRowType(model))
      ..writeln(_emitDelegate(model));
  }

  buffer
    ..writeln('final class OrmTypedClient {')
    ..writeln('  final OrmModelContext _context;')
    ..writeln('')
    ..writeln('  const OrmTypedClient(this._context);')
    ..writeln('');

  for (final model in schema.models) {
    final getterName = _toLowerCamel(model.name);
    buffer.writeln(
      '  ${model.name}Delegate get $getterName => ${model.name}Delegate(_context.collection(${_singleQuoted(model.name)}));',
    );
  }

  buffer
    ..writeln('}')
    ..writeln('')
    ..writeln('extension OrmTypedClientExtension on OrmModelContext {')
    ..writeln('  OrmTypedClient get typed => OrmTypedClient(this);')
    ..writeln('}');

  return buffer.toString();
}

String _emitRowType(SchemaModelDefinition model) {
  final buffer = StringBuffer()..writeln('typedef ${model.name}Row = ({');

  for (final field in model.fields) {
    buffer.writeln('  ${field.typeSource} ${field.name},');
  }

  buffer.writeln('});');
  return buffer.toString();
}

String _emitDelegate(SchemaModelDefinition model) {
  final rowType = '${model.name}Row';
  final className = '${model.name}Delegate';

  final buffer = StringBuffer()
    ..writeln('final class $className {')
    ..writeln('  final ModelDelegate _delegate;')
    ..writeln('')
    ..writeln('  const $className(this._delegate);')
    ..writeln('')
    ..writeln('  ModelDelegate get raw => _delegate;')
    ..writeln('')
    ..writeln('  ModelQuery query() => _delegate.query();')
    ..writeln('')
    ..writeln(
      '  Future<List<$rowType>> findMany({'
      'JsonMap where = const <String, Object?>{}, '
      'int? skip, '
      'int? take, '
      'List<OrmOrderBy> orderBy = const <OrmOrderBy>[], '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async {',
    )
    ..writeln('    final rows = await _delegate.findMany(')
    ..writeln('      where: where,')
    ..writeln('      skip: skip,')
    ..writeln('      take: take,')
    ..writeln('      orderBy: orderBy,')
    ..writeln('      select: select,')
    ..writeln('      include: include,')
    ..writeln('    );')
    ..writeln(
      '    return rows.map(_to${model.name}Row).toList(growable: false);',
    )
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Stream<$rowType> streamMany({'
      'JsonMap where = const <String, Object?>{}, '
      'int? skip, '
      'int? take, '
      'List<OrmOrderBy> orderBy = const <OrmOrderBy>[], '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async* {',
    )
    ..writeln('    await for (final row in _delegate.streamMany(')
    ..writeln('      where: where,')
    ..writeln('      skip: skip,')
    ..writeln('      take: take,')
    ..writeln('      orderBy: orderBy,')
    ..writeln('      select: select,')
    ..writeln('      include: include,')
    ..writeln('    )) {')
    ..writeln('      yield _to${model.name}Row(row);')
    ..writeln('    }')
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Future<$rowType?> findUnique({'
      'JsonMap where = const <String, Object?>{}, '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async {',
    )
    ..writeln(
      '    final row = await _delegate.findUnique(where: where, select: select, include: include);',
    )
    ..writeln('    if (row == null) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('    return _to${model.name}Row(row);')
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Future<$rowType?> findFirst({'
      'JsonMap where = const <String, Object?>{}, '
      'int? skip, '
      'int? take, '
      'List<OrmOrderBy> orderBy = const <OrmOrderBy>[], '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async {',
    )
    ..writeln('    final row = await _delegate.findFirst(')
    ..writeln('      where: where,')
    ..writeln('      skip: skip,')
    ..writeln('      take: take,')
    ..writeln('      orderBy: orderBy,')
    ..writeln('      select: select,')
    ..writeln('      include: include,')
    ..writeln('    );')
    ..writeln('    if (row == null) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('    return _to${model.name}Row(row);')
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Future<$rowType> create({'
      'required JsonMap data, '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async {',
    )
    ..writeln(
      '    final row = await _delegate.create(data: data, select: select, include: include);',
    )
    ..writeln('    return _to${model.name}Row(row);')
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Future<List<$rowType>> createMany({'
      'required List<JsonMap> data, '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async {',
    )
    ..writeln(
      '    final rows = await _delegate.createMany(data: data, select: select, include: include);',
    )
    ..writeln(
      '    return rows.map(_to${model.name}Row).toList(growable: false);',
    )
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Future<$rowType?> update({'
      'JsonMap where = const <String, Object?>{}, '
      'required JsonMap data, '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async {',
    )
    ..writeln('    final row = await _delegate.update(')
    ..writeln('      where: where,')
    ..writeln('      data: data,')
    ..writeln('      select: select,')
    ..writeln('      include: include,')
    ..writeln('    );')
    ..writeln('    if (row == null) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('    return _to${model.name}Row(row);')
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Future<$rowType?> delete({'
      'JsonMap where = const <String, Object?>{}, '
      'List<String> select = const <String>[], '
      'Map<String, IncludeSpec> include = const <String, IncludeSpec>{}'
      '}) async {',
    )
    ..writeln('    final row = await _delegate.delete(')
    ..writeln('      where: where,')
    ..writeln('      select: select,')
    ..writeln('      include: include,')
    ..writeln('    );')
    ..writeln('    if (row == null) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('    return _to${model.name}Row(row);')
    ..writeln('  }')
    ..writeln('')
    ..writeln(
      '  Future<int> count({JsonMap where = const <String, Object?>{}}) => _delegate.count(where: where);',
    )
    ..writeln('')
    ..writeln(
      '  Future<bool> exists({JsonMap where = const <String, Object?>{}}) => _delegate.exists(where: where);',
    )
    ..writeln('')
    ..writeln('  $rowType fromJson(JsonMap row) => _to${model.name}Row(row);')
    ..writeln('')
    ..writeln('  $rowType _to${model.name}Row(JsonMap row) {')
    ..writeln('    return (');

  for (final field in model.fields) {
    buffer.writeln(
      "      ${field.name}: row[${_singleQuoted(field.name)}] as ${field.typeSource},",
    );
  }

  buffer
    ..writeln('    );')
    ..writeln('  }')
    ..writeln('}');

  return buffer.toString();
}

String _toLowerCamel(String value) {
  if (value.isEmpty) {
    return value;
  }
  final first = value.substring(0, 1).toLowerCase();
  return '$first${value.substring(1)}';
}

String _singleQuoted(String value) {
  return "'${value.replaceAll("'", "\\'")}'";
}
