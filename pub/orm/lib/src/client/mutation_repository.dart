part of 'client.dart';

@immutable
final class _PreparedMutationPlan {
  final OrmPlan plan;
  final Map<String, IncludeSpec> include;

  const _PreparedMutationPlan({required this.plan, required this.include});
}

@immutable
final class _NormalizedMutationInput {
  final JsonMap where;
  final List<String> select;
  final Map<String, IncludeSpec> include;

  const _NormalizedMutationInput({
    required this.where,
    required this.select,
    required this.include,
  });
}

final class _RepositoryMutationExecutor {
  final ModelDelegate _delegate;

  const _RepositoryMutationExecutor(this._delegate);

  _RepositoryOperation _startOperation(String kind) {
    return _RepositoryOperation.start(kind: '${_delegate.modelName}.$kind');
  }

  Future<JsonMap> create({
    required JsonMap data,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    _RepositoryOperation? operation,
    String phase = 'write',
    String strategy = 'singlePlan',
    String? relation,
    int? itemIndex,
  }) async {
    final trace = operation ?? _startOperation('create');
    final normalized = await _normalizeMutationInput(
      where: const <String, Object?>{},
      select: select,
      include: include,
    );
    final prepared = _composeMutationPlan(
      action: OrmAction.create,
      mutationResultMode: OrmMutationResultMode.row,
      data: data,
      normalized: normalized,
      repositoryTrace: trace.nextTrace(
        phase: phase,
        strategy: strategy,
        relation: relation,
        itemIndex: itemIndex,
      ),
    );
    final normalizedInclude = prepared.include;
    final response = await _delegate._client.execute(prepared.plan);

    var row = _readRow(response.data, action: 'create');
    if (row == null) {
      if (_delegate._client.contract.capabilities.mutationReturning &&
          response.affectedRows > 0) {
        throw RuntimeCreateResultMissingException(model: _delegate.modelName);
      }
      row = _delegate._fallbackCreateRow(data: data);
    }

    if (row == null) {
      throw RuntimeCreateResultMissingException(model: _delegate.modelName);
    }

    return _shapeMutationRow(
      action: OrmAction.create,
      row: row,
      select: select,
      include: normalizedInclude,
    );
  }

  Future<JsonMap?> update({
    required JsonMap where,
    required JsonMap data,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    _RepositoryOperation? operation,
    String phase = 'write',
    String strategy = 'singlePlan',
    String? relation,
    int? itemIndex,
  }) {
    final trace = operation ?? _startOperation('update');
    return _runNullableMutation(
      action: OrmAction.update,
      mutationResultMode: OrmMutationResultMode.rowOrNull,
      where: where,
      data: data,
      select: select,
      include: include,
      responseAction: 'update',
      operation: trace,
      phase: phase,
      strategy: strategy,
      relation: relation,
      itemIndex: itemIndex,
    );
  }

  Future<JsonMap?> delete({
    required JsonMap where,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    _RepositoryOperation? operation,
    String phase = 'write',
    String strategy = 'singlePlan',
    int? itemIndex,
  }) {
    final trace = operation ?? _startOperation('delete');
    return _runNullableMutation(
      action: OrmAction.delete,
      mutationResultMode: OrmMutationResultMode.rowOrNull,
      where: where,
      data: const <String, Object?>{},
      select: select,
      include: include,
      responseAction: 'delete',
      operation: trace,
      phase: phase,
      strategy: strategy,
      itemIndex: itemIndex,
    );
  }

