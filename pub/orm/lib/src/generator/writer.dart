import 'model.dart';

final class TypedClientWriterOptions {
  final String ormImport;
  final String? libraryName;
  final String? banner;

  const TypedClientWriterOptions({
    this.ormImport = 'package:orm/orm.dart',
    this.libraryName,
    this.banner,
  });
}

final class TypedClientWriter {
  const TypedClientWriter();

  String write({
    required TypedClientSchema schema,
    TypedClientWriterOptions options = const TypedClientWriterOptions(),
  }) {
    final resolvedModels = _resolveModels(schema.models);
    final modelLookup = <String, _ResolvedModel>{};
    for (final model in resolvedModels) {
      modelLookup[model.model.name] = model;
      modelLookup[model.model.runtimeName] = model;
    }

    final buffer = StringBuffer();
    _writeHeader(buffer: buffer, options: options);
    _writeGeneratedClientClass(buffer: buffer, models: resolvedModels);

    for (final model in resolvedModels) {
      _writeTypedDelegateClass(buffer: buffer, model: model);
    }

    for (final model in resolvedModels) {
      _writeDataOrInputClass(
        buffer: buffer,
        model: model,
        classKind: _TemplateClassKind.data,
        lookup: modelLookup,
      );
      _writeDataOrInputClass(
        buffer: buffer,
        model: model,
        classKind: _TemplateClassKind.where,
        lookup: modelLookup,
      );
      _writeDataOrInputClass(
        buffer: buffer,
        model: model,
        classKind: _TemplateClassKind.create,
        lookup: modelLookup,
      );
      _writeDataOrInputClass(
        buffer: buffer,
        model: model,
        classKind: _TemplateClassKind.update,
        lookup: modelLookup,
      );
    }

    _writeJsonHelpers(buffer);
    return buffer.toString();
  }

  void _writeHeader({
    required StringBuffer buffer,
    required TypedClientWriterOptions options,
  }) {
    final libraryName = options.libraryName?.trim();
    if (libraryName != null && libraryName.isNotEmpty) {
      buffer.writeln('library $libraryName;');
      buffer.writeln();
    }

    final banner = options.banner?.trim();
    if (banner != null && banner.isNotEmpty) {
      final lines = banner.split('\n');
      for (final line in lines) {
        if (line.isEmpty) {
          buffer.writeln('//');
          continue;
        }
        buffer.writeln('// $line');
      }
    } else {
      buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.');
    }
    buffer.writeln('// ignore_for_file: unused_element');

    buffer.writeln();
    buffer.writeln("import '${options.ormImport}';");
    buffer.writeln();
  }

