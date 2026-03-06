part of 'client.dart';

final class _RepositoryIncludePlanner {
  final ModelDelegate _delegate;

  const _RepositoryIncludePlanner(this._delegate);

  Future<List<JsonMap>> resolve({
    required OrmAction action,
    required List<JsonMap> rows,
    required Map<String, IncludeSpec> include,
    required int depth,
    _RepositoryOperation? operation,
  }) {
    if (rows.isEmpty || include.isEmpty) {
      return Future<List<JsonMap>>.value(rows);
    }

    if (depth >= _delegate._client.maxIncludeDepth) {
      throw IncludeDepthExceededException(
        maxDepth: _delegate._client.maxIncludeDepth,
      );
    }

    final strategy = _delegate._client.includeStrategySelector(
      contract: _delegate._client.contract,
      modelName: _delegate.modelName,
      action: action,
      include: include,
      depth: depth,
    );
    final trace =
        operation ??
        _RepositoryOperation.start(kind: '${_delegate.modelName}.include');

    return switch (strategy) {
      IncludeExecutionStrategy.singleQuery => _resolveSingleQuery(
        rows: rows,
        include: include,
        depth: depth,
        operation: trace,
      ),
      IncludeExecutionStrategy.multiQuery => _resolveMultiQuery(
        rows: rows,
        include: include,
        depth: depth,
        operation: trace,
      ),
    };
  }

  Future<List<JsonMap>> _resolveSingleQuery({
    required List<JsonMap> rows,
    required Map<String, IncludeSpec> include,
    required int depth,
    required _RepositoryOperation operation,
  }) async {
    var hydrated = rows;

    for (final entry in include.entries) {
      final relationName = entry.key;
      final relationInclude = entry.value;
      final relation = _delegate._resolveRelation(
        model: _delegate.modelName,
        relationName: relationName,
      );
      final relatedDelegate = _delegate._runtime._resolveDelegate(
        relation.relatedModel,
      );
      _delegate._validateIncludePagination(include: relationInclude);

      final relatedRows = await _loadRelationRowsSingleQuery(
        relatedDelegate: relatedDelegate,
        relation: relation,
        relationInclude: relationInclude,
        depth: depth,
        operation: operation,
      );
      final rowsByRelationKey = _delegate._groupRowsByRelationFields(
        rows: relatedRows,
        fields: relation.targetFields,
      );

      final nextRows = <JsonMap>[];
      for (final row in hydrated) {
        final relationWhere = _delegate._buildRelationWhere(
          row: row,
          relation: relation,
        );
        if (relationWhere == null) {
          nextRows.add(
            _delegate._attachInclude(
              row,
              relationName,
              relation.cardinality == RelationCardinality.one
                  ? null
                  : const <JsonMap>[],
            ),
          );
          continue;
        }

        final relationKey = _delegate._buildRelationMergeKeyFromRow(
          row: relationWhere,
          fields: relation.targetFields,
        );
        final matchedRows = relationKey == null
            ? const <JsonMap>[]
            : (rowsByRelationKey[relationKey] ?? const <JsonMap>[]);
        final windowRows = _delegate._sliceRows(
          rows: matchedRows,
          skip: relationInclude.skip,
          take: relationInclude.take,
        );
        final shapedRows = relatedDelegate._shapeRows(
          windowRows,
          select: relationInclude.select,
          include: relationInclude.include,
        );
        nextRows.add(
          _delegate._attachInclude(
            row,
            relationName,
            relation.cardinality == RelationCardinality.one
                ? _firstOrNull(shapedRows)
                : shapedRows,
          ),
        );
      }

      hydrated = nextRows;
    }

    return hydrated;
  }

  Future<List<JsonMap>> _resolveMultiQuery({
    required List<JsonMap> rows,
    required Map<String, IncludeSpec> include,
    required int depth,
    required _RepositoryOperation operation,
  }) async {
    var hydrated = rows;

    for (final entry in include.entries) {
      final relationName = entry.key;
      final relationInclude = entry.value;
      final relation = _delegate._resolveRelation(
        model: _delegate.modelName,
        relationName: relationName,
      );
      final relatedDelegate = _delegate._runtime._resolveDelegate(
        relation.relatedModel,
      );

      final nextRows = <JsonMap>[];
      for (final row in hydrated) {
        final relationWhere = _delegate._buildRelationWhere(
          row: row,
          relation: relation,
        );
        if (relationWhere == null) {
          nextRows.add(
            _delegate._attachInclude(
              row,
              relationName,
              relation.cardinality == RelationCardinality.one
                  ? null
                  : const <JsonMap>[],
            ),
          );
          continue;
        }

        final relatedRows = await relatedDelegate._readAllInternal(
          action: OrmAction.read,
          where: <String, Object?>{...relationInclude.where, ...relationWhere},
          skip: relationInclude.skip,
          take: relationInclude.take,
          orderBy: relationInclude.orderBy,
          select: relationInclude.select,
          include: relationInclude.include,
          annotations: operation.nextAnnotations(
            phase: 'include.load',
            strategy: 'multiQuery',
            relation: relationName,
          ),
          includeDepth: depth + 1,
        );

        nextRows.add(
          _delegate._attachInclude(
            row,
            relationName,
            relation.cardinality == RelationCardinality.one
                ? _firstOrNull(relatedRows)
                : relatedRows,
          ),
        );
      }

      hydrated = nextRows;
    }

    return hydrated;
  }

  Future<List<JsonMap>> _loadRelationRowsSingleQuery({
    required ModelDelegate relatedDelegate,
    required ModelRelationContract relation,
    required IncludeSpec relationInclude,
    required int depth,
    required _RepositoryOperation operation,
  }) {
    final baseWhere = _delegate._buildSingleQueryRelationBaseWhere(
      includeWhere: relationInclude.where,
      relation: relation,
    );

    return relatedDelegate._readAllInternal(
      action: OrmAction.read,
      where: baseWhere,
      orderBy: relationInclude.orderBy,
      select: _delegate._buildSingleQueryRelationSelect(
        include: relationInclude,
        relation: relation,
      ),
      include: relationInclude.include,
      annotations: operation.nextAnnotations(
        phase: 'include.load',
        strategy: 'singleQuery',
        relation: relation.name,
      ),
      includeDepth: depth + 1,
    );
  }
}
