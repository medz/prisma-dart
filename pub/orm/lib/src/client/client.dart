import 'package:meta/meta.dart';

import '../contract/contract.dart';
import '../core/sort_order.dart';
import '../engine/engine.dart';
import '../runtime/core.dart';
import '../runtime/errors.dart';
import '../runtime/plan.dart';
import '../runtime/plugin.dart';
import '../runtime/types.dart';

part 'include_planner.dart';
part 'mutation_repository.dart';

typedef CollectionFactory =
    ModelDelegate Function({
      required OrmCollectionContext client,
      required String modelName,
    });

enum IncludeExecutionStrategy { singleQuery, multiQuery }

typedef IncludeExecutionStrategySelector =
    IncludeExecutionStrategy Function({
      required OrmContract contract,
      required String modelName,
      required OrmAction action,
      required Map<String, IncludeSpec> include,
      required int depth,
    });

const int _defaultMaxIncludeDepth = 4;
const Set<String> _whereLogicalKeys = <String>{'AND', 'OR', 'NOT'};
const List<String> _filterOperatorOrder = <String>[
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
const Set<String> _filterOperators = <String>{
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
const Set<String> _groupByAggregateBuckets = <String>{
  'count',
  'min',
  'max',
  'sum',
  'avg',
};
const Map<String, String> _groupByAggregateBucketAliases = <String, String>{
  '_count': 'count',
  '_min': 'min',
  '_max': 'max',
  '_sum': 'sum',
  '_avg': 'avg',
};
const Set<String> _toManyRelationWhereOperators = <String>{
  'some',
  'every',
  'none',
};
const Set<String> _toOneRelationWhereOperators = <String>{'is', 'isNot'};

IncludeExecutionStrategy defaultIncludeExecutionStrategySelector({
  required OrmContract contract,
  required String modelName,
  required OrmAction action,
  required Map<String, IncludeSpec> include,
  required int depth,
}) {
  if (contract.capabilities.includeSingleQuery) {
    return IncludeExecutionStrategy.singleQuery;
  }
  return IncludeExecutionStrategy.multiQuery;
}

@immutable
final class IncludeSpec {
  final JsonMap where;
  final int? skip;
  final int? take;
  final List<OrmOrderBy> orderBy;
  final List<String> select;
  final Map<String, IncludeSpec> include;

  const IncludeSpec({
    this.where = const <String, Object?>{},
    this.skip,
    this.take,
    this.orderBy = const <OrmOrderBy>[],
    this.select = const <String>[],
    this.include = const <String, IncludeSpec>{},
  });

  IncludeSpec merge(IncludeSpec other) {
    return IncludeSpec(
      where: <String, Object?>{...where, ...other.where},
      skip: other.skip ?? skip,
      take: other.take ?? take,
      orderBy: <OrmOrderBy>[...orderBy, ...other.orderBy],
      select: <String>[...select, ...other.select],
      include: _mergeIncludeSpecMap(include, other.include),
    );
  }

  IncludeSpec includeWith(
    Map<String, IncludeSpec> Function(Map<String, IncludeSpec> include) build, {
    bool merge = true,
  }) {
    final current = <String, IncludeSpec>{...include};
    final next = build(current);
    return IncludeSpec(
      where: <String, Object?>{...where},
      skip: skip,
      take: take,
      orderBy: <OrmOrderBy>[...orderBy],
      select: <String>[...select],
      include: merge
          ? _mergeIncludeSpecMap(include, next)
          : <String, IncludeSpec>{...next},
    );
  }
}

Map<String, IncludeSpec> _mergeIncludeSpecMap(
  Map<String, IncludeSpec> current,
  Map<String, IncludeSpec> next,
) {
  if (current.isEmpty) {
    if (next.isEmpty) {
      return const <String, IncludeSpec>{};
    }
    return <String, IncludeSpec>{...next};
  }
  if (next.isEmpty) {
    return <String, IncludeSpec>{...current};
  }
  final merged = <String, IncludeSpec>{...current};
  for (final entry in next.entries) {
    final existing = merged[entry.key];
    if (existing == null) {
      merged[entry.key] = entry.value;
      continue;
    }
    merged[entry.key] = existing.merge(entry.value);
  }
  return merged;
}

JsonMap _mergePlanAnnotations(
  JsonMap current,
  JsonMap next,
) {
  if (current.isEmpty) {
    if (next.isEmpty) {
      return const <String, Object?>{};
    }
    return Map<String, Object?>.unmodifiable(Map<String, Object?>.from(next));
  }
  if (next.isEmpty) {
    return Map<String, Object?>.unmodifiable(Map<String, Object?>.from(current));
  }
  return Map<String, Object?>.unmodifiable(<String, Object?>{
    ...current,
    ...next,
  });
}

int _repositoryOperationSeed = 0;

Never _throwApiNotImplemented(
  String surface, {
  Map<String, Object?> details = const <String, Object?>{},
}) {
  throw ApiNotImplementedException(surface: surface, details: details);
}

final class _RepositoryOperation {
  final String id;
  final String kind;
  var _step = 0;

  _RepositoryOperation._({required this.id, required this.kind});

  factory _RepositoryOperation.start({required String kind}) {
    _repositoryOperationSeed += 1;
    return _RepositoryOperation._(
      id: 'repo_${kind}_$_repositoryOperationSeed',
      kind: kind,
    );
  }

  OrmRepositoryTrace nextTrace({
    required String phase,
    required String strategy,
    String? relation,
    int? itemIndex,
  }) {
    _step += 1;
    return OrmRepositoryTrace(
      operationId: id,
      kind: kind,
      step: _step,
      phase: phase,
      strategy: strategy,
      relation: relation,
      itemIndex: itemIndex,
    );
  }
}

OrmIncludePlan _buildOrmIncludePlan(IncludeSpec spec) {
  return OrmIncludePlan(
    where: spec.where,
    skip: spec.skip,
    take: spec.take,
    orderBy: spec.orderBy,
    select: spec.select,
    include: _buildOrmIncludePlanMap(spec.include),
  );
}

Map<String, OrmIncludePlan> _buildOrmIncludePlanMap(
  Map<String, IncludeSpec> include,
) {
  if (include.isEmpty) {
    return const <String, OrmIncludePlan>{};
  }
  return <String, OrmIncludePlan>{
    for (final entry in include.entries)
      entry.key: _buildOrmIncludePlan(entry.value),
  };
}

abstract interface class OrmDbContext {
  OrmDbNamespace get db;
}

abstract interface class OrmExecutionContext {
  OrmContract get contract;

  Future<EngineResponse> execute(OrmPlan plan);
}

abstract interface class OrmCollectionContext implements OrmExecutionContext {
  IncludeExecutionStrategySelector get includeStrategySelector;

  int get maxIncludeDepth;

  Future<T> transaction<T>(Future<T> Function(OrmDbNamespace txDb) run);
}

abstract interface class _OrmDelegateRuntime implements OrmCollectionContext {
  ModelDelegate _resolveDelegate(String modelKey);
}

final class OrmClient implements OrmDbContext, _OrmDelegateRuntime {
  @override
  final OrmContract contract;
  final OrmEngine engine;
  final OrmRuntimeCore _runtime;
  final Map<String, ModelDelegate> _delegates = <String, ModelDelegate>{};
  final Map<String, String> _modelAliases;
  final Map<String, CollectionFactory> _collectionRegistry;
  late final OrmDbNamespace _db = OrmDbNamespace(
    sqlContext: this,
    resolveDelegate: _resolveDelegate,
  );
  @override
  final IncludeExecutionStrategySelector includeStrategySelector;
  @override
  final int maxIncludeDepth;

  OrmClient({
    required this.contract,
    required this.engine,
    List<OrmPlugin> plugins = const <OrmPlugin>[],
    RuntimeVerifyOptions verify = const RuntimeVerifyOptions(),
    RuntimeMode mode = RuntimeMode.strict,
    RuntimeLog log = const SilentRuntimeLog(),
    Map<String, CollectionFactory> collections =
        const <String, CollectionFactory>{},
    this.includeStrategySelector = defaultIncludeExecutionStrategySelector,
    this.maxIncludeDepth = _defaultMaxIncludeDepth,
  }) : assert(maxIncludeDepth > 0, 'maxIncludeDepth must be greater than 0.'),
       _runtime = OrmRuntimeCore(
         contract: contract,
         engine: engine,
         plugins: plugins,
         verify: verify,
         mode: mode,
         log: log,
       ),
       _modelAliases = _createModelAliases(contract),
       _collectionRegistry = _createCollectionRegistry(contract, collections);

  bool get isConnected => _runtime.isConnected;

  Future<void> connect() => _runtime.connect();

  Future<void> disconnect() async {
    await _runtime.disconnect();
    _delegates.clear();
  }

  Future<T> withConnection<T>(
    Future<T> Function(OrmScopedClient connection) run,
  ) async {
    final connection = await _runtime.connection();
    final scoped = OrmScopedClient._(
      contract: contract,
      executePlan: connection.execute,
      modelAliases: _modelAliases,
      collectionRegistry: _collectionRegistry,
      includeStrategySelector: includeStrategySelector,
      maxIncludeDepth: maxIncludeDepth,
    );

    try {
      return await run(scoped);
    } finally {
      await connection.release();
    }
  }

  Future<T> withTransaction<T>(
    Future<T> Function(OrmScopedClient transaction) run,
  ) async {
    final connection = await _runtime.connection();
    OrmRuntimeTransaction? transaction;

    try {
      final openedTransaction = await connection.transaction();
      transaction = openedTransaction;
      final scoped = OrmScopedClient._(
        contract: contract,
        executePlan: openedTransaction.execute,
        modelAliases: _modelAliases,
        collectionRegistry: _collectionRegistry,
        includeStrategySelector: includeStrategySelector,
        maxIncludeDepth: maxIncludeDepth,
      );
      final value = await run(scoped);
      await openedTransaction.commit();
      return value;
    } catch (_) {
      if (transaction != null) {
        try {
          await transaction.rollback();
        } catch (_) {
          // Keep the original exception when rollback fails.
        }
      }
      rethrow;
    } finally {
      await connection.release();
    }
  }

  Future<OrmRuntimeConnection> connection() => _runtime.connection();

  RuntimeTelemetryEvent? telemetry() => _runtime.telemetry();

  RuntimeOperationTelemetryEvent? operationTelemetry([String? operationId]) {
    return _runtime.operationTelemetry(operationId);
  }

  List<RuntimeOperationTelemetryEvent> recentOperationTelemetry({
    int limit = 50,
  }) {
    return _runtime.recentOperationTelemetry(limit: limit);
  }

  @override
  OrmDbNamespace get db => _db;

  @override
  ModelDelegate _resolveDelegate(String modelKey) {
    final modelName = _resolveModelOrThrow(modelKey: modelKey);
    return _delegates.putIfAbsent(modelName, () {
      final factory = _collectionRegistry[modelName];
      if (factory == null) {
        return ModelDelegate(client: this, modelName: modelName);
      }
      return factory(client: this, modelName: modelName);
    });
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) => _runtime.execute(plan);

  @override
  Future<T> transaction<T>(Future<T> Function(OrmDbNamespace txDb) run) {
    return withTransaction((scoped) => run(scoped.db));
  }

  String _resolveModelOrThrow({required String modelKey}) {
    final resolved = _resolveModel(modelKey);
    if (resolved != null) {
      return resolved;
    }
    throw ModelNotFoundException(modelKey, contract.models.keys);
  }

  String? _resolveModel(String modelKey) {
    final exact = _modelAliases[modelKey];
    if (exact != null) {
      return exact;
    }
    if (modelKey.endsWith('s') && modelKey.length > 1) {
      final singular = modelKey.substring(0, modelKey.length - 1);
      final singularMatch = _modelAliases[singular];
      if (singularMatch != null) {
        return singularMatch;
      }
    }
    return contract.resolveModel(modelKey);
  }
}

final class OrmScopedClient implements OrmDbContext, _OrmDelegateRuntime {
  @override
  final OrmContract contract;
  final Future<EngineResponse> Function(OrmPlan plan) _executePlan;
  final Map<String, String> _modelAliases;
  final Map<String, CollectionFactory> _collectionRegistry;
  final Map<String, ModelDelegate> _delegates = <String, ModelDelegate>{};
  late final OrmDbNamespace _db = OrmDbNamespace(
    sqlContext: this,
    resolveDelegate: _resolveDelegate,
  );
  @override
  final IncludeExecutionStrategySelector includeStrategySelector;
  @override
  final int maxIncludeDepth;

  OrmScopedClient._({
    required this.contract,
    required Future<EngineResponse> Function(OrmPlan plan) executePlan,
    required Map<String, String> modelAliases,
    required Map<String, CollectionFactory> collectionRegistry,
    required this.includeStrategySelector,
    required this.maxIncludeDepth,
  }) : _executePlan = executePlan,
       _modelAliases = modelAliases,
       _collectionRegistry = collectionRegistry;

  @override
  ModelDelegate _resolveDelegate(String modelKey) {
    final modelName = _resolveModelOrThrow(modelKey: modelKey);
    return _delegates.putIfAbsent(modelName, () {
      final factory = _collectionRegistry[modelName];
      if (factory == null) {
        return ModelDelegate(client: this, modelName: modelName);
      }
      return factory(client: this, modelName: modelName);
    });
  }

  @override
  OrmDbNamespace get db => _db;

  @override
  Future<EngineResponse> execute(OrmPlan plan) => _executePlan(plan);

  @override
  Future<T> transaction<T>(Future<T> Function(OrmDbNamespace txDb) run) {
    return run(db);
  }

  String _resolveModelOrThrow({required String modelKey}) {
    final resolved = _resolveModel(modelKey);
    if (resolved != null) {
      return resolved;
    }
    throw ModelNotFoundException(modelKey, contract.models.keys);
  }

  String? _resolveModel(String modelKey) {
    final exact = _modelAliases[modelKey];
    if (exact != null) {
      return exact;
    }
    if (modelKey.endsWith('s') && modelKey.length > 1) {
      final singular = modelKey.substring(0, modelKey.length - 1);
      final singularMatch = _modelAliases[singular];
      if (singularMatch != null) {
        return singularMatch;
      }
    }
    return contract.resolveModel(modelKey);
  }
}

@immutable
final class OrmSqlMutationResult {
  final JsonMap? row;
  final int affectedRows;

  const OrmSqlMutationResult({this.row, this.affectedRows = 0});
}

final class OrmDbNamespace {
  final OrmExecutionContext _sqlContext;
  final ModelDelegate Function(String modelKey) _resolveDelegate;

  late final OrmModelNamespace orm = OrmModelNamespace(_resolveDelegate);
  late final OrmSqlApi sql = OrmSqlApi(
    _sqlContext,
    resolveDelegate: _resolveDelegate,
  );

  OrmDbNamespace({
    required OrmExecutionContext sqlContext,
    required ModelDelegate Function(String modelKey) resolveDelegate,
  }) : _sqlContext = sqlContext,
       _resolveDelegate = resolveDelegate;
}

final class OrmModelNamespace {
  final ModelDelegate Function(String modelKey) _resolveModel;

  OrmModelNamespace(this._resolveModel);

  ModelDelegate model(String modelKey) => _resolveModel(modelKey);
}

final class OrmSqlApi {
  final OrmExecutionContext _client;
  final ModelDelegate Function(String modelKey) _resolveDelegate;

  const OrmSqlApi(
    this._client, {
    required ModelDelegate Function(String modelKey) resolveDelegate,
  }) : _resolveDelegate = resolveDelegate;

  OrmSqlSelectBuilder from(String modelKey) {
    return OrmSqlSelectBuilder._(
      client: _client,
      modelName: _resolveSqlModelName(
        resolveDelegate: _resolveDelegate,
        modelKey: modelKey,
      ),
    );
  }

  OrmSqlInsertBuilder insertInto(String modelKey) {
    return OrmSqlInsertBuilder._(
      client: _client,
      modelName: _resolveSqlModelName(
        resolveDelegate: _resolveDelegate,
        modelKey: modelKey,
      ),
    );
  }

  OrmSqlUpdateBuilder update(String modelKey) {
    return OrmSqlUpdateBuilder._(
      client: _client,
      modelName: _resolveSqlModelName(
        resolveDelegate: _resolveDelegate,
        modelKey: modelKey,
      ),
    );
  }

  OrmSqlDeleteBuilder deleteFrom(String modelKey) {
    return OrmSqlDeleteBuilder._(
      client: _client,
      modelName: _resolveSqlModelName(
        resolveDelegate: _resolveDelegate,
        modelKey: modelKey,
      ),
    );
  }
}

@immutable
final class OrmSqlSelectBuilder {
  final OrmExecutionContext _client;
  final String _modelName;
  final JsonMap _where;
  final int? _skip;
  final int? _take;
  final List<OrmOrderBy> _orderBy;
  final List<String> _distinct;
  final List<String> _select;

  OrmSqlSelectBuilder._({
    required OrmExecutionContext client,
    required String modelName,
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
  }) : _client = client,
       _modelName = modelName,
       _where = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(where),
       ),
       _skip = skip,
       _take = take,
       _orderBy = List<OrmOrderBy>.unmodifiable(orderBy),
       _distinct = List<String>.unmodifiable(distinct),
       _select = List<String>.unmodifiable(select);

  OrmSqlSelectBuilder where(JsonMap where) => _copy(where: where);

  OrmSqlSelectBuilder orderBy(List<OrmOrderBy> orderBy) =>
      _copy(orderBy: orderBy);

  OrmSqlSelectBuilder orderByField(
    String field, {
    SortOrder order = SortOrder.asc,
    bool append = true,
  }) {
    final nextOrderBy = append
        ? <OrmOrderBy>[..._orderBy, OrmOrderBy(field, order: order)]
        : <OrmOrderBy>[OrmOrderBy(field, order: order)];
    return _copy(orderBy: nextOrderBy);
  }

  OrmSqlSelectBuilder distinct(List<String> distinct) =>
      _copy(distinct: distinct);

  OrmSqlSelectBuilder select(List<String> fields) => _copy(select: fields);

  OrmSqlSelectBuilder selectField(String field, {bool append = true}) {
    final nextSelect = append ? <String>[..._select, field] : <String>[field];
    return _copy(select: nextSelect);
  }

  OrmSqlSelectBuilder skip(int? value) => _copy(skip: value);

  OrmSqlSelectBuilder take(int? value) => _copy(take: value);

  OrmPlan toPlan() {
    return _buildSqlPlan(
      client: _client,
      modelName: _modelName,
      action: OrmAction.read,
      where: _where,
      skip: _skip,
      take: _take,
      orderBy: _orderBy,
      distinct: _distinct,
      select: _select,
    );
  }

  Future<List<JsonMap>> all() async {
    final response = await _client.execute(toPlan());
    return _readRows(response.data, action: 'sql.all');
  }

  Future<JsonMap?> firstOrNull() async {
    final response = await _client.execute(take(1).toPlan());
    final rows = _readRows(response.data, action: 'sql.firstOrNull');
    return _firstOrNull(rows);
  }

  Stream<JsonMap> stream() async* {
    final rows = await all();
    for (final row in rows) {
      yield row;
    }
  }

  OrmSqlSelectBuilder _copy({
    JsonMap? where,
    Object? skip = _sqlKeepToken,
    Object? take = _sqlKeepToken,
    List<OrmOrderBy>? orderBy,
    List<String>? distinct,
    List<String>? select,
  }) {
    return OrmSqlSelectBuilder._(
      client: _client,
      modelName: _modelName,
      where: where ?? _where,
      skip: identical(skip, _sqlKeepToken) ? _skip : skip as int?,
      take: identical(take, _sqlKeepToken) ? _take : take as int?,
      orderBy: orderBy ?? _orderBy,
      distinct: distinct ?? _distinct,
      select: select ?? _select,
    );
  }
}

@immutable
final class OrmSqlInsertBuilder {
  final OrmExecutionContext _client;
  final String _modelName;
  final JsonMap _data;
  final List<String> _select;

  OrmSqlInsertBuilder._({
    required OrmExecutionContext client,
    required String modelName,
    JsonMap data = const <String, Object?>{},
    List<String> select = const <String>[],
  }) : _client = client,
       _modelName = modelName,
       _data = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(data),
       ),
       _select = List<String>.unmodifiable(select);

  OrmSqlInsertBuilder values(JsonMap data) => _copy(data: data);

  OrmSqlInsertBuilder returning(List<String> fields) => _copy(select: fields);

  OrmSqlInsertBuilder returningField(String field, {bool append = true}) {
    final nextSelect = append ? <String>[..._select, field] : <String>[field];
    return _copy(select: nextSelect);
  }

  OrmPlan toPlan() {
    return _buildSqlPlan(
      client: _client,
      modelName: _modelName,
      action: OrmAction.create,
      mutationResultMode: OrmMutationResultMode.rowOrNull,
      data: _data,
      select: _select,
    );
  }

  Future<OrmSqlMutationResult> execute() async {
    final response = await _client.execute(toPlan());
    return OrmSqlMutationResult(
      row: _readRow(response.data, action: 'sql.insert'),
      affectedRows: response.affectedRows,
    );
  }

  Future<JsonMap?> one() async => (await execute()).row;

  OrmSqlInsertBuilder _copy({JsonMap? data, List<String>? select}) {
    return OrmSqlInsertBuilder._(
      client: _client,
      modelName: _modelName,
      data: data ?? _data,
      select: select ?? _select,
    );
  }
}