  void _writeGeneratedClientClass({
    required StringBuffer buffer,
    required List<_ResolvedModel> models,
  }) {
    buffer.writeln('class GeneratedOrmClient {');
    buffer.writeln('  final OrmModelContext _context;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmClient(this._context);');
    buffer.writeln();

    for (final model in models) {
      buffer.writeln(
        '  late final ${model.delegateClassName} ${model.getterName} =',
      );
      buffer.writeln(
        "      ${model.delegateClassName}(_context.model('${_escapeString(model.model.runtimeName)}'));",
      );
      buffer.writeln();
    }

    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeTypedDelegateClass({
    required StringBuffer buffer,
    required _ResolvedModel model,
  }) {
    buffer.writeln('class ${model.delegateClassName} {');
    buffer.writeln('  final ModelDelegate _delegate;');
    buffer.writeln();
    buffer.writeln('  const ${model.delegateClassName}(this._delegate);');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> findMany({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln('    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final rows = await _delegate.findMany(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> findUnique({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final row = await _delegate.findUnique(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> findFirst({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final row = await _delegate.findFirst(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> create({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final row = await _delegate.create(');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> update({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final row = await _delegate.update(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> delete({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final row = await _delegate.delete(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> upsert({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    required ${model.createInputClassName} create,');
    buffer.writeln('    required ${model.updateInputClassName} update,');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final row = await _delegate.upsert(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      create: create.toJson(),');
    buffer.writeln('      update: update.toJson(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> count({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return _delegate.count(where: where.toJson());');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<bool> exists({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return _delegate.exists(where: where.toJson());');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Stream<${model.dataClassName}> stream({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln('    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],');
    buffer.writeln('    List<String> select = const <String>[],');
    buffer.writeln(
      '    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},',
    );
    buffer.writeln('  }) async* {');
    buffer.writeln('    await for (final row in _delegate.streamMany(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    )) {');
    buffer.writeln('      yield ${model.dataClassName}.fromJson(row);');
    buffer.writeln('    }');
    buffer.writeln('  }');

    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeDataOrInputClass({
    required StringBuffer buffer,
    required _ResolvedModel model,
    required _TemplateClassKind classKind,
    required Map<String, _ResolvedModel> lookup,
  }) {
    final className = _className(model, classKind);
    final fields = _buildFieldBindings(_fieldsForClass(model.model, classKind));

    buffer.writeln('class $className {');

    for (final field in fields) {
      final type = _fieldType(
        field: field.field,
        classKind: classKind,
        lookup: lookup,
      );
      buffer.writeln('  final $type ${field.memberName};');
    }

    if (fields.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('  const $className({');
      for (final field in fields) {
        final isOptional = _isOptionalField(field.field, classKind: classKind);
        final prefix = isOptional ? '' : 'required ';
        buffer.writeln('    ${prefix}this.${field.memberName},');
      }
      buffer.writeln('  });');
    } else {
      buffer.writeln();
      buffer.writeln('  const $className();');
    }

    buffer.writeln();
    buffer.writeln(
      '  factory $className.fromJson(Map<String, Object?> json) {',
    );
    buffer.writeln('    return $className(');
    for (final field in fields) {
      final decodeExpression = _decodeExpression(
        field: field.field,
        classKind: classKind,
        accessor: "json['${_escapeString(field.field.name)}']",
        lookup: lookup,
      );
      if (_isOptionalField(field.field, classKind: classKind)) {
        buffer.writeln('      ${field.memberName}: $decodeExpression,');
      } else {
        final type = _fieldType(
          field: field.field,
          classKind: classKind,
          lookup: lookup,
        );
        final nonNullableType = _stripNullable(type);
        buffer.writeln(
          "      ${field.memberName}: _requiredValue<$nonNullableType>($decodeExpression, '${_escapeString(field.field.name)}'),",
        );
      }
    }
    buffer.writeln('    );');
    buffer.writeln('  }');

    buffer.writeln();
    buffer.writeln('  Map<String, Object?> toJson() {');
    buffer.writeln('    return <String, Object?>{');
    for (final field in fields) {
      final isOptional = _isOptionalField(field.field, classKind: classKind);
      final memberName = isOptional ? '${field.memberName}!' : field.memberName;
      final valueExpression = _encodeExpression(
        field: field.field,
        classKind: classKind,
        memberName: memberName,
        lookup: lookup,
      );

      if (isOptional) {
        buffer.writeln(
          "      if (${field.memberName} != null) '${_escapeString(field.field.name)}': $valueExpression,",
        );
      } else {
        buffer.writeln(
          "      '${_escapeString(field.field.name)}': $valueExpression,",
        );
      }
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeJsonHelpers(StringBuffer buffer) {
    buffer.writeln(
      'typedef _FromJsonFactory<T> = T Function(Map<String, Object?> json);',
    );
    buffer.writeln();
    buffer.writeln('T _requiredValue<T>(T? value, String fieldName) {');
    buffer.writeln('  if (value == null) {');
    buffer.writeln(
      "    throw FormatException('Missing required field: \$fieldName.');",
    );
    buffer.writeln('  }');
    buffer.writeln('  return value;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('String? _readString(Object? value) {');
    buffer.writeln('  if (value is String) {');
    buffer.writeln('    return value;');
    buffer.writeln('  }');
    buffer.writeln('  return null;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('int? _readInt(Object? value) {');
    buffer.writeln('  if (value is int) {');
    buffer.writeln('    return value;');
    buffer.writeln('  }');
    buffer.writeln('  if (value is num) {');
    buffer.writeln('    return value.toInt();');
    buffer.writeln('  }');
    buffer.writeln('  return null;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('double? _readDouble(Object? value) {');
    buffer.writeln('  if (value is double) {');
    buffer.writeln('    return value;');
    buffer.writeln('  }');
    buffer.writeln('  if (value is num) {');
    buffer.writeln('    return value.toDouble();');
    buffer.writeln('  }');
    buffer.writeln('  return null;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('bool? _readBool(Object? value) {');
    buffer.writeln('  if (value is bool) {');
    buffer.writeln('    return value;');
    buffer.writeln('  }');
    buffer.writeln('  return null;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('DateTime? _readDateTime(Object? value) {');
    buffer.writeln('  if (value is DateTime) {');
    buffer.writeln('    return value;');
    buffer.writeln('  }');
    buffer.writeln('  if (value is String) {');
    buffer.writeln('    return DateTime.tryParse(value);');
    buffer.writeln('  }');
    buffer.writeln('  return null;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('Object? _readJsonValue(Object? value) {');
    buffer.writeln('  return value;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('List<String>? _readStringList(Object? value) {');
    buffer.writeln('  if (value is! List) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <String>[];');
    buffer.writeln('  for (final item in value) {');
    buffer.writeln('    if (item is String) {');
    buffer.writeln('      result.add(item);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('  return List<String>.unmodifiable(result);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('List<int>? _readIntList(Object? value) {');
    buffer.writeln('  if (value is! List) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <int>[];');
    buffer.writeln('  for (final item in value) {');
    buffer.writeln('    if (item is int) {');
    buffer.writeln('      result.add(item);');
    buffer.writeln('      continue;');
    buffer.writeln('    }');
    buffer.writeln('    if (item is num) {');
    buffer.writeln('      result.add(item.toInt());');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('  return List<int>.unmodifiable(result);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('List<double>? _readDoubleList(Object? value) {');
    buffer.writeln('  if (value is! List) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <double>[];');
    buffer.writeln('  for (final item in value) {');
    buffer.writeln('    if (item is double) {');
    buffer.writeln('      result.add(item);');
    buffer.writeln('      continue;');
    buffer.writeln('    }');
    buffer.writeln('    if (item is num) {');
    buffer.writeln('      result.add(item.toDouble());');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('  return List<double>.unmodifiable(result);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('List<bool>? _readBoolList(Object? value) {');
    buffer.writeln('  if (value is! List) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <bool>[];');
    buffer.writeln('  for (final item in value) {');
    buffer.writeln('    if (item is bool) {');
    buffer.writeln('      result.add(item);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('  return List<bool>.unmodifiable(result);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('List<DateTime>? _readDateTimeList(Object? value) {');
    buffer.writeln('  if (value is! List) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <DateTime>[];');
    buffer.writeln('  for (final item in value) {');
    buffer.writeln('    final parsed = _readDateTime(item);');
    buffer.writeln('    if (parsed != null) {');
    buffer.writeln('      result.add(parsed);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('  return List<DateTime>.unmodifiable(result);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('List<Object?>? _readJsonList(Object? value) {');
    buffer.writeln('  if (value is! List) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  return List<Object?>.unmodifiable(value);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('Map<String, Object?>? _readJsonMap(Object? value) {');
    buffer.writeln('  if (value is Map<String, Object?>) {');
    buffer.writeln('    return value;');
    buffer.writeln('  }');
    buffer.writeln('  if (value is! Map) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <String, Object?>{};');
    buffer.writeln('  for (final entry in value.entries) {');
    buffer.writeln('    final key = entry.key;');
    buffer.writeln('    if (key is String) {');
    buffer.writeln('      result[key] = entry.value;');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('  return result;');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln(
      'List<Map<String, Object?>>? _readJsonMapList(Object? value) {',
    );
    buffer.writeln('  if (value is! List) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <Map<String, Object?>>[];');
    buffer.writeln('  for (final item in value) {');
    buffer.writeln('    final map = _readJsonMap(item);');
    buffer.writeln('    if (map != null) {');
    buffer.writeln('      result.add(map);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('  return List<Map<String, Object?>>.unmodifiable(result);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln(
      'T? _readRelation<T>(Object? value, _FromJsonFactory<T> fromJson) {',
    );
    buffer.writeln('  final map = _readJsonMap(value);');
    buffer.writeln('  if (map == null) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  return fromJson(map);');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('List<T>? _readRelationList<T>(');
    buffer.writeln('  Object? value,');
    buffer.writeln('  _FromJsonFactory<T> fromJson,');
    buffer.writeln(') {');
    buffer.writeln('  final maps = _readJsonMapList(value);');
    buffer.writeln('  if (maps == null) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('  final result = <T>[];');
    buffer.writeln('  for (final map in maps) {');
    buffer.writeln('    result.add(fromJson(map));');
    buffer.writeln('  }');
    buffer.writeln('  return List<T>.unmodifiable(result);');
    buffer.writeln('}');
    buffer.writeln();
  }

  List<_ResolvedModel> _resolveModels(List<TypedModel> models) {
    final resolved = <_ResolvedModel>[];
    final usedClassNames = <String>{};
    final usedGetterNames = <String>{};

    for (final model in models) {
      final classBaseName = _makeUnique(
        base: _toUpperCamelIdentifier(model.name, fallback: 'Model'),
        used: usedClassNames,
      );
      final getterName = _makeUnique(
        base: _toLowerCamelIdentifier(model.name, fallback: 'model'),
        used: usedGetterNames,
      );
      resolved.add(
        _ResolvedModel(
          model: model,
          classBaseName: classBaseName,
          getterName: getterName,
        ),
      );
    }

    return resolved;
  }

  Iterable<TypedField> _fieldsForClass(
    TypedModel model,
    _TemplateClassKind classKind,
  ) {
    return switch (classKind) {
      _TemplateClassKind.data => model.fields,
      _TemplateClassKind.where => model.fields.where(
        (field) => field.includeInWhere,
      ),
      _TemplateClassKind.create => model.fields.where(
        (field) => field.includeInCreate,
      ),
      _TemplateClassKind.update => model.fields.where(
        (field) => field.includeInUpdate,
      ),
    };
  }

  List<_FieldBinding> _buildFieldBindings(Iterable<TypedField> fields) {
    final bindings = <_FieldBinding>[];
    final usedNames = <String>{};
    for (final field in fields) {
      final memberName = _makeUnique(
        base: _toLowerCamelIdentifier(field.name, fallback: 'field'),
        used: usedNames,
      );
      bindings.add(_FieldBinding(field: field, memberName: memberName));
    }
    return bindings;
  }

  String _className(_ResolvedModel model, _TemplateClassKind classKind) {
    return switch (classKind) {
      _TemplateClassKind.data => model.dataClassName,
      _TemplateClassKind.where => model.whereInputClassName,
      _TemplateClassKind.create => model.createInputClassName,
      _TemplateClassKind.update => model.updateInputClassName,
    };
  }

  bool _isOptionalField(
    TypedField field, {
    required _TemplateClassKind classKind,
  }) {
    if (field.isRelation) {
      return true;
    }

    return switch (classKind) {
      _TemplateClassKind.data => true,
      _TemplateClassKind.where => true,
      _TemplateClassKind.create => field.isNullable,
      _TemplateClassKind.update => true,
    };
  }

  String _fieldType({
    required TypedField field,
    required _TemplateClassKind classKind,
    required Map<String, _ResolvedModel> lookup,
  }) {
    final optional = _isOptionalField(field, classKind: classKind);
    final baseType = _baseType(
      field: field,
      classKind: classKind,
      lookup: lookup,
    );

    if (optional) {
      return '$baseType?';
    }
    return baseType;
  }

  String _baseType({
    required TypedField field,
    required _TemplateClassKind classKind,
    required Map<String, _ResolvedModel> lookup,
  }) {
    if (field.isRelation) {
      final relationModelName = field.relationModel;
      final relation = relationModelName == null
          ? null
          : lookup[relationModelName];
      final elementType = relation == null
          ? 'Map<String, Object?>'
          : '${relation.classBaseName}${_classSuffix(classKind)}';

      if (field.isList) {
        return 'List<$elementType>';
      }
      return elementType;
    }

    final scalarType = field.scalarType;
    if (scalarType == null) {
      return 'Object';
    }

    if (field.isList) {
      if (scalarType == TypedScalarType.json) {
        return 'List<Object?>';
      }
      return 'List<${scalarType.dartType}>';
    }

    return scalarType.dartType;
  }

  String _decodeExpression({
    required TypedField field,
    required _TemplateClassKind classKind,
    required String accessor,
    required Map<String, _ResolvedModel> lookup,
  }) {
    if (field.isRelation) {
      final relationModelName = field.relationModel;
      final relation = relationModelName == null
          ? null
          : lookup[relationModelName];

      if (relation == null) {
        if (field.isList) {
          return '_readJsonMapList($accessor)';
        }
        return '_readJsonMap($accessor)';
      }

      final relationClass =
          '${relation.classBaseName}${_classSuffix(classKind)}';
      if (field.isList) {
        return '_readRelationList($accessor, $relationClass.fromJson)';
      }
      return '_readRelation($accessor, $relationClass.fromJson)';
    }

    return _decodeScalar(field, accessor: accessor);
  }

  String _decodeScalar(TypedField field, {required String accessor}) {
    final scalarType = field.scalarType;
    if (scalarType == null) {
      return '_readJsonValue($accessor)';
    }

    if (field.isList) {
      return switch (scalarType) {
        TypedScalarType.string => '_readStringList($accessor)',
        TypedScalarType.integer => '_readIntList($accessor)',
        TypedScalarType.floating => '_readDoubleList($accessor)',
        TypedScalarType.boolean => '_readBoolList($accessor)',
        TypedScalarType.dateTime => '_readDateTimeList($accessor)',
        TypedScalarType.json => '_readJsonList($accessor)',
      };
    }

    return switch (scalarType) {
      TypedScalarType.string => '_readString($accessor)',
      TypedScalarType.integer => '_readInt($accessor)',
      TypedScalarType.floating => '_readDouble($accessor)',
      TypedScalarType.boolean => '_readBool($accessor)',
      TypedScalarType.dateTime => '_readDateTime($accessor)',
      TypedScalarType.json => '_readJsonValue($accessor)',
    };
  }

  String _encodeExpression({
    required TypedField field,
    required _TemplateClassKind classKind,
    required String memberName,
    required Map<String, _ResolvedModel> lookup,
  }) {
    if (field.isRelation) {
      final relationModelName = field.relationModel;
      final relation = relationModelName == null
          ? null
          : lookup[relationModelName];

      if (relation == null) {
        return memberName;
      }

      if (field.isList) {
        return '$memberName.map((value) => value.toJson()).toList(growable: false)';
      }
      return '$memberName.toJson()';
    }

    final scalarType = field.scalarType;
    if (scalarType == TypedScalarType.dateTime) {
      if (field.isList) {
        return '$memberName.map((value) => value.toIso8601String()).toList(growable: false)';
      }
      return '$memberName.toIso8601String()';
    }

    return memberName;
  }

  String _classSuffix(_TemplateClassKind classKind) {
    return switch (classKind) {
      _TemplateClassKind.data => 'Data',
      _TemplateClassKind.where => 'WhereInput',
      _TemplateClassKind.create => 'CreateInput',
      _TemplateClassKind.update => 'UpdateInput',
    };
  }

  String _makeUnique({required String base, required Set<String> used}) {
    if (!used.contains(base)) {
      used.add(base);
      return base;
    }

    var index = 2;
    while (true) {
      final candidate = '$base$index';
      if (!used.contains(candidate)) {
        used.add(candidate);
        return candidate;
      }
      index += 1;
    }
  }

  String _toUpperCamelIdentifier(String raw, {required String fallback}) {
    final sanitized = _sanitize(raw);
    if (sanitized.isEmpty) {
      return fallback;
    }

    final first = sanitized.first;
    final head = _capitalize(first);
    final tail = sanitized.skip(1).map(_capitalize).join();
    final identifier = '$head$tail';
    return _avoidKeyword(identifier, suffix: 'Type');
  }

  String _toLowerCamelIdentifier(String raw, {required String fallback}) {
    final sanitized = _sanitize(raw);
    if (sanitized.isEmpty) {
      return fallback;
    }

    final first = sanitized.first;
    final head = first.toLowerCase();
    final tail = sanitized.skip(1).map(_capitalize).join();
    final identifier = '$head$tail';
    return _avoidKeyword(identifier, suffix: 'Value');
  }

  List<String> _sanitize(String raw) {
    final replaced = raw.replaceAll(RegExp(r'[^A-Za-z0-9]+'), ' ');
    final segments = replaced
        .split(RegExp(r'\s+'))
        .where((segment) => segment.isNotEmpty)
        .toList(growable: false);

    if (segments.isEmpty) {
      return const <String>[];
    }

    final normalized = <String>[];
    for (final segment in segments) {
      final withPrefix = RegExp(r'^[0-9]').hasMatch(segment)
          ? 'n$segment'
          : segment;
      normalized.add(withPrefix);
    }
    return normalized;
  }

  String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }
    final lower = value.toLowerCase();
    return '${lower[0].toUpperCase()}${lower.substring(1)}';
  }

  String _avoidKeyword(String name, {required String suffix}) {
    if (_dartKeywords.contains(name)) {
      return '$name$suffix';
    }
    return name;
  }

  String _stripNullable(String type) {
    if (type.endsWith('?')) {
      return type.substring(0, type.length - 1);
    }
    return type;
  }

  String _escapeString(String value) {
    return value
        .replaceAll(r'\\', r'\\\\')
        .replaceAll("'", r"\\'")
        .replaceAll('\n', r'\\n')
        .replaceAll('\r', r'\\r');
  }
}

enum _TemplateClassKind { data, where, create, update }

final class _ResolvedModel {
  final TypedModel model;
  final String classBaseName;
  final String getterName;

  const _ResolvedModel({
    required this.model,
    required this.classBaseName,
    required this.getterName,
  });

  String get delegateClassName => '${classBaseName}TypedDelegate';

  String get dataClassName => '${classBaseName}Data';

  String get whereInputClassName => '${classBaseName}WhereInput';

  String get createInputClassName => '${classBaseName}CreateInput';

  String get updateInputClassName => '${classBaseName}UpdateInput';
}

final class _FieldBinding {
  final TypedField field;
  final String memberName;

  const _FieldBinding({required this.field, required this.memberName});
}

const Set<String> _dartKeywords = <String>{
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'base',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'of',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'sealed',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'when',
  'while',
  'with',
  'yield',
};
