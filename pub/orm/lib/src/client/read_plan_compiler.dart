part of 'client.dart';

final class _OrmReadPlanCompiler {
  final ModelDelegate _delegate;

  _OrmReadPlanCompiler(this._delegate);

  OrmPreparedReadQuery compile({required _OrmPreparedReadState state}) {
    if (state._skip case final offset? when offset < 0) {
      throw PlanInvalidPaginationException(key: 'skip', value: offset);
    }
    if (state._take case final limit? when limit < 0) {
      throw PlanInvalidPaginationException(key: 'take', value: limit);
    }

    final normalizedInclude = normalizeInclude(state._include);
    if ((state._cursor != null || state._page != null) &&
        state._orderBy.isEmpty) {
      throw runtimeError(
        'PLAN.CURSOR_ORDER_BY_REQUIRED',
        'Cursor and page windows require orderBy() first.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          if (state._cursor != null) 'cursor': state._cursor,
          if (state._page != null) 'page': state._page!.toJson(),
        },
      );
    }
    if (state._cursor != null || state._page != null) {
      validateStableCursorOrderBy(orderBy: state._orderBy);
    }
    if (state._page != null && state.resultMode != OrmReadResultMode.all) {
      throw runtimeError(
        'PLAN.PAGE_RESULT_MODE_INVALID',
        'Page windows currently compile only to collection read plans.',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'resultMode': state.resultMode.name,
          'page': state._page!.toJson(),
        },
      );
    }

    final isCollectionRead = state.resultMode != OrmReadResultMode.oneOrNull;
    final resolvedTake = state._page != null
        ? null
        : state.resultMode == OrmReadResultMode.firstOrNull
        ? 1
        : state._take;
    final readSelect = switch (state.resultMode) {
      OrmReadResultMode.oneOrNull => expandSelectForInclude(
        model: _delegate.modelName,
        select: state._select,
        include: normalizedInclude,
      ),
      OrmReadResultMode.all ||
      OrmReadResultMode.firstOrNull => expandSelectForExecution(
        model: _delegate.modelName,
        select: state._select,
        include: normalizedInclude,
        distinct: state._distinct,
      ),
    };

    return OrmPreparedReadQuery._(
      delegate: _delegate,
      state: state,
      normalizedInclude: normalizedInclude,
      plan: OrmPlan.read(
        contractHash: _delegate._client.contract.hash,
        target: _delegate._client.contract.target,
        storageHash: _delegate._client.contract.markerStorageHash,
        profileHash: _delegate._client.contract.profileHash,
        lane: 'orm',
        annotations: _mergePlanAnnotations(
          state._annotations,
          state._distinct.isEmpty
              ? const <String, Object?>{}
              : <String, Object?>{
                  'distinct': List<String>.from(
                    state._distinct,
                    growable: false,
                  ),
                },
        ),
        repositoryTrace: state._repositoryTrace,
        model: _delegate.modelName,
        where: state._where,
        skip: isCollectionRead ? state._skip : null,
        take: isCollectionRead ? resolvedTake : null,
        orderBy: isCollectionRead ? state._orderBy : const <OrmOrderBy>[],
        distinct: isCollectionRead ? state._distinct : const <String>[],
        select: readSelect,
        include: _buildOrmIncludePlanMap(normalizedInclude),
        cursor: state._cursor == null
            ? null
            : OrmReadCursorPlan(values: state._cursor!),
        page: state._page,
        resultMode: state.resultMode,
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
}