@immutable
final class OrmSqlUpdateBuilder {
  final OrmExecutionContext _client;
  final String _modelName;
  final JsonMap _where;
  final JsonMap _data;
  final List<String> _select;

  OrmSqlUpdateBuilder._({
    required OrmExecutionContext client,
    required String modelName,
    JsonMap where = const <String, Object?>{},
    JsonMap data = const <String, Object?>{},
    List<String> select = const <String>[],
  }) : _client = client,
       _modelName = modelName,
       _where = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(where),
       ),
       _data = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(data),
       ),
       _select = List<String>.unmodifiable(select);

  OrmSqlUpdateBuilder where(JsonMap where) => _copy(where: where);

  OrmSqlUpdateBuilder set(JsonMap data) => _copy(data: data);

  OrmSqlUpdateBuilder returning(List<String> fields) => _copy(select: fields);

  OrmSqlUpdateBuilder returningField(String field, {bool append = true}) {
    final nextSelect = append ? <String>[..._select, field] : <String>[field];
    return _copy(select: nextSelect);
  }

  OrmPlan toPlan() {
    return _buildSqlPlan(
      client: _client,
      modelName: _modelName,
      action: OrmAction.update,
      mutationResultMode: OrmMutationResultMode.rowOrNull,
      where: _where,
      data: _data,
      select: _select,
    );
  }

  Future<OrmSqlMutationResult> execute() async {
    final response = await _client.execute(toPlan());
    return OrmSqlMutationResult(
      row: _readRow(response.data, action: 'sql.update'),
      affectedRows: response.affectedRows,
    );
  }

  Future<JsonMap?> one() async => (await execute()).row;

  OrmSqlUpdateBuilder _copy({
    JsonMap? where,
    JsonMap? data,
    List<String>? select,
  }) {
    return OrmSqlUpdateBuilder._(
      client: _client,
      modelName: _modelName,
      where: where ?? _where,
      data: data ?? _data,
      select: select ?? _select,
    );
  }
}

