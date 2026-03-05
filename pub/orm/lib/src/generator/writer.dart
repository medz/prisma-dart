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
    buffer.writeln('  final OrmModelContext _context;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmClient(this._context);');
    buffer.writeln();
    buffer.writeln(
      '  late final GeneratedOrmDb db = GeneratedOrmDb(_context);',
    );

    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class GeneratedOrmDb {');
    buffer.writeln('  final OrmModelContext _context;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmDb(this._context);');
    buffer.writeln();
    buffer.writeln(
      '  late final GeneratedOrmCollections orm = GeneratedOrmCollections(_context);',
    );
    buffer.writeln();
    buffer.writeln(
      '  late final GeneratedOrmSql sql = GeneratedOrmSql(_context);',
    );
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class GeneratedOrmCollections {');
    buffer.writeln('  final OrmModelContext _context;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmCollections(this._context);');
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

    buffer.writeln('class GeneratedOrmSql {');
    buffer.writeln('  final OrmModelContext _context;');
    buffer.writeln('  late final OrmSqlApi _api = _context.sql;');
    buffer.writeln();
    buffer.writeln('  GeneratedOrmSql(this._context);');
    buffer.writeln();
    buffer.writeln('  OrmSqlApi get raw => _api;');
    buffer.writeln();
    for (final model in models) {
      buffer.writeln(
        '  late final ${model.sqlClassName} ${model.getterName} =',
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
    final aggregateCountBucketClassName =
        '${model.classBaseName}AggregateCountBucket';
    final aggregateMinBucketClassName =
        '${model.classBaseName}AggregateMinBucket';
    final aggregateMaxBucketClassName =
        '${model.classBaseName}AggregateMaxBucket';
    final aggregateSumBucketClassName =
        '${model.classBaseName}AggregateSumBucket';
    final aggregateAvgBucketClassName =
        '${model.classBaseName}AggregateAvgBucket';
    final aggregateBucketClassNames = <String, String>{
      'count': aggregateCountBucketClassName,
      'min': aggregateMinBucketClassName,
      'max': aggregateMaxBucketClassName,
      'sum': aggregateSumBucketClassName,
      'avg': aggregateAvgBucketClassName,
    };

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
    buffer.writeln('  final Object? value;');
    buffer.writeln();
    buffer.writeln(
      '  const ${model.groupByHavingConditionClassName}._(this.value);',
    );
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} equals(Object? value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingConditionClassName}._(value);',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} notEquals(Object? value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'not': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} not(${model.groupByHavingConditionClassName} condition) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'not': condition.toJsonValue()});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} inList(List<Object?> values) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'in': values});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} notInList(List<Object?> values) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'notIn': values});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} contains(String value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'contains': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} startsWith(String value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'startsWith': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} endsWith(String value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'endsWith': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} gt(Object? value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'gt': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} gte(Object? value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'gte': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} lt(Object? value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'lt': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingConditionClassName} lte(Object? value) {',
    );
    buffer.writeln(
      "    return ${model.groupByHavingConditionClassName}._(<String, Object?>{'lte': value});",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Object? toJsonValue() => value;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.groupByHavingClassName} {');
    buffer.writeln('  final Map<String, Object?> value;');
    buffer.writeln();
    buffer.writeln(
      '  const ${model.groupByHavingClassName}() : value = const <String, Object?>{};',
    );
    buffer.writeln();
    buffer.writeln('  const ${model.groupByHavingClassName}._(this.value);');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} raw(Map<String, Object?> value) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingClassName}._(Map<String, Object?>.from(value));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} and(List<${model.groupByHavingClassName}> clauses) {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln('      <String, Object?>{');
    buffer.writeln(
      "        'AND': clauses.map((clause) => clause.toJson()).toList(growable: false),",
    );
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} or(List<${model.groupByHavingClassName}> clauses) {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln('      <String, Object?>{');
    buffer.writeln(
      "        'OR': clauses.map((clause) => clause.toJson()).toList(growable: false),",
    );
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} not(List<${model.groupByHavingClassName}> clauses) {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln('      <String, Object?>{');
    buffer.writeln(
      "        'NOT': clauses.map((clause) => clause.toJson()).toList(growable: false),",
    );
    buffer.writeln('      },');
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
      '      <String, Object?>{field.value: condition.toJsonValue()},',
    );
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
    buffer.writeln('      <String, Object?>{');
    buffer.writeln(
      "        '_count': <String, Object?>{field.value: condition.toJsonValue()},",
    );
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByHavingClassName} countAll('
      '${model.groupByHavingConditionClassName} condition'
      ') {',
    );
    buffer.writeln('    return ${model.groupByHavingClassName}._(');
    buffer.writeln('      <String, Object?>{');
    buffer.writeln(
      "        '_count': <String, Object?>{'all': condition.toJsonValue()},",
    );
    buffer.writeln('      },');
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
      buffer.writeln('      <String, Object?>{');
      buffer.writeln(
        "        '_$bucket': <String, Object?>{field.value: condition.toJsonValue()},",
      );
      buffer.writeln('      },');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
    }
    buffer.writeln(
      '  ${model.groupByHavingClassName} merge(${model.groupByHavingClassName} other) {',
    );
    buffer.writeln(
      '    return ${model.groupByHavingClassName}._(<String, Object?>{...value, ...other.value});',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  Map<String, Object?> toJson() {');
    buffer.writeln('    return Map<String, Object?>.from(value);');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  bool get isEmpty => value.isEmpty;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln('class ${model.groupByOrderByClassName} {');
    buffer.writeln('  final OrmOrderBy value;');
    buffer.writeln();
    buffer.writeln('  const ${model.groupByOrderByClassName}._(this.value);');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByOrderByClassName} by('
      '${model.distinctClassName} field, '
      '{SortOrder order = SortOrder.asc}'
      ') {',
    );
    buffer.writeln(
      '    return ${model.groupByOrderByClassName}._(OrmOrderBy(field.value, order: order));',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByOrderByClassName} count('
      '${model.distinctClassName} field, '
      '{SortOrder order = SortOrder.asc}'
      ') {',
    );
    buffer.writeln(
      "    return ${model.groupByOrderByClassName}._(OrmOrderBy('_count.\${field.value}', order: order));",
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static ${model.groupByOrderByClassName} countAll({SortOrder order = SortOrder.asc}) {',
    );
    buffer.writeln(
      "    return ${model.groupByOrderByClassName}._(OrmOrderBy('_count.all', order: order));",
    );
    buffer.writeln('  }');
    buffer.writeln();
    for (final bucket in const <String>['min', 'max', 'sum', 'avg']) {
      buffer.writeln(
        '  static ${model.groupByOrderByClassName} $bucket('
        '${model.distinctClassName} field, '
        '{SortOrder order = SortOrder.asc}'
        ') {',
      );
      buffer.writeln(
        "    return ${model.groupByOrderByClassName}._(OrmOrderBy('_$bucket.\${field.value}', order: order));",
      );
      buffer.writeln('  }');
      buffer.writeln();
    }
    buffer.writeln('}');
    buffer.writeln();

    for (final entry in aggregateBucketClassNames.entries) {
      _writeAggregateBucketClass(
        buffer: buffer,
        scalarFields: scalarFields,
        className: entry.value,
        bucket: entry.key,
      );
    }

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
    buffer.writeln('  int? get countAll => count.all;');
    buffer.writeln();
    for (final entry in aggregateBucketClassNames.entries) {
      buffer.writeln('  ${entry.value} get ${entry.key} {');
      buffer.writeln('    return ${entry.value}._(');
      buffer.writeln(
        "      _readJsonMap(_value['${entry.key}']) ?? const <String, Object?>{},",
      );
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
    }
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
    buffer.writeln('  int? get countAll => count.all;');
    buffer.writeln();
    for (final entry in aggregateBucketClassNames.entries) {
      buffer.writeln('  ${entry.value} get ${entry.key} {');
      buffer.writeln('    return ${entry.value}._(');
      buffer.writeln(
        "      _readJsonMap(_value['${entry.key}']) ?? const <String, Object?>{},",
      );
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
    }
    buffer.writeln('  ${model.aggregateResultClassName} get aggregate {');
    buffer.writeln('    return ${model.aggregateResultClassName}.fromJson(');
    buffer.writeln('      <String, Object?>{');
    for (final entry in aggregateBucketClassNames.entries) {
      buffer.writeln("        '${entry.key}': ${entry.key}.toJson(),");
    }
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
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
      buffer.writeln('  final ${relationModel.whereInputClassName} where;');
      buffer.writeln('  final int? skip;');
      buffer.writeln('  final int? take;');
      buffer.writeln(
        '  final List<${relationModel.orderByClassName}> orderBy;',
      );
      buffer.writeln('  final ${relationModel.selectClassName}? select;');
      buffer.writeln('  final ${relationModel.includeClassName}? include;');
      buffer.writeln();
      buffer.writeln('  const $includeClassName({');
      buffer.writeln(
        '    this.where = const ${relationModel.whereInputClassName}(),',
      );
      buffer.writeln('    this.skip,');
      buffer.writeln('    this.take,');
      buffer.writeln(
        '    this.orderBy = const <${relationModel.orderByClassName}>[],',
      );
      buffer.writeln('    this.select,');
      buffer.writeln('    this.include,');
      buffer.writeln('  });');
      buffer.writeln();
      buffer.writeln('  IncludeSpec toIncludeSpec() {');
      buffer.writeln('    return IncludeSpec(');
      buffer.writeln('      where: where.toJson(),');
      buffer.writeln('      skip: skip,');
      buffer.writeln('      take: take,');
      buffer.writeln(
        '      orderBy: orderBy.map((entry) => entry.value).toList(growable: false),',
      );
      buffer.writeln('      select: select?.toFields() ?? const <String>[],');
      buffer.writeln(
        '      include: include?.toIncludeMap() ?? const <String, IncludeSpec>{},',
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
  }

  void _writeAggregateBucketClass({
    required StringBuffer buffer,
    required List<TypedField> scalarFields,
    required String className,
    required String bucket,
  }) {
    final fields = scalarFields
        .where(
          (field) =>
              _supportsAggregateBucketField(field: field, bucket: bucket),
        )
        .toList(growable: false);

    buffer.writeln('class $className {');
    buffer.writeln('  final Map<String, Object?> _value;');
    buffer.writeln();
    buffer.writeln('  const $className._(this._value);');
    buffer.writeln();

    if (bucket == 'count') {
      buffer.writeln("  int? get all => _readInt(_value['all']);");
      buffer.writeln();
    }

    for (final scalarField in fields) {
      final memberName = _toLowerCamelIdentifier(
        scalarField.name,
        fallback: 'field',
      );
      final fieldName = _escapeString(scalarField.name);
      final accessor = "_value['$fieldName']";
      final decode = _aggregateBucketDecodeExpression(
        field: scalarField,
        bucket: bucket,
        accessor: accessor,
      );
      final fieldType = _aggregateBucketFieldType(
        field: scalarField,
        bucket: bucket,
      );
      buffer.writeln('  $fieldType get $memberName => $decode;');
      buffer.writeln();
    }

    buffer.writeln('  Map<String, Object?> toJson() {');
    buffer.writeln('    return Map<String, Object?>.from(_value);');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();
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

    buffer.writeln('  Future<List<${model.dataClassName}>> findMany({');
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
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeOrderBy = orderBy.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln(
      '    final runtimeDistinct = distinct.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final rows = await _delegate.findMany(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: runtimeOrderBy,');
    buffer.writeln('      distinct: runtimeDistinct,');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> findUnique({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final row = await _delegate.findUnique(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
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
    buffer.writeln(
      '    List<${model.orderByClassName}> orderBy = const <${model.orderByClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> distinct = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeOrderBy = orderBy.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln(
      '    final runtimeDistinct = distinct.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final row = await _delegate.findFirst(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      orderBy: runtimeOrderBy,');
    buffer.writeln('      distinct: runtimeDistinct,');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> create({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final row = await _delegate.create(');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> createMany({');
    buffer.writeln('    required List<${model.createInputClassName}> data,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final rows = await _delegate.createMany(');
    buffer.writeln(
      '      data: data.map((entry) => entry.toJson()).toList(growable: false),',
    );
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> update({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final row = await _delegate.update(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      data: data.toJson(),');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> delete({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final row = await _delegate.delete(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}> upsert({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.createInputClassName} create,');
    buffer.writeln('    required ${model.updateInputClassName} update,');
    buffer.writeln('    ${model.selectClassName}? select,');
    buffer.writeln('    ${model.includeClassName}? include,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    final row = await _delegate.upsert(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      create: create.toJson(),');
    buffer.writeln('      update: update.toJson(),');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    );');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> deleteMany({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return _delegate.deleteMany(where: where.toJson());');
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

    buffer.writeln('  Future<${model.aggregateResultClassName}> aggregate({');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    bool countAll = false,');
    buffer.writeln(
      '    List<${model.distinctClassName}> count = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> min = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> max = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> sum = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> avg = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('  }) async {');
    buffer.writeln('    final value = await _delegate.aggregate(');
    buffer.writeln('      where: where.toJson(),');
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
    buffer.writeln(
      '    return ${model.aggregateResultClassName}.fromJson(value);',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.groupByResultClassName}>> groupBy({');
    buffer.writeln('    required List<${model.distinctClassName}> by,');
    buffer.writeln(
      '    ${model.whereInputClassName} where = const ${model.whereInputClassName}(),',
    );
    buffer.writeln('    int? skip,');
    buffer.writeln('    int? take,');
    buffer.writeln(
      '    List<${model.groupByOrderByClassName}> groupByOrderBy = const <${model.groupByOrderByClassName}>[],',
    );
    buffer.writeln(
      '    ${model.groupByHavingClassName} typedHaving = const ${model.groupByHavingClassName}(),',
    );
    buffer.writeln('    bool countAll = false,');
    buffer.writeln(
      '    List<${model.distinctClassName}> count = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> min = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> max = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> sum = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> avg = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final runtimeOrderBy = groupByOrderBy.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln('    final runtimeHaving = typedHaving.toJson();');
    buffer.writeln('    final rows = await _delegate.groupBy(');
    buffer.writeln(
      '      by: by.map((entry) => entry.value).toList(growable: false),',
    );
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      having: runtimeHaving,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: runtimeOrderBy,');
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
    buffer.writeln(
      '    return rows.map(${model.groupByResultClassName}.fromJson).toList(growable: false);',
    );
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
    buffer.writeln('  }) async* {');
    buffer.writeln(
      '    final runtimeOrderBy = orderBy.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln(
      '    final runtimeDistinct = distinct.map((entry) => entry.value).toList(growable: false);',
    );
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      '    final runtimeInclude = include?.toIncludeMap() ?? const <String, IncludeSpec>{};',
    );
    buffer.writeln('    await for (final row in _delegate.streamMany(');
    buffer.writeln('      where: where.toJson(),');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: runtimeOrderBy,');
    buffer.writeln('      distinct: runtimeDistinct,');
    buffer.writeln('      select: runtimeSelect,');
    buffer.writeln('      include: runtimeInclude,');
    buffer.writeln('    )) {');
    buffer.writeln('      yield ${model.dataClassName}.fromJson(row);');
    buffer.writeln('    }');
    buffer.writeln('  }');

    buffer.writeln('}');
    buffer.writeln();
    _writeTypedQueryClass(buffer: buffer, model: model);
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

    buffer.writeln('  OrmSqlSelectBuilder selectPlan({');
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
    buffer.writeln(
      '    final runtimeSelect = select?.toFields() ?? const <String>[];',
    );
    buffer.writeln("    return _sql.from('$runtimeName')");
    buffer.writeln('        .where(where.toJson())');
    buffer.writeln('        .skip(skip)');
    buffer.writeln('        .take(take)');
    buffer.writeln('        .orderBy(runtimeOrderBy)');
    buffer.writeln('        .distinct(runtimeDistinct)');
    buffer.writeln('        .select(runtimeSelect);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> query({');
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
    buffer.writeln('    final rows = await selectPlan(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('    ).query();');
    buffer.writeln(
      '    return rows.map(${model.dataClassName}.fromJson).toList(growable: false);',
    );
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
    buffer.writeln('    await for (final row in selectPlan(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: take,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('    ).stream()) {');
    buffer.writeln('      yield ${model.dataClassName}.fromJson(row);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> first({');
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
    buffer.writeln('    final row = await selectPlan(');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: skip,');
    buffer.writeln('      take: 1,');
    buffer.writeln('      orderBy: orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('    ).first();');
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmSqlInsertBuilder insertPlan({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln(
      '    final runtimeReturning = returning?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      "    return _sql.insertInto('$runtimeName').values(data.toJson()).returning(runtimeReturning);",
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<OrmSqlMutationResult> insertResult({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln(
      '    return insertPlan(data: data, returning: returning).execute();',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> insert({');
    buffer.writeln('    required ${model.createInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final row = (await insertResult(data: data, returning: returning)).row;',
    );
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmSqlUpdateBuilder updatePlan({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln(
      '    final runtimeReturning = returning?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      "    return _sql.update('$runtimeName').where(where.toJson()).set(data.toJson()).returning(runtimeReturning);",
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<OrmSqlMutationResult> updateResult({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln(
      '    return updatePlan(where: where, data: data, returning: returning).execute();',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> update({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    required ${model.updateInputClassName} data,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final row = (await updateResult(where: where, data: data, returning: returning)).row;',
    );
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  OrmSqlDeleteBuilder deletePlan({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln(
      '    final runtimeReturning = returning?.toFields() ?? const <String>[];',
    );
    buffer.writeln(
      "    return _sql.deleteFrom('$runtimeName').where(where.toJson()).returning(runtimeReturning);",
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<OrmSqlMutationResult> deleteResult({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) {');
    buffer.writeln(
      '    return deletePlan(where: where, returning: returning).execute();',
    );
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> delete({');
    buffer.writeln('    required ${model.whereUniqueInputClassName} where,');
    buffer.writeln('    ${model.selectClassName}? returning,');
    buffer.writeln('  }) async {');
    buffer.writeln(
      '    final row = (await deleteResult(where: where, returning: returning)).row;',
    );
    buffer.writeln('    if (row == null) {');
    buffer.writeln('      return null;');
    buffer.writeln('    }');
    buffer.writeln('    return ${model.dataClassName}.fromJson(row);');
    buffer.writeln('  }');

    buffer.writeln('}');
    buffer.writeln();
  }

  void _writeTypedQueryClass({
    required StringBuffer buffer,
    required _ResolvedModel model,
  }) {
    buffer.writeln('class ${model.queryClassName} {');
    buffer.writeln('  final ${model.delegateClassName} _delegate;');
    buffer.writeln('  final ${model.whereInputClassName} _where;');
    buffer.writeln('  final int? _skip;');
    buffer.writeln('  final int? _take;');
    buffer.writeln('  final List<${model.orderByClassName}> _orderBy;');
    buffer.writeln('  final List<${model.distinctClassName}> _distinct;');
    buffer.writeln('  final ${model.selectClassName}? _select;');
    buffer.writeln('  final ${model.includeClassName}? _include;');
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
    buffer.writeln('       _include = include;');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} where(${model.whereInputClassName} where) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('    );');
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
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} distinct(List<${model.distinctClassName}> distinct) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} select(${model.selectClassName}? select) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  ${model.queryClassName} include(${model.includeClassName}? include) {',
    );
    buffer.writeln('    return ${model.queryClassName}._(');
    buffer.writeln('      delegate: _delegate,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.dataClassName}>> all() {');
    buffer.writeln('    return _delegate.findMany(');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.dataClassName}?> first() {');
    buffer.writeln('    return _delegate.findFirst(');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Stream<${model.dataClassName}> stream() {');
    buffer.writeln('    return _delegate.stream(');
    buffer.writeln('      where: _where,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      orderBy: _orderBy,');
    buffer.writeln('      distinct: _distinct,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<${model.aggregateResultClassName}> aggregate({');
    buffer.writeln('    bool countAll = false,');
    buffer.writeln(
      '    List<${model.distinctClassName}> count = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> min = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> max = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> sum = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> avg = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return _delegate.aggregate(');
    buffer.writeln('      where: _where,');
    buffer.writeln('      countAll: countAll,');
    buffer.writeln('      count: count,');
    buffer.writeln('      min: min,');
    buffer.writeln('      max: max,');
    buffer.writeln('      sum: sum,');
    buffer.writeln('      avg: avg,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<List<${model.groupByResultClassName}>> groupBy({');
    buffer.writeln('    required List<${model.distinctClassName}> by,');
    buffer.writeln(
      '    ${model.groupByHavingClassName} typedHaving = const ${model.groupByHavingClassName}(),',
    );
    buffer.writeln(
      '    List<${model.groupByOrderByClassName}> groupByOrderBy = const <${model.groupByOrderByClassName}>[],',
    );
    buffer.writeln('    bool countAll = false,');
    buffer.writeln(
      '    List<${model.distinctClassName}> count = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> min = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> max = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> sum = const <${model.distinctClassName}>[],',
    );
    buffer.writeln(
      '    List<${model.distinctClassName}> avg = const <${model.distinctClassName}>[],',
    );
    buffer.writeln('  }) {');
    buffer.writeln('    return _delegate.groupBy(');
    buffer.writeln('      by: by,');
    buffer.writeln('      where: _where,');
    buffer.writeln('      typedHaving: typedHaving,');
    buffer.writeln('      skip: _skip,');
    buffer.writeln('      take: _take,');
    buffer.writeln('      groupByOrderBy: groupByOrderBy,');
    buffer.writeln('      countAll: countAll,');
    buffer.writeln('      count: count,');
    buffer.writeln('      min: min,');
    buffer.writeln('      max: max,');
    buffer.writeln('      sum: sum,');
    buffer.writeln('      avg: avg,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln(
      '  Future<List<${model.dataClassName}>> createMany({required List<${model.createInputClassName}> data}) {',
    );
    buffer.writeln('    return _delegate.createMany(');
    buffer.writeln('      data: data,');
    buffer.writeln('      select: _select,');
    buffer.writeln('      include: _include,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> deleteMany() {');
    buffer.writeln('    return _delegate.deleteMany(where: _where);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<int> count() {');
    buffer.writeln('    return _delegate.count(where: _where);');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  Future<bool> exists() {');
    buffer.writeln('    return _delegate.exists(where: _where);');
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
      _TemplateClassKind.whereUnique => model.fields.where(
        _includeInWhereUnique,
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
      _TemplateClassKind.whereUnique => model.whereUniqueInputClassName,
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

enum _TemplateClassKind { data, where, whereUnique, create, update }

final class _ResolvedModel {
  final TypedModel model;
  final String classBaseName;
  final String getterName;

  const _ResolvedModel({
    required this.model,
    required this.classBaseName,
    required this.getterName,
  });

  String get delegateClassName => '${classBaseName}Delegate';

  String get sqlClassName => '${classBaseName}Sql';

  String get queryClassName => '${classBaseName}Query';

  String get distinctClassName => '${classBaseName}Distinct';

  String get dataClassName => '${classBaseName}Data';

  String get whereInputClassName => '${classBaseName}WhereInput';

  String get whereUniqueInputClassName => '${classBaseName}WhereUniqueInput';

  String get createInputClassName => '${classBaseName}CreateInput';

  String get updateInputClassName => '${classBaseName}UpdateInput';

  String get orderByClassName => '${classBaseName}OrderBy';

  String get groupByOrderByClassName => '${classBaseName}GroupByOrderBy';

  String get groupByHavingClassName => '${classBaseName}GroupByHaving';

  String get groupByHavingConditionClassName =>
      '${classBaseName}GroupByHavingCondition';

  String get aggregateResultClassName => '${classBaseName}AggregateResult';

  String get groupByResultClassName => '${classBaseName}GroupByResult';

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
