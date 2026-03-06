import 'dart:async';

import 'package:meta/meta.dart';

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
const String _aggregateEmptyAlias = '__empty';
const String _aggregateRowAlias = '__row';

final class SqlAdapter
    implements
        TargetAdapter<SqlStatement, SqlResult>,
        ExplainCapableTargetAdapter<SqlStatement, SqlResult>,
        ReadStreamCapableTargetAdapter<SqlStatement, JsonMap> {
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
  JsonMap describe(
    OrmPlan plan,
    SqlStatement request, {
    JsonMap? driverExplain,
  }) {
    return Map<String, Object?>.unmodifiable(<String, Object?>{
      'source': driverExplain == null ? 'adapter' : 'driver',
      'target': contract.target,
      'request': Map<String, Object?>.unmodifiable(<String, Object?>{
        'kind': 'sql',
        'action': request.action.name,
        'text': request.text,
        'parameterCount': request.parameters.length,
      }),
      if (driverExplain != null) 'driver': driverExplain,
    });
  }

  SqlStatement _lowerRead({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    return switch (plan.read!.shape) {
      OrmReadShape.rows => _lowerRowRead(
        plan: plan,
        table: table,
        model: model,
      ),
      OrmReadShape.aggregate => _lowerAggregateRead(
        plan: plan,
        table: table,
        model: model,
      ),
      OrmReadShape.groupedAggregate => _lowerGroupedAggregateRead(
        plan: plan,
        table: table,
        model: model,
      ),
    };
  }

  SqlStatement _lowerRowRead({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final read = plan.read!;
    if (read.distinct.isNotEmpty) {
      return _buildReadSourceQuery(
        table: table,
        model: model,
        read: read,
        selectColumns: _buildSelectColumns(read.select),
      );
    }
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

  SqlStatement _lowerAggregateRead({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final read = plan.read!;
    final aggregate = read.aggregate!;
    final selectors = _buildAggregateSelectExpressions(
      aggregate: aggregate,
      rowRef: _id('_agg'),
    );
    if (selectors.isEmpty) {
      return SqlStatement(
        action: plan.action,
        text: 'SELECT 1 AS ${_id(_aggregateEmptyAlias)}',
        parameters: const <Object?>[],
      );
    }

    final baseFields = _aggregateBaseFields(aggregate);
    final inner = _buildReadSourceQuery(
      table: table,
      model: model,
      read: read,
      selectColumns: baseFields.isEmpty
          ? '1 AS ${_id(_aggregateRowAlias)}'
          : baseFields.map(_id).join(', '),
    );
    return SqlStatement(
      action: plan.action,
      text:
          'SELECT ${selectors.join(', ')} FROM (${inner.text}) AS ${_id('_agg')}',
      parameters: inner.parameters,
    );
  }

  SqlStatement _lowerGroupedAggregateRead({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final read = plan.read!;
    final aggregate = read.aggregate!;
    final groupBy = read.groupBy!;
    final params = <Object?>[];
    final whereClause = _buildWhereClause(
      model: model,
      where: read.where,
      params: params,
    );
    final selectClauses = <String>[
      ...groupBy.by.map((field) => _id(field)),
      ..._buildAggregateSelectExpressions(aggregate: aggregate, rowRef: null),
    ];
    final groupByClause = groupBy.by.map(_id).join(', ');
    final havingClause = _buildGroupedHavingClause(
      having: groupBy.having,
      params: params,
    );
    final orderByClause = _buildGroupedOrderByClause(groupBy.orderBy);
    final paginationClause = _buildGroupedLimitOffsetClause(
      skip: groupBy.skip,
      take: groupBy.take,
      params: params,
    );
    return SqlStatement(
      action: plan.action,
      text:
          'SELECT ${selectClauses.join(', ')} FROM ${_id(table)}'
          '$whereClause GROUP BY $groupByClause$havingClause$orderByClause$paginationClause',
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

  @override
  Stream<Object?> decodeReadRows(Stream<JsonMap> rows, OrmPlan plan) async* {
    await for (final rawRow in rows) {
      if (codecResolver == null) {
        yield rawRow;
        continue;
      }
      yield _decodeRow(model: plan.model, row: rawRow);
    }
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
    final read = plan.read!;
    return switch (read.shape) {
      OrmReadShape.rows => switch (read.resultMode) {
        OrmReadResultMode.firstOrNull ||
        OrmReadResultMode.oneOrNull => EngineResponse.buffered(
          _firstOrNull(rows),
          affectedRows: affectedRows,
        ),
        _ => EngineResponse.buffered(rows, affectedRows: affectedRows),
      },
      OrmReadShape.aggregate => EngineResponse.buffered(
        _decodeAggregateResult(read: read, row: _firstOrNull(rows)),
        affectedRows: affectedRows,
      ),
      OrmReadShape.groupedAggregate => EngineResponse.buffered(
        rows
            .map((row) => _decodeGroupedAggregateRow(read: read, row: row))
            .toList(growable: false),
        affectedRows: affectedRows,
      ),
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

  String _buildAllModelColumns(ModelContract model) {
    final fields = model.fields.toList(growable: false)..sort();
    return fields.map(_id).join(', ');
  }

  List<String> _aggregateBaseFields(OrmReadAggregatePlan aggregate) {
    final fields = <String>{
      ...aggregate.count,
      ...aggregate.min,
      ...aggregate.max,
      ...aggregate.sum,
      ...aggregate.avg,
    };
    return fields.toList(growable: false);
  }

  List<String> _buildAggregateSelectExpressions({
    required OrmReadAggregatePlan aggregate,
    required String? rowRef,
  }) {
    final expressions = <String>[];
    if (aggregate.countAll) {
      expressions.add(
        'COUNT(*) AS ${_id(_aggregateAlias(bucket: 'count', field: 'all'))}',
      );
    }
    for (final field in aggregate.count) {
      expressions.add(
        'COUNT(${_aggregateFieldReference(field: field, rowRef: rowRef)}) '
        'AS ${_id(_aggregateAlias(bucket: 'count', field: field))}',
      );
    }
    for (final field in aggregate.min) {
      expressions.add(
        'MIN(${_aggregateFieldReference(field: field, rowRef: rowRef)}) '
        'AS ${_id(_aggregateAlias(bucket: 'min', field: field))}',
      );
    }
    for (final field in aggregate.max) {
      expressions.add(
        'MAX(${_aggregateFieldReference(field: field, rowRef: rowRef)}) '
        'AS ${_id(_aggregateAlias(bucket: 'max', field: field))}',
      );
    }
    for (final field in aggregate.sum) {
      expressions.add(
        'SUM(${_aggregateFieldReference(field: field, rowRef: rowRef)}) '
        'AS ${_id(_aggregateAlias(bucket: 'sum', field: field))}',
      );
    }
    for (final field in aggregate.avg) {
      expressions.add(
        'AVG(${_aggregateFieldReference(field: field, rowRef: rowRef)}) '
        'AS ${_id(_aggregateAlias(bucket: 'avg', field: field))}',
      );
    }
    return expressions;
  }

  String _aggregateFieldReference({
    required String field,
    required String? rowRef,
  }) {
    if (rowRef == null) {
      return _id(field);
    }
    return '$rowRef.${_id(field)}';
  }

  String _aggregateAlias({required String bucket, required String field}) {
    return '__${bucket}_$field';
  }

  String _buildMutationReturningClause(List<String> select) {
    if (!contract.capabilities.mutationReturning) {
      return '';
    }

    return ' RETURNING ${_buildSelectColumns(select)}';
  }

  SqlStatement _buildReadSourceQuery({
    required String table,
    required String model,
    required OrmReadPlan read,
    required String selectColumns,
  }) {
    if (read.distinct.isNotEmpty) {
      return _buildDistinctReadSourceQuery(
        table: table,
        model: model,
        read: read,
        selectColumns: selectColumns,
      );
    }
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
      final innerOrderByClause = _buildOrderByClause(
        _reverseOrderBy(read.orderBy),
      );
      final innerLimitClause = _buildReadLimitOffsetClause(read, limitParams);
      return SqlStatement(
        action: OrmAction.read,
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
      action: OrmAction.read,
      text:
          'SELECT $selectColumns FROM ${_id(table)}'
          '$mergedWhereClause$orderByClause${_buildReadLimitOffsetClause(read, params)}',
      parameters: params,
    );
  }

  SqlStatement _buildDistinctReadSourceQuery({
    required String table,
    required String model,
    required OrmReadPlan read,
    required String selectColumns,
  }) {
    final modelContract = contract.models[model];
    if (modelContract == null) {
      throw ModelNotFoundException(model, contract.models.keys);
    }

    final sourceColumns = _buildAllModelColumns(modelContract);
    final resolvedSelectColumns = selectColumns == '*'
        ? sourceColumns
        : selectColumns;
    final whereParams = <Object?>[];
    final whereClause = _buildWhereClause(
      model: model,
      where: read.where,
      params: whereParams,
    );
    final partitionOrder = _buildOrderByClause(
      read.orderBy.isEmpty
          ? read.distinct
                .map((field) => OrmOrderBy(field))
                .toList(growable: false)
          : read.orderBy,
    );
    final distinctPartition = read.distinct.map(_id).join(', ');
    final baseQuery =
        'SELECT $sourceColumns, '
        'ROW_NUMBER() OVER (PARTITION BY $distinctPartition$partitionOrder) '
        'AS ${_id('_distinct_rank')} '
        'FROM ${_id(table)}$whereClause';
    final rankWhere = ' WHERE ${_id('_distinct_rank')} = 1';
    final windowParams = <Object?>[];
    final windowPredicate = _buildCursorWindowPredicate(
      read: read,
      params: windowParams,
    );
    final mergedWhereClause = _mergeWhereClauses(rankWhere, windowPredicate);
    final orderByClause = _buildOrderByClause(read.orderBy);

    if (read.page?.before != null) {
      final limitParams = <Object?>[];
      final innerOrderByClause = _buildOrderByClause(
        _reverseOrderBy(read.orderBy),
      );
      final innerLimitClause = _buildReadLimitOffsetClause(read, limitParams);
      return SqlStatement(
        action: OrmAction.read,
        text:
            'SELECT $resolvedSelectColumns FROM ('
            'SELECT * FROM ($baseQuery) AS ${_id('_distinct')}$mergedWhereClause'
            '$innerOrderByClause$innerLimitClause'
            ') AS ${_id('_page')}$orderByClause',
        parameters: <Object?>[...whereParams, ...windowParams, ...limitParams],
      );
    }

    final params = <Object?>[...whereParams, ...windowParams];
    return SqlStatement(
      action: OrmAction.read,
      text:
          'SELECT $resolvedSelectColumns FROM ($baseQuery) AS ${_id('_distinct')}'
          '$mergedWhereClause$orderByClause${_buildReadLimitOffsetClause(read, params)}',
      parameters: params,
    );
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

  String _buildGroupedOrderByClause(List<OrmOrderBy> orderBy) {
    if (orderBy.isEmpty) {
      return '';
    }
    final clauses = orderBy.map((entry) {
      final direction = entry.order.name.toUpperCase();
      return '${_groupedOrderByExpression(entry.field)} $direction';
    });
    return ' ORDER BY ${clauses.join(', ')}';
  }

  String _groupedOrderByExpression(String field) {
    final metric = _parseGroupedMetricField(field);
    if (metric == null) {
      return _id(field);
    }
    return _id(_aggregateAlias(bucket: metric.bucket, field: metric.field));
  }

  String _buildGroupedHavingClause({
    required OrmGroupByHaving having,
    required List<Object?> params,
  }) {
    if (having.isEmpty) {
      return '';
    }
    return ' HAVING ${_buildGroupedHavingExpression(having: having, params: params)}';
  }

  String _buildGroupedHavingExpression({
    required OrmGroupByHaving having,
    required List<Object?> params,
  }) {
    final predicates = <String>[];
    for (final node in having.nodes) {
      switch (node) {
        case OrmGroupByHavingLogicalNode():
          predicates.add(
            _buildGroupedHavingLogicalPredicate(node: node, params: params),
          );
        case OrmGroupByHavingPredicateNode():
          predicates.add(
            _buildGroupedHavingConditionPredicate(
              leftOperand: node.bucket == null
                  ? _id(node.field)
                  : _aggregateFunctionExpression(
                      bucket: _groupByMetricBucketName(node.bucket!),
                      field: node.field,
                      rowRef: null,
                    ),
              field: node.field,
              condition: node.condition,
              params: params,
            ),
          );
      }
    }
    if (predicates.isEmpty) {
      return '1 = 1';
    }
    return predicates.join(' AND ');
  }

  String _buildGroupedHavingLogicalPredicate({
    required OrmGroupByHavingLogicalNode node,
    required List<Object?> params,
  }) {
    if (node.clauses.isEmpty) {
      return node.operator == OrmGroupByHavingLogicalOperator.or
          ? '0 = 1'
          : '1 = 1';
    }
    final joiner = node.operator == OrmGroupByHavingLogicalOperator.or
        ? ' OR '
        : ' AND ';
    final clauses = node.clauses
        .map(
          (clause) =>
              _buildGroupedHavingExpression(having: clause, params: params),
        )
        .map((clause) => '($clause)')
        .join(joiner);
    return node.operator == OrmGroupByHavingLogicalOperator.not
        ? 'NOT ($clauses)'
        : clauses;
  }

  String _buildGroupedHavingConditionPredicate({
    required String leftOperand,
    required String field,
    required OrmGroupByHavingCondition condition,
    required List<Object?> params,
  }) {
    if (condition.shorthand != null) {
      params.add(condition.shorthand);
      return '$leftOperand = ?';
    }
    if (condition.isEmpty) {
      return '1 = 1';
    }

    final predicates = <String>[];
    for (final operator in _whereOperatorOrder) {
      final operand = switch (operator) {
        'equals' => condition.equals,
        'not' => condition.not,
        'in' => condition.inValues,
        'notIn' => condition.notInValues,
        'contains' => condition.contains,
        'startsWith' => condition.startsWith,
        'endsWith' => condition.endsWith,
        'gt' => condition.gt,
        'gte' => condition.gte,
        'lt' => condition.lt,
        'lte' => condition.lte,
        _ => null,
      };
      if (operand == null) {
        continue;
      }
      predicates.add(
        _buildGroupedHavingOperatorPredicate(
          leftOperand: leftOperand,
          field: field,
          operator: operator,
          operand: operand,
          params: params,
        ),
      );
    }
    if (predicates.isEmpty) {
      return '1 = 1';
    }
    return predicates.join(' AND ');
  }

  String _buildGroupedHavingOperatorPredicate({
    required String leftOperand,
    required String field,
    required String operator,
    required Object? operand,
    required List<Object?> params,
  }) {
    switch (operator) {
      case 'equals':
        params.add(operand);
        return '$leftOperand = ?';
      case 'not':
        if (operand is Map) {
          final predicate = _buildGroupedHavingConditionPredicate(
            leftOperand: leftOperand,
            field: field,
            condition: OrmGroupByHavingCondition.parse(operand),
            params: params,
          );
          return 'NOT ($predicate)';
        }
        params.add(operand);
        return '$leftOperand <> ?';
      case 'in':
        final values = _coerceListOperand(operand);
        if (values.isEmpty) {
          return '0 = 1';
        }
        params.addAll(values);
        return '$leftOperand IN (${List<String>.filled(values.length, '?').join(', ')})';
      case 'notIn':
        final values = _coerceListOperand(operand);
        if (values.isEmpty) {
          return '1 = 1';
        }
        params.addAll(values);
        return '$leftOperand NOT IN (${List<String>.filled(values.length, '?').join(', ')})';
      case 'contains':
      case 'startsWith':
      case 'endsWith':
        if (operand is! String) {
          return '0 = 1';
        }
        final escaped = _escapeLikePattern(operand);
        final pattern = switch (operator) {
          'contains' => '%$escaped%',
          'startsWith' => '$escaped%',
          'endsWith' => '%$escaped',
          _ => escaped,
        };
        params.add(pattern);
        return "$leftOperand LIKE ? ESCAPE '\\'";
      case 'gt':
        params.add(operand);
        return '$leftOperand > ?';
      case 'gte':
        params.add(operand);
        return '$leftOperand >= ?';
      case 'lt':
        params.add(operand);
        return '$leftOperand < ?';
      case 'lte':
        params.add(operand);
        return '$leftOperand <= ?';
      default:
        return '1 = 1';
    }
  }

  String _groupByMetricBucketName(OrmGroupByHavingMetricBucket bucket) {
    return switch (bucket) {
      OrmGroupByHavingMetricBucket.count => 'count',
      OrmGroupByHavingMetricBucket.min => 'min',
      OrmGroupByHavingMetricBucket.max => 'max',
      OrmGroupByHavingMetricBucket.sum => 'sum',
      OrmGroupByHavingMetricBucket.avg => 'avg',
    };
  }

  String _buildGroupedLimitOffsetClause({
    required int? skip,
    required int? take,
    required List<Object?> params,
  }) {
    final clauses = <String>[];
    if (take case final limit?) {
      clauses.add(' LIMIT ?');
      params.add(limit);
    }
    if (skip case final offset?) {
      if (take == null) {
        clauses.add(' LIMIT -1');
      }
      clauses.add(' OFFSET ?');
      params.add(offset);
    }
    return clauses.join();
  }

  _GroupedMetricField? _parseGroupedMetricField(String field) {
    final parts = field.split('.');
    if (parts.length != 2) {
      return null;
    }
    final bucket = _normalizeGroupedMetricBucket(parts[0]);
    if (bucket == null) {
      return null;
    }
    return _GroupedMetricField(bucket: bucket, field: parts[1]);
  }

  String? _normalizeGroupedMetricBucket(String bucket) {
    return switch (bucket) {
      'count' || '_count' => 'count',
      'min' || '_min' => 'min',
      'max' || '_max' => 'max',
      'sum' || '_sum' => 'sum',
      'avg' || '_avg' => 'avg',
      _ => null,
    };
  }

  String _aggregateFunctionExpression({
    required String bucket,
    required String field,
    required String? rowRef,
  }) {
    final fieldRef = field == 'all' && bucket == 'count'
        ? '*'
        : _aggregateFieldReference(field: field, rowRef: rowRef);
    return switch (bucket) {
      'count' => field == 'all' ? 'COUNT(*)' : 'COUNT($fieldRef)',
      'min' => 'MIN($fieldRef)',
      'max' => 'MAX($fieldRef)',
      'sum' => 'SUM($fieldRef)',
      'avg' => 'AVG($fieldRef)',
      _ => throw StateError('Unsupported aggregate bucket: $bucket'),
    };
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

  JsonMap _decodeAggregateResult({
    required OrmReadPlan read,
    required JsonMap? row,
  }) {
    final aggregate = read.aggregate!;
    if (!aggregate.countAll &&
        aggregate.count.isEmpty &&
        aggregate.min.isEmpty &&
        aggregate.max.isEmpty &&
        aggregate.sum.isEmpty &&
        aggregate.avg.isEmpty) {
      return const <String, Object?>{};
    }

    final source = row ?? const <String, Object?>{};
    final result = <String, Object?>{};
    if (aggregate.countAll || aggregate.count.isNotEmpty) {
      result['count'] = <String, Object?>{
        if (aggregate.countAll)
          'all': source[_aggregateAlias(bucket: 'count', field: 'all')] ?? 0,
        for (final field in aggregate.count)
          field: source[_aggregateAlias(bucket: 'count', field: field)] ?? 0,
      };
    }
    if (aggregate.min.isNotEmpty) {
      result['min'] = <String, Object?>{
        for (final field in aggregate.min)
          field: source[_aggregateAlias(bucket: 'min', field: field)],
      };
    }
    if (aggregate.max.isNotEmpty) {
      result['max'] = <String, Object?>{
        for (final field in aggregate.max)
          field: source[_aggregateAlias(bucket: 'max', field: field)],
      };
    }
    if (aggregate.sum.isNotEmpty) {
      result['sum'] = <String, Object?>{
        for (final field in aggregate.sum)
          field: source[_aggregateAlias(bucket: 'sum', field: field)],
      };
    }
    if (aggregate.avg.isNotEmpty) {
      result['avg'] = <String, Object?>{
        for (final field in aggregate.avg)
          field: source[_aggregateAlias(bucket: 'avg', field: field)],
      };
    }
    return Map<String, Object?>.unmodifiable(result);
  }

  JsonMap _decodeGroupedAggregateRow({
    required OrmReadPlan read,
    required JsonMap row,
  }) {
    final groupBy = read.groupBy!;
    final result = <String, Object?>{
      for (final field in groupBy.by) field: row[field],
    };
    result.addAll(_decodeAggregateResult(read: read, row: row));
    return Map<String, Object?>.unmodifiable(result);
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

@immutable
final class _GroupedMetricField {
  final String bucket;
  final String field;

  const _GroupedMetricField({required this.bucket, required this.field});
}

T? _firstOrNull<T>(List<T> values) {
  if (values.isEmpty) {
    return null;
  }
  return values.first;
}