@immutable
final class OrmSqlDeleteBuilder {
  final OrmExecutionContext _client;
  final String _modelName;
  final JsonMap _where;
  final List<String> _select;

  OrmSqlDeleteBuilder._({
    required OrmExecutionContext client,
    required String modelName,
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
  }) : _client = client,
       _modelName = modelName,
       _where = Map<String, Object?>.unmodifiable(
         Map<String, Object?>.from(where),
       ),
       _select = List<String>.unmodifiable(select);

  OrmSqlDeleteBuilder where(JsonMap where) => _copy(where: where);

  OrmSqlDeleteBuilder returning(List<String> fields) => _copy(select: fields);

  OrmSqlDeleteBuilder returningField(String field, {bool append = true}) {
    final nextSelect = append ? <String>[..._select, field] : <String>[field];
    return _copy(select: nextSelect);
  }

  OrmPlan toPlan() {
    return _buildSqlPlan(
      client: _client,
      modelName: _modelName,
      action: OrmAction.delete,
      mutationResultMode: OrmMutationResultMode.rowOrNull,
      where: _where,
      select: _select,
    );
  }

  Future<OrmSqlMutationResult> execute() async {
    final response = await _client.execute(toPlan());
    return OrmSqlMutationResult(
      row: _readRow(response.data, action: 'sql.delete'),
      affectedRows: response.affectedRows,
    );
  }

  Future<JsonMap?> one() async => (await execute()).row;

  OrmSqlDeleteBuilder _copy({JsonMap? where, List<String>? select}) {
    return OrmSqlDeleteBuilder._(
      client: _client,
      modelName: _modelName,
      where: where ?? _where,
      select: select ?? _select,
    );
  }
}

const Object _sqlKeepToken = Object();

String _resolveSqlModelName({
  required ModelDelegate Function(String modelKey) resolveDelegate,
  required String modelKey,
}) {
  final delegate = resolveDelegate(modelKey);
  return delegate.modelName;
}

OrmPlan _buildSqlPlan({
  required OrmExecutionContext client,
  required String modelName,
  required OrmAction action,
  OrmMutationResultMode? mutationResultMode,
  JsonMap where = const <String, Object?>{},
  JsonMap data = const <String, Object?>{},
  int? skip,
  int? take,
  List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
  List<String> distinct = const <String>[],
  List<String> select = const <String>[],
}) {
  final contract = client.contract;
  return action == OrmAction.read
      ? OrmPlan.read(
          contractHash: contract.hash,
          target: contract.target,
          storageHash: contract.markerStorageHash,
          profileHash: contract.profileHash,
          lane: 'sql',
          model: modelName,
          where: where,
          skip: skip,
          take: take,
          orderBy: orderBy,
          distinct: distinct,
          select: select,
          resultMode: OrmReadResultMode.all,
        )
      : OrmPlan.mutation(
          contractHash: contract.hash,
          target: contract.target,
          storageHash: contract.markerStorageHash,
          profileHash: contract.profileHash,
          lane: 'sql',
          model: modelName,
          action: action,
          where: where,
          data: data,
          select: select,
          resultMode: mutationResultMode ?? OrmMutationResultMode.rowOrNull,
        );
}

@immutable
final class _PreparedReadPlan {
  final OrmPlan plan;
  final Map<String, IncludeSpec> include;

  const _PreparedReadPlan({required this.plan, required this.include});
}

class ModelDelegate {
  final OrmCollectionContext _client;
  final String modelName;

  ModelDelegate({required OrmCollectionContext client, required this.modelName})
    : _client = client;

  @protected
  OrmCollectionContext get client => _client;

  _OrmDelegateRuntime get _runtime => _client as _OrmDelegateRuntime;

  ModelQuery query() => ModelQuery._(this, const ModelQueryState());

  ModelQuery where(JsonMap where) => query().where(where);

  ModelQuery whereWith(
    JsonMap Function(JsonMap where) build, {
    bool merge = true,
  }) => query().whereWith(build, merge: merge);

  ModelQuery orderBy(List<OrmOrderBy> orderBy) => query().orderBy(orderBy);

  ModelQuery orderByField(String field, {SortOrder order = SortOrder.asc}) =>
      query().orderByField(field, order: order);

  ModelQuery skip(int value) => query().skip(value);

  ModelQuery take(int value) => query().take(value);

  ModelQuery cursor(JsonMap cursor) => query().cursor(cursor);

  ModelQuery page({
    required int size,
    JsonMap? after,
    JsonMap? before,
  }) => query().page(size: size, after: after, before: before);

  ModelQuery select(List<String> fields) => query().select(fields);

  ModelQuery selectWith(
    List<String> Function(List<String> fields) build, {
    bool append = false,
  }) => query().selectWith(build, append: append);

  ModelQuery selectField(String field) => query().selectField(field);

  ModelQuery distinct(List<String> fields, {bool append = false}) =>
      query().distinct(fields, append: append);

  ModelQuery distinctField(String field) => query().distinctField(field);

  ModelQuery include(Map<String, IncludeSpec> include) =>
      query().include(include);

  ModelQuery includeWith(
    Map<String, IncludeSpec> Function(Map<String, IncludeSpec> include) build, {
    bool merge = true,
  }) => query().includeWith(build, merge: merge);

  ModelQuery includeRelation(
    String relation, {
    IncludeSpec spec = const IncludeSpec(),
  }) => query().includeRelation(relation, spec: spec);

  Future<OrmPlan> toPlan({
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    JsonMap? cursor,
    OrmReadPagePlan? page,
  }) async {
    final prepared = await _buildReadPlan(
      resultMode: OrmReadResultMode.all,
      where: where,
      skip: skip,
      take: take,
      orderBy: orderBy,
      distinct: distinct,
      select: select,
      include: include,
      cursor: cursor,
      page: page,
    );
    return prepared.plan;
  }

