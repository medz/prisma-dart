part of 'client.dart';

@immutable
final class _OrmPreparedReadState {
  final OrmReadResultMode resultMode;
  final OrmReadQuerySpec _spec;
  final JsonMap _annotations;
  final OrmRepositoryTrace? _repositoryTrace;

  _OrmPreparedReadState({
    required this.resultMode,
    required OrmReadQuerySpec spec,
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
  }) : _spec = spec.copyWith(),
       _annotations = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(annotations),
       ),
       _repositoryTrace = repositoryTrace;

  JsonMap get _where => _spec.where;

  int? get _skip => _spec.skip;

  int? get _take => _spec.take;

  List<OrmOrderBy> get _orderBy => _spec.orderBy;

  List<String> get _distinct => _spec.distinct;

  List<String> get _select => _spec.select;

  Map<String, IncludeSpec> get _include => _spec.include;

  JsonMap? get _cursor => _spec.cursor;

  OrmReadPagePlan? get _page => _spec.page;

  _OrmPreparedReadState copyWith({
    OrmReadResultMode? resultMode,
    OrmReadQuerySpec? spec,
    JsonMap? annotations,
    Object? repositoryTrace = _stateKeepToken,
  }) {
    return _OrmPreparedReadState(
      resultMode: resultMode ?? this.resultMode,
      spec: spec ?? _spec,
      annotations: annotations ?? _annotations,
      repositoryTrace: identical(repositoryTrace, _stateKeepToken)
          ? _repositoryTrace
          : repositoryTrace as OrmRepositoryTrace?,
    );
  }
}

@immutable
final class OrmPreparedReadQuery {
  final ModelDelegate _delegate;
  final OrmPlan plan;
  final _OrmPreparedReadState _state;
  final Map<String, IncludeSpec> _normalizedInclude;

  OrmPreparedReadQuery._({
    required ModelDelegate delegate,
    required this.plan,
    required _OrmPreparedReadState state,
    Map<String, IncludeSpec> normalizedInclude = const <String, IncludeSpec>{},
  }) : _delegate = delegate,
       _state = state,
       _normalizedInclude = Map<String, IncludeSpec>.unmodifiable(
         Map<String, IncludeSpec>.from(normalizedInclude),
       );

  JsonMap get _where => _state._where;

  int? get _skip => _state._skip;

  int? get _take => _state._take;

  List<OrmOrderBy> get _orderBy => _state._orderBy;

  List<String> get _distinct => _state._distinct;

  List<String> get _select => _state._select;

  Map<String, IncludeSpec> get _include => _state._include;

  JsonMap? get _cursor => _state._cursor;

  OrmReadPagePlan? get _page => _state._page;

  JsonMap get _annotations => _state._annotations;

  OrmRepositoryTrace? get _repositoryTrace => _state._repositoryTrace;

  OrmReadResultMode get _resultMode => _state.resultMode;

  Future<JsonMap> inspectPlan() async {
    return Map<String, Object?>.unmodifiable(<String, Object?>{
      ...plan.toJson(),
      'terminalExecution': _terminalExecutionSummary(
        contract: _delegate._client.contract,
        includeStrategySelector: _delegate._client.includeStrategySelector,
        modelName: _delegate.modelName,
        distinct: _distinct,
        include: _normalizedInclude,
        cursor: _cursor,
        page: _page,
      ),
    });
  }

  Future<JsonMap> explain() async {
    final explained = await _delegate._runtime.explainPlan(plan);
    return Map<String, Object?>.unmodifiable(<String, Object?>{
      ...explained,
      'terminalExecution': _terminalExecutionSummary(
        contract: _delegate._client.contract,
        includeStrategySelector: _delegate._client.includeStrategySelector,
        modelName: _delegate.modelName,
        distinct: _distinct,
        include: _normalizedInclude,
        cursor: _cursor,
        page: _page,
      ),
    });
  }

  Future<List<JsonMap>> all({int includeDepth = 0}) {
    return _delegate._readRepository.all(
      prepared: this,
      action: OrmAction.read,
      includeDepth: includeDepth,
    );
  }

  Future<OrmPageResult<JsonMap>> pageResult({int includeDepth = 0}) {
    return _delegate._readRepository.pageResult(
      prepared: this,
      action: OrmAction.read,
      includeDepth: includeDepth,
    );
  }

  Future<JsonMap?> oneOrNull({int includeDepth = 0}) {
    return _delegate._readRepository.oneOrNull(
      prepared: this,
      action: OrmAction.read,
      includeDepth: includeDepth,
    );
  }

  Future<JsonMap?> firstOrNull({int includeDepth = 0}) {
    return _delegate._readRepository.firstOrNull(
      prepared: this,
      action: OrmAction.read,
      includeDepth: includeDepth,
    );
  }

