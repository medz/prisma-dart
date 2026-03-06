part of 'client.dart';

@immutable
final class OrmPreparedReadQuery {
  final ModelDelegate _delegate;
  final OrmPlan plan;
  final JsonMap _where;
  final int? _skip;
  final int? _take;
  final List<OrmOrderBy> _orderBy;
  final List<String> _distinct;
  final List<String> _select;
  final Map<String, IncludeSpec> _include;
  final Map<String, IncludeSpec> _normalizedInclude;
  final JsonMap? _cursor;
  final OrmReadPagePlan? _page;
  final JsonMap _annotations;
  final OrmRepositoryTrace? _repositoryTrace;
  final OrmReadResultMode _resultMode;

  OrmPreparedReadQuery._({
    required ModelDelegate delegate,
    required this.plan,
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    Map<String, IncludeSpec> normalizedInclude = const <String, IncludeSpec>{},
    JsonMap? cursor,
    OrmReadPagePlan? page,
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
    required OrmReadResultMode resultMode,
  }) : _delegate = delegate,
       _where = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(where),
       ),
       _skip = skip,
       _take = take,
       _orderBy = List<OrmOrderBy>.unmodifiable(orderBy),
       _distinct = List<String>.unmodifiable(distinct),
       _select = List<String>.unmodifiable(select),
       _include = Map<String, IncludeSpec>.unmodifiable(
         Map<String, IncludeSpec>.from(include),
       ),
       _normalizedInclude = Map<String, IncludeSpec>.unmodifiable(
         Map<String, IncludeSpec>.from(normalizedInclude),
       ),
       _cursor = cursor == null
           ? null
           : Map<String, Object?>.unmodifiable(
               Map<String, Object?>.from(cursor),
             ),
       _page = page,
       _annotations = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(annotations),
       ),
       _repositoryTrace = repositoryTrace,
       _resultMode = resultMode;

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

final class _RepositoryReadExecutor {
  final ModelDelegate _delegate;

  _RepositoryReadExecutor(this._delegate);

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
      resultMode: OrmReadResultMode.all,
      where: prepared._where,
      orderBy: prepared._orderBy,
      select: pageSelect,
      include: prepared._include,
      page: OrmReadPagePlan(
        size: page.size + 1,
        after: page.after,
        before: page.before,
      ),
      annotations: prepared._annotations,
      repositoryTrace: operation.nextTrace(
        phase: 'page.items',
        strategy: 'windowPlusOne',
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
            resultMode: OrmReadResultMode.firstOrNull,
            where: prepared._where,
            skip: prepared._skip,
            orderBy: prepared._orderBy,
            distinct: prepared._distinct,
            select: prepared._select,
            include: prepared._include,
            annotations: prepared._annotations,
            repositoryTrace: prepared._repositoryTrace,
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
            resultMode: OrmReadResultMode.oneOrNull,
            where: prepared._where,
            select: prepared._select,
            include: prepared._include,
            annotations: prepared._annotations,
            repositoryTrace: prepared._repositoryTrace,
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