  Future<List<JsonMap>> all({
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _readAllInternal(
      action: OrmAction.read,
      where: where,
      skip: skip,
      take: take,
      orderBy: orderBy,
      distinct: distinct,
      select: select,
      include: include,
      includeDepth: 0,
    );
  }

  Stream<JsonMap> stream({
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) async* {
    final rows = await all(
      where: where,
      skip: skip,
      take: take,
      orderBy: orderBy,
      distinct: distinct,
      select: select,
      include: include,
    );

    for (final row in rows) {
      yield row;
    }
  }

  Future<JsonMap?> oneOrNull({
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _readOneInternal(
      action: OrmAction.read,
      where: where,
      select: select,
      include: include,
      includeDepth: 0,
    );
  }

  Future<JsonMap?> firstOrNull({
    JsonMap where = const <String, Object?>{},
    int? skip,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) async {
    return _readFirstInternal(
      action: OrmAction.read,
      where: where,
      skip: skip,
      orderBy: orderBy,
      distinct: distinct,
      select: select,
      include: include,
      includeDepth: 0,
    );
  }

  Future<int> count({JsonMap where = const <String, Object?>{}}) async {
    final rows = await _readAllInternal(
      action: OrmAction.read,
      where: where,
      includeDepth: 0,
    );
    return rows.length;
  }

  Future<bool> exists({JsonMap where = const <String, Object?>{}}) async {
    final row = await firstOrNull(where: where, select: const <String>[]);
    return row != null;
  }

  Future<JsonMap> aggregate({
    JsonMap where = const <String, Object?>{},
    bool countAll = false,
    List<String> count = const <String>[],
    List<String> min = const <String>[],
    List<String> max = const <String>[],
    List<String> sum = const <String>[],
    List<String> avg = const <String>[],
  }) async {
    _assertKnownAggregateFields(fields: count, source: 'aggregate.count');
    _assertKnownAggregateFields(fields: min, source: 'aggregate.min');
    _assertKnownAggregateFields(fields: max, source: 'aggregate.max');
    _assertKnownAggregateFields(fields: sum, source: 'aggregate.sum');
    _assertKnownAggregateFields(fields: avg, source: 'aggregate.avg');

    final rows = await _readAllInternal(
      action: OrmAction.read,
      where: where,
      select: _buildAggregateSelect(
        count: count,
        min: min,
        max: max,
        sum: sum,
        avg: avg,
      ),
      includeDepth: 0,
    );

    return _buildAggregateResult(
      rows: rows,
      countAll: countAll,
      count: count,
      min: min,
      max: max,
      sum: sum,
      avg: avg,
    );
  }

  Future<List<JsonMap>> groupBy({
    required List<String> by,
    JsonMap where = const <String, Object?>{},
    JsonMap having = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    bool countAll = false,
    List<String> count = const <String>[],
    List<String> min = const <String>[],
    List<String> max = const <String>[],
    List<String> sum = const <String>[],
    List<String> avg = const <String>[],
  }) async {
    if (by.isEmpty) {
      throw runtimeError(
        'PLAN.GROUP_BY_FIELDS_EMPTY',
        'GroupBy requires at least one field in by.',
        details: <String, Object?>{'model': modelName},
      );
    }
    if (skip case final offset? when offset < 0) {
      throw PlanInvalidPaginationException(key: 'skip', value: offset);
    }
    if (take case final limit? when limit < 0) {
      throw PlanInvalidPaginationException(key: 'take', value: limit);
    }

    _assertKnownAggregateFields(fields: by, source: 'groupBy.by');
    _assertKnownAggregateFields(fields: count, source: 'groupBy.count');
    _assertKnownAggregateFields(fields: min, source: 'groupBy.min');
    _assertKnownAggregateFields(fields: max, source: 'groupBy.max');
    _assertKnownAggregateFields(fields: sum, source: 'groupBy.sum');
    _assertKnownAggregateFields(fields: avg, source: 'groupBy.avg');
    _assertGroupByOrderByFields(
      orderBy: orderBy,
      by: by,
      countAll: countAll,
      count: count,
      min: min,
      max: max,
      sum: sum,
      avg: avg,
    );
    _assertGroupByHavingFields(
      having: having,
      by: by,
      countAll: countAll,
      count: count,
      min: min,
      max: max,
      sum: sum,
      avg: avg,
    );

    final rows = await _readAllInternal(
      action: OrmAction.read,
      where: where,
      select: _buildAggregateSelect(
        count: by.followedBy(count).toList(growable: false),
        min: min,
        max: max,
        sum: sum,
        avg: avg,
      ),
      includeDepth: 0,
    );

    final groupedRows = <_RelationMergeKey, List<JsonMap>>{};
    for (final row in rows) {
      final key = _RelationMergeKey(
        by
            .map((field) => row.containsKey(field) ? row[field] : null)
            .toList(growable: false),
      );
      groupedRows.putIfAbsent(key, () => <JsonMap>[]).add(row);
    }

    var results = <JsonMap>[];
    for (final entry in groupedRows.entries) {
      final groupRows = entry.value;
      if (groupRows.isEmpty) {
        continue;
      }

      final groupResult = <String, Object?>{};
      final first = groupRows.first;
      for (final field in by) {
        groupResult[field] = first[field];
      }
      groupResult.addAll(
        _buildAggregateResult(
          rows: groupRows,
          countAll: countAll,
          count: count,
          min: min,
          max: max,
          sum: sum,
          avg: avg,
        ),
      );
      results.add(groupResult);
    }

    if (having.isNotEmpty) {
      results = results
          .where((row) => _matchesGroupByHaving(row: row, having: having))
          .toList(growable: false);
    }

    if (orderBy.isNotEmpty) {
      results.sort(
        (left, right) => _compareRowsForGroupByOrderBy(
          left: left,
          right: right,
          orderBy: orderBy,
        ),
      );
    }

    return _sliceRows(rows: results, skip: skip, take: take);
  }

  Future<JsonMap> create({
    required JsonMap data,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) => _RepositoryMutationExecutor(this).create(
    data: data,
    select: select,
    include: include,
  );

  Future<JsonMap> createNested({
    required JsonMap data,
    Map<String, List<JsonMap>> create = const <String, List<JsonMap>>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) => _RepositoryMutationExecutor(this).createNested(
    data: data,
    nestedCreate: create,
    select: select,
    include: include,
  );

  Future<JsonMap?> updateNested({
    JsonMap where = const <String, Object?>{},
    required JsonMap data,
    Map<String, List<JsonMap>> create = const <String, List<JsonMap>>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) => _RepositoryMutationExecutor(this).updateNested(
    where: where,
    data: data,
    nestedCreate: create,
    select: select,
    include: include,
  );

  Future<List<JsonMap>> createMany({
    required List<JsonMap> data,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) => _RepositoryMutationExecutor(this).createMany(
    data: data,
    select: select,
    include: include,
  );

  Future<int> updateMany({
    JsonMap where = const <String, Object?>{},
    required JsonMap data,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) async {
    _throwApiNotImplemented(
      'orm.updateMany',
      details: <String, Object?>{
        'model': modelName,
        'where': where,
        'data': data,
        'select': select,
        'include': include.keys.toList(growable: false),
      },
    );
  }

  Future<int> deleteMany({JsonMap where = const <String, Object?>{}}) =>
      _RepositoryMutationExecutor(this).deleteMany(where: where);

  Future<JsonMap> upsert({
    required JsonMap where,
    required JsonMap create,
    required JsonMap update,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) => _RepositoryMutationExecutor(this).upsert(
    where: where,
    create: create,
    update: update,
    select: select,
    include: include,
  );

  Future<JsonMap?> update({
    JsonMap where = const <String, Object?>{},
    required JsonMap data,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) => _RepositoryMutationExecutor(this).update(
    where: where,
    data: data,
    select: select,
    include: include,
  );

  Future<JsonMap?> delete({
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) => _RepositoryMutationExecutor(this).delete(
    where: where,
    select: select,
    include: include,
  );

  Future<_PreparedReadPlan> _buildReadPlan({
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

    final normalizedInclude = _normalizeInclude(include);
    final normalizedWhere = await _normalizeWhereForExecution(
      model: modelName,
      where: where,
    );
    final isCollectionRead = resultMode != OrmReadResultMode.oneOrNull;
    final resolvedTake = resultMode == OrmReadResultMode.firstOrNull ? 1 : take;
    final readSelect = switch (resultMode) {
      OrmReadResultMode.oneOrNull => _expandSelectForInclude(
        model: modelName,
        select: select,
        include: normalizedInclude,
      ),
      OrmReadResultMode.all || OrmReadResultMode.firstOrNull =>
        _expandSelectForExecution(
          model: modelName,
          select: select,
          include: normalizedInclude,
          distinct: distinct,
        ),
    };

    return _PreparedReadPlan(
      include: normalizedInclude,
      plan: OrmPlan.read(
        contractHash: _client.contract.hash,
        target: _client.contract.target,
        storageHash: _client.contract.markerStorageHash,
        profileHash: _client.contract.profileHash,
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
        model: modelName,
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

  Future<List<JsonMap>> _readAllInternal({
    required OrmAction action,
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
    required int includeDepth,
  }) async {
    final prepared = await _buildReadPlan(
      resultMode: OrmReadResultMode.all,
      where: where,
      skip: skip,
      take: take,
      orderBy: orderBy,
      distinct: distinct,
      select: select,
      include: include,
      annotations: annotations,
      repositoryTrace: repositoryTrace,
    );
    final normalizedInclude = prepared.include;
    final response = await _client.execute(prepared.plan);

    var rows = _readRows(response.data);
    if (distinct.isNotEmpty) {
      rows = _applyDistinctRows(rows: rows, distinct: distinct);
      rows = _sliceRows(rows: rows, skip: skip, take: take);
    }
    final hydratedRows = await _resolveIncludeRows(
      action: action,
      rows: rows,
      include: normalizedInclude,
      depth: includeDepth,
    );

    return _shapeRows(hydratedRows, select: select, include: normalizedInclude);
  }

  Future<JsonMap?> _readFirstInternal({
    required OrmAction action,
    JsonMap where = const <String, Object?>{},
    int? skip,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
    required int includeDepth,
  }) async {
    final prepared = await _buildReadPlan(
      resultMode: OrmReadResultMode.firstOrNull,
      where: where,
      skip: skip,
      orderBy: orderBy,
      distinct: distinct,
      select: select,
      include: include,
      annotations: annotations,
      repositoryTrace: repositoryTrace,
    );
    final normalizedInclude = prepared.include;
    final response = await _client.execute(prepared.plan);

    final row = _readRow(response.data, action: 'firstOrNull');
    if (row == null) {
      return null;
    }

    final hydratedRows = await _resolveIncludeRows(
      action: action,
      rows: <JsonMap>[row],
      include: normalizedInclude,
      depth: includeDepth,
    );

    return _shapeRows(
      hydratedRows,
      select: select,
      include: normalizedInclude,
    ).single;
  }

  Future<JsonMap?> _readOneInternal({
    required OrmAction action,
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
    required int includeDepth,
  }) async {
    final prepared = await _buildReadPlan(
      resultMode: OrmReadResultMode.oneOrNull,
      where: where,
      select: select,
      include: include,
      annotations: annotations,
      repositoryTrace: repositoryTrace,
    );
    final normalizedInclude = prepared.include;
    final response = await _client.execute(prepared.plan);

    final row = _readRow(response.data, action: 'oneOrNull');
    if (row == null) {
      return null;
    }

    final hydratedRows = await _resolveIncludeRows(
      action: action,
      rows: <JsonMap>[row],
      include: normalizedInclude,
      depth: includeDepth,
    );

    return _shapeRows(
      hydratedRows,
      select: select,
      include: normalizedInclude,
    ).single;
  }

  Future<List<JsonMap>> _resolveIncludeRows({
    required OrmAction action,
    required List<JsonMap> rows,
    required Map<String, IncludeSpec> include,
    required int depth,
    _RepositoryOperation? operation,
  }) {
    return _RepositoryIncludePlanner(
      this,
    ).resolve(
      action: action,
      rows: rows,
      include: include,
      depth: depth,
      operation: operation,
    );
  }

  ModelRelationContract _resolveRelation({
    required String model,
    required String relationName,
  }) {
    final modelContract = _client.contract.models[model];
    if (modelContract == null) {
      throw ModelNotFoundException(model, _client.contract.models.keys);
    }

    final relation = modelContract.relations[relationName];
    if (relation != null) {
      return relation;
    }

    throw IncludeRelationNotFoundException(
      model: model,
      relation: relationName,
      availableRelations: modelContract.relations.keys,
    );
  }

  JsonMap? _buildRelationWhere({
    required JsonMap row,
    required ModelRelationContract relation,
  }) {
    final where = <String, Object?>{};

    for (var index = 0; index < relation.sourceFields.length; index++) {
      final sourceField = relation.sourceFields[index];
      final targetField = relation.targetFields[index];
      if (!row.containsKey(sourceField)) {
        return null;
      }

      final value = row[sourceField];
      if (value == null) {
        return null;
      }

      where[targetField] = value;
    }

    return where;
  }

  JsonMap _buildSingleQueryRelationBaseWhere({
    required JsonMap includeWhere,
    required ModelRelationContract relation,
  }) {
    if (includeWhere.isEmpty) {
      return const <String, Object?>{};
    }

    final targetFields = relation.targetFields.toSet();
    final baseWhere = <String, Object?>{};
    var removedTargetField = false;
    for (final entry in includeWhere.entries) {
      if (targetFields.contains(entry.key)) {
        removedTargetField = true;
        continue;
      }
      baseWhere[entry.key] = entry.value;
    }

    if (!removedTargetField) {
      return includeWhere;
    }

    if (baseWhere.isEmpty) {
      return const <String, Object?>{};
    }
    return baseWhere;
  }

  List<String> _buildSingleQueryRelationSelect({
    required IncludeSpec include,
    required ModelRelationContract relation,
  }) {
    if (include.select.isEmpty) {
      return const <String>[];
    }

    final expanded = <String>{...include.select, ...relation.targetFields};
    return expanded.toList(growable: false);
  }

  void _validateIncludePagination({required IncludeSpec include}) {
    if (include.skip case final skip?) {
      if (skip < 0) {
        throw PlanInvalidPaginationException(key: 'skip', value: skip);
      }
    }
    if (include.take case final take?) {
      if (take < 0) {
        throw PlanInvalidPaginationException(key: 'take', value: take);
      }
    }
  }

  Map<_RelationMergeKey, List<JsonMap>> _groupRowsByRelationFields({
    required List<JsonMap> rows,
    required List<String> fields,
  }) {
    final grouped = <_RelationMergeKey, List<JsonMap>>{};
    for (final row in rows) {
      final key = _buildRelationMergeKeyFromRow(row: row, fields: fields);
      if (key == null) {
        continue;
      }
      grouped.putIfAbsent(key, () => <JsonMap>[]).add(row);
    }
    return grouped;
  }

  _RelationMergeKey? _buildRelationMergeKeyFromRow({
    required JsonMap row,
    required List<String> fields,
  }) {
    final values = <Object?>[];
    for (final field in fields) {
      if (!row.containsKey(field)) {
        return null;
      }
      final value = row[field];
      if (value == null) {
        return null;
      }
      values.add(value);
    }

    return _RelationMergeKey(values);
  }

  List<JsonMap> _sliceRows({
    required List<JsonMap> rows,
    required int? skip,
    required int? take,
  }) {
    if (rows.isEmpty) {
      return const <JsonMap>[];
    }

    var window = rows;
    if (skip case final offset?) {
      if (offset >= window.length) {
        return const <JsonMap>[];
      }
      window = window.sublist(offset);
    }

    if (take case final limit?) {
      if (limit == 0) {
        return const <JsonMap>[];
      }
      if (limit < window.length) {
        window = window.sublist(0, limit);
      }
    }

    return List<JsonMap>.from(window, growable: false);
  }

  List<String> _expandSelectForExecution({
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
        final relation = _resolveRelation(
          model: model,
          relationName: relationName,
        );
        expanded.addAll(relation.sourceFields);
      }
    }

    return expanded.toList(growable: false);
  }

  List<String> _expandSelectForInclude({
    required String model,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    return _expandSelectForExecution(
      model: model,
      select: select,
      include: include,
      distinct: const <String>[],
    );
  }

  void _assertKnownAggregateFields({
    required List<String> fields,
    required String source,
  }) {
    if (fields.isEmpty) {
      return;
    }

    final model = _client.contract.models[modelName];
    if (model == null) {
      throw ModelNotFoundException(modelName, _client.contract.models.keys);
    }

    for (final field in fields) {
      if (model.fields.contains(field)) {
        continue;
      }
      throw PlanFieldNotFoundException(
        model: modelName,
        field: field,
        source: source,
      );
    }
  }

  void _assertGroupByOrderByFields({
    required List<OrmOrderBy> orderBy,
    required List<String> by,
    required bool countAll,
    required List<String> count,
    required List<String> min,
    required List<String> max,
    required List<String> sum,
    required List<String> avg,
  }) {
    if (orderBy.isEmpty) {
      return;
    }

    final allowedFields = _groupByOrderableFields(
      by: by,
      countAll: countAll,
      count: count,
      min: min,
      max: max,
      sum: sum,
      avg: avg,
    );
    for (final clause in orderBy) {
      if (allowedFields.contains(clause.field)) {
        continue;
      }
      throw runtimeError(
        'PLAN.GROUP_BY_ORDER_BY_INVALID',
        'GroupBy orderBy field is not available in grouped results.',
        details: <String, Object?>{
          'model': modelName,
          'field': clause.field,
          'allowedFields': allowedFields.toList(growable: false),
        },
      );
    }
  }

  void _assertGroupByHavingFields({
    required JsonMap having,
    required List<String> by,
    required bool countAll,
    required List<String> count,
    required List<String> min,
    required List<String> max,
    required List<String> sum,
    required List<String> avg,
  }) {
    if (having.isEmpty) {
      return;
    }
    _assertGroupByHavingClause(
      clause: having,
      source: 'groupBy.having',
      by: by,
      countAll: countAll,
      count: count,
      min: min,
      max: max,
      sum: sum,
      avg: avg,
    );
  }

  void _assertGroupByHavingClause({
    required JsonMap clause,
    required String source,
    required List<String> by,
    required bool countAll,
    required List<String> count,
    required List<String> min,
    required List<String> max,
    required List<String> sum,
    required List<String> avg,
  }) {
    for (final entry in clause.entries) {
      final key = entry.key;
      final value = entry.value;
      if (_whereLogicalKeys.contains(key)) {
        final nestedMap = _coerceWhereMap(value);
        if (nestedMap != null) {
          _assertGroupByHavingClause(
            clause: nestedMap,
            source: '$source.$key',
            by: by,
            countAll: countAll,
            count: count,
            min: min,
            max: max,
            sum: sum,
            avg: avg,
          );
          continue;
        }

        final nestedList = _coerceWhereList(value);
        if (nestedList == null) {
          throw runtimeError(
            'PLAN.GROUP_BY_HAVING_INVALID',
            'GroupBy having logical operator expects a map or list of maps.',
            details: <String, Object?>{
              'model': modelName,
              'source': '$source.$key',
            },
          );
        }
        for (var index = 0; index < nestedList.length; index++) {
          _assertGroupByHavingClause(
            clause: nestedList[index],
            source: '$source.$key[$index]',
            by: by,
            countAll: countAll,
            count: count,
            min: min,
            max: max,
            sum: sum,
            avg: avg,
          );
        }
        continue;
      }

      if (by.contains(key)) {
        _assertGroupByHavingCondition(condition: value, source: '$source.$key');
        continue;
      }

      final aggregateBucket = _normalizeGroupByAggregateBucket(key);
      if (aggregateBucket != null) {
        final aggregateFilters = _coerceWhereMap(value);
        if (aggregateFilters == null) {
          throw runtimeError(
            'PLAN.GROUP_BY_HAVING_INVALID',
            'GroupBy having aggregate bucket expects a map.',
            details: <String, Object?>{
              'model': modelName,
              'source': '$source.$key',
              'bucket': key,
            },
          );
        }
        final allowedFields = _groupByAggregateBucketFields(
          bucket: aggregateBucket,
          countAll: countAll,
          count: count,
          min: min,
          max: max,
          sum: sum,
          avg: avg,
        );
        for (final aggregateEntry in aggregateFilters.entries) {
          final aggregateField = aggregateEntry.key;
          if (!allowedFields.contains(aggregateField)) {
            throw runtimeError(
              'PLAN.GROUP_BY_HAVING_FIELD_INVALID',
              'GroupBy having references an aggregate field that is not selected.',
              details: <String, Object?>{
                'model': modelName,
                'source': '$source.$key.$aggregateField',
                'bucket': key,
                'field': aggregateField,
                'allowedFields': allowedFields.toList(growable: false),
              },
            );
          }
          _assertGroupByHavingCondition(
            condition: aggregateEntry.value,
            source: '$source.$key.$aggregateField',
          );
        }
        continue;
      }

      throw runtimeError(
        'PLAN.GROUP_BY_HAVING_FIELD_INVALID',
        'GroupBy having field is not groupable or aggregated.',
        details: <String, Object?>{
          'model': modelName,
          'source': '$source.$key',
          'field': key,
          'allowedFields': <String>[
            ...by,
            ..._groupByAggregateBuckets,
            ..._groupByAggregateBucketAliases.keys,
            ..._whereLogicalKeys,
          ],
        },
      );
    }
  }

  void _assertGroupByHavingCondition({
    required Object? condition,
    required String source,
  }) {
    final conditionMap = _coerceWhereMap(condition);
    if (conditionMap == null || conditionMap.isEmpty) {
      return;
    }

    final unknownOperators = conditionMap.keys
        .where((operator) => !_filterOperators.contains(operator))
        .toList(growable: false);
    if (unknownOperators.isNotEmpty) {
      throw runtimeError(
        'PLAN.GROUP_BY_HAVING_OPERATOR_INVALID',
        'GroupBy having contains unknown filter operators.',
        details: <String, Object?>{
          'model': modelName,
          'source': source,
          'unknownOperators': unknownOperators,
          'supportedOperators': _filterOperators.toList(growable: false),
        },
      );
    }

    for (final entry in conditionMap.entries) {
      final operator = entry.key;
      final operand = entry.value;
      if ((operator == 'in' || operator == 'notIn') && operand is! List) {
        throw runtimeError(
          'PLAN.GROUP_BY_HAVING_OPERATOR_INVALID',
          'GroupBy having in/notIn expects a list operand.',
          details: <String, Object?>{
            'model': modelName,
            'source': '$source.$operator',
            'operator': operator,
          },
        );
      }
      if (operator == 'not') {
        _assertGroupByHavingCondition(
          condition: operand,
          source: '$source.$operator',
        );
      }
    }
  }

  Set<String> _groupByOrderableFields({
    required List<String> by,
    required bool countAll,
    required List<String> count,
    required List<String> min,
    required List<String> max,
    required List<String> sum,
    required List<String> avg,
  }) {
    final fields = <String>{...by};
    for (final bucket in _groupByAggregateBuckets) {
      final bucketFields = _groupByAggregateBucketFields(
        bucket: bucket,
        countAll: countAll,
        count: count,
        min: min,
        max: max,
        sum: sum,
        avg: avg,
      );
      for (final field in bucketFields) {
        fields.add('$bucket.$field');
        fields.addAll(_groupByAggregateBucketAliasFieldPaths(bucket, field));
      }
    }
    return fields;
  }

  Set<String> _groupByAggregateBucketFields({
    required String bucket,
    required bool countAll,
    required List<String> count,
    required List<String> min,
    required List<String> max,
    required List<String> sum,
    required List<String> avg,
  }) {
    return switch (bucket) {
      'count' => <String>{if (countAll) 'all', ...count},
      'min' => <String>{...min},
      'max' => <String>{...max},
      'sum' => <String>{...sum},
      'avg' => <String>{...avg},
      _ => const <String>{},
    };
  }

  String? _normalizeGroupByAggregateBucket(String bucket) {
    if (_groupByAggregateBuckets.contains(bucket)) {
      return bucket;
    }
    return _groupByAggregateBucketAliases[bucket];
  }

  Set<String> _groupByAggregateBucketAliasFieldPaths(
    String bucket,
    String field,
  ) {
    final paths = <String>{};
    for (final alias in _groupByAggregateBucketAliases.entries) {
      if (alias.value != bucket) {
        continue;
      }
      paths.add('${alias.key}.$field');
    }
    return paths;
  }

  bool _matchesGroupByHaving({required JsonMap row, required JsonMap having}) {
    for (final entry in having.entries) {
      final key = entry.key;
      final value = entry.value;

      if (_whereLogicalKeys.contains(key)) {
        final logicalMatches = _matchesGroupByHavingLogical(
          row: row,
          operator: key,
          operand: value,
        );
        if (!logicalMatches) {
          return false;
        }
        continue;
      }

      final aggregateBucket = _normalizeGroupByAggregateBucket(key);
      if (aggregateBucket != null) {
        final aggregateFilters = _coerceWhereMap(value);
        if (aggregateFilters == null) {
          return false;
        }
        for (final aggregateEntry in aggregateFilters.entries) {
          final aggregateValue = _readGroupByAggregateValue(
            row: row,
            bucket: aggregateBucket,
            field: aggregateEntry.key,
          );
          if (!_matchesGroupByHavingCondition(
            actual: aggregateValue,
            condition: aggregateEntry.value,
          )) {
            return false;
          }
        }
        continue;
      }

      if (!_matchesGroupByHavingCondition(actual: row[key], condition: value)) {
        return false;
      }
    }

    return true;
  }

  bool _matchesGroupByHavingLogical({
    required JsonMap row,
    required String operator,
    required Object? operand,
  }) {
    final nestedMap = _coerceWhereMap(operand);
    if (nestedMap != null) {
      final matched = _matchesGroupByHaving(row: row, having: nestedMap);
      return operator == 'NOT' ? !matched : matched;
    }

    final nestedList = _coerceWhereList(operand);
    if (nestedList == null) {
      return false;
    }

    return switch (operator) {
      'AND' => nestedList.every(
        (clause) => _matchesGroupByHaving(row: row, having: clause),
      ),
      'OR' => nestedList.any(
        (clause) => _matchesGroupByHaving(row: row, having: clause),
      ),
      'NOT' => nestedList.every(
        (clause) => !_matchesGroupByHaving(row: row, having: clause),
      ),
      _ => false,
    };
  }

  bool _matchesGroupByHavingCondition({
    required Object? actual,
    required Object? condition,
  }) {
    final conditionMap = _coerceWhereMap(condition);
    if (conditionMap == null || conditionMap.isEmpty) {
      return actual == condition;
    }

    if (conditionMap.keys.any(
      (operator) => !_filterOperators.contains(operator),
    )) {
      return false;
    }

    for (final operator in _filterOperatorOrder) {
      if (!conditionMap.containsKey(operator)) {
        continue;
      }
      final operand = conditionMap[operator];
      if (!_matchesGroupByHavingOperator(
        actual: actual,
        operator: operator,
        operand: operand,
      )) {
        return false;
      }
    }
    return true;
  }

  bool _matchesGroupByHavingOperator({
    required Object? actual,
    required String operator,
    required Object? operand,
  }) {
    return switch (operator) {
      'equals' => actual == operand,
      'not' =>
        operand is Map
            ? !_matchesGroupByHavingCondition(
                actual: actual,
                condition: operand,
              )
            : actual != operand,
      'in' => _matchInList(actual: actual, operand: operand),
      'notIn' => _matchNotInList(actual: actual, operand: operand),
      'contains' =>
        actual is String && operand is String && actual.contains(operand),
      'startsWith' =>
        actual is String && operand is String && actual.startsWith(operand),
      'endsWith' =>
        actual is String && operand is String && actual.endsWith(operand),
      'gt' => _matchesGroupByHavingComparison(
        actual: actual,
        operand: operand,
        predicate: (comparison) => comparison > 0,
      ),
      'gte' => _matchesGroupByHavingComparison(
        actual: actual,
        operand: operand,
        predicate: (comparison) => comparison >= 0,
      ),
      'lt' => _matchesGroupByHavingComparison(
        actual: actual,
        operand: operand,
        predicate: (comparison) => comparison < 0,
      ),
      'lte' => _matchesGroupByHavingComparison(
        actual: actual,
        operand: operand,
        predicate: (comparison) => comparison <= 0,
      ),
      _ => false,
    };
  }

  bool _matchInList({required Object? actual, required Object? operand}) {
    if (operand is! List) {
      return false;
    }
    return List<Object?>.from(operand).contains(actual);
  }

  bool _matchNotInList({required Object? actual, required Object? operand}) {
    if (operand is! List) {
      return false;
    }
    return !List<Object?>.from(operand).contains(actual);
  }

  bool _matchesGroupByHavingComparison({
    required Object? actual,
    required Object? operand,
    required bool Function(int comparison) predicate,
  }) {
    final comparison = _compareGroupByHavingValues(actual, operand);
    if (comparison == null) {
      return false;
    }
    return predicate(comparison);
  }

  int? _compareGroupByHavingValues(Object? left, Object? right) {
    if (left == null || right == null) {
      return null;
    }
    if (left is num && right is num) {
      return left.compareTo(right);
    }
    if (left is String && right is String) {
      return left.compareTo(right);
    }
    if (left is DateTime && right is DateTime) {
      return left.compareTo(right);
    }
    if (left is bool && right is bool) {
      final leftValue = left ? 1 : 0;
      final rightValue = right ? 1 : 0;
      return leftValue.compareTo(rightValue);
    }
    if (left is Comparable<Object?> && left.runtimeType == right.runtimeType) {
      return left.compareTo(right);
    }
    return null;
  }

  Object? _readGroupByAggregateValue({
    required JsonMap row,
    required String bucket,
    required String field,
  }) {
    final bucketValue = row[bucket];
    if (bucketValue is! Map<Object?, Object?>) {
      return null;
    }
    return bucketValue[field];
  }

  Object? _readGroupByOrderByValue({
    required JsonMap row,
    required String field,
  }) {
    if (row.containsKey(field)) {
      return row[field];
    }
    final fieldPath = field.split('.');
    if (fieldPath.length != 2) {
      return row[field];
    }
    final normalizedBucket = _normalizeGroupByAggregateBucket(fieldPath[0]);
    if (normalizedBucket == null) {
      return row[field];
    }
    return _readGroupByAggregateValue(
      row: row,
      bucket: normalizedBucket,
      field: fieldPath[1],
    );
  }

  int _compareRowsForGroupByOrderBy({
    required JsonMap left,
    required JsonMap right,
    required List<OrmOrderBy> orderBy,
  }) {
    for (final clause in orderBy) {
      final compared = _compareOrderByValues(
        _readGroupByOrderByValue(row: left, field: clause.field),
        _readGroupByOrderByValue(row: right, field: clause.field),
      );
      if (compared == 0) {
        continue;
      }
      return clause.order == SortOrder.desc ? -compared : compared;
    }
    return 0;
  }

  List<String> _buildAggregateSelect({
    required List<String> count,
    required List<String> min,
    required List<String> max,
    required List<String> sum,
    required List<String> avg,
  }) {
    final fields = <String>{...count, ...min, ...max, ...sum, ...avg};
    if (fields.isEmpty) {
      return const <String>[];
    }
    return fields.toList(growable: false);
  }

  JsonMap _buildAggregateResult({
    required List<JsonMap> rows,
    required bool countAll,
    required List<String> count,
    required List<String> min,
    required List<String> max,
    required List<String> sum,
    required List<String> avg,
  }) {
    final result = <String, Object?>{};

    if (countAll || count.isNotEmpty) {
      final countResult = <String, Object?>{};
      if (countAll) {
        countResult['all'] = rows.length;
      }
      for (final field in count) {
        countResult[field] = rows.where((row) => row[field] != null).length;
      }
      result['count'] = countResult;
    }

    if (min.isNotEmpty) {
      final minResult = <String, Object?>{};
      for (final field in min) {
        minResult[field] = _aggregateMin(rows: rows, field: field);
      }
      result['min'] = minResult;
    }

    if (max.isNotEmpty) {
      final maxResult = <String, Object?>{};
      for (final field in max) {
        maxResult[field] = _aggregateMax(rows: rows, field: field);
      }
      result['max'] = maxResult;
    }

    if (sum.isNotEmpty) {
      final sumResult = <String, Object?>{};
      for (final field in sum) {
        sumResult[field] = _aggregateSum(rows: rows, field: field);
      }
      result['sum'] = sumResult;
    }

    if (avg.isNotEmpty) {
      final avgResult = <String, Object?>{};
      for (final field in avg) {
        avgResult[field] = _aggregateAvg(rows: rows, field: field);
      }
      result['avg'] = avgResult;
    }

    return result;
  }

  Object? _aggregateMin({required List<JsonMap> rows, required String field}) {
    Object? current;
    for (final row in rows) {
      final value = row[field];
      if (value == null) {
        continue;
      }
      if (current == null ||
          _compareAggregateValues(left: value, right: current) < 0) {
        current = value;
      }
    }
    return current;
  }

  Object? _aggregateMax({required List<JsonMap> rows, required String field}) {
    Object? current;
    for (final row in rows) {
      final value = row[field];
      if (value == null) {
        continue;
      }
      if (current == null ||
          _compareAggregateValues(left: value, right: current) > 0) {
        current = value;
      }
    }
    return current;
  }

  num? _aggregateSum({required List<JsonMap> rows, required String field}) {
    num? sum;
    for (final row in rows) {
      final value = row[field];
      if (value is! num) {
        continue;
      }
      sum = (sum ?? 0) + value;
    }
    return sum;
  }

  double? _aggregateAvg({required List<JsonMap> rows, required String field}) {
    var count = 0;
    var sum = 0.0;
    for (final row in rows) {
      final value = row[field];
      if (value is! num) {
        continue;
      }
      sum += value.toDouble();
      count += 1;
    }
    if (count == 0) {
      return null;
    }
    return sum / count;
  }

  int _compareAggregateValues({required Object left, required Object right}) {
    if (left is num && right is num) {
      return left.compareTo(right);
    }
    if (left is DateTime && right is DateTime) {
      return left.compareTo(right);
    }
    if (left is Comparable<Object?> && left.runtimeType == right.runtimeType) {
      return left.compareTo(right);
    }
    return left.toString().compareTo(right.toString());
  }

  List<String> _expandSelectForNestedCreate({
    required String model,
    required List<String> select,
    required Map<String, List<JsonMap>> create,
  }) {
    if (select.isEmpty || create.isEmpty) {
      return select;
    }

    final expanded = <String>{...select};
    for (final relationName in create.keys) {
      final relation = _resolveRelation(
        model: model,
        relationName: relationName,
      );
      expanded.addAll(relation.sourceFields);
    }

    return expanded.toList(growable: false);
  }

  List<JsonMap> _shapeRows(
    List<JsonMap> rows, {
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    if (rows.isEmpty) {
      return const <JsonMap>[];
    }

    if (select.isEmpty && include.isEmpty) {
      return rows;
    }

    return rows
        .map((row) => _shapeRow(row, select: select, include: include))
        .toList(growable: false);
  }

  JsonMap _shapeRow(
    JsonMap row, {
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    if (select.isEmpty && include.isEmpty) {
      return row;
    }

    final shaped = <String, Object?>{};
    if (select.isEmpty) {
      shaped.addAll(row);
    } else {
      for (final field in select) {
        shaped[field] = row[field];
      }
    }

    for (final relationName in include.keys) {
      if (row.containsKey(relationName)) {
        shaped[relationName] = row[relationName];
      }
    }

    return shaped;
  }

  JsonMap _attachInclude(JsonMap row, String relation, Object? value) {
    final next = <String, Object?>{...row, relation: value};
    return next;
  }

  List<JsonMap> _applyDistinctRows({
    required List<JsonMap> rows,
    required List<String> distinct,
  }) {
    if (rows.isEmpty || distinct.isEmpty) {
      return rows;
    }

    final seen = <_RelationMergeKey>{};
    final deduplicated = <JsonMap>[];
    for (final row in rows) {
      final key = _RelationMergeKey(
        distinct
            .map((field) => row.containsKey(field) ? row[field] : null)
            .toList(growable: false),
      );
      if (seen.add(key)) {
        deduplicated.add(row);
      }
    }
    return deduplicated;
  }

  int _compareOrderByValues(Object? left, Object? right) {
    if (left == null && right == null) {
      return 0;
    }
    if (left == null) {
      return -1;
    }
    if (right == null) {
      return 1;
    }
    if (left is num && right is num) {
      return left.compareTo(right);
    }
    if (left is DateTime && right is DateTime) {
      return left.compareTo(right);
    }
    if (left is Comparable<Object?> && left.runtimeType == right.runtimeType) {
      return left.compareTo(right);
    }
    return left.toString().compareTo(right.toString());
  }

  JsonMap? _fallbackCreateRow({required JsonMap data}) {
    if (_client.contract.capabilities.mutationReturning) {
      return null;
    }
    return Map<String, Object?>.from(data);
  }

  Future<JsonMap> _normalizeWhereForExecution({
    required String model,
    required JsonMap where,
  }) async {
    if (where.isEmpty) {
      return const <String, Object?>{};
    }
    if (_client.contract.target == 'sql-family') {
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

    final modelContract = _client.contract.models[model];
    if (modelContract == null) {
      throw ModelNotFoundException(model, _client.contract.models.keys);
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
          'model': modelName,
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
          'model': modelName,
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
    final relatedRows = await _runtime
        ._resolveDelegate(relation.relatedModel)
        ._readAllInternal(
          action: OrmAction.read,
          where: relatedWhere,
          select: relation.targetFields,
          includeDepth: 0,
        );

    final keys = <_RelationMergeKey>{};
    for (final row in relatedRows) {
      final key = _buildRelationMergeKeyFromRow(
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

  Map<String, IncludeSpec> _normalizeInclude(Map<String, IncludeSpec> include) {
    if (include.isEmpty) {
      return const <String, IncludeSpec>{};
    }
    return include;
  }

  Map<String, List<JsonMap>> _normalizeNestedCreate(
    Map<String, List<JsonMap>> create,
  ) {
    if (create.isEmpty) {
      return const <String, List<JsonMap>>{};
    }

    final normalized = <String, List<JsonMap>>{};
    for (final entry in create.entries) {
      normalized[entry.key] = entry.value
          .map((row) => Map<String, Object?>.from(row))
          .toList(growable: false);
    }
    return normalized;
  }

  JsonMap _linkNestedData({
    required JsonMap parent,
    required String relationName,
    required ModelRelationContract relation,
    required JsonMap data,
  }) {
    final relationFields = <String, Object?>{};
    for (var index = 0; index < relation.sourceFields.length; index++) {
      final sourceField = relation.sourceFields[index];
      final targetField = relation.targetFields[index];
      if (!parent.containsKey(sourceField) || parent[sourceField] == null) {
        throw runtimeError(
          'PLAN.RELATION_SOURCE_FIELD_MISSING',
          'Missing source field for nested create relation linking.',
          details: <String, Object?>{
            'model': modelName,
            'relation': relationName,
            'sourceField': sourceField,
            'targetField': targetField,
          },
        );
      }
      relationFields[targetField] = parent[sourceField];
    }

    return <String, Object?>{...data, ...relationFields};
  }
}

@immutable
final class ModelQueryState {
  final JsonMap where;
  final int? skip;
  final int? take;
  final List<OrmOrderBy> orderBy;
  final List<String> distinct;
  final List<String> select;
  final Map<String, IncludeSpec> include;
  final JsonMap? cursor;
  final OrmReadPagePlan? page;

  const ModelQueryState({
    this.where = const <String, Object?>{},
    this.skip,
    this.take,
    this.orderBy = const <OrmOrderBy>[],
    this.distinct = const <String>[],
    this.select = const <String>[],
    this.include = const <String, IncludeSpec>{},
    this.cursor,
    this.page,
  });
}

@immutable
final class ModelQuery {
  final ModelDelegate _delegate;
  final ModelQueryState _state;

  const ModelQuery._(this._delegate, this._state);

  JsonMap get whereClause => _state.where;

  int? get skipValue => _state.skip;

  int? get takeValue => _state.take;

  List<OrmOrderBy> get orderByValues => _state.orderBy;

  List<String> get distinctValues => _state.distinct;

  List<String> get selectedFields => _state.select;

  Map<String, IncludeSpec> get includeValues => _state.include;

  JsonMap? get cursorValues => _state.cursor;

  OrmReadPagePlan? get pageWindow => _state.page;

  ModelQuery where(JsonMap where, {bool merge = true}) {
    final nextWhere = merge
        ? <String, Object?>{..._state.where, ...where}
        : <String, Object?>{...where};
    return _next(
      ModelQueryState(
        where: nextWhere,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: _state.include,
        cursor: _state.cursor,
        page: _state.page,
      ),
    );
  }

  ModelQuery whereWith(
    JsonMap Function(JsonMap where) build, {
    bool merge = true,
  }) {
    final current = Map<String, Object?>.from(_state.where);
    final next = build(Map<String, Object?>.unmodifiable(current));
    return where(next, merge: merge);
  }

  ModelQuery orderBy(List<OrmOrderBy> orderBy, {bool append = true}) {
    final nextOrderBy = append
        ? <OrmOrderBy>[..._state.orderBy, ...orderBy]
        : <OrmOrderBy>[...orderBy];
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: nextOrderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: _state.include,
        cursor: _state.cursor,
        page: _state.page,
      ),
    );
  }

  ModelQuery orderByField(String field, {SortOrder order = SortOrder.asc}) {
    return orderBy(<OrmOrderBy>[OrmOrderBy(field, order: order)]);
  }

  ModelQuery distinct(List<String> fields, {bool append = false}) {
    final nextDistinct = append
        ? <String>[..._state.distinct, ...fields]
        : <String>[...fields];
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        distinct: nextDistinct,
        select: _state.select,
        include: _state.include,
        cursor: _state.cursor,
        page: _state.page,
      ),
    );
  }

  ModelQuery distinctField(String field) {
    return distinct(<String>[field], append: true);
  }

  ModelQuery select(List<String> fields, {bool append = false}) {
    final nextSelect = append
        ? <String>[..._state.select, ...fields]
        : <String>[...fields];
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: nextSelect,
        include: _state.include,
        cursor: _state.cursor,
        page: _state.page,
      ),
    );
  }

  ModelQuery selectWith(
    List<String> Function(List<String> fields) build, {
    bool append = false,
  }) {
    final current = List<String>.from(_state.select, growable: false);
    final next = build(List<String>.unmodifiable(current));
    return select(next, append: append);
  }

  ModelQuery selectField(String field) {
    return select(<String>[field], append: true);
  }

  ModelQuery include(Map<String, IncludeSpec> include, {bool merge = true}) {
    final nextInclude = merge
        ? _mergeIncludeSpecMap(_state.include, include)
        : <String, IncludeSpec>{...include};

    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: nextInclude,
        cursor: _state.cursor,
        page: _state.page,
      ),
    );
  }

  ModelQuery includeWith(
    Map<String, IncludeSpec> Function(Map<String, IncludeSpec> include) build, {
    bool merge = true,
  }) {
    final current = <String, IncludeSpec>{..._state.include};
    final next = build(current);
    return include(next, merge: merge);
  }

  ModelQuery includeRelation(
    String relation, {
    IncludeSpec spec = const IncludeSpec(),
  }) {
    return include(<String, IncludeSpec>{relation: spec});
  }

  ModelQuery skip(int value) {
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: value,
        take: _state.take,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: _state.include,
        cursor: _state.cursor,
        page: null,
      ),
    );
  }

  ModelQuery take(int value) {
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: value,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: _state.include,
        cursor: _state.cursor,
        page: null,
      ),
    );
  }

  ModelQuery cursor(JsonMap cursor) {
    if (cursor.isEmpty) {
      throw PlanCursorWindowInvalidException(
        reason: 'cursorEmpty',
        details: <String, Object?>{'model': _delegate.modelName},
      );
    }
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: _state.include,
        cursor: Map<String, Object?>.unmodifiable(
          Map<String, Object?>.from(cursor),
        ),
        page: null,
      ),
    );
  }

  ModelQuery page({
    required int size,
    JsonMap? after,
    JsonMap? before,
  }) {
    if (size <= 0) {
      throw PlanCursorWindowInvalidException(
        reason: 'pageSizeInvalid',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'size': size,
        },
      );
    }
    if (after != null && before != null) {
      throw PlanCursorWindowInvalidException(
        reason: 'pageDirectionAmbiguous',
        details: <String, Object?>{'model': _delegate.modelName},
      );
    }
    if (after != null && after.isEmpty) {
      throw PlanCursorWindowInvalidException(
        reason: 'pageAfterEmpty',
        details: <String, Object?>{'model': _delegate.modelName},
      );
    }
    if (before != null && before.isEmpty) {
      throw PlanCursorWindowInvalidException(
        reason: 'pageBeforeEmpty',
        details: <String, Object?>{'model': _delegate.modelName},
      );
    }
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: null,
        take: null,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: _state.include,
        cursor: null,
        page: OrmReadPagePlan(
          size: size,
          after: after == null ? null : Map<String, Object?>.from(after),
          before: before == null ? null : Map<String, Object?>.from(before),
        ),
      ),
    );
  }

  ModelQuery unbounded() {
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: null,
        orderBy: _state.orderBy,
        distinct: _state.distinct,
        select: _state.select,
        include: _state.include,
        cursor: _state.cursor,
        page: null,
      ),
    );
  }

  Future<OrmPlan> toPlan() {
    return _delegate.toPlan(
      where: _state.where,
      skip: _state.skip,
      take: _state.take,
      orderBy: _state.orderBy,
      distinct: _state.distinct,
      select: _state.select,
      include: _state.include,
      cursor: _state.cursor,
      page: _state.page,
    );
  }

  Future<List<JsonMap>> all() {
    _assertReadExecutionSupported('all');
    return _delegate.all(
      where: _state.where,
      skip: _state.skip,
      take: _state.take,
      orderBy: _state.orderBy,
      distinct: _state.distinct,
      select: _state.select,
      include: _state.include,
    );
  }

  Stream<JsonMap> stream() {
    _assertReadExecutionSupported('stream');
    return _delegate.stream(
      where: _state.where,
      skip: _state.skip,
      take: _state.take,
      orderBy: _state.orderBy,
      distinct: _state.distinct,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> oneOrNull() {
    _assertReadExecutionSupported('oneOrNull');
    return _delegate.oneOrNull(
      where: _state.where,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> firstOrNull() {
    _assertReadExecutionSupported('firstOrNull');
    return _delegate.firstOrNull(
      where: _state.where,
      skip: _state.skip,
      orderBy: _state.orderBy,
      distinct: _state.distinct,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<int> count() {
    _assertReadExecutionSupported('count');
    return _delegate.count(where: _state.where);
  }

  Future<bool> exists() {
    _assertReadExecutionSupported('exists');
    return _delegate.exists(where: _state.where);
  }

  Future<JsonMap> explain() async {
    final plan = await toPlan();
    return plan.toJson();
  }

  Future<JsonMap> aggregate({
    bool countAll = false,
    List<String> count = const <String>[],
    List<String> min = const <String>[],
    List<String> max = const <String>[],
    List<String> sum = const <String>[],
    List<String> avg = const <String>[],
  }) {
    _assertReadExecutionSupported('aggregate');
    return _delegate.aggregate(
      where: _state.where,
      countAll: countAll,
      count: count,
      min: min,
      max: max,
      sum: sum,
      avg: avg,
    );
  }

  Future<List<JsonMap>> groupBy({
    required List<String> by,
    JsonMap having = const <String, Object?>{},
    bool countAll = false,
    List<String> count = const <String>[],
    List<String> min = const <String>[],
    List<String> max = const <String>[],
    List<String> sum = const <String>[],
    List<String> avg = const <String>[],
  }) {
    _assertReadExecutionSupported('groupBy');
    return _delegate.groupBy(
      by: by,
      where: _state.where,
      having: having,
      skip: _state.skip,
      take: _state.take,
      orderBy: _state.orderBy,
      countAll: countAll,
      count: count,
      min: min,
      max: max,
      sum: sum,
      avg: avg,
    );
  }

  void _assertReadExecutionSupported(String terminal) {
    if (_state.cursor != null) {
      _throwApiNotImplemented(
        'orm.query.cursor.execute',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'terminal': terminal,
          'cursor': _state.cursor,
        },
      );
    }
    if (_state.page != null) {
      _throwApiNotImplemented(
        'orm.query.page.execute',
        details: <String, Object?>{
          'model': _delegate.modelName,
          'terminal': terminal,
          'page': _state.page!.toJson(),
        },
      );
    }
  }

  void _assertMutationQueryState({
    required String action,
    bool allowWhere = true,
  }) {
    final invalidKeys = <String>[
      if (!allowWhere && _state.where.isNotEmpty) 'where',
      if (_state.skip != null) 'skip',
      if (_state.take != null) 'take',
      if (_state.orderBy.isNotEmpty) 'orderBy',
      if (_state.distinct.isNotEmpty) 'distinct',
      if (_state.cursor != null) 'cursor',
      if (_state.page != null) 'page',
    ];
    if (invalidKeys.isEmpty) {
      return;
    }

    throw runtimeError(
      'PLAN.MUTATION_QUERY_STATE_INVALID',
      '$action does not allow query state keys: ${invalidKeys.join(', ')}.',
      details: <String, Object?>{
        'action': action,
        'invalidKeys': invalidKeys,
      },
    );
  }

  Future<JsonMap> create({required JsonMap data}) {
    _assertMutationQueryState(action: 'create', allowWhere: false);
    return _delegate.create(
      data: data,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<List<JsonMap>> createMany({required List<JsonMap> data}) {
    _assertMutationQueryState(action: 'createMany', allowWhere: false);
    return _delegate.createMany(
      data: data,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<int> updateMany({required JsonMap data}) {
    _assertMutationQueryState(action: 'updateMany');
    return _delegate.updateMany(
      where: _state.where,
      data: data,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<int> deleteMany() {
    _assertMutationQueryState(action: 'deleteMany');
    return _delegate.deleteMany(where: _state.where);
  }

  Future<JsonMap> upsert({required JsonMap create, required JsonMap update}) {
    _assertMutationQueryState(action: 'upsert');
    return _delegate.upsert(
      where: _state.where,
      create: create,
      update: update,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> update({required JsonMap data}) {
    _assertMutationQueryState(action: 'update');
    return _delegate.update(
      where: _state.where,
      data: data,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> updateNested({
    required JsonMap data,
    Map<String, List<JsonMap>> create = const <String, List<JsonMap>>{},
  }) {
    _assertMutationQueryState(action: 'updateNested');
    return _delegate.updateNested(
      where: _state.where,
      data: data,
      create: create,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> delete() {
    _assertMutationQueryState(action: 'delete');
    return _delegate.delete(
      where: _state.where,
      select: _state.select,
      include: _state.include,
    );
  }

  ModelQuery _next(ModelQueryState nextState) =>
      ModelQuery._(_delegate, nextState);
}

@immutable
final class _RelationMergeKey {
  final List<Object?> parts;

  _RelationMergeKey(List<Object?> values)
    : parts = List<Object?>.unmodifiable(values);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! _RelationMergeKey) {
      return false;
    }
    return _listEquals(parts, other.parts);
  }

  @override
  int get hashCode => Object.hashAll(parts);
}

Map<String, String> _createModelAliases(OrmContract contract) {
  final aliases = <String, String>{};

  for (final model in contract.models.values) {
    final name = model.name;
    final lower = _lowercaseFirst(name);
    aliases[name] = name;
    aliases[lower] = name;
    aliases['${lower}s'] = name;
    aliases[model.table] = name;
    if (!model.table.endsWith('s')) {
      aliases['${model.table}s'] = name;
    }
  }

  for (final alias in contract.aliases.entries) {
    if (contract.models.containsKey(alias.value)) {
      aliases[alias.key] = alias.value;
    }
  }

  return aliases;
}

Map<String, CollectionFactory> _createCollectionRegistry(
  OrmContract contract,
  Map<String, CollectionFactory> collections,
) {
  if (collections.isEmpty) {
    return const <String, CollectionFactory>{};
  }

  final aliases = _createModelAliases(contract);
  final registry = <String, CollectionFactory>{};

  for (final entry in collections.entries) {
    final model = aliases[entry.key] ?? aliases[_lowercaseFirst(entry.key)];
    if (model == null) {
      throw ModelNotFoundException(entry.key, contract.models.keys);
    }
    registry[model] = entry.value;
  }

  return registry;
}

List<JsonMap> _readRows(Object? data, {String action = 'findMany'}) {
  if (data == null) {
    return const <JsonMap>[];
  }
  if (data is! List<Object?>) {
    throw RuntimeResponseShapeException(
      action: action,
      expected: 'List<Map<String, Object?>>',
      actual: data,
    );
  }
  return data
      .map((value) => _coerceRow(value, action: action))
      .toList(growable: false);
}

JsonMap? _readRow(Object? data, {required String action}) {
  if (data == null) {
    return null;
  }
  return _coerceRow(data, action: action);
}

JsonMap _coerceRow(Object? value, {required String action}) {
  if (value is Map<String, Object?>) {
    return Map<String, Object?>.from(value);
  }
  if (value is Map<Object?, Object?>) {
    return value.map((key, item) => MapEntry(key.toString(), item));
  }
  throw RuntimeResponseShapeException(
    action: action,
    expected: 'Map<String, Object?>',
    actual: value,
  );
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

T? _firstOrNull<T>(List<T> values) {
  if (values.isEmpty) {
    return null;
  }
  return values.first;
}

bool _listEquals(List<Object?> left, List<Object?> right) {
  if (identical(left, right)) {
    return true;
  }
  if (left.length != right.length) {
    return false;
  }
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) {
      return false;
    }
  }
  return true;
}

String _lowercaseFirst(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value[0].toLowerCase() + value.substring(1);
}