  Stream<JsonMap> stream({int includeDepth = 0}) {
    return _delegate._readRepository.stream(
      prepared: this,
      action: OrmAction.read,
      includeDepth: includeDepth,
    );
  }
}

@immutable
final class OrmPreparedAggregateQuery {
  final ModelDelegate _delegate;
  final OrmPlan plan;

  const OrmPreparedAggregateQuery._({
    required ModelDelegate delegate,
    required this.plan,
    required OrmReadQuerySpec spec,
    required OrmAggregateSpec aggregate,
  }) : _delegate = delegate;

  Future<JsonMap> inspectPlan() async =>
      Map<String, Object?>.unmodifiable(plan.toJson());

  Future<JsonMap> execute() =>
      _delegate._readRepository.aggregate(prepared: this);
}

@immutable
final class OrmPreparedGroupedQuery {
  final ModelDelegate _delegate;
  final OrmPlan plan;

  const OrmPreparedGroupedQuery._({
    required ModelDelegate delegate,
    required this.plan,
    required OrmReadQuerySpec baseSpec,
    required OrmGroupBySpec groupBy,
  }) : _delegate = delegate;

  Future<JsonMap> inspectPlan() async =>
      Map<String, Object?>.unmodifiable(plan.toJson());

  Future<List<JsonMap>> execute() =>
      _delegate._readRepository.grouped(prepared: this);
}

final class _RepositoryReadExecutor {
  final ModelDelegate _delegate;

  _RepositoryReadExecutor(this._delegate);

  Future<JsonMap> aggregate({
    required OrmPreparedAggregateQuery prepared,
  }) async {
    final response = await _delegate._client.execute(prepared.plan);
    return (await _collectSingleRow(response, action: 'aggregate')) ??
        const <String, Object?>{};
  }

  Future<List<JsonMap>> grouped({
    required OrmPreparedGroupedQuery prepared,
  }) async {
    final response = await _delegate._client.execute(prepared.plan);
    return _collectRows(response, action: 'groupBy');
  }

  Future<List<JsonMap>> all({
    required OrmPreparedReadQuery prepared,
    required OrmAction action,
    required int includeDepth,
  }) async {
    final response = await _delegate._client.execute(prepared.plan);
    final rows = await _delegate._collectCollectionRows(
      response,
      action: 'all',
      distinct: prepared._distinct,
      skip: prepared._skip,
      take: prepared._take,
    );
    final hydratedRows = await _delegate._resolveIncludeRows(
      action: action,
      rows: rows,
      include: prepared._normalizedInclude,
      depth: includeDepth,
    );

    return _delegate._shapeRows(
      hydratedRows,
      select: prepared._select,
      include: prepared._normalizedInclude,
    );
  }

  Future<OrmPageResult<JsonMap>> pageResult({
    required OrmPreparedReadQuery prepared,
    required OrmAction action,
    required int includeDepth,
  }) async {
    final page = prepared._page;
    if (page == null) {
      throw runtimeError(
        'PLAN.PAGE_RESULT_REQUIRES_PAGE_WINDOW',
        'pageResult() requires page() first.',
        details: <String, Object?>{'model': _delegate.modelName},
      );
    }

    final operation = _RepositoryOperation.start(
      kind: '${_delegate.modelName}.pageResult',
    );
    final pageSelect = _delegate._expandSelectForPageExecution(
      select: prepared._select,
      orderBy: prepared._orderBy,
    );
    final itemsPrepared = await _delegate._prepareReadQuery(
      state: prepared._state.copyWith(
        resultMode: OrmReadResultMode.all,
        spec: prepared._state._spec.copyWith(
          where: prepared._where,
          skip: null,
          take: null,
          orderBy: prepared._orderBy,
          distinct: const <String>[],
          select: pageSelect,
          include: prepared._include,
          cursor: null,
          page: OrmReadPagePlan(
            size: page.size + 1,
            after: page.after,
            before: page.before,
          ),
        ),
        annotations: prepared._annotations,
        repositoryTrace: operation.nextTrace(
          phase: 'page.items',
          strategy: 'windowPlusOne',
        ),
      ),
    );
    final response = await _delegate._client.execute(itemsPrepared.plan);
    final rawRows = await _collectRows(response, action: 'pageResult');
    final overflowed = rawRows.length > page.size;
    final windowRows = _delegate._trimPageResultRows(rows: rawRows, page: page);
    final hydratedRows = await _delegate._resolveIncludeRows(
      action: action,
      rows: windowRows,
      include: itemsPrepared._normalizedInclude,
      depth: includeDepth,
      operation: operation,
    );
    final pageInfo = await _delegate._buildPageInfo(
      where: prepared._where,
      orderBy: prepared._orderBy,
      page: page,
      rows: windowRows,
      overflowed: overflowed,
      operation: operation,
    );

    return OrmPageResult<JsonMap>(
      items: _delegate._shapeRows(
        hydratedRows,
        select: prepared._select,
        include: itemsPrepared._normalizedInclude,
      ),
      pageInfo: pageInfo,
    );
  }

