import '../core/sort_order.dart';
import '../contract/contract.dart';
import '../engine/engine.dart';
import '../runtime/errors.dart';
import '../runtime/plan.dart';
import '../runtime/types.dart';
import '../target/adapter.dart';
import 'codec.dart';
import 'types.dart';

const List<String> _whereOperatorOrder = <String>[
  'equals',
  'not',
  'in',
  'notIn',
  'contains',
  'startsWith',
  'endsWith',
  'gt',
  'gte',
  'lt',
  'lte',
];

const Set<String> _whereOperators = <String>{
  'equals',
  'not',
  'in',
  'notIn',
  'contains',
  'startsWith',
  'endsWith',
  'gt',
  'gte',
  'lt',
  'lte',
};

const Set<String> _whereLogicalKeys = <String>{'AND', 'OR', 'NOT'};
const List<String> _toManyRelationWhereOperatorOrder = <String>[
  'some',
  'none',
  'every',
];
const List<String> _toOneRelationWhereOperatorOrder = <String>['is', 'isNot'];
const Set<String> _toManyRelationWhereOperators = <String>{
  'some',
  'every',
  'none',
};
const Set<String> _toOneRelationWhereOperators = <String>{'is', 'isNot'};
const String _relationWhereAlias = '_rel';

final class SqlAdapter
    implements
        TargetAdapter<SqlStatement, SqlResult>,
        ExplainCapableTargetAdapter<SqlStatement, SqlResult> {
  final OrmContract contract;
  final String identifierQuote;
  final SqlFieldCodecResolver? codecResolver;

  SqlAdapter({
    this.identifierQuote = '"',
    required this.contract,
    this.codecResolver,
  });

  @override
  SqlStatement lower(OrmPlan plan) {
    final model = contract.models[plan.model];
    if (model == null) {
      throw ModelNotFoundException(plan.model, contract.models.keys);
    }

    return switch (plan.action) {
      OrmAction.read => _lowerRead(
        plan: plan,
        table: model.table,
        model: plan.model,
      ),
      OrmAction.create => _lowerCreate(
        plan: plan,
        table: model.table,
        model: plan.model,
      ),
      OrmAction.update => _lowerUpdate(
        plan: plan,
        table: model.table,
        model: plan.model,
      ),
      OrmAction.delete => _lowerDelete(
        plan: plan,
        table: model.table,
        model: plan.model,
      ),
    };
  }

  @override
  JsonMap describe(OrmPlan plan, SqlStatement request) {
    return Map<String, Object?>.unmodifiable(<String, Object?>{
      'source': 'adapter',
      'target': contract.target,
      'request': Map<String, Object?>.unmodifiable(<String, Object?>{
        'kind': 'sql',
        'action': request.action.name,
        'text': request.text,
        'parameterCount': request.parameters.length,
      }),
    });
  }

  SqlStatement _lowerRead({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final read = plan.read!;
    final whereParams = <Object?>[];
    final whereClause = _buildWhereClause(
      model: model,
      where: read.where,
      params: whereParams,
    );
    final windowParams = <Object?>[];
    final windowPredicate = _buildCursorWindowPredicate(
      read: read,
      params: windowParams,
    );
    final mergedWhereClause = _mergeWhereClauses(whereClause, windowPredicate);
    final orderByClause = _buildOrderByClause(read.orderBy);

    if (read.page?.before != null) {
      final limitParams = <Object?>[];
      final selectColumns = _buildSelectColumns(read.select);
      final innerOrderByClause = _buildOrderByClause(
        _reverseOrderBy(read.orderBy),
      );
      final innerLimitClause = _buildReadLimitOffsetClause(read, limitParams);
      return SqlStatement(
        action: plan.action,
        text:
            'SELECT $selectColumns FROM ('
            'SELECT * FROM ${_id(table)}'
            '$mergedWhereClause$innerOrderByClause$innerLimitClause'
            ') AS ${_id('_page')}$orderByClause',
        parameters: <Object?>[...whereParams, ...windowParams, ...limitParams],
      );
    }

    final params = <Object?>[...whereParams, ...windowParams];
    return SqlStatement(
      action: plan.action,
      text:
          'SELECT ${_buildSelectColumns(read.select)} FROM ${_id(table)}'
          '$mergedWhereClause$orderByClause${_buildReadLimitOffsetClause(read, params)}',
      parameters: params,
    );
  }

  @override
  EngineResponse decode(SqlResult response, OrmPlan plan) {
    final resolver = codecResolver;
    if (resolver == null) {
      return switch (plan.action) {
        OrmAction.read => _decodeReadResult(
          rows: response.rows,
          affectedRows: response.affectedRows,
          plan: plan,
        ),
        OrmAction.create ||
        OrmAction.update ||
        OrmAction.delete => EngineResponse.buffered(
          _firstOrNull(response.rows),
          affectedRows: response.affectedRows,
        ),
      };
    }

    final decodedRows = _decodeRows(model: plan.model, rows: response.rows);
    return switch (plan.action) {
      OrmAction.read => _decodeReadResult(
        rows: decodedRows,
        affectedRows: response.affectedRows,
        plan: plan,
      ),
      OrmAction.create ||
      OrmAction.update ||
      OrmAction.delete => EngineResponse.buffered(
        _firstOrNull(decodedRows),
        affectedRows: response.affectedRows,
      ),
    };
  }

  SqlStatement _lowerCreate({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final mutation = plan.mutation!;
    final columns = mutation.data.keys.toList(growable: false);
    final values = columns
        .map(
          (column) => _encodeValue(
            model: model,
            field: column,
            value: mutation.data[column],
          ),
        )
        .toList(growable: false);
    final placeholders = List<String>.filled(columns.length, '?').join(', ');

    return SqlStatement(
      action: plan.action,
      text:
          'INSERT INTO ${_id(table)} (${columns.map(_id).join(', ')}) '
          'VALUES ($placeholders)${_buildMutationReturningClause(mutation.select)}',
      parameters: values,
    );
  }

  SqlStatement _lowerUpdate({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final mutation = plan.mutation!;
    final setColumns = mutation.data.keys.toList(growable: false);
    final setValues = setColumns
        .map(
          (column) => _encodeValue(
            model: model,
            field: column,
            value: mutation.data[column],
          ),
        )
        .toList(growable: false);

    final params = <Object?>[...setValues];
    final wherePart = _buildWhereClause(
      model: model,
      where: mutation.where,
      params: params,
    );

    return SqlStatement(
      action: plan.action,
      text:
          'UPDATE ${_id(table)} SET '
          '${setColumns.map((column) => '${_id(column)} = ?').join(', ')}'
          '$wherePart${_buildMutationReturningClause(mutation.select)}',
      parameters: params,
    );
  }

  EngineResponse _decodeReadResult({
    required List<JsonMap> rows,
    required int affectedRows,
    required OrmPlan plan,
  }) {
    return switch (plan.read!.resultMode) {
      OrmReadResultMode.firstOrNull || OrmReadResultMode.oneOrNull =>
        EngineResponse.buffered(_firstOrNull(rows), affectedRows: affectedRows),
      _ => EngineResponse.buffered(rows, affectedRows: affectedRows),
    };
  }

  SqlStatement _lowerDelete({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final mutation = plan.mutation!;
    final params = <Object?>[];
    final wherePart = _buildWhereClause(
      model: model,
      where: mutation.where,
      params: params,
    );

    return SqlStatement(
      action: plan.action,
      text:
          'DELETE FROM ${_id(table)}'
          '$wherePart${_buildMutationReturningClause(mutation.select)}',
      parameters: params,
    );
  }

  String _buildSelectColumns(List<String> select) {
    if (select.isEmpty) {
      return '*';
    }
    return select.map(_id).join(', ');
  }

  String _buildMutationReturningClause(List<String> select) {
    if (!contract.capabilities.mutationReturning) {
      return '';
    }

    return ' RETURNING ${_buildSelectColumns(select)}';
  }

  String _buildWhereClause({
    required String model,
    required JsonMap where,
    required List<Object?> params,
  }) {
    if (where.isEmpty) {
      return '';
    }

    final modelContract = contract.models[model];
    if (modelContract == null) {
      throw ModelNotFoundException(model, contract.models.keys);
    }
    final predicate = _buildWhereExpression(
      model: model,
      where: where,
      params: params,
      fieldRefPrefix: null,
      rowRef: _id(modelContract.table),
    );
    return ' WHERE $predicate';
  }

  String _buildWhereExpression({
    required String model,
    required JsonMap where,
    required List<Object?> params,
    required String rowRef,
    required String? fieldRefPrefix,
  }) {
    final modelContract = contract.models[model];
    if (modelContract == null) {
      throw ModelNotFoundException(model, contract.models.keys);
    }

    final predicates = <String>[];

    for (final entry in where.entries) {
      final key = entry.key;
      if (_whereLogicalKeys.contains(key)) {
        predicates.add(
          _buildWhereLogicalPredicate(
            model: model,
            key: key,
            operand: entry.value,
            params: params,
            rowRef: rowRef,
            fieldRefPrefix: fieldRefPrefix,
          ),
        );
        continue;
      }

      final relation = modelContract.relations[key];
      if (relation != null) {
        predicates.addAll(
          _buildWhereRelationPredicates(
            relation: relation,
            condition: entry.value,
            params: params,
            outerRowRef: rowRef,
          ),
        );
        continue;
      }

      predicates.addAll(
        _buildWhereFieldPredicates(
          model: model,
          field: key,
          condition: entry.value,
          params: params,
          fieldRefPrefix: fieldRefPrefix,
        ),
      );
    }

    if (predicates.isEmpty) {
      return '1 = 1';
    }

    return predicates.join(' AND ');
  }

  String _buildWhereLogicalPredicate({
    required String model,
    required String key,
    required Object? operand,
    required List<Object?> params,
    required String rowRef,
    required String? fieldRefPrefix,
  }) {
    return switch (key) {
      'AND' => _buildWhereAndPredicate(
        model: model,
        operand: operand,
        params: params,
        rowRef: rowRef,
        fieldRefPrefix: fieldRefPrefix,
      ),
      'OR' => _buildWhereOrPredicate(
        model: model,
        operand: operand,
        params: params,
        rowRef: rowRef,
        fieldRefPrefix: fieldRefPrefix,
      ),
      'NOT' => _buildWhereNotPredicate(
        model: model,
        operand: operand,
        params: params,
        rowRef: rowRef,
        fieldRefPrefix: fieldRefPrefix,
      ),
      _ => '1 = 0',
    };
  }

  String _buildWhereAndPredicate({
    required String model,
    required Object? operand,
    required List<Object?> params,
    required String rowRef,
    required String? fieldRefPrefix,
  }) {
    final where = _coerceWhereMap(operand);
    if (where != null) {
      final nested = _buildWhereExpression(
        model: model,
        where: where,
        params: params,
        rowRef: rowRef,
        fieldRefPrefix: fieldRefPrefix,
      );
      return '($nested)';
    }

    final whereList = _coerceWhereList(operand);
    if (whereList == null) {
      return '1 = 0';
    }
    if (whereList.isEmpty) {
      return '1 = 1';
    }

    final predicates = whereList
        .map(
          (item) => _buildWhereExpression(
            model: model,
            where: item,
            params: params,
            rowRef: rowRef,
            fieldRefPrefix: fieldRefPrefix,
          ),
        )
        .toList(growable: false);
    return '(${predicates.join(' AND ')})';
  }

  String _buildWhereOrPredicate({
    required String model,
    required Object? operand,
    required List<Object?> params,
    required String rowRef,
    required String? fieldRefPrefix,
  }) {
    final where = _coerceWhereMap(operand);
    if (where != null) {
      final nested = _buildWhereExpression(
        model: model,
        where: where,
        params: params,
        rowRef: rowRef,
        fieldRefPrefix: fieldRefPrefix,
      );
      return '($nested)';
    }

    final whereList = _coerceWhereList(operand);
    if (whereList == null) {
      return '1 = 0';
    }
    if (whereList.isEmpty) {
      return '1 = 0';
    }

    final predicates = whereList
        .map(
          (item) => _buildWhereExpression(
            model: model,
            where: item,
            params: params,
            rowRef: rowRef,
            fieldRefPrefix: fieldRefPrefix,
          ),
        )
        .toList(growable: false);
    return '(${predicates.join(' OR ')})';
  }

  String _buildWhereNotPredicate({
    required String model,
    required Object? operand,
    required List<Object?> params,
    required String rowRef,
    required String? fieldRefPrefix,
  }) {
    final where = _coerceWhereMap(operand);
    if (where != null) {
      final nested = _buildWhereExpression(
        model: model,
        where: where,
        params: params,
        rowRef: rowRef,
        fieldRefPrefix: fieldRefPrefix,
      );
      return 'NOT ($nested)';
    }

    final whereList = _coerceWhereList(operand);
    if (whereList == null) {
      return '1 = 0';
    }
    if (whereList.isEmpty) {
      return '1 = 1';
    }

    final predicates = whereList
        .map(
          (item) => _buildWhereExpression(
            model: model,
            where: item,
            params: params,
            rowRef: rowRef,
            fieldRefPrefix: fieldRefPrefix,
          ),
        )
        .map((item) => 'NOT ($item)')
        .toList(growable: false);
    return '(${predicates.join(' AND ')})';
  }

  List<String> _buildWhereFieldPredicates({
    required String model,
    required String field,
    required Object? condition,
    required List<Object?> params,
    required String? fieldRefPrefix,
  }) {
    final predicates = <String>[];
    final operatorMap = _coerceOperatorMap(condition);
    if (operatorMap == null) {
      predicates.add(
        '${_fieldReference(field: field, fieldRefPrefix: fieldRefPrefix)} = ?',
      );
      params.add(
        _encodeWhereValue(model: model, field: field, value: condition),
      );
      return predicates;
    }

    for (final operator in _whereOperatorOrder) {
      if (!operatorMap.containsKey(operator)) {
        continue;
      }
      _appendWhereOperatorPredicate(
        predicates: predicates,
        params: params,
        model: model,
        field: field,
        operator: operator,
        operand: operatorMap[operator],
        fieldRefPrefix: fieldRefPrefix,
      );
    }

    return predicates;
  }

  List<String> _buildWhereRelationPredicates({
    required ModelRelationContract relation,
    required Object? condition,
    required List<Object?> params,
    required String outerRowRef,
  }) {
    final relationWhere = _coerceWhereMap(condition);
    if (relationWhere == null) {
      return const <String>['1 = 0'];
    }
    if (relationWhere.isEmpty) {
      return const <String>['1 = 1'];
    }

    final supportedOperators = _relationWhereOperatorsFor(
      cardinality: relation.cardinality,
    );
    if (relationWhere.keys.any((key) => !supportedOperators.contains(key))) {
      return const <String>['1 = 0'];
    }

    final predicates = <String>[];
    if (relation.cardinality == RelationCardinality.many) {
      for (final operator in _toManyRelationWhereOperatorOrder) {
        if (!relationWhere.containsKey(operator)) {
          continue;
        }
        final relatedWhere = _normalizeRelationWhereOperand(
          relationWhere[operator],
        );
        if (relatedWhere == null) {
          return const <String>['1 = 0'];
        }
        switch (operator) {
          case 'some':
            predicates.add(
              _buildRelationExistsPredicate(
                relation: relation,
                relatedWhere: relatedWhere,
                params: params,
                outerRowRef: outerRowRef,
                negated: false,
              ),
            );
          case 'none':
            predicates.add(
              _buildRelationExistsPredicate(
                relation: relation,
                relatedWhere: relatedWhere,
                params: params,
                outerRowRef: outerRowRef,
                negated: true,
              ),
            );
          case 'every':
            predicates.add(
              _buildRelationExistsPredicate(
                relation: relation,
                relatedWhere: <String, Object?>{'NOT': relatedWhere},
                params: params,
                outerRowRef: outerRowRef,
                negated: true,
              ),
            );
          default:
            return const <String>['1 = 0'];
        }
      }
      return predicates;
    }

    for (final operator in _toOneRelationWhereOperatorOrder) {
      if (!relationWhere.containsKey(operator)) {
        continue;
      }
      final operand = relationWhere[operator];
      if (operand == null) {
        predicates.add(
          _buildRelationExistsPredicate(
            relation: relation,
            relatedWhere: const <String, Object?>{},
            params: params,
            outerRowRef: outerRowRef,
            negated: operator == 'is',
          ),
        );
        continue;
      }

      final relatedWhere = _normalizeRelationWhereOperand(operand);
      if (relatedWhere == null) {
        return const <String>['1 = 0'];
      }
      predicates.add(
        _buildRelationExistsPredicate(
          relation: relation,
          relatedWhere: relatedWhere,
          params: params,
          outerRowRef: outerRowRef,
          negated: operator == 'isNot',
        ),
      );
    }
    return predicates;
  }

  JsonMap? _normalizeRelationWhereOperand(Object? operand) {
    if (operand == null) {
      return const <String, Object?>{};
    }
    return _coerceWhereMap(operand);
  }

  String _buildRelationExistsPredicate({
    required ModelRelationContract relation,
    required JsonMap relatedWhere,
    required List<Object?> params,
    required String outerRowRef,
    required bool negated,
  }) {
    final relatedModel = contract.models[relation.relatedModel];
    if (relatedModel == null) {
      throw ModelNotFoundException(relation.relatedModel, contract.models.keys);
    }

    final relationRowRef = _id(_relationWhereAlias);
    final predicates = _buildRelationJoinPredicates(
      relation: relation,
      outerRowRef: outerRowRef,
      relationRowRef: relationRowRef,
    );
    if (relatedWhere.isNotEmpty) {
      predicates.add(
        _buildWhereExpression(
          model: relation.relatedModel,
          where: relatedWhere,
          params: params,
          rowRef: relationRowRef,
          fieldRefPrefix: relationRowRef,
        ),
      );
    }

    final existsSql =
        'EXISTS (SELECT 1 FROM ${_id(relatedModel.table)} AS $relationRowRef '
        'WHERE ${predicates.join(' AND ')})';
    if (negated) {
      return 'NOT $existsSql';
    }
    return existsSql;
  }

  List<String> _buildRelationJoinPredicates({
    required ModelRelationContract relation,
    required String outerRowRef,
    required String relationRowRef,
  }) {
    final predicates = <String>[];
    for (var index = 0; index < relation.sourceFields.length; index++) {
      final sourceFieldRef =
          '$outerRowRef.${_id(relation.sourceFields[index])}';
      final targetFieldRef =
          '$relationRowRef.${_id(relation.targetFields[index])}';
      predicates.add('$targetFieldRef = $sourceFieldRef');
    }
    return predicates;
  }

  Map<String, Object?>? _coerceOperatorMap(Object? value) {
    if (value is! Map) {
      return null;
    }
    if (value.isEmpty) {
      return null;
    }

    final normalized = <String, Object?>{};
    for (final entry in value.entries) {
      final key = entry.key;
      if (key is! String) {
        return null;
      }
      if (!_whereOperators.contains(key)) {
        return null;
      }
      normalized[key] = entry.value;
    }
    return normalized;
  }

  JsonMap? _coerceWhereMap(Object? value) {
    if (value is! Map) {
      return null;
    }

    final normalized = <String, Object?>{};
    for (final entry in value.entries) {
      final key = entry.key;
      if (key is! String) {
        return null;
      }
      normalized[key] = entry.value;
    }
    return normalized;
  }

  List<JsonMap>? _coerceWhereList(Object? value) {
    if (value is! List) {
      return null;
    }

    final whereList = <JsonMap>[];
    for (final item in value) {
      final where = _coerceWhereMap(item);
      if (where == null) {
        return null;
      }
      whereList.add(where);
    }
    return whereList;
  }

  void _appendWhereOperatorPredicate({
    required List<String> predicates,
    required List<Object?> params,
    required String model,
    required String field,
    required String operator,
    required Object? operand,
    required String? fieldRefPrefix,
  }) {
    final idField = _fieldReference(
      field: field,
      fieldRefPrefix: fieldRefPrefix,
    );

    switch (operator) {
      case 'equals':
        predicates.add('$idField = ?');
        params.add(
          _encodeWhereValue(model: model, field: field, value: operand),
        );
      case 'not':
        predicates.add('$idField <> ?');
        params.add(
          _encodeWhereValue(model: model, field: field, value: operand),
        );
      case 'gt':
        predicates.add('$idField > ?');
        params.add(
          _encodeWhereValue(model: model, field: field, value: operand),
        );
      case 'contains' || 'startsWith' || 'endsWith':
        final likePattern = _encodeLikePattern(
          model: model,
          field: field,
          operator: operator,
          operand: operand,
        );
        if (likePattern == null) {
          predicates.add('1 = 0');
          return;
        }
        predicates.add("$idField LIKE ? ESCAPE '\\'");
        params.add(likePattern);
      case 'gte':
        predicates.add('$idField >= ?');
        params.add(
          _encodeWhereValue(model: model, field: field, value: operand),
        );
      case 'lt':
        predicates.add('$idField < ?');
        params.add(
          _encodeWhereValue(model: model, field: field, value: operand),
        );
      case 'lte':
        predicates.add('$idField <= ?');
        params.add(
          _encodeWhereValue(model: model, field: field, value: operand),
        );
      case 'in' || 'notIn':
        final values = _coerceListOperand(operand);
        if (values.isEmpty) {
          predicates.add(operator == 'in' ? '1 = 0' : '1 = 1');
          return;
        }

        final placeholders = List<String>.filled(values.length, '?').join(', ');
        final sqlOperator = operator == 'in' ? 'IN' : 'NOT IN';
        predicates.add('$idField $sqlOperator ($placeholders)');
        for (final value in values) {
          params.add(
            _encodeWhereValue(model: model, field: field, value: value),
          );
        }
      default:
        throw StateError('Unsupported where operator: $operator');
    }
  }

  Set<String> _relationWhereOperatorsFor({
    required RelationCardinality cardinality,
  }) {
    return switch (cardinality) {
      RelationCardinality.many => _toManyRelationWhereOperators,
      RelationCardinality.one => _toOneRelationWhereOperators,
    };
  }

  String _fieldReference({
    required String field,
    required String? fieldRefPrefix,
  }) {
    if (fieldRefPrefix == null) {
      return _id(field);
    }
    return '$fieldRefPrefix.${_id(field)}';
  }

  List<Object?> _coerceListOperand(Object? value) {
    if (value is List<Object?>) {
      return value;
    }
    if (value is List) {
      return List<Object?>.from(value);
    }
    return const <Object?>[];
  }

  Object? _encodeWhereValue({
    required String model,
    required String field,
    required Object? value,
  }) {
    return _encodeValue(model: model, field: field, value: value);
  }

  String? _encodeLikePattern({
    required String model,
    required String field,
    required String operator,
    required Object? operand,
  }) {
    final encodedValue = _encodeWhereValue(
      model: model,
      field: field,
      value: operand,
    );
    if (encodedValue is! String) {
      return null;
    }

    final escaped = _escapeLikePattern(encodedValue);
    return switch (operator) {
      'contains' => '%$escaped%',
      'startsWith' => '$escaped%',
      'endsWith' => '%$escaped',
      _ => null,
    };
  }

  String _escapeLikePattern(String value) {
    return value
        .replaceAll('\\', '\\\\')
        .replaceAll('%', '\\%')
        .replaceAll('_', '\\_');
  }

  String _buildOrderByClause(List<OrmOrderBy> orderBy) {
    if (orderBy.isEmpty) {
      return '';
    }

    final clauses = orderBy.map((entry) {
      final direction = entry.order.name.toUpperCase();
      return '${_id(entry.field)} $direction';
    });

    return ' ORDER BY ${clauses.join(', ')}';
  }

  String _mergeWhereClauses(String whereClause, String predicate) {
    if (predicate.isEmpty) {
      return whereClause;
    }
    if (whereClause.isEmpty) {
      return ' WHERE $predicate';
    }
    return '$whereClause AND $predicate';
  }

  String _buildCursorWindowPredicate({
    required OrmReadPlan read,
    required List<Object?> params,
  }) {
    if (read.page?.after case final after?) {
      return _buildBoundaryPredicate(
        orderBy: read.orderBy,
        boundary: after,
        params: params,
        inclusive: false,
        before: false,
      );
    }
    if (read.page?.before case final before?) {
      return _buildBoundaryPredicate(
        orderBy: read.orderBy,
        boundary: before,
        params: params,
        inclusive: false,
        before: true,
      );
    }
    if (read.cursor case final cursor?) {
      return _buildBoundaryPredicate(
        orderBy: read.orderBy,
        boundary: cursor.values,
        params: params,
        inclusive: true,
        before: false,
      );
    }
    return '';
  }

  String _buildBoundaryPredicate({
    required List<OrmOrderBy> orderBy,
    required JsonMap boundary,
    required List<Object?> params,
    required bool inclusive,
    required bool before,
  }) {
    if (orderBy.isEmpty) {
      return '';
    }

    final equalityClauses = <String>[];
    final strictClauses = <String>[];
    for (var index = 0; index < orderBy.length; index++) {
      final prefixClauses = <String>[...equalityClauses];
      final order = orderBy[index];
      final operator = _boundaryOperator(order: order, before: before);
      prefixClauses.add('${_id(order.field)} $operator ?');
      strictClauses.add('(${prefixClauses.join(' AND ')})');

      for (var valueIndex = 0; valueIndex < index; valueIndex++) {
        params.add(boundary[orderBy[valueIndex].field]);
      }
      params.add(boundary[order.field]);

      equalityClauses.add('${_id(order.field)} = ?');
    }

    final strictPredicate = strictClauses.join(' OR ');
    if (!inclusive) {
      return '($strictPredicate)';
    }

    final equalityPredicate = equalityClauses.join(' AND ');
    for (final order in orderBy) {
      params.add(boundary[order.field]);
    }
    return '(($strictPredicate) OR ($equalityPredicate))';
  }

  String _boundaryOperator({required OrmOrderBy order, required bool before}) {
    return switch ((order.order, before)) {
      (SortOrder.asc, false) => '>',
      (SortOrder.asc, true) => '<',
      (SortOrder.desc, false) => '<',
      (SortOrder.desc, true) => '>',
    };
  }

  List<OrmOrderBy> _reverseOrderBy(List<OrmOrderBy> orderBy) {
    return orderBy
        .map(
          (entry) => OrmOrderBy(
            entry.field,
            order: entry.order == SortOrder.asc
                ? SortOrder.desc
                : SortOrder.asc,
          ),
        )
        .toList(growable: false);
  }

  String _buildReadLimitOffsetClause(OrmReadPlan plan, List<Object?> params) {
    final clauses = <String>[];
    final effectiveTake = switch (plan.resultMode) {
      OrmReadResultMode.oneOrNull => 1,
      _ => plan.page?.size ?? plan.take,
    };

    if (effectiveTake case final take?) {
      clauses.add(' LIMIT ?');
      params.add(take);
    }

    if (plan.skip case final skip?) {
      if (effectiveTake == null) {
        clauses.add(' LIMIT -1');
      }
      clauses.add(' OFFSET ?');
      params.add(skip);
    }

    return clauses.join();
  }

  String _id(String value) => '$identifierQuote$value$identifierQuote';

  List<JsonMap> _decodeRows({
    required String model,
    required List<JsonMap> rows,
  }) {
    if (rows.isEmpty) {
      return rows;
    }

    final decoded = <JsonMap>[];
    for (final row in rows) {
      decoded.add(_decodeRow(model: model, row: row));
    }
    return decoded;
  }

  JsonMap _decodeRow({required String model, required JsonMap row}) {
    final decoded = <String, Object?>{};
    for (final entry in row.entries) {
      decoded[entry.key] = _decodeValue(
        model: model,
        field: entry.key,
        value: entry.value,
      );
    }
    return decoded;
  }

  Object? _encodeValue({
    required String model,
    required String field,
    required Object? value,
  }) {
    final codec = codecResolver?.resolve(model: model, field: field);
    if (codec == null) {
      return value;
    }
    return codec.encode(value);
  }

  Object? _decodeValue({
    required String model,
    required String field,
    required Object? value,
  }) {
    final codec = codecResolver?.resolve(model: model, field: field);
    if (codec == null) {
      return value;
    }
    return codec.decode(value);
  }
}

T? _firstOrNull<T>(List<T> values) {
  if (values.isEmpty) {
    return null;
  }
  return values.first;
}
