part of 'client.dart';

@immutable
final class _PreparedReadPlan {
  final OrmPlan plan;
  final Map<String, IncludeSpec> include;

  const _PreparedReadPlan({required this.plan, required this.include});
}

final class _OrmReadPlanCompiler {
  final ModelDelegate _delegate;

  _OrmReadPlanCompiler(this._delegate);

  Future<_PreparedReadPlan> compile({
    required OrmReadResultMode resultMode,
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    JsonMap? cursor,
    OrmReadPagePlan? page,
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
  }) async {
    if (skip case final offset? when offset < 0) {
      throw PlanInvalidPaginationException(key: 'skip', value: offset);
    }
    if (take case final limit? when limit < 0) {
      throw PlanInvalidPaginationException(key: 'take', value: limit);
    }

    final normalizedInclude = normalizeInclude(include);
    final normalizedWhere = await normalizeWhereForExecution(
      model: _delegate.modelName,
      where: where,
    );
    if ((cursor != null || page != null) && orderBy.isEmpty) {
      throw runtimeError(
        'PLAN.CURSOR_ORDER_BY_REQUIRED',
        'Cursor and page windows require orderBy() first.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          if (cursor != null) 'cursor': cursor,
          if (page != null) 'page': page.toJson(),
        },
      );
    }
    if (cursor != null || page != null) {
      validateStableCursorOrderBy(orderBy: orderBy);
    }
    if ((cursor != null || page != null) && distinct.isNotEmpty) {
      throw runtimeError(
        'PLAN.CURSOR_DISTINCT_UNSUPPORTED',
        'Cursor and page windows do not support distinct yet.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'distinct': distinct,
          if (cursor != null) 'cursor': cursor,
          if (page != null) 'page': page.toJson(),
        },
      );
    }
    if (page != null && resultMode != OrmReadResultMode.all) {
      throw runtimeError(
        'PLAN.PAGE_RESULT_MODE_INVALID',
        'Page windows currently compile only to collection read plans.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'resultMode': resultMode.name,
          'page': page.toJson(),
        },
      );
    }

    final isCollectionRead = resultMode != OrmReadResultMode.oneOrNull;
    final resolvedTake = page != null
        ? null
        : resultMode == OrmReadResultMode.firstOrNull
        ? 1
        : take;
    final readSelect = switch (resultMode) {
      OrmReadResultMode.oneOrNull => expandSelectForInclude(
        model: _delegate.modelName,
        select: select,
        include: normalizedInclude,
      ),
      OrmReadResultMode.all ||
      OrmReadResultMode.firstOrNull => expandSelectForExecution(
        model: _delegate.modelName,
        select: select,
        include: normalizedInclude,
        distinct: distinct,
      ),
    };

    return _PreparedReadPlan(
      include: normalizedInclude,
      plan: OrmPlan.read(
        contractHash: _delegate._client.contract.hash,
        target: _delegate._client.contract.target,
        storageHash: _delegate._client.contract.markerStorageHash,
        profileHash: _delegate._client.contract.profileHash,
        lane: 'orm',
        annotations: _mergePlanAnnotations(
          annotations,
          distinct.isEmpty
              ? const <String, Object?>{}
              : <String, Object?>{
                  'distinct': List<String>.from(distinct, growable: false),
                },
        ),
        repositoryTrace: repositoryTrace,
        model: _delegate.modelName,
        where: normalizedWhere,
        skip: isCollectionRead && distinct.isEmpty ? skip : null,
        take: isCollectionRead && distinct.isEmpty ? resolvedTake : null,
        orderBy: isCollectionRead ? orderBy : const <OrmOrderBy>[],
        distinct: isCollectionRead ? distinct : const <String>[],
        select: readSelect,
        include: _buildOrmIncludePlanMap(normalizedInclude),
        cursor: cursor == null ? null : OrmReadCursorPlan(values: cursor),
        page: page,
        resultMode: resultMode,
      ),
    );
  }

  void validateStableCursorOrderBy({required List<OrmOrderBy> orderBy}) {
    final model = _delegate._client.contract.models[_delegate.modelName];
    if (model == null) {
      throw ModelNotFoundException(
        _delegate.modelName,
        _delegate._client.contract.models.keys,
      );
    }

    final idFields = model.idFields;
    if (idFields.isEmpty) {
      return;
    }
    if (orderBy.length < idFields.length) {
      _throwStableCursorOrderError(orderBy: orderBy, idFields: idFields);
    }

    final suffix = orderBy
        .sublist(orderBy.length - idFields.length)
        .map((entry) => entry.field)
        .toList(growable: false);
    if (_listEquals(suffix, idFields)) {
      return;
    }

    _throwStableCursorOrderError(orderBy: orderBy, idFields: idFields);
  }

  List<String> expandSelectForExecution({
    required String model,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required List<String> distinct,
  }) {
    if (select.isEmpty) {
      return select;
    }

    if (include.isEmpty && distinct.isEmpty) {
      return select;
    }

    final expanded = <String>{...select, ...distinct};
    if (include.isNotEmpty) {
      for (final relationName in include.keys) {
        final relation = _delegate._resolveRelation(
          model: model,
          relationName: relationName,
        );
        expanded.addAll(relation.sourceFields);
      }
    }

    return expanded.toList(growable: false);
  }

  List<String> expandSelectForInclude({
    required String model,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    return expandSelectForExecution(
      model: model,
      select: select,
      include: include,
      distinct: const <String>[],
    );
  }

  Map<String, IncludeSpec> normalizeInclude(Map<String, IncludeSpec> include) {
    if (include.isEmpty) {
      return const <String, IncludeSpec>{};
    }
    return include;
  }

  Future<JsonMap> normalizeWhereForExecution({
    required String model,
    required JsonMap where,
  }) async {
    if (where.isEmpty) {
      return const <String, Object?>{};
    }
    if (_delegate._client.contract.target == 'sql-family') {
      return where;
    }
    return _rewriteRelationWhere(model: model, where: where);
  }

  Never _throwStableCursorOrderError({
    required List<OrmOrderBy> orderBy,
    required List<String> idFields,
  }) {
    throw runtimeError(
      'PLAN.CURSOR_STABLE_ORDER_REQUIRED',
      'Cursor and page windows require orderBy() to end with the model id fields.',
      details: <String, Object?>{
        'model': _delegate.modelName,
        'idFields': idFields,
        'orderBy': orderBy
            .map((entry) => entry.toJson())
            .toList(growable: false),
      },
    );
  }

  Future<JsonMap> _rewriteRelationWhere({
    required String model,
    required JsonMap where,
  }) async {
    if (where.isEmpty) {
      return const <String, Object?>{};
    }

    final modelContract = _delegate._client.contract.models[model];
    if (modelContract == null) {
      throw ModelNotFoundException(
        model,
        _delegate._client.contract.models.keys,
      );
    }

    final normalizedWhere = <String, Object?>{};
    final relationClauses = <JsonMap>[];
    for (final entry in where.entries) {
      final key = entry.key;
      if (_whereLogicalKeys.contains(key)) {
        normalizedWhere[key] = await _normalizeWhereLogicalOperand(
          model: model,
          operand: entry.value,
        );
        continue;
      }

      final relation = modelContract.relations[key];
      if (relation == null) {
        normalizedWhere[key] = entry.value;
        continue;
      }

      final relationWhere = _coerceWhereMap(entry.value);
      if (relationWhere == null) {
        final supportedOperators = _relationWhereOperatorsFor(
          cardinality: relation.cardinality,
        );
        throw runtimeError(
          'PLAN.RELATION_WHERE_INVALID',
          'Relation where expects a map of operators.',
          details: <String, Object?>{
            'model': model,
            'relation': key,
            'expectedOperators': supportedOperators.toList(growable: false),
          },
        );
      }

      final clause = await _compileRelationWhereClause(
        relationName: key,
        relation: relation,
        where: relationWhere,
      );
      if (clause != null) {
        relationClauses.add(clause);
      }
    }

    for (final clause in relationClauses) {
      _appendAndWhereClause(where: normalizedWhere, clause: clause);
    }

    return normalizedWhere;
  }

  Future<Object?> _normalizeWhereLogicalOperand({
    required String model,
    required Object? operand,
  }) async {
    final nestedWhere = _coerceWhereMap(operand);
    if (nestedWhere != null) {
      return _rewriteRelationWhere(model: model, where: nestedWhere);
    }

    final nestedWhereList = _coerceWhereList(operand);
    if (nestedWhereList == null) {
      return operand;
    }

    final normalized = <JsonMap>[];
    for (final entry in nestedWhereList) {
      normalized.add(await _rewriteRelationWhere(model: model, where: entry));
    }
    return normalized;
  }

  Future<JsonMap?> _compileRelationWhereClause({
    required String relationName,
    required ModelRelationContract relation,
    required JsonMap where,
  }) async {
    if (where.isEmpty) {
      return null;
    }

    final supportedOperators = _relationWhereOperatorsFor(
      cardinality: relation.cardinality,
    );
    final unknownOperators = where.keys
        .where((key) => !supportedOperators.contains(key))
        .toList(growable: false);
    if (unknownOperators.isNotEmpty) {
      throw runtimeError(
        'PLAN.RELATION_WHERE_OPERATOR_INVALID',
        'Relation where contains unknown operators.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'relation': relationName,
          'unknownOperators': unknownOperators,
          'supportedOperators': supportedOperators.toList(growable: false),
        },
      );
    }

    final clauses = <JsonMap>[];
    if (relation.cardinality == RelationCardinality.many) {
      if (where.containsKey('some')) {
        final relationWhere = await _normalizeRelationOperatorWhere(
          relationName: relationName,
          relation: relation,
          operator: 'some',
          operand: where['some'],
        );
        clauses.add(
          await _buildRelationMembershipClause(
            relation: relation,
            relatedWhere: relationWhere,
            include: true,
          ),
        );
      }

      if (where.containsKey('none')) {
        final relationWhere = await _normalizeRelationOperatorWhere(
          relationName: relationName,
          relation: relation,
          operator: 'none',
          operand: where['none'],
        );
        clauses.add(
          await _buildRelationMembershipClause(
            relation: relation,
            relatedWhere: relationWhere,
            include: false,
          ),
        );
      }

      if (where.containsKey('every')) {
        final relationWhere = await _normalizeRelationOperatorWhere(
          relationName: relationName,
          relation: relation,
          operator: 'every',
          operand: where['every'],
        );
        clauses.add(
          await _buildRelationMembershipClause(
            relation: relation,
            relatedWhere: <String, Object?>{'NOT': relationWhere},
            include: false,
          ),
        );
      }
    } else {
      if (where.containsKey('is')) {
        final isOperand = where['is'];
        if (isOperand == null) {
          clauses.add(
            await _buildRelationMembershipClause(
              relation: relation,
              relatedWhere: const <String, Object?>{},
              include: false,
            ),
          );
        } else {
          final relationWhere = await _normalizeRelationOperatorWhere(
            relationName: relationName,
            relation: relation,
            operator: 'is',
            operand: isOperand,
          );
          clauses.add(
            await _buildRelationMembershipClause(
              relation: relation,
              relatedWhere: relationWhere,
              include: true,
            ),
          );
        }
      }

      if (where.containsKey('isNot')) {
        final isNotOperand = where['isNot'];
        if (isNotOperand == null) {
          clauses.add(
            await _buildRelationMembershipClause(
              relation: relation,
              relatedWhere: const <String, Object?>{},
              include: true,
            ),
          );
        } else {
          final relationWhere = await _normalizeRelationOperatorWhere(
            relationName: relationName,
            relation: relation,
            operator: 'isNot',
            operand: isNotOperand,
          );
          clauses.add(
            await _buildRelationMembershipClause(
              relation: relation,
              relatedWhere: relationWhere,
              include: false,
            ),
          );
        }
      }
    }

    if (clauses.isEmpty) {
      return null;
    }
    if (clauses.length == 1) {
      return clauses.single;
    }
    return <String, Object?>{'AND': clauses};
  }

  Future<JsonMap> _normalizeRelationOperatorWhere({
    required String relationName,
    required ModelRelationContract relation,
    required String operator,
    required Object? operand,
  }) async {
    if (operand == null) {
      return const <String, Object?>{};
    }

    final nestedWhere = _coerceWhereMap(operand);
    if (nestedWhere == null) {
      throw runtimeError(
        'PLAN.RELATION_WHERE_VALUE_INVALID',
        'Relation where operator expects a nested where map.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'relation': relationName,
          'operator': operator,
        },
      );
    }

    return _rewriteRelationWhere(
      model: relation.relatedModel,
      where: nestedWhere,
    );
  }

  Future<JsonMap> _buildRelationMembershipClause({
    required ModelRelationContract relation,
    required JsonMap relatedWhere,
    required bool include,
  }) async {
    final relatedRows = await _delegate._runtime
        ._resolveDelegate(relation.relatedModel)
        ._readAllInternal(
          action: OrmAction.read,
          where: relatedWhere,
          select: relation.targetFields,
          includeDepth: 0,
        );

    final keys = <_RelationMergeKey>{};
    for (final row in relatedRows) {
      final key = _delegate._buildRelationMergeKeyFromRow(
        row: row,
        fields: relation.targetFields,
      );
      if (key != null) {
        keys.add(key);
      }
    }

    return _buildRelationTupleMembershipWhere(
      sourceFields: relation.sourceFields,
      keys: keys,
      include: include,
    );
  }

  JsonMap _buildRelationTupleMembershipWhere({
    required List<String> sourceFields,
    required Set<_RelationMergeKey> keys,
    required bool include,
  }) {
    if (keys.isEmpty) {
      return include
          ? const <String, Object?>{'OR': <JsonMap>[]}
          : const <String, Object?>{'AND': <JsonMap>[]};
    }

    if (sourceFields.length == 1) {
      final field = sourceFields.single;
      final values = keys
          .map((key) => key.parts.single)
          .toList(growable: false);
      return <String, Object?>{
        field: <String, Object?>{include ? 'in' : 'notIn': values},
      };
    }

    final tupleClauses = keys
        .map((key) {
          final where = <String, Object?>{};
          for (var index = 0; index < sourceFields.length; index++) {
            where[sourceFields[index]] = key.parts[index];
          }
          return where;
        })
        .toList(growable: false);

    if (include) {
      return <String, Object?>{'OR': tupleClauses};
    }

    return <String, Object?>{
      'NOT': <String, Object?>{'OR': tupleClauses},
    };
  }

  void _appendAndWhereClause({
    required JsonMap where,
    required JsonMap clause,
  }) {
    if (clause.isEmpty) {
      return;
    }

    final existing = where['AND'];
    if (existing == null) {
      where['AND'] = <JsonMap>[clause];
      return;
    }

    final existingMap = _coerceWhereMap(existing);
    if (existingMap != null) {
      where['AND'] = <JsonMap>[existingMap, clause];
      return;
    }

    final existingList = _coerceWhereList(existing);
    if (existingList != null) {
      where['AND'] = <JsonMap>[...existingList, clause];
      return;
    }

    where['AND'] = <JsonMap>[clause];
  }

  Set<String> _relationWhereOperatorsFor({
    required RelationCardinality cardinality,
  }) {
    return switch (cardinality) {
      RelationCardinality.many => _toManyRelationWhereOperators,
      RelationCardinality.one => _toOneRelationWhereOperators,
    };
  }
}
