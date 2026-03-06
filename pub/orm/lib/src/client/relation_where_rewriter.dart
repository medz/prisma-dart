part of 'client.dart';

final class _RepositoryRelationWhereRewriter {
  final ModelDelegate _delegate;

  const _RepositoryRelationWhereRewriter(this._delegate);

  Future<JsonMap> rewrite({
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
