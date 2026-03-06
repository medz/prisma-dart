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
    _writeWhereFilterClasses(buffer);
    _writeGeneratedClientClass(buffer: buffer, models: resolvedModels);

    for (final model in resolvedModels) {
      _writeQueryDslClasses(buffer: buffer, model: model, lookup: modelLookup);
      _writeTypedDelegateClass(buffer: buffer, model: model);
      _writeTypedSqlClass(buffer: buffer, model: model);
    }

    for (final model in resolvedModels) {
      _writeRelationWhereFilterClasses(
        buffer: buffer,
        model: model,
        lookup: modelLookup,
      );
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
        classKind: _TemplateClassKind.whereUnique,
        lookup: modelLookup,
      );
      _writeDataOrInputClass(
        buffer: buffer,
        model: model,
        classKind: _TemplateClassKind.cursor,
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
    buffer.writeln(
      '// ignore_for_file: unused_element, non_constant_identifier_names',
    );

    buffer.writeln();
    buffer.writeln("import '${options.ormImport}';");
    buffer.writeln();
    buffer.writeln('const Object _typedStateKeepToken = Object();');
    buffer.writeln();
  }

  void _writeWhereFilterClasses(StringBuffer buffer) {
    buffer.writeln('class StringWhereFilter {');
    buffer.writeln('  final String? equals;');
    buffer.writeln('  final String? not;');
    buffer.writeln('  final List<String>? inValues;');
    buffer.writeln('  final List<String>? notIn;');
    buffer.writeln('  final String? gt;');
    buffer.writeln('  final String? gte;');
    buffer.writeln('  final String? lt;');
    buffer.writeln('  final String? lte;');
    buffer.writeln('  final String? contains;');
    buffer.writeln('  final String? startsWith;');
    buffer.writeln('  final String? endsWith;');
    buffer.writeln();
    buffer.writeln('  const StringWhereFilter({');
    buffer.writeln('    this.equals,');
    buffer.writeln('    this.not,');
    buffer.writeln('    this.inValues,');
    buffer.writeln('    this.notIn,');
    buffer.writeln('    this.gt,');
    buffer.writeln('    this.gte,');
    buffer.writeln('    this.lt,');
    buffer.writeln('    this.lte,');
    buffer.writeln('    this.contains,');
    buffer.writeln('    this.startsWith,');
    buffer.writeln('    this.endsWith,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
      '  factory StringWhereFilter.fromJsonValue(Object? value) {',
    );
    buffer.writeln('    if (value is String) {');
    buffer.writeln('      return StringWhereFilter(equals: value);');
    buffer.writeln('    }');
    buffer.writeln('    if (value is Map<String, Object?>) {');
    buffer.writeln('      return StringWhereFilter(');
    buffer.writeln("        equals: _readString(value['equals']),");
    buffer.writeln("        not: _readString(value['not']),");
    buffer.writeln("        inValues: _readStringList(value['in']),");
    buffer.writeln("        notIn: _readStringList(value['notIn']),");
    buffer.writeln("        gt: _readString(value['gt']),");
    buffer.writeln("        gte: _readString(value['gte']),");
    buffer.writeln("        lt: _readString(value['lt']),");
    buffer.writeln("        lte: _readString(value['lte']),");
    buffer.writeln("        contains: _readString(value['contains']),");
    buffer.writeln("        startsWith: _readString(value['startsWith']),");
    buffer.writeln("        endsWith: _readString(value['endsWith']),");
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    return const StringWhereFilter();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() {');
    buffer.writeln('    if (isEmpty) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln(
      '    if (equals != null && not == null && inValues == null && notIn == null && gt == null && gte == null && lt == null && lte == null && contains == null && startsWith == null && endsWith == null) {',
    );
    buffer.writeln('      return equals;');
    buffer.writeln('    }');
    buffer.writeln('    return <String, Object?>{');
    buffer.writeln("      if (equals != null) 'equals': equals,");
    buffer.writeln("      if (not != null) 'not': not,");
    buffer.writeln("      if (inValues != null) 'in': inValues,");
    buffer.writeln("      if (notIn != null) 'notIn': notIn,");
    buffer.writeln("      if (gt != null) 'gt': gt,");
    buffer.writeln("      if (gte != null) 'gte': gte,");
    buffer.writeln("      if (lt != null) 'lt': lt,");
    buffer.writeln("      if (lte != null) 'lte': lte,");
    buffer.writeln("      if (contains != null) 'contains': contains,");
    buffer.writeln("      if (startsWith != null) 'startsWith': startsWith,");
    buffer.writeln("      if (endsWith != null) 'endsWith': endsWith,");
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty =>');
    buffer.writeln('      equals == null &&');
    buffer.writeln('      not == null &&');
    buffer.writeln('      inValues == null &&');
    buffer.writeln('      notIn == null &&');
    buffer.writeln('      gt == null &&');
    buffer.writeln('      gte == null &&');
    buffer.writeln('      lt == null &&');
    buffer.writeln('      lte == null &&');
    buffer.writeln('      contains == null &&');
    buffer.writeln('      startsWith == null &&');
    buffer.writeln('      endsWith == null;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class IntWhereFilter {');
    buffer.writeln('  final int? equals;');
    buffer.writeln('  final int? not;');
    buffer.writeln('  final List<int>? inValues;');
    buffer.writeln('  final List<int>? notIn;');
    buffer.writeln('  final int? gt;');
    buffer.writeln('  final int? gte;');
    buffer.writeln('  final int? lt;');
    buffer.writeln('  final int? lte;');
    buffer.writeln();
    buffer.writeln('  const IntWhereFilter({');
    buffer.writeln('    this.equals,');
    buffer.writeln('    this.not,');
    buffer.writeln('    this.inValues,');
    buffer.writeln('    this.notIn,');
    buffer.writeln('    this.gt,');
    buffer.writeln('    this.gte,');
    buffer.writeln('    this.lt,');
    buffer.writeln('    this.lte,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln('  factory IntWhereFilter.fromJsonValue(Object? value) {');
    buffer.writeln('    if (value is int) {');
    buffer.writeln('      return IntWhereFilter(equals: value);');
    buffer.writeln('    }');
    buffer.writeln('    if (value is num) {');
    buffer.writeln('      return IntWhereFilter(equals: value.toInt());');
    buffer.writeln('    }');
    buffer.writeln('    if (value is Map<String, Object?>) {');
    buffer.writeln('      return IntWhereFilter(');
    buffer.writeln("        equals: _readInt(value['equals']),");
    buffer.writeln("        not: _readInt(value['not']),");
    buffer.writeln("        inValues: _readIntList(value['in']),");
    buffer.writeln("        notIn: _readIntList(value['notIn']),");
    buffer.writeln("        gt: _readInt(value['gt']),");
    buffer.writeln("        gte: _readInt(value['gte']),");
    buffer.writeln("        lt: _readInt(value['lt']),");
    buffer.writeln("        lte: _readInt(value['lte']),");
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    return const IntWhereFilter();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() {');
    buffer.writeln('    if (isEmpty) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln(
      '    if (equals != null && not == null && inValues == null && notIn == null && gt == null && gte == null && lt == null && lte == null) {',
    );
    buffer.writeln('      return equals;');
    buffer.writeln('    }');
    buffer.writeln('    return <String, Object?>{');
    buffer.writeln("      if (equals != null) 'equals': equals,");
    buffer.writeln("      if (not != null) 'not': not,");
    buffer.writeln("      if (inValues != null) 'in': inValues,");
    buffer.writeln("      if (notIn != null) 'notIn': notIn,");
    buffer.writeln("      if (gt != null) 'gt': gt,");
    buffer.writeln("      if (gte != null) 'gte': gte,");
    buffer.writeln("      if (lt != null) 'lt': lt,");
    buffer.writeln("      if (lte != null) 'lte': lte,");
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty =>');
    buffer.writeln('      equals == null &&');
    buffer.writeln('      not == null &&');
    buffer.writeln('      inValues == null &&');
    buffer.writeln('      notIn == null &&');
    buffer.writeln('      gt == null &&');
    buffer.writeln('      gte == null &&');
    buffer.writeln('      lt == null &&');
    buffer.writeln('      lte == null;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class DoubleWhereFilter {');
    buffer.writeln('  final double? equals;');
    buffer.writeln('  final double? not;');
    buffer.writeln('  final List<double>? inValues;');
    buffer.writeln('  final List<double>? notIn;');
    buffer.writeln('  final double? gt;');
    buffer.writeln('  final double? gte;');
    buffer.writeln('  final double? lt;');
    buffer.writeln('  final double? lte;');
    buffer.writeln();
    buffer.writeln('  const DoubleWhereFilter({');
    buffer.writeln('    this.equals,');
    buffer.writeln('    this.not,');
    buffer.writeln('    this.inValues,');
    buffer.writeln('    this.notIn,');
    buffer.writeln('    this.gt,');
    buffer.writeln('    this.gte,');
    buffer.writeln('    this.lt,');
    buffer.writeln('    this.lte,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
      '  factory DoubleWhereFilter.fromJsonValue(Object? value) {',
    );
    buffer.writeln('    if (value is double) {');
    buffer.writeln('      return DoubleWhereFilter(equals: value);');
    buffer.writeln('    }');
    buffer.writeln('    if (value is num) {');
    buffer.writeln('      return DoubleWhereFilter(equals: value.toDouble());');
    buffer.writeln('    }');
    buffer.writeln('    if (value is Map<String, Object?>) {');
    buffer.writeln('      return DoubleWhereFilter(');
    buffer.writeln("        equals: _readDouble(value['equals']),");
    buffer.writeln("        not: _readDouble(value['not']),");
    buffer.writeln("        inValues: _readDoubleList(value['in']),");
    buffer.writeln("        notIn: _readDoubleList(value['notIn']),");
    buffer.writeln("        gt: _readDouble(value['gt']),");
    buffer.writeln("        gte: _readDouble(value['gte']),");
    buffer.writeln("        lt: _readDouble(value['lt']),");
    buffer.writeln("        lte: _readDouble(value['lte']),");
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    return const DoubleWhereFilter();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() {');
    buffer.writeln('    if (isEmpty) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln(
      '    if (equals != null && not == null && inValues == null && notIn == null && gt == null && gte == null && lt == null && lte == null) {',
    );
    buffer.writeln('      return equals;');
    buffer.writeln('    }');
    buffer.writeln('    return <String, Object?>{');
    buffer.writeln("      if (equals != null) 'equals': equals,");
    buffer.writeln("      if (not != null) 'not': not,");
    buffer.writeln("      if (inValues != null) 'in': inValues,");
    buffer.writeln("      if (notIn != null) 'notIn': notIn,");
    buffer.writeln("      if (gt != null) 'gt': gt,");
    buffer.writeln("      if (gte != null) 'gte': gte,");
    buffer.writeln("      if (lt != null) 'lt': lt,");
    buffer.writeln("      if (lte != null) 'lte': lte,");
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty =>');
    buffer.writeln('      equals == null &&');
    buffer.writeln('      not == null &&');
    buffer.writeln('      inValues == null &&');
    buffer.writeln('      notIn == null &&');
    buffer.writeln('      gt == null &&');
    buffer.writeln('      gte == null &&');
    buffer.writeln('      lt == null &&');
    buffer.writeln('      lte == null;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class BoolWhereFilter {');
    buffer.writeln('  final bool? equals;');
    buffer.writeln('  final bool? not;');
    buffer.writeln('  final List<bool>? inValues;');
    buffer.writeln('  final List<bool>? notIn;');
    buffer.writeln();
    buffer.writeln('  const BoolWhereFilter({');
    buffer.writeln('    this.equals,');
    buffer.writeln('    this.not,');
    buffer.writeln('    this.inValues,');
    buffer.writeln('    this.notIn,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln('  factory BoolWhereFilter.fromJsonValue(Object? value) {');
    buffer.writeln('    if (value is bool) {');
    buffer.writeln('      return BoolWhereFilter(equals: value);');
    buffer.writeln('    }');
    buffer.writeln('    if (value is Map<String, Object?>) {');
    buffer.writeln('      return BoolWhereFilter(');
    buffer.writeln("        equals: _readBool(value['equals']),");
    buffer.writeln("        not: _readBool(value['not']),");
    buffer.writeln("        inValues: _readBoolList(value['in']),");
    buffer.writeln("        notIn: _readBoolList(value['notIn']),");
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    return const BoolWhereFilter();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() {');
    buffer.writeln('    if (isEmpty) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln(
      '    if (equals != null && not == null && inValues == null && notIn == null) {',
    );
    buffer.writeln('      return equals;');
    buffer.writeln('    }');
    buffer.writeln('    return <String, Object?>{');
    buffer.writeln("      if (equals != null) 'equals': equals,");
    buffer.writeln("      if (not != null) 'not': not,");
    buffer.writeln("      if (inValues != null) 'in': inValues,");
    buffer.writeln("      if (notIn != null) 'notIn': notIn,");
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty =>');
    buffer.writeln('      equals == null &&');
    buffer.writeln('      not == null &&');
    buffer.writeln('      inValues == null &&');
    buffer.writeln('      notIn == null;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class DateTimeWhereFilter {');
    buffer.writeln('  final DateTime? equals;');
    buffer.writeln('  final DateTime? not;');
    buffer.writeln('  final List<DateTime>? inValues;');
    buffer.writeln('  final List<DateTime>? notIn;');
    buffer.writeln('  final DateTime? gt;');
    buffer.writeln('  final DateTime? gte;');
    buffer.writeln('  final DateTime? lt;');
    buffer.writeln('  final DateTime? lte;');
    buffer.writeln();
    buffer.writeln('  const DateTimeWhereFilter({');
    buffer.writeln('    this.equals,');
    buffer.writeln('    this.not,');
    buffer.writeln('    this.inValues,');
    buffer.writeln('    this.notIn,');
    buffer.writeln('    this.gt,');
    buffer.writeln('    this.gte,');
    buffer.writeln('    this.lt,');
    buffer.writeln('    this.lte,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
      '  factory DateTimeWhereFilter.fromJsonValue(Object? value) {',
    );
    buffer.writeln('    if (value is DateTime) {');
    buffer.writeln('      return DateTimeWhereFilter(equals: value);');
    buffer.writeln('    }');
    buffer.writeln('    if (value is String) {');
    buffer.writeln(
      '      return DateTimeWhereFilter(equals: DateTime.tryParse(value));',
    );
    buffer.writeln('    }');
    buffer.writeln('    if (value is Map<String, Object?>) {');
    buffer.writeln('      return DateTimeWhereFilter(');
    buffer.writeln("        equals: _readDateTime(value['equals']),");
    buffer.writeln("        not: _readDateTime(value['not']),");
    buffer.writeln("        inValues: _readDateTimeList(value['in']),");
    buffer.writeln("        notIn: _readDateTimeList(value['notIn']),");
    buffer.writeln("        gt: _readDateTime(value['gt']),");
    buffer.writeln("        gte: _readDateTime(value['gte']),");
    buffer.writeln("        lt: _readDateTime(value['lt']),");
    buffer.writeln("        lte: _readDateTime(value['lte']),");
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    return const DateTimeWhereFilter();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() {');
    buffer.writeln('    if (isEmpty) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln(
      '    if (equals != null && not == null && inValues == null && notIn == null && gt == null && gte == null && lt == null && lte == null) {',
    );
    buffer.writeln('      return equals!.toIso8601String();');
    buffer.writeln('    }');
    buffer.writeln('    return <String, Object?>{');
    buffer.writeln(
      "      if (equals != null) 'equals': equals!.toIso8601String(),",
    );
    buffer.writeln("      if (not != null) 'not': not!.toIso8601String(),");
    buffer.writeln(
      "      if (inValues != null) 'in': inValues!.map((value) => value.toIso8601String()).toList(growable: false),",
    );
    buffer.writeln(
      "      if (notIn != null) 'notIn': notIn!.map((value) => value.toIso8601String()).toList(growable: false),",
    );
    buffer.writeln("      if (gt != null) 'gt': gt!.toIso8601String(),");
    buffer.writeln("      if (gte != null) 'gte': gte!.toIso8601String(),");
    buffer.writeln("      if (lt != null) 'lt': lt!.toIso8601String(),");
    buffer.writeln("      if (lte != null) 'lte': lte!.toIso8601String(),");
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty =>');
    buffer.writeln('      equals == null &&');
    buffer.writeln('      not == null &&');
    buffer.writeln('      inValues == null &&');
    buffer.writeln('      notIn == null &&');
    buffer.writeln('      gt == null &&');
    buffer.writeln('      gte == null &&');
    buffer.writeln('      lt == null &&');
    buffer.writeln('      lte == null;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class JsonWhereFilter {');
    buffer.writeln('  final Object? equals;');
    buffer.writeln();
    buffer.writeln('  const JsonWhereFilter({this.equals});');
    buffer.writeln();
    buffer.writeln('  factory JsonWhereFilter.fromJsonValue(Object? value) {');
    buffer.writeln(
      '    if (value is Map<String, Object?> && value.length == 1 && value.containsKey(\'equals\')) {',
    );
    buffer.writeln("      return JsonWhereFilter(equals: value['equals']);");
    buffer.writeln('    }');
    buffer.writeln(
      '    if (value is Map<String, Object?> || value is List<Object?> || value is String || value is num || value is bool || value == null) {',
    );
    buffer.writeln('      return JsonWhereFilter(equals: value);');
    buffer.writeln('    }');
    buffer.writeln('    return const JsonWhereFilter();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() {');
    buffer.writeln('    if (isEmpty) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln("    return <String, Object?>{'equals': equals};");
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty => equals == null;');
    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeGeneratedClientClass({
    required StringBuffer buffer,
    required List<_ResolvedModel> models,
  }) {
    buffer.writeln('class GeneratedOrmClient {');
    buffer.writeln('  final OrmDbContext _context;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmClient(this._context);');
    buffer.writeln();
    buffer.writeln(
      '  late final GeneratedOrmDb db = GeneratedOrmDb(_context.db);',
    );

    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class GeneratedOrmDb {');
    buffer.writeln('  final OrmDbNamespace _db;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmDb(this._db);');
    buffer.writeln();
    buffer.writeln(
      '  late final GeneratedOrmCollections orm = GeneratedOrmCollections(_db.orm);',
    );
    buffer.writeln();
    buffer.writeln(
      '  late final GeneratedOrmSql sql = GeneratedOrmSql(_db.sql);',
    );
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class GeneratedOrmCollections {');
    buffer.writeln('  final OrmModelNamespace _orm;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmCollections(this._orm);');
    buffer.writeln();

    for (final model in models) {
      buffer.writeln(
        '  late final ${model.delegateClassName} ${model.propertyName} =',
      );
      buffer.writeln(
        "      ${model.delegateClassName}(_orm.model('${_escapeString(model.model.runtimeName)}'));",
      );
      buffer.writeln();
    }

    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class GeneratedOrmSql {');
    buffer.writeln('  final OrmSqlApi _api;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmSql(this._api);');
    buffer.writeln();
    buffer.writeln('  OrmSqlApi get raw => _api;');
    buffer.writeln();
    for (final model in models) {
      buffer.writeln(
        '  late final ${model.sqlClassName} ${model.propertyName} =',
      );
      buffer.writeln('      ${model.sqlClassName}(_api);');
      buffer.writeln();
    }
    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeQueryDslClasses({
    required StringBuffer buffer,
    required _ResolvedModel model,
    required Map<String, _ResolvedModel> lookup,
  }) {
    final scalarFields = model.model.fields
        .where((field) => field.isScalar)
        .toList(growable: false);
    final relationFields = model.model.fields
        .where((field) => field.isRelation)
        .toList(growable: false);
    buffer.writeln('class ${model.distinctClassName} {');
    buffer.writeln('  final String value;');
    buffer.writeln();
    buffer.writeln('  const ${model.distinctClassName}._(this.value);');
    if (scalarFields.isNotEmpty) {
      for (final field in scalarFields) {
        final memberName = _toLowerCamelIdentifier(
          field.name,
          fallback: 'field',
        );
        buffer.writeln(
          "  static const ${model.distinctClassName} $memberName = ${model.distinctClassName}._('${_escapeString(field.name)}');",
        );
      }
      final fieldEntries = scalarFields
          .map(
            (field) => _toLowerCamelIdentifier(field.name, fallback: 'field'),
          )
          .join(', ');
      buffer.writeln();
      buffer.writeln(
        '  static const List<${model.distinctClassName}> values = <${model.distinctClassName}>[$fieldEntries];',
      );
    } else {
      buffer.writeln();
      buffer.writeln(
        '  static const List<${model.distinctClassName}> values = <${model.distinctClassName}>[];',
      );
    }
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.orderByClassName} {');
    buffer.writeln('  final OrmOrderBy value;');
    buffer.writeln();
    buffer.writeln('  const ${model.orderByClassName}._(this.value);');
    buffer.writeln();
    for (final field in scalarFields) {
      final methodName = _toLowerCamelIdentifier(field.name, fallback: 'field');
      buffer.writeln(
        '  static ${model.orderByClassName} $methodName({SortOrder order = SortOrder.asc}) {',
      );
      buffer.writeln(
        "    return ${model.orderByClassName}._(OrmOrderBy('${_escapeString(field.name)}', order: order));",
      );
      buffer.writeln('  }');
      buffer.writeln();
    }
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.groupByHavingConditionClassName} {');
    buffer.writeln('  final OrmGroupByHavingCondition _value;');
    buffer.writeln();
    buffer.writeln(
      '  const ${model.groupByHavingConditionClassName}._(this._value);',
    );
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} equals(Object? value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(OrmGroupByHavingCondition(equals: value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} notEquals(Object? value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(OrmGroupByHavingCondition(not: value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} not(${model.groupByHavingConditionClassName} condition) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(OrmGroupByHavingCondition(not: condition.toJsonValue()));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} gt(Object? value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(OrmGroupByHavingCondition(gt: value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} gte(Object? value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(OrmGroupByHavingCondition(gte: value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} lt(Object? value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(OrmGroupByHavingCondition(lt: value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} lte(Object? value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(OrmGroupByHavingCondition(lte: value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() => _value.toJsonValue();');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.groupByHavingClassName} {');
    buffer.writeln('  final OrmGroupByHaving _value;');
    buffer.writeln();
    buffer.writeln(
      '  const ${model.groupByHavingClassName}() : _value = const OrmGroupByHaving.empty();',
    );
    buffer.writeln();
    buffer.writeln('  const ${model.groupByHavingClassName}._(this._value);');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} and(List<${model.groupByHavingClassName}> clauses) {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln(
      '      OrmGroupByHaving(<OrmGroupByHavingNode>[',
    );
    buffer.writeln(
      '        OrmGroupByHavingLogicalNode(',
    );
    buffer.writeln(
      '          operator: OrmGroupByHavingLogicalOperator.and,',
    );
    buffer.writeln(
      '          clauses: clauses.map((clause) => clause._value).toList(growable: false),',
    );
    buffer.writeln('        ),');
    buffer.writeln('      ]),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} or(List<${model.groupByHavingClassName}> clauses) {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln(
      '      OrmGroupByHaving(<OrmGroupByHavingNode>[',
    );
    buffer.writeln(
      '        OrmGroupByHavingLogicalNode(',
    );
    buffer.writeln(
      '          operator: OrmGroupByHavingLogicalOperator.or,',
    );
    buffer.writeln(
      '          clauses: clauses.map((clause) => clause._value).toList(growable: false),',
    );
    buffer.writeln('        ),');
    buffer.writeln('      ]),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} not(List<${model.groupByHavingClassName}> clauses) {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln(
      '      OrmGroupByHaving(<OrmGroupByHavingNode>[',
    );
    buffer.writeln(
      '        OrmGroupByHavingLogicalNode(',
    );
    buffer.writeln(
      '          operator: OrmGroupByHavingLogicalOperator.not,',
    );
    buffer.writeln(
      '          clauses: clauses.map((clause) => clause._value).toList(growable: false),',
    );
    buffer.writeln('        ),');
    buffer.writeln('      ]),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} by('
      '${model.distinctClassName} field, '
      '${model.groupByHavingConditionClassName} condition'
      ') {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln(
      '      OrmGroupByHaving(<OrmGroupByHavingNode>[',
    );
    buffer.writeln(
      '        OrmGroupByHavingPredicateNode(field: field.value, condition: condition._value),',
    );
    buffer.writeln('      ]),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} count('
      '${model.distinctClassName} field, '
      '${model.groupByHavingConditionClassName} condition'
      ') {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln(
      '      OrmGroupByHaving(<OrmGroupByHavingNode>[',
    );
    buffer.writeln(
      '        OrmGroupByHavingPredicateNode(field: field.value, condition: condition._value, bucket: OrmGroupByHavingMetricBucket.count),',
    );
    buffer.writeln('      ]),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} countAll('
      '${model.groupByHavingConditionClassName} condition'
      ') {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln(
      '      OrmGroupByHaving(<OrmGroupByHavingNode>[',
    );
    buffer.writeln(
      "        OrmGroupByHavingPredicateNode(field: 'all', condition: condition._value, bucket: OrmGroupByHavingMetricBucket.count),",
    );
    buffer.writeln('      ]),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    for (final bucket in const <String>['min', 'max', 'sum', 'avg']) {
      buffer.writeln(
        '  static ${model.groupByHavingClassName} $bucket('
        '${model.distinctClassName} field, '
        '${model.groupByHavingConditionClassName} condition'
        ') {',
      );
      buffer.writeln('    return ${model.groupByHavingClassName}._(');
      buffer.writeln(
        '      OrmGroupByHaving(<OrmGroupByHavingNode>[',
      );
      buffer.writeln(
        '        OrmGroupByHavingPredicateNode(field: field.value, condition: condition._value, bucket: OrmGroupByHavingMetricBucket.$bucket),',
      );
      buffer.writeln('      ]),');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
    }
    buffer.writeln(
      '  ${model.groupByHavingClassName} merge(${model.groupByHavingClassName} other) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingClassName}._(_value.merge(other._value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  OrmGroupByHaving toRuntimeHaving() {');
    buffer.writeln('    return _value;');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Map<String, Object?> toJson() {');
    buffer.writeln('    return _value.toJson();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty => _value.isEmpty;');
    buffer.writeln('}');
    buffer.writeln();

    final havingBuilderClassName = '${model.groupByHavingClassName}Builder';
    final havingPredicateBuilderClassName =
        '${model.groupByHavingClassName}PredicateBuilder';

    buffer.writeln('class $havingBuilderClassName {');
    buffer.writeln('  const $havingBuilderClassName();');
    buffer.writeln();
    buffer.writeln(
      '  $havingPredicateBuilderClassName by(${model.distinctClassName} field) =>',
    );
    buffer.writeln(
      '      $havingPredicateBuilderClassName._((condition) => ${model.groupByHavingClassName}.by(field, condition));',
    );
    buffer.writeln();
    buffer.writeln(
      '  $havingPredicateBuilderClassName count(${model.distinctClassName} field) =>',
    );
    buffer.writeln(
      '      $havingPredicateBuilderClassName._((condition) => ${model.groupByHavingClassName}.count(field, condition));',
    );
    buffer.writeln();
    buffer.writeln('  $havingPredicateBuilderClassName countAll() =>');
    buffer.writeln(
      '      $havingPredicateBuilderClassName._((condition) => ${model.groupByHavingClassName}.countAll(condition));',
    );
    buffer.writeln();
    for (final bucket in const <String>['min', 'max', 'sum', 'avg']) {
      buffer.writeln(
        '  $havingPredicateBuilderClassName $bucket(${model.distinctClassName} field) =>',
      );
      buffer.writeln(
        '      $havingPredicateBuilderClassName._((condition) => ${model.groupByHavingClassName}.$bucket(field, condition));',
      );
      buffer.writeln();
    }
    buffer.writeln(
      '  ${model.groupByHavingClassName} and(List<${model.groupByHavingClassName}> clauses) =>',
    );
    buffer.writeln('      ${model.groupByHavingClassName}.and(clauses);');
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} or(List<${model.groupByHavingClassName}> clauses) =>',
    );
    buffer.writeln('      ${model.groupByHavingClassName}.or(clauses);');
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} not(List<${model.groupByHavingClassName}> clauses) =>',
    );
    buffer.writeln('      ${model.groupByHavingClassName}.not(clauses);');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class $havingPredicateBuilderClassName {');
    buffer.writeln(
      '  final ${model.groupByHavingClassName} Function(${model.groupByHavingConditionClassName} condition) _build;',
    );
    buffer.writeln();
    buffer.writeln('  $havingPredicateBuilderClassName._(this._build);');
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} equals(Object? value) => _build(${model.groupByHavingConditionClassName}.equals(value));',
    );
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} notEquals(Object? value) => _build(${model.groupByHavingConditionClassName}.notEquals(value));',
    );
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} gt(Object? value) => _build(${model.groupByHavingConditionClassName}.gt(value));',
    );
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} gte(Object? value) => _build(${model.groupByHavingConditionClassName}.gte(value));',
    );
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} lt(Object? value) => _build(${model.groupByHavingConditionClassName}.lt(value));',
    );
    buffer.writeln();
    buffer.writeln(
      '  ${model.groupByHavingClassName} lte(Object? value) => _build(${model.groupByHavingConditionClassName}.lte(value));',
    );
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.aggregateSpecClassName} {');
    buffer.writeln('  final bool countAll;');
    buffer.writeln('  final List<${model.distinctClassName}> count;');
    buffer.writeln('  final List<${model.distinctClassName}> min;');
    buffer.writeln('  final List<${model.distinctClassName}> max;');
    buffer.writeln('  final List<${model.distinctClassName}> sum;');
    buffer.writeln('  final List<${model.distinctClassName}> avg;');
    buffer.writeln();
    buffer.writeln('  const ${model.aggregateSpecClassName}({');
    buffer.writeln('    this.countAll = false,');
    buffer.writeln('    this.count = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.min = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.max = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.sum = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.avg = const <${model.distinctClassName}>[],');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln('  ${model.aggregateSpecClassName} copyWith({');
    buffer.writeln('    bool? countAll,');
    buffer.writeln('    List<${model.distinctClassName}>? count,');
    buffer.writeln('    List<${model.distinctClassName}>? min,');
    buffer.writeln('    List<${model.distinctClassName}>? max,');
    buffer.writeln('    List<${model.distinctClassName}>? sum,');
    buffer.writeln('    List<${model.distinctClassName}>? avg,');
    buffer.writeln('  }) {');
    buffer.writeln('    return ${model.aggregateSpecClassName}(');
    buffer.writeln('      countAll: countAll ?? this.countAll,');
    buffer.writeln('      count: count ?? this.count,');
    buffer.writeln('      min: min ?? this.min,');
    buffer.writeln('      max: max ?? this.max,');
    buffer.writeln('      sum: sum ?? this.sum,');
    buffer.writeln('      avg: avg ?? this.avg,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  OrmAggregateSpec toRuntimeSpec() {');
    buffer.writeln('    return OrmAggregateSpec(');
    buffer.writeln('      countAll: countAll,');
    buffer.writeln(
      '      count: count.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      min: min.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      max: max.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      sum: sum.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      avg: avg.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    final aggregateBuilderClassName = '${model.classBaseName}AggregateBuilder';
    buffer.writeln('class $aggregateBuilderClassName {');
    buffer.writeln('  final ${model.aggregateSpecClassName} _spec;');
    buffer.writeln();
    buffer.writeln('  const $aggregateBuilderClassName._(this._spec);');
    buffer.writeln();
    buffer.writeln(
      '  const $aggregateBuilderClassName() : _spec = const ${model.aggregateSpecClassName}();',
    );
    buffer.writeln();
    buffer.writeln(
      '  $aggregateBuilderClassName countAll() => $aggregateBuilderClassName._(_spec.copyWith(countAll: true));',
    );
    buffer.writeln();
    for (final bucket in const <String>['count', 'min', 'max', 'sum', 'avg']) {
      buffer.writeln(
        '  $aggregateBuilderClassName $bucket(${model.distinctClassName} field) =>',
      );
      buffer.writeln('      $aggregateBuilderClassName._(');
      buffer.writeln('        _spec.copyWith(');
      buffer.writeln('          $bucket: _appendUnique(_spec.$bucket, field),');
      buffer.writeln('        ),');
      buffer.writeln('      );');
      buffer.writeln();
    }
    buffer.writeln(
      '  $aggregateBuilderClassName merge(${model.aggregateSpecClassName} spec) =>',
    );
    buffer.writeln('      $aggregateBuilderClassName._(');
    buffer.writeln('        _spec.copyWith(');
    buffer.writeln('          countAll: _spec.countAll || spec.countAll,');
    for (final bucket in const <String>['count', 'min', 'max', 'sum', 'avg']) {
      buffer.writeln(
        '          $bucket: _appendUniqueMany(_spec.$bucket, spec.$bucket),',
      );
    }
    buffer.writeln('        ),');
    buffer.writeln('      );');
    buffer.writeln();
    buffer.writeln('  ${model.aggregateSpecClassName} toSpec() => _spec;');
    buffer.writeln();
    buffer.writeln(
      '  List<${model.distinctClassName}> _appendUnique(List<${model.distinctClassName}> current, ${model.distinctClassName} field) {',
    );
    buffer.writeln('    if (current.contains(field)) {');
    buffer.writeln('      return current;');
    buffer.writeln('    }');
    buffer.writeln(
      '    return <${model.distinctClassName}>[...current, field];',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  List<${model.distinctClassName}> _appendUniqueMany(List<${model.distinctClassName}> current, List<${model.distinctClassName}> next) {',
    );
    buffer.writeln('    if (next.isEmpty) {');
    buffer.writeln('      return current;');
    buffer.writeln('    }');
    buffer.writeln(
      '    final merged = <${model.distinctClassName}>[...current];',
    );
    buffer.writeln('    for (final field in next) {');
    buffer.writeln('      if (!merged.contains(field)) {');
    buffer.writeln('        merged.add(field);');
    buffer.writeln('      }');
    buffer.writeln('    }');
    buffer.writeln('    return merged;');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.groupBySpecClassName} {');
    buffer.writeln('  final List<${model.distinctClassName}> by;');
    buffer.writeln('  final ${model.groupByHavingClassName} having;');
    buffer.writeln('  final bool countAll;');
    buffer.writeln('  final List<${model.distinctClassName}> count;');
    buffer.writeln('  final List<${model.distinctClassName}> min;');
    buffer.writeln('  final List<${model.distinctClassName}> max;');
    buffer.writeln('  final List<${model.distinctClassName}> sum;');
    buffer.writeln('  final List<${model.distinctClassName}> avg;');
    buffer.writeln();
    buffer.writeln('  const ${model.groupBySpecClassName}({');
    buffer.writeln('    required this.by,');
    buffer.writeln(
      '    this.having = const ${model.groupByHavingClassName}(),',
    );
    buffer.writeln('    this.countAll = false,');
    buffer.writeln('    this.count = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.min = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.max = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.sum = const <${model.distinctClassName}>[],');
    buffer.writeln('    this.avg = const <${model.distinctClassName}>[],');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln('  ${model.groupBySpecClassName} copyWith({');
    buffer.writeln('    List<${model.distinctClassName}>? by,');
    buffer.writeln('    ${model.groupByHavingClassName}? having,');
    buffer.writeln('    bool? countAll,');
    buffer.writeln('    List<${model.distinctClassName}>? count,');
    buffer.writeln('    List<${model.distinctClassName}>? min,');
    buffer.writeln('    List<${model.distinctClassName}>? max,');
    buffer.writeln('    List<${model.distinctClassName}>? sum,');
    buffer.writeln('    List<${model.distinctClassName}>? avg,');
    buffer.writeln('  }) {');
    buffer.writeln('    return ${model.groupBySpecClassName}(');
    buffer.writeln('      by: by ?? this.by,');
    buffer.writeln('      having: having ?? this.having,');
    buffer.writeln('      countAll: countAll ?? this.countAll,');
    buffer.writeln('      count: count ?? this.count,');
    buffer.writeln('      min: min ?? this.min,');
    buffer.writeln('      max: max ?? this.max,');
    buffer.writeln('      sum: sum ?? this.sum,');
    buffer.writeln('      avg: avg ?? this.avg,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  OrmGroupBySpec toRuntimeSpec() {');
    buffer.writeln('    return OrmGroupBySpec(');
    buffer.writeln(
      '      by: by.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln('      having: having.toRuntimeHaving(),');
    buffer.writeln('      countAll: countAll,');
    buffer.writeln(
      '      count: count.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      min: min.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      max: max.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      sum: sum.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '      avg: avg.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.aggregateResultClassName} {');
    buffer.writeln('  final Map<String, Object?> _value;');
    buffer.writeln();
    buffer.writeln('  const ${model.aggregateResultClassName}._(this._value);');
    buffer.writeln();
    buffer.writeln(
      '  factory ${model.aggregateResultClassName}.fromJson(Map<String, Object?> value) {',
    );
    buffer.writeln('    return ${model.aggregateResultClassName}._(');
    buffer.writeln(
      '      Map<String, Object?>.unmodifiable(Map<String, Object?>.from(value)),',
    );
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    _writeAggregateResultGetters(
      buffer: buffer,
      scalarFields: scalarFields,
      sourceAccessor: '_value',
    );
    buffer.writeln('  Map<String, Object?> toJson() {');
    buffer.writeln('    return Map<String, Object?>.from(_value);');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.groupByResultClassName} {');
    buffer.writeln('  final Map<String, Object?> _value;');
    buffer.writeln();
    buffer.writeln('  const ${model.groupByResultClassName}._(this._value);');
    buffer.writeln();
    buffer.writeln(
      '  factory ${model.groupByResultClassName}.fromJson(Map<String, Object?> value) {',
    );
    buffer.writeln('    return ${model.groupByResultClassName}._(');
    buffer.writeln(
      '      Map<String, Object?>.unmodifiable(Map<String, Object?>.from(value)),',
    );
    buffer.writeln('    );');
    buffer.writeln('  }');
    for (final field in scalarFields) {
      final memberName = _toLowerCamelIdentifier(field.name, fallback: 'field');
      final fieldName = _escapeString(field.name);
      final decode = _decodeScalar(field, accessor: "_value['$fieldName']");
      final fieldType = _scalarResultType(field);
      buffer.writeln();
      buffer.writeln('  $fieldType get $memberName => $decode;');
    }
    buffer.writeln();
    _writeAggregateResultGetters(
      buffer: buffer,
      scalarFields: scalarFields,
      sourceAccessor: '_value',
    );
    buffer.writeln('  Map<String, Object?> toJson() {');
    buffer.writeln('    return Map<String, Object?>.from(_value);');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.selectClassName} {');
    for (final field in scalarFields) {
      final memberName = _toLowerCamelIdentifier(field.name, fallback: 'field');
      buffer.writeln('  final bool $memberName;');
    }
    if (scalarFields.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('  const ${model.selectClassName}({');
      for (final field in scalarFields) {
        final memberName = _toLowerCamelIdentifier(
          field.name,
          fallback: 'field',
        );
        buffer.writeln('    this.$memberName = false,');
      }
      buffer.writeln('  });');
    } else {
      buffer.writeln();
      buffer.writeln('  const ${model.selectClassName}();');
    }
    buffer.writeln();
    buffer.writeln(
      '  ${model.selectClassName} merge(${model.selectClassName} other) {',
    );
    if (scalarFields.isEmpty) {
      buffer.writeln('    return this;');
    } else {
      buffer.writeln('    return ${model.selectClassName}(');
      for (final field in scalarFields) {
        final memberName = _toLowerCamelIdentifier(
          field.name,
          fallback: 'field',
        );
        buffer.writeln('      $memberName: $memberName || other.$memberName,');
      }
      buffer.writeln('    );');
    }
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  List<String> toFields() {');
    if (scalarFields.isEmpty) {
      buffer.writeln('    return const <String>[];');
    } else {
      buffer.writeln('    final fields = <String>[];');
      for (final field in scalarFields) {
        final memberName = _toLowerCamelIdentifier(
          field.name,
          fallback: 'field',
        );
        buffer.writeln(
          "    if ($memberName) fields.add('${_escapeString(field.name)}');",
        );
      }
      buffer.writeln('    return List<String>.unmodifiable(fields);');
    }
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    for (final relation in relationFields) {
      final relationModelName = relation.relationModel;
      final relationModel = relationModelName == null
          ? null
          : lookup[relationModelName];
      if (relationModel == null) {
        continue;
      }
      final includeClassName = _relationIncludeClassName(
        owner: model,
        relationFieldName: relation.name,
      );
      buffer.writeln('class $includeClassName {');
      buffer.writeln('  final ${relationModel.whereInputClassName} _where;');
      buffer.writeln('  final int? _skip;');
      buffer.writeln('  final int? _take;');
      buffer.writeln(
        '  final List<${relationModel.orderByClassName}> _orderBy;',
      );
      buffer.writeln('  final ${relationModel.selectClassName}? _select;');
      buffer.writeln('  final ${relationModel.includeClassName}? _include;');
      buffer.writeln();
      buffer.writeln('  const $includeClassName({');
      buffer.writeln(
        '    ${relationModel.whereInputClassName} where = const ${relationModel.whereInputClassName}(),',
      );
      buffer.writeln('    int? skip,');
      buffer.writeln('    int? take,');
      buffer.writeln(
        '    List<${relationModel.orderByClassName}> orderBy = const <${relationModel.orderByClassName}>[],',
      );
      buffer.writeln('    ${relationModel.selectClassName}? select,');
      buffer.writeln('    ${relationModel.includeClassName}? include,');
      buffer.writeln('  }) : _where = where,');
      buffer.writeln('       _skip = skip,');
      buffer.writeln('       _take = take,');
      buffer.writeln('       _orderBy = orderBy,');
      buffer.writeln('       _select = select,');
      buffer.writeln('       _include = include;');
      buffer.writeln();
      buffer.writeln('  $includeClassName merge($includeClassName other) {');
      buffer.writeln('    return $includeClassName(');
      buffer.writeln('      where: _where.andWith(other._where),');
      buffer.writeln('      skip: other._skip ?? _skip,');
      buffer.writeln('      take: other._take ?? _take,');
      buffer.writeln(
        '      orderBy: <${relationModel.orderByClassName}>[..._orderBy, ...other._orderBy],',
      );
      buffer.writeln('      select: _select == null');
      buffer.writeln('          ? other._select');
      buffer.writeln(
        '          : (other._select == null ? _select : _select!.merge(other._select!)),',
      );
      buffer.writeln('      include: _include == null');
      buffer.writeln('          ? other._include');
      buffer.writeln(
        '          : (other._include == null ? _include : _include!.merge(other._include!)),',
      );
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln(
        '  $includeClassName where(${relationModel.whereInputClassName} where, {bool merge = true}) {',
      );
      buffer.writeln('    return $includeClassName(');
      buffer.writeln('      where: merge ? _where.andWith(where) : where,');
      buffer.writeln('      skip: _skip,');
      buffer.writeln('      take: _take,');
      buffer.writeln('      orderBy: _orderBy,');
      buffer.writeln('      select: _select,');
      buffer.writeln('      include: _include,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln('  $includeClassName skip(int? skip) {');
      buffer.writeln('    return $includeClassName(');
      buffer.writeln('      where: _where,');
      buffer.writeln('      skip: skip,');
      buffer.writeln('      take: _take,');
      buffer.writeln('      orderBy: _orderBy,');
      buffer.writeln('      select: _select,');
      buffer.writeln('      include: _include,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln('  $includeClassName take(int? take) {');
      buffer.writeln('    return $includeClassName(');
      buffer.writeln('      where: _where,');
      buffer.writeln('      skip: _skip,');
      buffer.writeln('      take: take,');
      buffer.writeln('      orderBy: _orderBy,');
      buffer.writeln('      select: _select,');
      buffer.writeln('      include: _include,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln(
        '  $includeClassName orderBy(List<${relationModel.orderByClassName}> orderBy, {bool append = true}) {',
      );
      buffer.writeln('    return $includeClassName(');
      buffer.writeln('      where: _where,');
      buffer.writeln('      skip: _skip,');
      buffer.writeln('      take: _take,');
      buffer.writeln('      orderBy: append');
      buffer.writeln(
        '          ? <${relationModel.orderByClassName}>[..._orderBy, ...orderBy]',
      );
      buffer.writeln('          : orderBy,');
      buffer.writeln('      select: _select,');
      buffer.writeln('      include: _include,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln(
        '  $includeClassName select(${relationModel.selectClassName}? select, {bool merge = true}) {',
      );
      buffer.writeln('    return $includeClassName(');
      buffer.writeln('      where: _where,');
      buffer.writeln('      skip: _skip,');
      buffer.writeln('      take: _take,');
      buffer.writeln('      orderBy: _orderBy,');
      buffer.writeln('      select: merge');
      buffer.writeln(
        '          ? (select == null ? _select : (_select?.merge(select) ?? select))',
      );
      buffer.writeln('          : select,');
      buffer.writeln('      include: _include,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln(
        '  $includeClassName include(${relationModel.includeClassName}? include, {bool merge = true}) {',
      );
      buffer.writeln('    return $includeClassName(');
      buffer.writeln('      where: _where,');
      buffer.writeln('      skip: _skip,');
      buffer.writeln('      take: _take,');
      buffer.writeln('      orderBy: _orderBy,');
      buffer.writeln('      select: _select,');
      buffer.writeln('      include: merge');
      buffer.writeln(
        '          ? (include == null ? _include : (_include?.merge(include) ?? include))',
      );
      buffer.writeln('          : include,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln(
        '  $includeClassName includeWith(${relationModel.includeClassName} Function(${relationModel.includeClassName} include) build, {bool merge = true}) {',
      );
      buffer.writeln(
        '    final current = _include ?? const ${relationModel.includeClassName}();',
      );
      buffer.writeln('    final next = build(current);');
      buffer.writeln('    return include(next, merge: merge);');
      buffer.writeln('  }');
      buffer.writeln();
      buffer.writeln('  IncludeSpec toIncludeSpec() {');
      buffer.writeln('    return IncludeSpec(');
      buffer.writeln('      where: _where.toJson(),');
      buffer.writeln('      skip: _skip,');
      buffer.writeln('      take: _take,');
      buffer.writeln(
        '      orderBy: _orderBy.map((entry) => entry.value).toList(growable: false),',
      );
      buffer.writeln('      select: _select?.toFields() ?? const <String>[],');
      buffer.writeln(
        '      include: _include?.toIncludeMap() ?? const <String, IncludeSpec>{},',
      );
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln('}');
      buffer.writeln();
    }

    buffer.writeln('class ${model.includeClassName} {');
    for (final relation in relationFields) {
      final includeClassName = _relationIncludeClassName(
        owner: model,
        relationFieldName: relation.name,
      );
      final memberName = _toLowerCamelIdentifier(
        relation.name,
        fallback: 'relation',
      );
      buffer.writeln('  final $includeClassName? $memberName;');
    }
    if (relationFields.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('  const ${model.includeClassName}({');
      for (final relation in relationFields) {
        final memberName = _toLowerCamelIdentifier(
          relation.name,
          fallback: 'relation',
        );
        buffer.writeln('    this.$memberName,');
      }
      buffer.writeln('  });');
    } else {
      buffer.writeln();
      buffer.writeln('  const ${model.includeClassName}();');
    }
    buffer.writeln();
    buffer.writeln(
      '  ${model.includeClassName} merge(${model.includeClassName} other) {',
    );
    if (relationFields.isEmpty) {
      buffer.writeln('    return this;');
    } else {
      buffer.writeln('    return ${model.includeClassName}(');
      for (final relation in relationFields) {
        final memberName = _toLowerCamelIdentifier(
          relation.name,
          fallback: 'relation',
        );
        buffer.writeln('      $memberName: $memberName == null');
        buffer.writeln('          ? other.$memberName');
        buffer.writeln(
          '          : (other.$memberName == null ? $memberName : $memberName!.merge(other.$memberName!)),',
        );
      }
      buffer.writeln('    );');
    }
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  ${model.includeClassName} includeWith(${model.includeClassName} Function(${model.includeClassName} include) build, {bool merge = true}) {',
    );
    buffer.writeln('    final next = build(this);');
    buffer.writeln('    return merge ? this.merge(next) : next;');
    buffer.writeln('  }');
    buffer.writeln();
    for (final relation in relationFields) {
      final includeClassName = _relationIncludeClassName(
        owner: model,
        relationFieldName: relation.name,
      );
      final memberName = _toLowerCamelIdentifier(
        relation.name,
        fallback: 'relation',
      );
      final methodSuffix = _toUpperCamelIdentifier(
        relation.name,
        fallback: 'Relation',
      );
      buffer.writeln(
        '  ${model.includeClassName} include$methodSuffix([$includeClassName Function($includeClassName current)? configure]) {',
      );
      buffer.writeln(
        '    final current = $memberName ?? const $includeClassName();',
      );
      buffer.writeln(
        '    final next = configure == null ? current : configure(current);',
      );
      buffer.writeln(
        '    return merge(${model.includeClassName}($memberName: next));',
      );
      buffer.writeln('  }');
      buffer.writeln();
    }
    buffer.writeln('  Map<String, IncludeSpec> toIncludeMap() {');
    if (relationFields.isEmpty) {
      buffer.writeln('    return const <String, IncludeSpec>{};');
    } else {
      buffer.writeln('    final include = <String, IncludeSpec>{};');
      for (final relation in relationFields) {
        final memberName = _toLowerCamelIdentifier(
          relation.name,
          fallback: 'relation',
        );
        buffer.writeln(
          "    if ($memberName != null) include['${_escapeString(relation.name)}'] = $memberName!.toIncludeSpec();",
        );
      }
      buffer.writeln('    return include;');
    }
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.nestedCreateInputClassName} {');
    for (final relation in relationFields) {
      final relationModel = lookup[relation.relationModel];
      if (relationModel == null) {
        continue;
      }
      final memberName = _toLowerCamelIdentifier(
        relation.name,
        fallback: 'relation',
      );
      buffer.writeln(
        '  final List<${relationModel.createInputClassName}>? $memberName;',
      );
    }
    if (relationFields.any(
      (relation) => lookup[relation.relationModel] != null,
    )) {
      buffer.writeln();
      buffer.writeln('  const ${model.nestedCreateInputClassName}({');
      for (final relation in relationFields) {
        final relationModel = lookup[relation.relationModel];
        if (relationModel == null) {
          continue;
        }
        final memberName = _toLowerCamelIdentifier(
          relation.name,
          fallback: 'relation',
        );
        buffer.writeln('    this.$memberName,');
      }
      buffer.writeln('  });');
    } else {
      buffer.writeln();
      buffer.writeln('  const ${model.nestedCreateInputClassName}();');
    }
    buffer.writeln();
    buffer.writeln('  Map<String, List<JsonMap>> toJson() {');
    if (!relationFields.any(
      (relation) => lookup[relation.relationModel] != null,
    )) {
      buffer.writeln('    return const <String, List<JsonMap>>{};');
    } else {
      buffer.writeln('    final create = <String, List<JsonMap>>{};');
      for (final relation in relationFields) {
        final relationModel = lookup[relation.relationModel];
        if (relationModel == null) {
          continue;
        }
        final memberName = _toLowerCamelIdentifier(
          relation.name,
          fallback: 'relation',
        );
        buffer.writeln(
          "    if ($memberName != null) create['${_escapeString(relation.name)}'] = $memberName!.map((entry) => entry.toJson()).toList(growable: false);",
        );
      }
      buffer.writeln('    return create;');
    }
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeAggregateResultGetters({
    required StringBuffer buffer,
    required List<TypedField> scalarFields,
    required String sourceAccessor,
  }) {
    for (final bucket in const <String>['count', 'min', 'max', 'sum', 'avg']) {
      if (bucket == 'count') {
        buffer.writeln(
          "  int? get countAll => _readInt(_readJsonMap($sourceAccessor['count'])?['all']);",
        );
        buffer.writeln();
      }
      for (final scalarField in scalarFields) {
        if (!_supportsAggregateBucketField(field: scalarField, bucket: bucket)) {
          continue;
        }
        final getterName = _aggregateBucketGetterName(
          bucket: bucket,
          field: scalarField.name,
        );
        final fieldName = _escapeString(scalarField.name);
        final accessor =
            "_readJsonMap($sourceAccessor['$bucket'])?['$fieldName']";
        final decode = _aggregateBucketDecodeExpression(
          field: scalarField,
          bucket: bucket,
          accessor: accessor,
        );
        final fieldType = _aggregateBucketFieldType(
          field: scalarField,
          bucket: bucket,
        );
        buffer.writeln('  $fieldType get $getterName => $decode;');
        buffer.writeln();
      }
    }
  }

  String _aggregateBucketGetterName({
    required String bucket,
    required String field,
  }) {
    final bucketPart = _toLowerCamelIdentifier(bucket, fallback: 'bucket');
    final fieldPart = _toUpperCamelIdentifier(field, fallback: 'Field');
    return '$bucketPart$fieldPart';
  }

  bool _supportsAggregateBucketField({
    required TypedField field,
    required String bucket,
  }) {
    if (!field.isScalar) {
      return false;
    }
    if (bucket == 'sum' || bucket == 'avg') {
      if (field.isList) {
        return false;
      }
      return field.scalarType == TypedScalarType.integer ||
          field.scalarType == TypedScalarType.floating;
    }
    return true;
  }

  String _aggregateBucketFieldType({
    required TypedField field,
    required String bucket,
  }) {
    return switch (bucket) {
      'count' => 'int?',
      'sum' => field.scalarType == TypedScalarType.integer ? 'int?' : 'double?',
      'avg' => 'double?',
      'min' || 'max' => _scalarResultType(field),
      _ => 'Object?',
    };
  }

  String _aggregateBucketDecodeExpression({
    required TypedField field,
    required String bucket,
    required String accessor,
  }) {
    return switch (bucket) {
      'count' => '_readInt($accessor)',
      'sum' =>
        field.scalarType == TypedScalarType.integer
            ? '_readInt($accessor)'
            : '_readDouble($accessor)',
      'avg' => '_readDouble($accessor)',
      'min' || 'max' => _decodeScalar(field, accessor: accessor),
      _ => '_readJsonValue($accessor)',
    };
  }

  String _scalarResultType(TypedField field) {
    final scalarType = field.scalarType;
    if (scalarType == null) {
      return 'Object?';
    }
    if (field.isList) {
      if (scalarType == TypedScalarType.json) {
        return 'List<Object?>?';
      }
      return 'List<${scalarType.dartType}>?';
    }
    return '${scalarType.dartType}?';
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

    buffer.writeln('  ${model.queryClassName} query({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: this,');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} where(${model.whereInputClassName} where, {bool merge = true}) => query().where(where, merge: merge);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} whereWith(${model.whereInputClassName} Function(${model.whereInputClassName} where) build, {bool merge = true}) => query().whereWith(build, merge: merge);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} orderBy(List<${model.orderByClassName}> orderBy) => query().orderBy(orderBy);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} distinct(List<${model.distinctClassName}> distinct, {bool append = false}) => query().distinct(distinct, append: append);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} skip(int? skip) => query().skip(skip);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} take(int? take) => query().take(take);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} cursor(${model.cursorInputClassName} cursor) => query().cursor(cursor);',
    );
    buffer.writeln();

    buffer.writeln('  ${model.queryClassName} page({');
    buffer.writeln('    required int size,');
    buffer.writeln('    ${model.cursorInputClassName}? after,');
    buffer.writeln('    ${model.cursorInputClassName}? before,');
    buffer.writeln(
      '  }) => query().page(size: size, after: after, before: before);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} select(${model.selectClassName}? select, {bool merge = false}) => query().select(select, merge: merge);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} selectWith(${model.selectClassName} Function(${model.selectClassName} select) build, {bool merge = false}) => query().selectWith(build, merge: merge);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} include(${model.includeClassName}? include, {bool merge = true}) => query().include(include, merge: merge);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} includeWith(${model.includeClassName} Function(${model.includeClassName} include) build, {bool merge = true}) => query().includeWith(build, merge: merge);',
    );
    buffer.writeln();

    buffer.writeln('  Future<OrmPlan> toPlan({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).toPlan();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> all({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).all();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> oneOrNull({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where.toWhereInput(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).oneOrNull();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> firstOrNull({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).firstOrNull();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> create({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).create(data: data);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> createNested({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln(
      '    ${model.nestedCreateInputClassName} create = const ${model.nestedCreateInputClassName}(),',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).createNested(data: data, create: create);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> createMany({');
    buffer.writeln('    required List<${model.createInputClassName}> data,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).createMany(data: data);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> update({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where.toWhereInput(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).update(data: data);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> updateNested({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln(
      '    ${model.nestedCreateInputClassName} create = const ${model.nestedCreateInputClassName}(),',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).updateNested(data: data, create: create);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> delete({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where.toWhereInput(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).delete();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> upsert({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.createInputClassName} create,');
    buffer.writeln('    required ${model.updateInputClassName} update,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where.toWhereInput(),');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).upsert(create: create, update: update);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> updateCount({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(where: where).updateCount(data: data);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> updateAll({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).updateAll(data: data);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> deleteCount({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(where: where).deleteCount();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> deleteAll({');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).deleteAll();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> count({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return query(where: where).count();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<bool> exists({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return query(where: where).exists();');
    buffer.writeln('  }');
    buffer.writeln();

    final aggregateBuilderClassName = '${model.classBaseName}AggregateBuilder';
    buffer.writeln('  Future<${model.aggregateResultClassName}> aggregate({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln(
      '    required $aggregateBuilderClassName Function($aggregateBuilderClassName aggregate) build,',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return query(where: where).aggregate(build);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<${model.aggregateResultClassName}> aggregateWith({',
    );
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    required ${model.aggregateSpecClassName} aggregate,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(where: where).aggregateWith(aggregate);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  ${model.groupedQueryClassName} groupedBy(');
    buffer.writeln('    List<${model.distinctClassName}> by, {');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return query(where: where).groupedBy(by);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Stream<${model.dataClassName}> stream({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) {');
    buffer.writeln('    return query(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    ).stream();');
    buffer.writeln('  }');

    buffer.writeln('}');
    buffer.writeln();
    _writeTypedQueryClass(buffer: buffer, model: model);
    _writeTypedGroupedQueryClass(buffer: buffer, model: model);
  }

  void _writeTypedSqlClass({
    required StringBuffer buffer,
    required _ResolvedModel model,
  }) {
    final runtimeName = _escapeString(model.model.runtimeName);
    buffer.writeln('class ${model.sqlClassName} {');
    buffer.writeln('  final OrmSqlApi _sql;');
    buffer.writeln();
    buffer.writeln('  const ${model.sqlClassName}(this._sql);');
    buffer.writeln();

    buffer.writeln(
      '  List<String> _fields(${model.selectClassName}? select) {',
    );
    buffer.writeln('    return select?.toFields() ?? const <String>[];');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.dataClassName} _decodeRow(JsonMap row) => ${model.dataClassName}.fromJson(row);',
    );
    buffer.writeln();

    buffer.writeln(
      '  ${model.dataClassName}? _decodeOptionalRow(JsonMap? row) {',
    );
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return _decodeRow(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  List<${model.dataClassName}> _decodeRows(List<JsonMap> rows) {',
    );
    buffer.writeln('    return rows.map(_decodeRow).toList(growable: false);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmSqlSelectBuilder _selectBuilder({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('  }) {');
    buffer.writeln(
      '    final runtimeOrderBy = orderBy.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln(
      '    final runtimeDistinct = distinct.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln('    final runtimeSelect = _fields(select);');
    buffer.writeln("    return _sql.from('$runtimeName')");
    buffer.writeln('        .where(where.toJson())');
    buffer.writeln('        .skip(skip)');
    buffer.writeln('        .take(take)');
    buffer.writeln('        .orderBy(runtimeOrderBy)');
    buffer.writeln('        .distinct(runtimeDistinct)');
    buffer.writeln('        .select(runtimeSelect);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmPlan toPlan({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('  }) {');
    buffer.writeln('    return _selectBuilder(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('    ).toPlan();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> all({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('  }) async {');
    buffer.writeln('    final rows = await _selectBuilder(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('    ).all();');
    buffer.writeln('    return _decodeRows(rows);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Stream<${model.dataClassName}> stream({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('  }) async* {');
    buffer.writeln('    await for (final row in _selectBuilder(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('    ).stream()) {');
    buffer.writeln('      yield _decodeRow(row);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> firstOrNull({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('  }) async {');
    buffer.writeln('    final row = await _selectBuilder(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('    ).firstOrNull();');
    buffer.writeln('    return _decodeOptionalRow(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmSqlInsertBuilder insertPlan({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln('    final runtimeReturning = _fields(returning);');
    buffer.writeln(
      "    return _sql.insertInto('$runtimeName').values(data.toJson()).returning(runtimeReturning);",
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> insert({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    return _decodeOptionalRow(await insertPlan(data: data, returning: returning).one());',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmSqlUpdateBuilder updatePlan({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln('    final runtimeReturning = _fields(returning);');
    buffer.writeln(
      "    return _sql.update('$runtimeName').where(where.toJson()).set(data.toJson()).returning(runtimeReturning);",
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> update({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    return _decodeOptionalRow(await updatePlan(where: where, data: data, returning: returning).one());',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmSqlDeleteBuilder deletePlan({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln('    final runtimeReturning = _fields(returning);');
    buffer.writeln(
      "    return _sql.deleteFrom('$runtimeName').where(where.toJson()).returning(runtimeReturning);",
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> delete({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    return _decodeOptionalRow(await deletePlan(where: where, returning: returning).one());',
    );
    buffer.writeln('  }');

    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeTypedQueryClass({
    required StringBuffer buffer,
    required _ResolvedModel model,
  }) {
    final runtimeName = _escapeString(model.model.runtimeName);
    final aggregateBuilderClassName = '${model.classBaseName}AggregateBuilder';
    final relationFields = model.model.fields
        .where((field) => field.isRelation)
        .toList(growable: false);
    buffer.writeln('class ${model.queryClassName} {');
    buffer.writeln('  final ${model.delegateClassName} _delegate;');
    buffer.writeln('  final ${model.whereInputClassName} _where;');
    buffer.writeln('  final int? _skip;');
    buffer.writeln('  final int? _take;');
    buffer.writeln('  final List<${model.orderByClassName}> _orderBy;');
    buffer.writeln('  final List<${model.distinctClassName}> _distinct;');
    buffer.writeln('  final ${model.selectClassName}? _select;');
    buffer.writeln('  final ${model.includeClassName}? _include;');
    buffer.writeln('  final ${model.cursorInputClassName}? _cursor;');
    buffer.writeln('  final int? _pageSize;');
    buffer.writeln('  final ${model.cursorInputClassName}? _pageAfter;');
    buffer.writeln('  final ${model.cursorInputClassName}? _pageBefore;');
    buffer.writeln();
    buffer.writeln('  ${model.queryClassName}._({');
    buffer.writeln('    required ${model.delegateClassName} delegate,');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    required int? skip,');
    buffer.writeln('    required int? take,');
    buffer.writeln('    required List<${model.orderByClassName}> orderBy,');
    buffer.writeln('    required List<${model.distinctClassName}> distinct,');
    buffer.writeln('    required ${model.selectClassName}? select,');
    buffer.writeln('    required ${model.includeClassName}? include,');
    buffer.writeln('    ${model.cursorInputClassName}? cursor,');
    buffer.writeln('    int? pageSize,');
    buffer.writeln('    ${model.cursorInputClassName}? pageAfter,');
    buffer.writeln('    ${model.cursorInputClassName}? pageBefore,');
    buffer.writeln('  }) : _delegate = delegate,');
    buffer.writeln('       _where = where,');
    buffer.writeln('       _skip = skip,');
    buffer.writeln('       _take = take,');
    buffer.writeln(
      '       _orderBy = List<${model.orderByClassName}>.unmodifiable(orderBy),',
    );
    buffer.writeln(
      '       _distinct = List<${model.distinctClassName}>.unmodifiable(distinct),',
    );
    buffer.writeln('       _select = select,');
    buffer.writeln('       _include = include,');
    buffer.writeln('       _cursor = cursor,');
    buffer.writeln('       _pageSize = pageSize,');
    buffer.writeln('       _pageAfter = pageAfter,');
    buffer.writeln('       _pageBefore = pageBefore;');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} where(${model.whereInputClassName} where, {bool merge = true}) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: merge ? _where.andWith(where) : where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: _pageSize,');
    buffer.writeln('      pageAfter: _pageAfter,');
    buffer.writeln('      pageBefore: _pageBefore,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} whereWith(${model.whereInputClassName} Function(${model.whereInputClassName} where) build, {bool merge = true}) {',
    );
    buffer.writeln('    final next = build(_where);');
    buffer.writeln('    return where(next, merge: merge);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  ${model.queryClassName} skip(int? skip) {');
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: _pageSize,');
    buffer.writeln('      pageAfter: _pageAfter,');
    buffer.writeln('      pageBefore: _pageBefore,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  ${model.queryClassName} take(int? take) {');
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: null,');
    buffer.writeln('      pageAfter: null,');
    buffer.writeln('      pageBefore: null,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  ${model.queryClassName} unbounded() {');
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: null,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: null,');
    buffer.writeln('      pageAfter: null,');
    buffer.writeln('      pageBefore: null,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} cursor(${model.cursorInputClassName} cursor) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: cursor,');
    buffer.writeln('      pageSize: null,');
    buffer.writeln('      pageAfter: null,');
    buffer.writeln('      pageBefore: null,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  ${model.queryClassName} page({');
    buffer.writeln('    required int size,');
    buffer.writeln('    ${model.cursorInputClassName}? after,');
    buffer.writeln('    ${model.cursorInputClassName}? before,');
    buffer.writeln('  }) {');
    buffer.writeln('    if (size <= 0) {');
    buffer.writeln('      throw PlanCursorWindowInvalidException(');
    buffer.writeln("        reason: 'pageSizeInvalid',");
    buffer.writeln(
      "        details: <String, Object?>{'model': '$runtimeName', 'size': size},",
    );
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    if (after != null && before != null) {');
    buffer.writeln('      throw PlanCursorWindowInvalidException(');
    buffer.writeln("        reason: 'pageDirectionAmbiguous',");
    buffer.writeln(
      "        details: <String, Object?>{'model': '$runtimeName'},",
    );
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: null,');
    buffer.writeln('      take: null,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: null,');
    buffer.writeln('      pageSize: size,');
    buffer.writeln('      pageAfter: after,');
    buffer.writeln('      pageBefore: before,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} orderBy(List<${model.orderByClassName}> orderBy) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: _pageSize,');
    buffer.writeln('      pageAfter: _pageAfter,');
    buffer.writeln('      pageBefore: _pageBefore,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} distinct(List<${model.distinctClassName}> distinct, {bool append = false}) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: append');
    buffer.writeln(
      '          ? <${model.distinctClassName}>[..._distinct, ...distinct]',
    );
    buffer.writeln('          : distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: _pageSize,');
    buffer.writeln('      pageAfter: _pageAfter,');
    buffer.writeln('      pageBefore: _pageBefore,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} select(${model.selectClassName}? select, {bool merge = false}) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: merge');
    buffer.writeln(
      '          ? (select == null ? _select : (_select?.merge(select) ?? select))',
    );
    buffer.writeln('          : select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: _pageSize,');
    buffer.writeln('      pageAfter: _pageAfter,');
    buffer.writeln('      pageBefore: _pageBefore,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} selectWith(${model.selectClassName} Function(${model.selectClassName} select) build, {bool merge = false}) {',
    );
    buffer.writeln(
      '    final current = _select ?? const ${model.selectClassName}();',
    );
    buffer.writeln('    final next = build(current);');
    buffer.writeln('    return select(next, merge: merge);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} include(${model.includeClassName}? include, {bool merge = true}) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: merge');
    buffer.writeln(
      '          ? (include == null ? _include : (_include?.merge(include) ?? include))',
    );
    buffer.writeln('          : include,');
    buffer.writeln('      cursor: _cursor,');
    buffer.writeln('      pageSize: _pageSize,');
    buffer.writeln('      pageAfter: _pageAfter,');
    buffer.writeln('      pageBefore: _pageBefore,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  ${model.queryClassName} includeWith(${model.includeClassName} Function(${model.includeClassName} include) build, {bool merge = true}) {',
    );
    buffer.writeln(
      '    final current = _include ?? const ${model.includeClassName}();',
    );
    buffer.writeln('    final next = build(current);');
    buffer.writeln('    return include(next, merge: merge);');
    buffer.writeln('  }');
    buffer.writeln();
    for (final relation in relationFields) {
      final includeClassName = _relationIncludeClassName(
        owner: model,
        relationFieldName: relation.name,
      );
      final memberName = _toLowerCamelIdentifier(
        relation.name,
        fallback: 'relation',
      );
      final methodSuffix = _toUpperCamelIdentifier(
        relation.name,
        fallback: 'Relation',
      );
      buffer.writeln(
        '  ${model.queryClassName} include$methodSuffix([$includeClassName Function($includeClassName current)? configure]) {',
      );
      buffer.writeln(
        '    final current = _include?.$memberName ?? const $includeClassName();',
      );
      buffer.writeln(
        '    final next = configure == null ? current : configure(current);',
      );
      buffer.writeln(
        '    return include(${model.includeClassName}($memberName: next));',
      );
      buffer.writeln('  }');
      buffer.writeln();
    }

    buffer.writeln(
      '  List<OrmOrderBy> get _runtimeOrderBy => _orderBy.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln();
    buffer.writeln(
      '  List<String> get _runtimeDistinct => _distinct.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln();
    buffer.writeln(
      '  List<String> get _runtimeSelect => _select?.toFields() ?? const <String>[];',
    );
    buffer.writeln();
    buffer.writeln(
      '  Map<String, IncludeSpec> get _runtimeInclude => _include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln();
    buffer.writeln('  JsonMap? get _runtimeCursor => _cursor?.toJson();');
    buffer.writeln();
    buffer.writeln('  OrmReadPagePlan? get _runtimePage {');
    buffer.writeln('    final size = _pageSize;');
    buffer.writeln('    if (size == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return OrmReadPagePlan(');
    buffer.writeln('      size: size,');
    buffer.writeln('      after: _pageAfter?.toJson(),');
    buffer.writeln('      before: _pageBefore?.toJson(),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  OrmReadQuerySpec _readSpec() {');
    buffer.writeln('    return OrmReadQuerySpec(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _runtimeOrderBy,');
    buffer.writeln('      distinct: _runtimeDistinct,');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('      cursor: _runtimeCursor,');
    buffer.writeln('      page: _runtimePage,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Future<OrmPreparedReadQuery> _prepareRead() {');
    buffer.writeln(
      '    return _delegate._delegate.prepareRead(spec: _readSpec());',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  void _assertReadExecutionSupported(String terminal) {');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  void _assertAggregateQueryState() {');
    buffer.writeln('    final invalidKeys = <String>[');
    buffer.writeln("      if (_skip != null) 'skip',");
    buffer.writeln("      if (_take != null) 'take',");
    buffer.writeln("      if (_distinct.isNotEmpty) 'distinct',");
    buffer.writeln("      if (_select != null) 'select',");
    buffer.writeln("      if (_include != null) 'include',");
    buffer.writeln('    ];');
    buffer.writeln('    if (invalidKeys.isEmpty) {');
    buffer.writeln('      return;');
    buffer.writeln('    }');
    buffer.writeln();
    buffer.writeln('    throw runtimeError(');
    buffer.writeln("      'PLAN.AGGREGATE_QUERY_STATE_INVALID',");
    buffer.writeln(
      "      'aggregate() does not allow query state keys: \${invalidKeys.join(', ')}.',",
    );
    buffer.writeln('      details: <String, Object?>{');
    buffer.writeln("        'model': '$runtimeName',");
    buffer.writeln("        'invalidKeys': invalidKeys,");
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  void _assertGroupedQueryBaseState() {');
    buffer.writeln('    final invalidKeys = <String>[');
    buffer.writeln("      if (_skip != null) 'skip',");
    buffer.writeln("      if (_take != null) 'take',");
    buffer.writeln("      if (_orderBy.isNotEmpty) 'orderBy',");
    buffer.writeln("      if (_distinct.isNotEmpty) 'distinct',");
    buffer.writeln("      if (_select != null) 'select',");
    buffer.writeln("      if (_include != null) 'include',");
    buffer.writeln("      if (_cursor != null) 'cursor',");
    buffer.writeln("      if (_pageSize != null) 'page',");
    buffer.writeln('    ];');
    buffer.writeln('    if (invalidKeys.isEmpty) {');
    buffer.writeln('      return;');
    buffer.writeln('    }');
    buffer.writeln();
    buffer.writeln('    throw runtimeError(');
    buffer.writeln("      'PLAN.GROUP_BY_QUERY_STATE_INVALID',");
    buffer.writeln(
      "      'groupedBy() does not allow query state keys: \${invalidKeys.join(', ')}.',",
    );
    buffer.writeln('      details: <String, Object?>{');
    buffer.writeln("        'model': '$runtimeName',");
    buffer.writeln("        'invalidKeys': invalidKeys,");
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  void _assertMutationQueryState({');
    buffer.writeln('    required String action,');
    buffer.writeln('    bool allowWhere = true,');
    buffer.writeln('    bool requireWhere = false,');
    buffer.writeln('    bool allowSelect = true,');
    buffer.writeln('    bool allowInclude = true,');
    buffer.writeln('  }) {');
    buffer.writeln('    final invalidKeys = <String>[');
    buffer.writeln("      if (!allowWhere && !_where.isEmpty) 'where',");
    buffer.writeln("      if (_skip != null) 'skip',");
    buffer.writeln("      if (_take != null) 'take',");
    buffer.writeln("      if (_orderBy.isNotEmpty) 'orderBy',");
    buffer.writeln("      if (_distinct.isNotEmpty) 'distinct',");
    buffer.writeln("      if (!allowSelect && _select != null) 'select',");
    buffer.writeln("      if (!allowInclude && _include != null) 'include',");
    buffer.writeln("      if (_cursor != null) 'cursor',");
    buffer.writeln("      if (_pageSize != null) 'page',");
    buffer.writeln('    ];');
    buffer.writeln('    if (invalidKeys.isNotEmpty) {');
    buffer.writeln('      throw runtimeError(');
    buffer.writeln("        'PLAN.MUTATION_QUERY_STATE_INVALID',");
    buffer.writeln(
      "        '\$action does not allow query state keys: \${invalidKeys.join(', ')}.',",
    );
    buffer.writeln('        details: <String, Object?>{');
    buffer.writeln("          'model': '$runtimeName',");
    buffer.writeln("          'action': action,");
    buffer.writeln("          'invalidKeys': invalidKeys,");
    buffer.writeln('        },');
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln('    if (!requireWhere || !_where.isEmpty) {');
    buffer.writeln('      return;');
    buffer.writeln('    }');
    buffer.writeln();
    buffer.writeln('    throw runtimeError(');
    buffer.writeln("      'PLAN.MUTATION_WHERE_REQUIRED',");
    buffer.writeln("      '\$action requires where() first.',");
    buffer.writeln('      details: <String, Object?>{');
    buffer.writeln("        'model': '$runtimeName',");
    buffer.writeln("        'action': action,");
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<OrmPlan> toPlan() async {');
    buffer.writeln('    return (await _prepareRead()).plan;');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<JsonMap> inspectPlan() async {');
    buffer.writeln('    return (await _prepareRead()).inspectPlan();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> all() async {');
    buffer.writeln("    _assertReadExecutionSupported('all');");
    buffer.writeln('    final rows = await (await _prepareRead()).all();');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<OrmPageResult<${model.dataClassName}>> pageResult() async {',
    );
    buffer.writeln("    _assertReadExecutionSupported('pageResult');");
    buffer.writeln(
      '    final result = await (await _prepareRead()).pageResult();',
    );
    buffer.writeln(
      '    return result.mapItems(${model.dataClassName}.fromJson);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> oneOrNull() async {');
    buffer.writeln("    _assertReadExecutionSupported('oneOrNull');");
    buffer.writeln('    final row = await (await _prepareRead()).oneOrNull();');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> firstOrNull() async {');
    buffer.writeln("    _assertReadExecutionSupported('firstOrNull');");
    buffer.writeln(
      '    final row = await (await _prepareRead()).firstOrNull();',
    );
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Stream<${model.dataClassName}> stream() async* {');
    buffer.writeln("    _assertReadExecutionSupported('stream');");
    buffer.writeln('    final prepared = await _prepareRead();');
    buffer.writeln('    await for (final row in prepared.stream()) {');
    buffer.writeln('      yield ${model.dataClassName}.fromJson(row);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<JsonMap> explain() async {');
    buffer.writeln('    return (await _prepareRead()).explain();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<${model.aggregateResultClassName}> aggregate($aggregateBuilderClassName Function($aggregateBuilderClassName aggregate) build) {',
    );
    buffer.writeln("    _assertReadExecutionSupported('aggregate');");
    buffer.writeln(
      '    return aggregateWith(build($aggregateBuilderClassName()).toSpec());',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<${model.aggregateResultClassName}> aggregateWith(${model.aggregateSpecClassName} aggregate) {',
    );
    buffer.writeln("    _assertReadExecutionSupported('aggregate');");
    buffer.writeln('    _assertAggregateQueryState();');
    buffer.writeln('    return _delegate._delegate.aggregateWith(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      orderBy: _runtimeOrderBy,');
    buffer.writeln('      cursor: _runtimeCursor,');
    buffer.writeln('      page: _runtimePage,');
    buffer.writeln('      aggregate: aggregate.toRuntimeSpec(),');
    buffer.writeln('    ).then(${model.aggregateResultClassName}.fromJson);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.groupedQueryClassName} groupedBy(List<${model.distinctClassName}> by) {',
    );
    buffer.writeln('    _assertGroupedQueryBaseState();');
    buffer.writeln('    return ${model.groupedQueryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      groupBy: ${model.groupBySpecClassName}(by: by),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> create({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      "    _assertMutationQueryState(action: 'create', allowWhere: false);",
    );
    buffer.writeln('    final row = await _delegate._delegate.create(');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> createNested({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln(
      '    ${model.nestedCreateInputClassName} create = const ${model.nestedCreateInputClassName}(),',
    );
    buffer.writeln('  }) async {');
    buffer.writeln(
      "    _assertMutationQueryState(action: 'createNested', allowWhere: false);",
    );
    buffer.writeln('    final row = await _delegate._delegate.createNested(');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      create: create.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<List<${model.dataClassName}>> createMany({required List<${model.createInputClassName}> data}) async {',
    );
    buffer.writeln(
      "    _assertMutationQueryState(action: 'createMany', allowWhere: false);",
    );
    buffer.writeln('    final rows = await _delegate._delegate.createMany(');
    buffer.writeln(
      '      data: data.map((entry) => entry.toJson()).toList(growable: false),',
    );
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> updateNested({');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln(
      '    ${model.nestedCreateInputClassName} create = const ${model.nestedCreateInputClassName}(),',
    );
    buffer.writeln('  }) async {');
    buffer.writeln("    _assertMutationQueryState(action: 'updateNested');");
    buffer.writeln('    final row = await _delegate._delegate.updateNested(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      create: create.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> update({');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('  }) async {');
    buffer.writeln("    _assertMutationQueryState(action: 'update');");
    buffer.writeln('    final row = await _delegate._delegate.update(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<List<${model.dataClassName}>> updateAll({required ${model.updateInputClassName} data}) async {',
    );
    buffer.writeln(
      "    _assertMutationQueryState(action: 'updateAll', requireWhere: true);",
    );
    buffer.writeln('    final rows = await _delegate._delegate.updateAll(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<int> updateCount({required ${model.updateInputClassName} data}) {',
    );
    buffer.writeln(
      "    _assertMutationQueryState(action: 'updateCount', requireWhere: true, allowSelect: false, allowInclude: false);",
    );
    buffer.writeln('    return _delegate._delegate.updateCount(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> deleteCount() {');
    buffer.writeln(
      "    _assertMutationQueryState(action: 'deleteCount', requireWhere: true, allowSelect: false, allowInclude: false);",
    );
    buffer.writeln('    return _delegate._delegate.deleteCount(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> deleteAll() async {');
    buffer.writeln(
      "    _assertMutationQueryState(action: 'deleteAll', requireWhere: true);",
    );
    buffer.writeln('    final rows = await _delegate._delegate.deleteAll(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> delete() async {');
    buffer.writeln("    _assertMutationQueryState(action: 'delete');");
    buffer.writeln('    final row = await _delegate._delegate.delete(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> upsert({');
    buffer.writeln('    required ${model.createInputClassName} create,');
    buffer.writeln('    required ${model.updateInputClassName} update,');
    buffer.writeln('  }) async {');
    buffer.writeln("    _assertMutationQueryState(action: 'upsert');");
    buffer.writeln('    final row = await _delegate._delegate.upsert(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      create: create.toJson(),');
    buffer.writeln('      update: update.toJson(),');
    buffer.writeln('      select: _runtimeSelect,');
    buffer.writeln('      include: _runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> count() {');
    buffer.writeln("    _assertReadExecutionSupported('count');");
    buffer.writeln('    return _delegate._delegate.count(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      orderBy: _runtimeOrderBy,');
    buffer.writeln('      cursor: _runtimeCursor,');
    buffer.writeln('      page: _runtimePage,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<bool> exists() {');
    buffer.writeln("    _assertReadExecutionSupported('exists');");
    buffer.writeln('    return _delegate._delegate.exists(');
    buffer.writeln('      where: _where.toJson(),');
    buffer.writeln('      orderBy: _runtimeOrderBy,');
    buffer.writeln('      cursor: _runtimeCursor,');
    buffer.writeln('      page: _runtimePage,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeTypedGroupedQueryClass({
    required StringBuffer buffer,
    required _ResolvedModel model,
  }) {
    final aggregateBuilderClassName = '${model.classBaseName}AggregateBuilder';
    buffer.writeln('class ${model.groupedQueryClassName} {');
    buffer.writeln('  final ${model.delegateClassName} _delegate;');
    buffer.writeln('  final ${model.whereInputClassName} _where;');
    buffer.writeln('  final ${model.groupBySpecClassName} _groupBy;');
    buffer.writeln();
    buffer.writeln('  const ${model.groupedQueryClassName}._({');
    buffer.writeln('    required ${model.delegateClassName} delegate,');
    buffer.writeln('    required ${model.whereInputClassName} where,');
    buffer.writeln('    required ${model.groupBySpecClassName} groupBy,');
    buffer.writeln('  }) : _delegate = delegate,');
    buffer.writeln('       _where = where,');
    buffer.writeln('       _groupBy = groupBy;');
    buffer.writeln();

    buffer.writeln(
      '  ${model.groupedQueryClassName} having(${model.groupByHavingClassName} having, {bool merge = true}) {',
    );
    buffer.writeln('    return _next(');
    buffer.writeln('      _groupBy.copyWith(');
    buffer.writeln(
      '        having: merge ? _groupBy.having.merge(having) : having,',
    );
    buffer.writeln('      ),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.groupedQueryClassName} havingExpr(${model.groupByHavingClassName} Function(${model.groupByHavingClassName}Builder having) build, {bool merge = true}) {',
    );
    buffer.writeln(
      '    final next = build(const ${model.groupByHavingClassName}Builder());',
    );
    buffer.writeln('    return having(next, merge: merge);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<OrmPlan> toPlan() {');
    buffer.writeln('    return _runtimeGrouped(_groupBy).toPlan();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<JsonMap> inspectPlan() {');
    buffer.writeln('    return _runtimeGrouped(_groupBy).inspectPlan();');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<List<${model.groupByResultClassName}>> aggregate($aggregateBuilderClassName Function($aggregateBuilderClassName aggregate) build) {',
    );
    buffer.writeln(
      '    return aggregateWith(build($aggregateBuilderClassName()).toSpec());',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<List<${model.groupByResultClassName}>> aggregateWith(${model.aggregateSpecClassName} aggregate) {',
    );
    buffer.writeln('    return _executeSpec(');
    buffer.writeln('      _groupBy.copyWith(');
    buffer.writeln('        countAll: aggregate.countAll,');
    buffer.writeln('        count: aggregate.count,');
    buffer.writeln('        min: aggregate.min,');
    buffer.writeln('        max: aggregate.max,');
    buffer.writeln('        sum: aggregate.sum,');
    buffer.writeln('        avg: aggregate.avg,');
    buffer.writeln('      ),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<List<${model.groupByResultClassName}>> _execute() => _executeSpec(_groupBy);',
    );
    buffer.writeln();

    buffer.writeln(
      '  Future<List<${model.groupByResultClassName}>> _executeSpec(${model.groupBySpecClassName} groupBy) {',
    );
    buffer.writeln('    return _runtimeGrouped(groupBy)');
    buffer.writeln('        .aggregateWith(');
    buffer.writeln('          OrmAggregateSpec(');
    buffer.writeln('            countAll: groupBy.countAll,');
    buffer.writeln(
      '            count: groupBy.count.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '            min: groupBy.min.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '            max: groupBy.max.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '            sum: groupBy.sum.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln(
      '            avg: groupBy.avg.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln('          ),');
    buffer.writeln('        )');
    buffer.writeln(
      '        .then((rows) => rows.map(${model.groupByResultClassName}.fromJson).toList(growable: false));',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ModelGroupedQuery _runtimeGrouped(${model.groupBySpecClassName} groupBy) {',
    );
    buffer.writeln('    return _delegate._delegate');
    buffer.writeln('        .groupedBy(');
    buffer.writeln(
      '          by: groupBy.by.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln('          where: _where.toJson(),');
    buffer.writeln('        )');
    buffer.writeln(
      '        .having(groupBy.having.toRuntimeHaving(), merge: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.groupedQueryClassName} _next(${model.groupBySpecClassName} groupBy) {',
    );
    buffer.writeln('    return ${model.groupedQueryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      groupBy: groupBy,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeRelationWhereFilterClasses({
    required StringBuffer buffer,
    required _ResolvedModel model,
    required Map<String, _ResolvedModel> lookup,
  }) {
    final relationFields = model.model.fields
        .where((field) => field.isRelation)
        .toList(growable: false);

    for (final relation in relationFields) {
      final relationModelName = relation.relationModel;
      final relationModel = relationModelName == null
          ? null
          : lookup[relationModelName];
      if (relationModel == null) {
        continue;
      }

      final className = _relationWhereFilterClassName(
        owner: model,
        relationFieldName: relation.name,
      );
      buffer.writeln('class $className {');
      if (relation.isList) {
        buffer.writeln('  final ${relationModel.whereInputClassName}? some;');
        buffer.writeln('  final ${relationModel.whereInputClassName}? every;');
        buffer.writeln('  final ${relationModel.whereInputClassName}? none;');
        buffer.writeln();
        buffer.writeln(
          '  const $className({this.some, this.every, this.none});',
        );
        buffer.writeln();
        buffer.writeln('  factory $className.fromJsonValue(Object? value) {');
        buffer.writeln('    if (value is Map<String, Object?>) {');
        buffer.writeln('      return $className(');
        buffer.writeln(
          "        some: _readRelation(value['some'], ${relationModel.whereInputClassName}.fromJson),",
        );
        buffer.writeln(
          "        every: _readRelation(value['every'], ${relationModel.whereInputClassName}.fromJson),",
        );
        buffer.writeln(
          "        none: _readRelation(value['none'], ${relationModel.whereInputClassName}.fromJson),",
        );
        buffer.writeln('      );');
        buffer.writeln('    }');
        buffer.writeln('    return const $className();');
        buffer.writeln('  }');
        buffer.writeln();
        buffer.writeln('  Object? toJsonValue() {');
        buffer.writeln('    if (isEmpty) {');
        buffer.writeln('      return null;');
        buffer.writeln('    }');
        buffer.writeln('    return <String, Object?>{');
        buffer.writeln("      if (some != null) 'some': some!.toJson(),");
        buffer.writeln("      if (every != null) 'every': every!.toJson(),");
        buffer.writeln("      if (none != null) 'none': none!.toJson(),");
        buffer.writeln('    };');
        buffer.writeln('  }');
        buffer.writeln();
        buffer.writeln(
          '  bool get isEmpty => some == null && every == null && none == null;',
        );
      } else {
        buffer.writeln('  final ${relationModel.whereInputClassName}? is_;');
        buffer.writeln('  final ${relationModel.whereInputClassName}? isNot;');
        buffer.writeln('  final bool isNull;');
        buffer.writeln('  final bool isNotNull;');
        buffer.writeln();
        buffer.writeln('  const $className({');
        buffer.writeln('    this.is_,');
        buffer.writeln('    this.isNot,');
        buffer.writeln('    this.isNull = false,');
        buffer.writeln('    this.isNotNull = false,');
        buffer.writeln('  }) : assert(!((is_ != null) && isNull)),');
        buffer.writeln('       assert(!((isNot != null) && isNotNull)),');
        buffer.writeln('       assert(!(isNull && isNotNull));');
        buffer.writeln();
        buffer.writeln('  factory $className.fromJsonValue(Object? value) {');
        buffer.writeln('    if (value is Map<String, Object?>) {');
        buffer.writeln("      final hasIs = value.containsKey('is');");
        buffer.writeln("      final hasIsNot = value.containsKey('isNot');");
        buffer.writeln('      return $className(');
        buffer.writeln(
          "        is_: hasIs && value['is'] != null ? _readRelation(value['is'], ${relationModel.whereInputClassName}.fromJson) : null,",
        );
        buffer.writeln(
          "        isNot: hasIsNot && value['isNot'] != null ? _readRelation(value['isNot'], ${relationModel.whereInputClassName}.fromJson) : null,",
        );
        buffer.writeln("        isNull: hasIs && value['is'] == null,");
        buffer.writeln(
          "        isNotNull: hasIsNot && value['isNot'] == null,",
        );
        buffer.writeln('      );');
        buffer.writeln('    }');
        buffer.writeln('    return const $className();');
        buffer.writeln('  }');
        buffer.writeln();
        buffer.writeln('  Object? toJsonValue() {');
        buffer.writeln('    if (isEmpty) {');
        buffer.writeln('      return null;');
        buffer.writeln('    }');
        buffer.writeln('    return <String, Object?>{');
        buffer.writeln("      if (is_ != null) 'is': is_!.toJson(),");
        buffer.writeln("      if (isNull) 'is': null,");
        buffer.writeln("      if (isNot != null) 'isNot': isNot!.toJson(),");
        buffer.writeln("      if (isNotNull) 'isNot': null,");
        buffer.writeln('    };');
        buffer.writeln('  }');
        buffer.writeln();
        buffer.writeln('  bool get isEmpty =>');
        buffer.writeln('      is_ == null &&');
        buffer.writeln('      isNot == null &&');
        buffer.writeln('      !isNull &&');
        buffer.writeln('      !isNotNull;');
      }
      buffer.writeln('}');
      buffer.writeln();
    }
  }

  void _writeDataOrInputClass({
    required StringBuffer buffer,
    required _ResolvedModel model,
    required _TemplateClassKind classKind,
    required Map<String, _ResolvedModel> lookup,
  }) {
    final className = _className(model, classKind);
    final fields = _buildFieldBindings(_fieldsForClass(model.model, classKind));
    final includeLogicalWhere = classKind == _TemplateClassKind.where;

    buffer.writeln('class $className {');

    for (final field in fields) {
      final type = _fieldType(
        owner: model,
        field: field.field,
        classKind: classKind,
        lookup: lookup,
      );
      buffer.writeln('  final $type ${field.memberName};');
    }
    if (includeLogicalWhere) {
      buffer.writeln('  final List<$className>? and;');
      buffer.writeln('  final List<$className>? or;');
      buffer.writeln('  final $className? not;');
    }

    if (fields.isNotEmpty || includeLogicalWhere) {
      buffer.writeln();
      buffer.writeln('  const $className({');
      for (final field in fields) {
        final isOptional = _isOptionalField(field.field, classKind: classKind);
        final prefix = isOptional ? '' : 'required ';
        buffer.writeln('    ${prefix}this.${field.memberName},');
      }
      if (includeLogicalWhere) {
        buffer.writeln('    this.and,');
        buffer.writeln('    this.or,');
        buffer.writeln('    this.not,');
      }
      buffer.writeln('  });');
    } else {
      buffer.writeln();
      buffer.writeln('  const $className();');
    }

    if (includeLogicalWhere) {
      buffer.writeln();
      buffer.writeln('  $className andWith($className other) {');
      buffer.writeln('    if (isEmpty) {');
      buffer.writeln('      return other;');
      buffer.writeln('    }');
      buffer.writeln('    if (other.isEmpty) {');
      buffer.writeln('      return this;');
      buffer.writeln('    }');
      buffer.writeln('    return $className(');
      buffer.writeln('      and: <$className>[this, other],');
      buffer.writeln('    );');
      buffer.writeln('  }');
    }

    buffer.writeln();
    buffer.writeln(
      '  factory $className.fromJson(Map<String, Object?> json) {',
    );
    buffer.writeln('    return $className(');
    for (final field in fields) {
      final decodeExpression = _decodeExpression(
        owner: model,
        field: field.field,
        classKind: classKind,
        accessor: "json['${_escapeString(field.field.name)}']",
        lookup: lookup,
      );
      if (_isOptionalField(field.field, classKind: classKind)) {
        buffer.writeln('      ${field.memberName}: $decodeExpression,');
      } else {
        final type = _fieldType(
          owner: model,
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
    if (includeLogicalWhere) {
      buffer.writeln(
        "      and: _readRelationList(json['AND'], $className.fromJson),",
      );
      buffer.writeln(
        "      or: _readRelationList(json['OR'], $className.fromJson),",
      );
      buffer.writeln(
        "      not: _readRelation(json['NOT'], $className.fromJson),",
      );
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
        owner: model,
        field: field.field,
        classKind: classKind,
        memberName: memberName,
        lookup: lookup,
      );
      final isWhereFilter =
          (_isWhereFilterClassKind(classKind) && field.field.isScalar) ||
          _isRelationWhereFilterField(field: field.field, classKind: classKind);

      if (isOptional) {
        if (isWhereFilter) {
          buffer.writeln(
            "      if (${field.memberName} != null && !${field.memberName}!.isEmpty) '${_escapeString(field.field.name)}': $valueExpression,",
          );
        } else {
          buffer.writeln(
            "      if (${field.memberName} != null) '${_escapeString(field.field.name)}': $valueExpression,",
          );
        }
      } else {
        buffer.writeln(
          "      '${_escapeString(field.field.name)}': $valueExpression,",
        );
      }
    }
    if (includeLogicalWhere) {
      buffer.writeln(
        "      if (and != null) 'AND': and!.map((value) => value.toJson()).toList(growable: false),",
      );
      buffer.writeln(
        "      if (or != null) 'OR': or!.map((value) => value.toJson()).toList(growable: false),",
      );
      buffer.writeln("      if (not != null) 'NOT': not!.toJson(),");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    if (classKind == _TemplateClassKind.whereUnique) {
      buffer.writeln();
      buffer.writeln('  ${model.whereInputClassName} toWhereInput() {');
      buffer.writeln('    return ${model.whereInputClassName}(');
      for (final field in fields) {
        final filterClass = _whereFilterClassName(field.field.scalarType);
        buffer.writeln(
          '      ${field.memberName}: ${field.memberName} == null ? null : $filterClass(equals: ${field.memberName}),',
        );
      }
      buffer.writeln('    );');
      buffer.writeln('  }');
    }
    if (includeLogicalWhere) {
      buffer.writeln();
      buffer.writeln('  bool get isEmpty =>');
      for (final field in fields) {
        buffer.writeln(
          '      (${field.memberName} == null || ${field.memberName}!.isEmpty) &&',
        );
      }
      buffer.writeln(
        '      (and == null || and!.every((value) => value.isEmpty)) &&',
      );
      buffer.writeln(
        '      (or == null || or!.every((value) => value.isEmpty)) &&',
      );
      buffer.writeln('      (not == null || not!.isEmpty);');
    }
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
    buffer.writeln('Object? _readWhereUniqueEquals(Object? value) {');
    buffer.writeln('  final map = _readJsonMap(value);');
    buffer.writeln('  if (map == null) {');
    buffer.writeln('    return value;');
    buffer.writeln('  }');
    buffer.writeln("  if (!map.containsKey('equals')) {");
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln("  return map['equals'];");
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
      final propertyName = _makeUnique(
        base: _toUpperCamelIdentifier(model.name, fallback: 'Model'),
        used: usedGetterNames,
      );
      resolved.add(
        _ResolvedModel(
          model: model,
          classBaseName: classBaseName,
          propertyName: propertyName,
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
      _TemplateClassKind.whereUnique => model.fields.where(
        _includeInWhereUnique,
      ),
      _TemplateClassKind.cursor => model.fields.where(_includeInCursor),
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
      _TemplateClassKind.whereUnique => model.whereUniqueInputClassName,
      _TemplateClassKind.cursor => model.cursorInputClassName,
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
      _TemplateClassKind.whereUnique => true,
      _TemplateClassKind.cursor => true,
      _TemplateClassKind.create => field.isNullable,
      _TemplateClassKind.update => true,
    };
  }

  String _fieldType({
    required _ResolvedModel owner,
    required TypedField field,
    required _TemplateClassKind classKind,
    required Map<String, _ResolvedModel> lookup,
  }) {
    final optional = _isOptionalField(field, classKind: classKind);
    final baseType = _baseType(
      owner: owner,
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
    required _ResolvedModel owner,
    required TypedField field,
    required _TemplateClassKind classKind,
    required Map<String, _ResolvedModel> lookup,
  }) {
    if (_isWhereFilterClassKind(classKind) && field.isScalar) {
      return _whereFilterClassName(field.scalarType);
    }
    if (_isRelationWhereFilterField(field: field, classKind: classKind)) {
      return _relationWhereFilterClassName(
        owner: owner,
        relationFieldName: field.name,
      );
    }

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
    required _ResolvedModel owner,
    required TypedField field,
    required _TemplateClassKind classKind,
    required String accessor,
    required Map<String, _ResolvedModel> lookup,
  }) {
    if (_isWhereFilterClassKind(classKind) && field.isScalar) {
      final filterClass = _whereFilterClassName(field.scalarType);
      return '$filterClass.fromJsonValue($accessor)';
    }
    if (classKind == _TemplateClassKind.whereUnique && field.isScalar) {
      return _decodeScalar(
        field,
        accessor: '_readWhereUniqueEquals($accessor)',
      );
    }
    if (_isRelationWhereFilterField(field: field, classKind: classKind)) {
      final filterClass = _relationWhereFilterClassName(
        owner: owner,
        relationFieldName: field.name,
      );
      return '$filterClass.fromJsonValue($accessor)';
    }

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
    required _ResolvedModel owner,
    required TypedField field,
    required _TemplateClassKind classKind,
    required String memberName,
    required Map<String, _ResolvedModel> lookup,
  }) {
    if (_isWhereFilterClassKind(classKind) && field.isScalar) {
      return '$memberName.toJsonValue()';
    }
    if (_isRelationWhereFilterField(field: field, classKind: classKind)) {
      return '$memberName.toJsonValue()';
    }

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

  String _whereFilterClassName(TypedScalarType? scalarType) {
    return switch (scalarType) {
      TypedScalarType.string => 'StringWhereFilter',
      TypedScalarType.integer => 'IntWhereFilter',
      TypedScalarType.floating => 'DoubleWhereFilter',
      TypedScalarType.boolean => 'BoolWhereFilter',
      TypedScalarType.dateTime => 'DateTimeWhereFilter',
      TypedScalarType.json || null => 'JsonWhereFilter',
    };
  }

  String _classSuffix(_TemplateClassKind classKind) {
    return switch (classKind) {
      _TemplateClassKind.data => 'Data',
      _TemplateClassKind.where => 'WhereInput',
      _TemplateClassKind.whereUnique => 'WhereUniqueInput',
      _TemplateClassKind.cursor => 'CursorInput',
      _TemplateClassKind.create => 'CreateInput',
      _TemplateClassKind.update => 'UpdateInput',
    };
  }

  bool _isWhereFilterClassKind(_TemplateClassKind classKind) {
    return classKind == _TemplateClassKind.where;
  }

  bool _isRelationWhereFilterField({
    required TypedField field,
    required _TemplateClassKind classKind,
  }) {
    return classKind == _TemplateClassKind.where && field.isRelation;
  }

  bool _includeInWhereUnique(TypedField field) {
    if (!field.isScalar || field.isList) {
      return false;
    }
    if (field.includeInWhereUnique) {
      return true;
    }
    return _isConventionalIdFieldName(field.name) && field.includeInWhere;
  }

  bool _includeInCursor(TypedField field) {
    return field.isScalar && !field.isList;
  }

  bool _isConventionalIdFieldName(String name) {
    return name.trim().toLowerCase() == 'id';
  }

  String _relationIncludeClassName({
    required _ResolvedModel owner,
    required String relationFieldName,
  }) {
    final relationPart = _toUpperCamelIdentifier(
      relationFieldName,
      fallback: 'Relation',
    );
    return '${owner.classBaseName}${relationPart}Include';
  }

  String _relationWhereFilterClassName({
    required _ResolvedModel owner,
    required String relationFieldName,
  }) {
    final relationPart = _toUpperCamelIdentifier(
      relationFieldName,
      fallback: 'Relation',
    );
    return '${owner.classBaseName}${relationPart}RelationWhereFilter';
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
      for (final part in _splitIdentifierSegment(segment)) {
        final withPrefix = RegExp(r'^[0-9]').hasMatch(part) ? 'n$part' : part;
        normalized.add(withPrefix);
      }
    }
    return normalized;
  }

  List<String> _splitIdentifierSegment(String segment) {
    final matches = RegExp(
      r'[A-Z]+(?=[A-Z][a-z]|[0-9]|$)|[A-Z]?[a-z]+|[0-9]+',
    ).allMatches(segment);
    if (matches.isEmpty) {
      return <String>[segment];
    }
    return matches
        .map((match) => match.group(0)!)
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
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

enum _TemplateClassKind { data, where, whereUnique, cursor, create, update }

final class _ResolvedModel {
  final TypedModel model;
  final String classBaseName;
  final String propertyName;

  const _ResolvedModel({
    required this.model,
    required this.classBaseName,
    required this.propertyName,
  });

  String get delegateClassName => '${classBaseName}Delegate';

  String get sqlClassName => '${classBaseName}Sql';

  String get queryClassName => '${classBaseName}Query';

  String get distinctClassName => '${classBaseName}Distinct';

  String get dataClassName => '${classBaseName}Data';

  String get whereInputClassName => '${classBaseName}WhereInput';

  String get whereUniqueInputClassName => '${classBaseName}WhereUniqueInput';

  String get cursorInputClassName => '${classBaseName}CursorInput';

  String get createInputClassName => '${classBaseName}CreateInput';

  String get nestedCreateInputClassName => '${classBaseName}NestedCreateInput';

  String get updateInputClassName => '${classBaseName}UpdateInput';

  String get orderByClassName => '${classBaseName}OrderBy';

  String get groupByOrderByClassName => '${classBaseName}GroupByOrderBy';

  String get groupByHavingClassName => '${classBaseName}GroupByHaving';

  String get groupByHavingConditionClassName =>
      '${classBaseName}GroupByHavingCondition';

  String get aggregateSpecClassName => '${classBaseName}AggregateSpec';

  String get aggregateResultClassName => '${classBaseName}AggregateResult';

  String get groupBySpecClassName => '${classBaseName}GroupBySpec';

  String get groupByResultClassName => '${classBaseName}GroupByResult';

  String get groupedQueryClassName => '${classBaseName}GroupedQuery';

  String get selectClassName => '${classBaseName}Select';

  String get includeClassName => '${classBaseName}Include';
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