  Future<JsonMap?> firstOrNull({
    required OrmPreparedReadQuery prepared,
    required OrmAction action,
    required int includeDepth,
  }) async {
    if (prepared._cursor != null || prepared._page != null) {
      final rows = await all(
        prepared: prepared,
        action: action,
        includeDepth: includeDepth,
      );
      return rows.isEmpty ? null : rows.first;
    }

    final effectivePrepared = prepared._distinct.isEmpty
        ? await _delegate._prepareReadQuery(
            state: prepared._state.copyWith(
              resultMode: OrmReadResultMode.firstOrNull,
              spec: prepared._state._spec.copyWith(
                where: prepared._where,
                skip: prepared._skip,
                orderBy: prepared._orderBy,
                distinct: prepared._distinct,
                select: prepared._select,
                include: prepared._include,
                cursor: null,
                page: null,
              ),
              annotations: prepared._annotations,
              repositoryTrace: prepared._repositoryTrace,
            ),
          )
        : prepared;

    final response = await _delegate._client.execute(effectivePrepared.plan);
    final row = prepared._distinct.isEmpty
        ? await _collectSingleRow(response, action: 'firstOrNull')
        : _firstOrNull(
            await _delegate._collectCollectionRows(
              response,
              action: 'firstOrNull',
              distinct: prepared._distinct,
              skip: prepared._skip,
              take: 1,
            ),
          );
    if (row == null) {
      return null;
    }

    final hydratedRows = await _delegate._resolveIncludeRows(
      action: action,
      rows: <JsonMap>[row],
      include: effectivePrepared._normalizedInclude,
      depth: includeDepth,
    );

    return _delegate
        ._shapeRows(
          hydratedRows,
          select: prepared._select,
          include: effectivePrepared._normalizedInclude,
        )
        .single;
  }

  Future<JsonMap?> oneOrNull({
    required OrmPreparedReadQuery prepared,
    required OrmAction action,
    required int includeDepth,
  }) async {
    if (prepared._cursor != null || prepared._page != null) {
      final rows = await all(
        prepared: prepared,
        action: action,
        includeDepth: includeDepth,
      );
      return rows.isEmpty ? null : rows.first;
    }

    final effectivePrepared =
        prepared._resultMode == OrmReadResultMode.oneOrNull
        ? prepared
        : await _delegate._prepareReadQuery(
            state: prepared._state.copyWith(
              resultMode: OrmReadResultMode.oneOrNull,
              spec: prepared._state._spec.copyWith(
                where: prepared._where,
                select: prepared._select,
                include: prepared._include,
                skip: null,
                take: null,
                orderBy: const <OrmOrderBy>[],
                distinct: const <String>[],
                cursor: null,
                page: null,
              ),
              annotations: prepared._annotations,
              repositoryTrace: prepared._repositoryTrace,
            ),
          );
    final response = await _delegate._client.execute(effectivePrepared.plan);

    final row = await _collectSingleRow(response, action: 'oneOrNull');
    if (row == null) {
      return null;
    }

    final hydratedRows = await _delegate._resolveIncludeRows(
      action: action,
      rows: <JsonMap>[row],
      include: effectivePrepared._normalizedInclude,
      depth: includeDepth,
    );

    return _delegate
        ._shapeRows(
          hydratedRows,
          select: prepared._select,
          include: effectivePrepared._normalizedInclude,
        )
        .single;
  }

  Stream<JsonMap> stream({
    required OrmPreparedReadQuery prepared,
    required OrmAction action,
    required int includeDepth,
  }) async* {
    final response = await _delegate._client.execute(prepared.plan);

    if (prepared._normalizedInclude.isEmpty && prepared._distinct.isEmpty) {
      await for (final row in _streamRows(response, action: 'stream')) {
        yield _delegate._shapeRow(
          row,
          select: prepared._select,
          include: prepared._normalizedInclude,
        );
      }
      return;
    }

    final rows = await _delegate._collectCollectionRows(
      response,
      action: 'stream',
      distinct: prepared._distinct,
      skip: prepared._skip,
      take: prepared._take,
    );
    if (rows.isEmpty) {
      return;
    }

    final hydratedRows = await _delegate._resolveIncludeRows(
      action: action,
      rows: rows,
      include: prepared._normalizedInclude,
      depth: includeDepth,
    );

    for (final row in _delegate._shapeRows(
      hydratedRows,
      select: prepared._select,
      include: prepared._normalizedInclude,
    )) {
      yield row;
    }
  }
}