  Future<JsonMap> createNested({
    required JsonMap data,
    required Map<String, List<JsonMap>> nestedCreate,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    final trace = _startOperation('createNested');
    return _delegate._client.transaction((txDb) async {
      final scoped = txDb.orm.model(_delegate.modelName);
      return _RepositoryMutationExecutor(scoped)._createNestedInScope(
        data: data,
        nestedCreate: nestedCreate,
        select: select,
        include: include,
        operation: trace,
      );
    });
  }

  Future<JsonMap?> updateNested({
    required JsonMap where,
    required JsonMap data,
    required Map<String, List<JsonMap>> nestedCreate,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    final trace = _startOperation('updateNested');
    return _delegate._client.transaction((txDb) async {
      final scoped = txDb.orm.model(_delegate.modelName);
      return _RepositoryMutationExecutor(scoped)._updateNestedInScope(
        where: where,
        data: data,
        nestedCreate: nestedCreate,
        select: select,
        include: include,
        operation: trace,
      );
    });
  }

  Future<List<JsonMap>> createMany({
    required List<JsonMap> data,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    final trace = _startOperation('createMany');
    return _delegate._client.transaction((txDb) async {
      final scoped = txDb.orm.model(_delegate.modelName);
      final executor = _RepositoryMutationExecutor(scoped);
      final rows = <JsonMap>[];
      for (var index = 0; index < data.length; index++) {
        final item = data[index];
        rows.add(
          await executor.create(
            data: item,
            select: select,
            include: include,
            operation: trace,
            phase: 'item.create',
            strategy: 'transaction',
            itemIndex: index,
          ),
        );
      }
      return rows;
    });
  }

  Future<int> deleteMany({required JsonMap where}) {
    final trace = _startOperation('deleteMany');
    return _delegate._client.transaction((txDb) async {
      final scoped = txDb.orm.model(_delegate.modelName);
      final executor = _RepositoryMutationExecutor(scoped);
      var deleted = 0;
      var attempt = 0;
      while (true) {
        final row = await executor.delete(
          where: where,
          select: const <String>[],
          include: const <String, IncludeSpec>{},
          operation: trace,
          phase: 'item.delete',
          strategy: 'transaction',
          itemIndex: attempt,
        );
        attempt += 1;
        if (row == null) {
          break;
        }
        deleted += 1;
      }
      return deleted;
    });
  }

  Future<JsonMap> upsert({
    required JsonMap where,
    required JsonMap create,
    required JsonMap update,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    final trace = _startOperation('upsert');
    return _delegate._client.transaction((txDb) async {
      final scoped = txDb.orm.model(_delegate.modelName);
      final executor = _RepositoryMutationExecutor(scoped);
      final existing = await scoped._readOneInternal(
        action: OrmAction.read,
        where: where,
        repositoryTrace: trace.nextTrace(
          phase: 'branch.lookup',
          strategy: 'branch',
        ),
        includeDepth: 0,
      );
      if (existing == null) {
        return executor.create(
          data: create,
          select: select,
          include: include,
          operation: trace,
          phase: 'branch.create',
          strategy: 'branch',
        );
      }

      final updatedRow = await executor.update(
        where: where,
        data: update,
        select: select,
        include: include,
        operation: trace,
        phase: 'branch.update',
        strategy: 'branch',
      );
      if (updatedRow != null) {
        return updatedRow;
      }

      throw runtimeError(
        'RUNTIME.UPSERT_UPDATE_MISSING',
        'Upsert update branch did not return a row.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'where': where,
        },
      );
    });
  }

  Future<JsonMap?> _runNullableMutation({
    required OrmAction action,
    required OrmMutationResultMode mutationResultMode,
    required JsonMap where,
    required JsonMap data,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required String responseAction,
    required _RepositoryOperation operation,
    required String phase,
    required String strategy,
    String? relation,
    int? itemIndex,
  }) async {
    final normalized = await _normalizeMutationInput(
      where: where,
      select: select,
      include: include,
    );
    final normalizedInclude = normalized.include;
    final normalizedWhere = normalized.where;
    final preDeleteRow = await _preloadDeleteRow(
      action: action,
      where: normalizedWhere,
      select: select,
      include: normalizedInclude,
      operation: operation,
    );
    final prepared = _composeMutationPlan(
      action: action,
      mutationResultMode: mutationResultMode,
      data: data,
      normalized: normalized,
      repositoryTrace: operation.nextTrace(
        phase: phase,
        strategy: strategy,
        relation: relation,
        itemIndex: itemIndex,
      ),
    );

    final response = await _delegate._client.execute(prepared.plan);
    final row = await _resolveNullableMutationRow(
      action: action,
      response: response,
      responseAction: responseAction,
      where: normalizedWhere,
      select: select,
      include: normalizedInclude,
      preDeleteRow: preDeleteRow,
      operation: operation,
    );
    if (row == null) {
      return null;
    }

    return _shapeMutationRow(
      action: action,
      row: row,
      select: select,
      include: normalizedInclude,
    );
  }

  Future<_NormalizedMutationInput> _normalizeMutationInput({
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) async {
    final normalizedInclude = _delegate._normalizeInclude(include);
    final normalizedWhere = where.isEmpty
        ? const <String, Object?>{}
        : await _delegate._normalizeWhereForExecution(
            model: _delegate.modelName,
            where: where,
          );

    return _NormalizedMutationInput(
      where: normalizedWhere,
      select: _delegate._expandSelectForInclude(
        model: _delegate.modelName,
        select: select,
        include: normalizedInclude,
      ),
      include: normalizedInclude,
    );
  }

  _PreparedMutationPlan _composeMutationPlan({
    required OrmAction action,
    required OrmMutationResultMode mutationResultMode,
    required JsonMap data,
    required _NormalizedMutationInput normalized,
    OrmRepositoryTrace? repositoryTrace,
  }) {
    return _PreparedMutationPlan(
      include: normalized.include,
      plan: OrmPlan.mutation(
        contractHash: _delegate._client.contract.hash,
        target: _delegate._client.contract.target,
        storageHash: _delegate._client.contract.markerStorageHash,
        profileHash: _delegate._client.contract.profileHash,
        lane: 'orm',
        repositoryTrace: repositoryTrace,
        model: _delegate.modelName,
        action: action,
        where: normalized.where,
        data: data,
        select: normalized.select,
        resultMode: mutationResultMode,
      ),
    );
  }

  Future<JsonMap?> _preloadDeleteRow({
    required OrmAction action,
    required JsonMap where,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required _RepositoryOperation operation,
  }) {
    if (action != OrmAction.delete ||
        _delegate._client.contract.capabilities.mutationReturning) {
      return Future<JsonMap?>.value(null);
    }

    return _delegate._readOneInternal(
      action: OrmAction.read,
      where: where,
      select: _delegate._expandSelectForInclude(
        model: _delegate.modelName,
        select: select,
        include: include,
      ),
      repositoryTrace: operation.nextTrace(
        phase: 'fallback.preload',
        strategy: 'returningDisabledFallback',
      ),
      include: const <String, IncludeSpec>{},
      includeDepth: 0,
    );
  }

  Future<JsonMap?> _resolveNullableMutationRow({
    required OrmAction action,
    required EngineResponse response,
    required String responseAction,
    required JsonMap where,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required JsonMap? preDeleteRow,
    required _RepositoryOperation operation,
  }) async {
    var row = _readRow(response.data, action: responseAction);
    if (row == null &&
        response.affectedRows > 0 &&
        !(_delegate._client.contract.capabilities.mutationReturning)) {
      row = switch (action) {
        OrmAction.update => await _delegate._readOneInternal(
          action: OrmAction.read,
          where: where,
          select: _delegate._expandSelectForInclude(
            model: _delegate.modelName,
            select: select,
            include: include,
          ),
          repositoryTrace: operation.nextTrace(
            phase: 'fallback.reload',
            strategy: 'returningDisabledFallback',
          ),
          include: const <String, IncludeSpec>{},
          includeDepth: 0,
        ),
        OrmAction.delete => preDeleteRow,
        _ => row,
      };
    }
    return row;
  }

  Future<JsonMap> _createNestedInScope({
    required JsonMap data,
    required Map<String, List<JsonMap>> nestedCreate,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required _RepositoryOperation operation,
  }) async {
    final normalizedCreate = _delegate._normalizeNestedCreate(nestedCreate);
    final normalizedInclude = _delegate._normalizeInclude(include);

    final created = await create(
      data: data,
      select: _delegate._expandSelectForNestedCreate(
        model: _delegate.modelName,
        select: select,
        create: normalizedCreate,
      ),
      include: const <String, IncludeSpec>{},
      operation: operation,
      phase: 'root.create',
      strategy: 'transaction',
    );

    for (final entry in normalizedCreate.entries) {
      final relation = _delegate._resolveRelation(
        model: _delegate.modelName,
        relationName: entry.key,
      );
      final related = _delegate._runtime._resolveDelegate(
        relation.relatedModel,
      );
      final relatedExecutor = _RepositoryMutationExecutor(related);
      for (var index = 0; index < entry.value.length; index++) {
        final child = entry.value[index];
        final linkedData = _delegate._linkNestedData(
          parent: created,
          relationName: entry.key,
          relation: relation,
          data: child,
        );
        await relatedExecutor.create(
          data: linkedData,
          select: const <String>[],
          include: const <String, IncludeSpec>{},
          operation: operation,
          phase: 'child.create',
          strategy: 'transaction',
          relation: entry.key,
          itemIndex: index,
        );
      }
    }

    return _shapeNestedMutationRow(
      action: OrmAction.create,
      row: created,
      select: select,
      include: normalizedInclude,
      nestedCreate: normalizedCreate,
    );
  }

  Future<JsonMap?> _updateNestedInScope({
    required JsonMap where,
    required JsonMap data,
    required Map<String, List<JsonMap>> nestedCreate,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required _RepositoryOperation operation,
  }) async {
    final normalizedCreate = _delegate._normalizeNestedCreate(nestedCreate);
    final normalizedInclude = _delegate._normalizeInclude(include);

    final updated = await update(
      where: where,
      data: data,
      select: _delegate._expandSelectForNestedCreate(
        model: _delegate.modelName,
        select: select,
        create: normalizedCreate,
      ),
      include: const <String, IncludeSpec>{},
      operation: operation,
      phase: 'root.update',
      strategy: 'transaction',
    );
    if (updated == null) {
      return null;
    }

    for (final entry in normalizedCreate.entries) {
      final relation = _delegate._resolveRelation(
        model: _delegate.modelName,
        relationName: entry.key,
      );
      final related = _delegate._runtime._resolveDelegate(
        relation.relatedModel,
      );
      final relatedExecutor = _RepositoryMutationExecutor(related);
      for (var index = 0; index < entry.value.length; index++) {
        final child = entry.value[index];
        final linkedData = _delegate._linkNestedData(
          parent: updated,
          relationName: entry.key,
          relation: relation,
          data: child,
        );
        await relatedExecutor.create(
          data: linkedData,
          select: const <String>[],
          include: const <String, IncludeSpec>{},
          operation: operation,
          phase: 'child.create',
          strategy: 'transaction',
          relation: entry.key,
          itemIndex: index,
        );
      }
    }

    return _shapeNestedMutationRow(
      action: OrmAction.update,
      row: updated,
      select: select,
      include: normalizedInclude,
      nestedCreate: normalizedCreate,
    );
  }

  Future<JsonMap> _shapeMutationRow({
    required OrmAction action,
    required JsonMap row,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) async {
    final hydratedRows = await _delegate._resolveIncludeRows(
      action: action,
      rows: <JsonMap>[row],
      include: include,
      depth: 0,
    );
    return _delegate._shapeRows(
      hydratedRows,
      select: select,
      include: include,
    ).single;
  }

  Future<JsonMap> _shapeNestedMutationRow({
    required OrmAction action,
    required JsonMap row,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required Map<String, List<JsonMap>> nestedCreate,
  }) async {
    final includeForReturn = <String, IncludeSpec>{
      for (final relationName in nestedCreate.keys)
        relationName: const IncludeSpec(),
      ...include,
    };

    if (includeForReturn.isEmpty) {
      return _delegate._shapeRows(
        <JsonMap>[row],
        select: select,
        include: const <String, IncludeSpec>{},
      ).single;
    }

    return _shapeMutationRow(
      action: action,
      row: row,
      select: select,
      include: includeForReturn,
    );
  }
}
