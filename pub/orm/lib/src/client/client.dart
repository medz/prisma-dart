import 'package:meta/meta.dart';

import '../contract/contract.dart';
import '../core/sort_order.dart';
import '../engine/engine.dart';
import '../runtime/core.dart';
import '../runtime/errors.dart';
import '../runtime/plan.dart';
import '../runtime/plugin.dart';
import '../runtime/types.dart';

typedef CollectionFactory =
    ModelDelegate Function({
      required OrmModelContext client,
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
const Set<String> _relationWhereOperators = <String>{'some', 'every', 'none'};

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
    JsonMap where = const <String, Object?>{},
    this.skip,
    this.take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) : where = where,
       orderBy = orderBy,
       select = select,
       include = include;
}

abstract interface class OrmModelContext {
  OrmContract get contract;

  IncludeExecutionStrategySelector get includeStrategySelector;

  int get maxIncludeDepth;

  Future<EngineResponse> execute(OrmPlan plan);

  ModelDelegate model(String modelKey);

  ModelDelegate collection(String modelKey);

  Future<T> transaction<T>(Future<T> Function(OrmModelContext tx) run);
}

final class OrmClient implements OrmModelContext {
  @override
  final OrmContract contract;
  final OrmEngine engine;
  final OrmRuntimeCore _runtime;
  final Map<String, ModelDelegate> _delegates = <String, ModelDelegate>{};
  final Map<String, String> _modelAliases;
  final Map<String, CollectionFactory> _collectionRegistry;
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
    final transaction = await connection.transaction();
    final scoped = OrmScopedClient._(
      contract: contract,
      executePlan: transaction.execute,
      modelAliases: _modelAliases,
      collectionRegistry: _collectionRegistry,
      includeStrategySelector: includeStrategySelector,
      maxIncludeDepth: maxIncludeDepth,
    );

    try {
      final value = await run(scoped);
      await transaction.commit();
      return value;
    } catch (_) {
      try {
        await transaction.rollback();
      } catch (_) {
        // Keep the original exception when rollback fails.
      }
      rethrow;
    } finally {
      await connection.release();
    }
  }

  Future<OrmRuntimeConnection> connection() => _runtime.connection();

  RuntimeTelemetryEvent? telemetry() => _runtime.telemetry();

  @override
  ModelDelegate model(String modelKey) {
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
  ModelDelegate collection(String modelKey) => model(modelKey);

  @override
  Future<EngineResponse> execute(OrmPlan plan) => _runtime.execute(plan);

  @override
  Future<T> transaction<T>(Future<T> Function(OrmModelContext tx) run) {
    return withTransaction((scoped) => run(scoped));
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

final class OrmScopedClient implements OrmModelContext {
  @override
  final OrmContract contract;
  final Future<EngineResponse> Function(OrmPlan plan) _executePlan;
  final Map<String, String> _modelAliases;
  final Map<String, CollectionFactory> _collectionRegistry;
  final Map<String, ModelDelegate> _delegates = <String, ModelDelegate>{};
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
  ModelDelegate model(String modelKey) {
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
  ModelDelegate collection(String modelKey) => model(modelKey);

  @override
  Future<EngineResponse> execute(OrmPlan plan) => _executePlan(plan);

  @override
  Future<T> transaction<T>(Future<T> Function(OrmModelContext tx) run) {
    return run(this);
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

class ModelDelegate {
  final OrmModelContext _client;
  final String modelName;

  ModelDelegate({required OrmModelContext client, required this.modelName})
    : _client = client;

  @protected
  OrmModelContext get client => _client;

  ModelQuery query() => ModelQuery._(this, const ModelQueryState());

  ModelQuery where(JsonMap where) => query().where(where);

  ModelQuery orderBy(List<OrmOrderBy> orderBy) => query().orderBy(orderBy);

  ModelQuery orderByField(String field, {SortOrder order = SortOrder.asc}) =>
      query().orderByField(field, order: order);

  ModelQuery skip(int value) => query().skip(value);

  ModelQuery take(int value) => query().take(value);

  ModelQuery select(List<String> fields) => query().select(fields);

  ModelQuery selectField(String field) => query().selectField(field);

  ModelQuery include(Map<String, IncludeSpec> include) =>
      query().include(include);

  ModelQuery includeRelation(
    String relation, {
    IncludeSpec spec = const IncludeSpec(),
  }) => query().includeRelation(relation, spec: spec);

  Future<List<JsonMap>> findMany({
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _findManyInternal(
      action: OrmAction.findMany,
      where: where,
      skip: skip,
      take: take,
      orderBy: orderBy,
      select: select,
      include: include,
      includeDepth: 0,
    );
  }

  Stream<JsonMap> streamMany({
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) async* {
    final rows = await findMany(
      where: where,
      skip: skip,
      take: take,
      orderBy: orderBy,
      select: select,
      include: include,
    );

    for (final row in rows) {
      yield row;
    }
  }

  Future<JsonMap?> findUnique({
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _findUniqueInternal(
      action: OrmAction.findUnique,
      where: where,
      select: select,
      include: include,
      includeDepth: 0,
    );
  }

  Future<JsonMap?> findFirst({
    JsonMap where = const <String, Object?>{},
    int? skip,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) async {
    final rows = await _findManyInternal(
      action: OrmAction.findMany,
      where: where,
      skip: skip,
      take: 1,
      orderBy: orderBy,
      select: select,
      include: include,
      includeDepth: 0,
    );
    return _firstOrNull(rows);
  }

  Future<int> count({JsonMap where = const <String, Object?>{}}) async {
    final rows = await _findManyInternal(
      action: OrmAction.findMany,
      where: where,
      includeDepth: 0,
    );
    return rows.length;
  }

  Future<bool> exists({JsonMap where = const <String, Object?>{}}) async {
    final row = await findFirst(where: where, select: const <String>[]);
    return row != null;
  }

  Future<JsonMap> create({
    required JsonMap data,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) async {
    final normalizedInclude = _normalizeInclude(include);
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        target: _client.contract.target,
        storageHash: _client.contract.markerStorageHash,
        profileHash: _client.contract.profileHash,
        model: modelName,
        action: OrmAction.create,
        data: data,
        select: _expandSelectForInclude(
          model: modelName,
          select: select,
          include: normalizedInclude,
        ),
      ),
    );

    var row = _readRow(response.data, action: 'create');
    if (row == null) {
      if (_client.contract.capabilities.mutationReturning &&
          response.affectedRows > 0) {
        throw RuntimeCreateResultMissingException(model: modelName);
      }
      row = _fallbackCreateRow(data: data);
    }

    if (row == null) {
      throw RuntimeCreateResultMissingException(model: modelName);
    }

    final hydratedRows = await _resolveIncludeRows(
      action: OrmAction.create,
      rows: <JsonMap>[row],
      include: normalizedInclude,
      depth: 0,
    );

    return _shapeRows(
      hydratedRows,
      select: select,
      include: normalizedInclude,
    ).single;
  }

  Future<JsonMap> createNested({
    required JsonMap data,
    Map<String, List<JsonMap>> create = const <String, List<JsonMap>>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _client.transaction((tx) async {
      final scoped = tx.model(modelName);
      return scoped._createNestedInScope(
        data: data,
        create: create,
        select: select,
        include: include,
      );
    });
  }

  Future<JsonMap?> updateNested({
    JsonMap where = const <String, Object?>{},
    required JsonMap data,
    Map<String, List<JsonMap>> create = const <String, List<JsonMap>>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _client.transaction((tx) async {
      final scoped = tx.model(modelName);
      return scoped._updateNestedInScope(
        where: where,
        data: data,
        create: create,
        select: select,
        include: include,
      );
    });
  }

  Future<List<JsonMap>> createMany({
    required List<JsonMap> data,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _client.transaction((tx) async {
      final scoped = tx.model(modelName);
      final rows = <JsonMap>[];
      for (final item in data) {
        final created = await scoped.create(
          data: item,
          select: select,
          include: include,
        );
        rows.add(created);
      }
      return rows;
    });
  }

  Future<int> deleteMany({JsonMap where = const <String, Object?>{}}) {
    return _client.transaction((tx) async {
      final scoped = tx.model(modelName);
      var deleted = 0;
      while (true) {
        final row = await scoped.delete(where: where);
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
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _client.transaction((tx) async {
      final scoped = tx.model(modelName);
      final existing = await scoped.findUnique(where: where);
      if (existing == null) {
        return scoped.create(data: create, select: select, include: include);
      }

      final updated = await scoped.update(
        where: where,
        data: update,
        select: select,
        include: include,
      );
      if (updated != null) {
        return updated;
      }

      throw runtimeError(
        'RUNTIME.UPSERT_UPDATE_MISSING',
        'Upsert update branch did not return a row.',
        details: <String, Object?>{'model': modelName, 'where': where},
      );
    });
  }

  Future<JsonMap?> update({
    JsonMap where = const <String, Object?>{},
    required JsonMap data,
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _runNullableMutation(
      action: OrmAction.update,
      where: where,
      data: data,
      select: select,
      include: include,
      responseAction: 'update',
    );
  }

  Future<JsonMap?> delete({
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
  }) {
    return _runNullableMutation(
      action: OrmAction.delete,
      where: where,
      data: const <String, Object?>{},
      select: select,
      include: include,
      responseAction: 'delete',
    );
  }

  Future<List<JsonMap>> _findManyInternal({
    required OrmAction action,
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    required int includeDepth,
  }) async {
    final normalizedInclude = _normalizeInclude(include);
    final normalizedWhere = await _normalizeWhereForExecution(
      model: modelName,
      where: where,
    );
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        target: _client.contract.target,
        storageHash: _client.contract.markerStorageHash,
        profileHash: _client.contract.profileHash,
        model: modelName,
        action: OrmAction.findMany,
        where: normalizedWhere,
        skip: skip,
        take: take,
        orderBy: orderBy,
        select: _expandSelectForInclude(
          model: modelName,
          select: select,
          include: normalizedInclude,
        ),
      ),
    );

    final rows = _readRows(response.data);
    final hydratedRows = await _resolveIncludeRows(
      action: action,
      rows: rows,
      include: normalizedInclude,
      depth: includeDepth,
    );

    return _shapeRows(hydratedRows, select: select, include: normalizedInclude);
  }

  Future<JsonMap?> _findUniqueInternal({
    required OrmAction action,
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
    Map<String, IncludeSpec> include = const <String, IncludeSpec>{},
    required int includeDepth,
  }) async {
    final normalizedInclude = _normalizeInclude(include);
    final normalizedWhere = await _normalizeWhereForExecution(
      model: modelName,
      where: where,
    );
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        target: _client.contract.target,
        storageHash: _client.contract.markerStorageHash,
        profileHash: _client.contract.profileHash,
        model: modelName,
        action: OrmAction.findUnique,
        where: normalizedWhere,
        select: _expandSelectForInclude(
          model: modelName,
          select: select,
          include: normalizedInclude,
        ),
      ),
    );

    final row = _readRow(response.data, action: 'findUnique');
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

  Future<JsonMap?> _runNullableMutation({
    required OrmAction action,
    required JsonMap where,
    required JsonMap data,
    required List<String> select,
    required Map<String, IncludeSpec> include,
    required String responseAction,
  }) async {
    final normalizedInclude = _normalizeInclude(include);
    final normalizedWhere = await _normalizeWhereForExecution(
      model: modelName,
      where: where,
    );
    JsonMap? preDeleteRow;
    if (action == OrmAction.delete &&
        !(_client.contract.capabilities.mutationReturning)) {
      preDeleteRow = await _findUniqueInternal(
        action: OrmAction.findUnique,
        where: normalizedWhere,
        select: _expandSelectForInclude(
          model: modelName,
          select: select,
          include: normalizedInclude,
        ),
        include: const <String, IncludeSpec>{},
        includeDepth: 0,
      );
    }

    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        target: _client.contract.target,
        storageHash: _client.contract.markerStorageHash,
        profileHash: _client.contract.profileHash,
        model: modelName,
        action: action,
        where: normalizedWhere,
        data: data,
        select: _expandSelectForInclude(
          model: modelName,
          select: select,
          include: normalizedInclude,
        ),
      ),
    );

    var row = _readRow(response.data, action: responseAction);
    if (row == null &&
        response.affectedRows > 0 &&
        !(_client.contract.capabilities.mutationReturning)) {
      row = switch (action) {
        OrmAction.update => await _findUniqueInternal(
          action: OrmAction.findUnique,
          where: normalizedWhere,
          select: _expandSelectForInclude(
            model: modelName,
            select: select,
            include: normalizedInclude,
          ),
          include: const <String, IncludeSpec>{},
          includeDepth: 0,
        ),
        OrmAction.delete => preDeleteRow,
        _ => row,
      };
    }

    if (row == null) {
      return null;
    }

    final hydratedRows = await _resolveIncludeRows(
      action: action,
      rows: <JsonMap>[row],
      include: normalizedInclude,
      depth: 0,
    );

    return _shapeRows(
      hydratedRows,
      select: select,
      include: normalizedInclude,
    ).single;
  }

  Future<JsonMap> _createNestedInScope({
    required JsonMap data,
    required Map<String, List<JsonMap>> create,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) async {
    final normalizedCreate = _normalizeNestedCreate(create);
    final normalizedInclude = _normalizeInclude(include);

    final created = await this.create(
      data: data,
      select: _expandSelectForNestedCreate(
        model: modelName,
        select: select,
        create: normalizedCreate,
      ),
    );

    for (final entry in normalizedCreate.entries) {
      final relation = _resolveRelation(
        model: modelName,
        relationName: entry.key,
      );
      final related = _client.model(relation.relatedModel);
      for (final child in entry.value) {
        final linkedData = _linkNestedData(
          parent: created,
          relationName: entry.key,
          relation: relation,
          data: child,
        );
        await related.create(data: linkedData);
      }
    }

    final includeForReturn = <String, IncludeSpec>{
      for (final relationName in normalizedCreate.keys)
        relationName: const IncludeSpec(),
      ...normalizedInclude,
    };

    if (includeForReturn.isEmpty) {
      return _shapeRows(
        <JsonMap>[created],
        select: select,
        include: const <String, IncludeSpec>{},
      ).single;
    }

    final hydratedRows = await _resolveIncludeRows(
      action: OrmAction.create,
      rows: <JsonMap>[created],
      include: includeForReturn,
      depth: 0,
    );

    return _shapeRows(
      hydratedRows,
      select: select,
      include: includeForReturn,
    ).single;
  }

  Future<JsonMap?> _updateNestedInScope({
    required JsonMap where,
    required JsonMap data,
    required Map<String, List<JsonMap>> create,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) async {
    final normalizedCreate = _normalizeNestedCreate(create);
    final normalizedInclude = _normalizeInclude(include);

    final updated = await this.update(
      where: where,
      data: data,
      select: _expandSelectForNestedCreate(
        model: modelName,
        select: select,
        create: normalizedCreate,
      ),
    );

    if (updated == null) {
      return null;
    }

    for (final entry in normalizedCreate.entries) {
      final relation = _resolveRelation(
        model: modelName,
        relationName: entry.key,
      );
      final related = _client.model(relation.relatedModel);
      for (final child in entry.value) {
        final linkedData = _linkNestedData(
          parent: updated,
          relationName: entry.key,
          relation: relation,
          data: child,
        );
        await related.create(data: linkedData);
      }
    }

    final includeForReturn = <String, IncludeSpec>{
      for (final relationName in normalizedCreate.keys)
        relationName: const IncludeSpec(),
      ...normalizedInclude,
    };

    if (includeForReturn.isEmpty) {
      return _shapeRows(
        <JsonMap>[updated],
        select: select,
        include: const <String, IncludeSpec>{},
      ).single;
    }

    final hydratedRows = await _resolveIncludeRows(
      action: OrmAction.update,
      rows: <JsonMap>[updated],
      include: includeForReturn,
      depth: 0,
    );

    return _shapeRows(
      hydratedRows,
      select: select,
      include: includeForReturn,
    ).single;
  }

  Future<List<JsonMap>> _resolveIncludeRows({
    required OrmAction action,
    required List<JsonMap> rows,
    required Map<String, IncludeSpec> include,
    required int depth,
  }) {
    if (rows.isEmpty || include.isEmpty) {
      return Future<List<JsonMap>>.value(rows);
    }

    if (depth >= _client.maxIncludeDepth) {
      throw IncludeDepthExceededException(maxDepth: _client.maxIncludeDepth);
    }

    final strategy = _client.includeStrategySelector(
      contract: _client.contract,
      modelName: modelName,
      action: action,
      include: include,
      depth: depth,
    );

    return switch (strategy) {
      IncludeExecutionStrategy.singleQuery => _resolveIncludeRowsSingleQuery(
        rows: rows,
        include: include,
        depth: depth,
      ),
      IncludeExecutionStrategy.multiQuery => _resolveIncludeRowsMultiQuery(
        rows: rows,
        include: include,
        depth: depth,
      ),
    };
  }

  Future<List<JsonMap>> _resolveIncludeRowsSingleQuery({
    required List<JsonMap> rows,
    required Map<String, IncludeSpec> include,
    required int depth,
  }) async {
    var hydrated = rows;

    for (final entry in include.entries) {
      final relationName = entry.key;
      final relationInclude = entry.value;
      final relation = _resolveRelation(
        model: modelName,
        relationName: relationName,
      );
      final relatedDelegate = _client.model(relation.relatedModel);
      _validateIncludePagination(include: relationInclude);

      final relatedRows = await _loadRelationRowsSingleQuery(
        relatedDelegate: relatedDelegate,
        relation: relation,
        relationInclude: relationInclude,
        depth: depth,
      );
      final rowsByRelationKey = _groupRowsByRelationFields(
        rows: relatedRows,
        fields: relation.targetFields,
      );

      final nextRows = <JsonMap>[];
      for (final row in hydrated) {
        final relationWhere = _buildRelationWhere(row: row, relation: relation);
        if (relationWhere == null) {
          final emptyValue = relation.cardinality == RelationCardinality.one
              ? null
              : const <JsonMap>[];
          nextRows.add(_attachInclude(row, relationName, emptyValue));
          continue;
        }

        final relationKey = _buildRelationMergeKeyFromRow(
          row: relationWhere,
          fields: relation.targetFields,
        );
        final matchedRows = relationKey == null
            ? const <JsonMap>[]
            : (rowsByRelationKey[relationKey] ?? const <JsonMap>[]);
        final windowRows = _sliceRows(
          rows: matchedRows,
          skip: relationInclude.skip,
          take: relationInclude.take,
        );
        final shapedRows = relatedDelegate._shapeRows(
          windowRows,
          select: relationInclude.select,
          include: relationInclude.include,
        );
        final relationValue = relation.cardinality == RelationCardinality.one
            ? _firstOrNull(shapedRows)
            : shapedRows;

        nextRows.add(_attachInclude(row, relationName, relationValue));
      }

      hydrated = nextRows;
    }

    return hydrated;
  }

  Future<List<JsonMap>> _resolveIncludeRowsMultiQuery({
    required List<JsonMap> rows,
    required Map<String, IncludeSpec> include,
    required int depth,
  }) async {
    var hydrated = rows;

    for (final entry in include.entries) {
      final relationName = entry.key;
      final relationInclude = entry.value;
      final relation = _resolveRelation(
        model: modelName,
        relationName: relationName,
      );
      final relatedDelegate = _client.model(relation.relatedModel);

      final nextRows = <JsonMap>[];
      for (final row in hydrated) {
        final relationWhere = _buildRelationWhere(row: row, relation: relation);
        if (relationWhere == null) {
          final emptyValue = relation.cardinality == RelationCardinality.one
              ? null
              : const <JsonMap>[];
          nextRows.add(_attachInclude(row, relationName, emptyValue));
          continue;
        }

        final relatedWhere = <String, Object?>{
          ...relationInclude.where,
          ...relationWhere,
        };

        final relatedRows = await relatedDelegate._findManyInternal(
          action: OrmAction.findMany,
          where: relatedWhere,
          skip: relationInclude.skip,
          take: relationInclude.take,
          orderBy: relationInclude.orderBy,
          select: relationInclude.select,
          include: relationInclude.include,
          includeDepth: depth + 1,
        );

        final relationValue = relation.cardinality == RelationCardinality.one
            ? _firstOrNull(relatedRows)
            : relatedRows;

        nextRows.add(_attachInclude(row, relationName, relationValue));
      }

      hydrated = nextRows;
    }

    return hydrated;
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

  Future<List<JsonMap>> _loadRelationRowsSingleQuery({
    required ModelDelegate relatedDelegate,
    required ModelRelationContract relation,
    required IncludeSpec relationInclude,
    required int depth,
  }) {
    final baseWhere = _buildSingleQueryRelationBaseWhere(
      includeWhere: relationInclude.where,
      relation: relation,
    );

    return relatedDelegate._findManyInternal(
      action: OrmAction.findMany,
      where: baseWhere,
      orderBy: relationInclude.orderBy,
      select: _buildSingleQueryRelationSelect(
        include: relationInclude,
        relation: relation,
      ),
      include: relationInclude.include,
      includeDepth: depth + 1,
    );
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

  List<String> _expandSelectForInclude({
    required String model,
    required List<String> select,
    required Map<String, IncludeSpec> include,
  }) {
    if (select.isEmpty || include.isEmpty) {
      return select;
    }

    final expanded = <String>{...select};
    for (final relationName in include.keys) {
      final relation = _resolveRelation(
        model: model,
        relationName: relationName,
      );
      expanded.addAll(relation.sourceFields);
    }

    return expanded.toList(growable: false);
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
      if (relation == null ||
          relation.cardinality != RelationCardinality.many) {
        normalizedWhere[key] = entry.value;
        continue;
      }

      final relationWhere = _coerceWhereMap(entry.value);
      if (relationWhere == null) {
        throw runtimeError(
          'PLAN.RELATION_WHERE_INVALID',
          'Relation where expects a map of operators.',
          details: <String, Object?>{
            'model': model,
            'relation': key,
            'expectedOperators': _relationWhereOperators.toList(
              growable: false,
            ),
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

    final unknownOperators = where.keys
        .where((key) => !_relationWhereOperators.contains(key))
        .toList(growable: false);
    if (unknownOperators.isNotEmpty) {
      throw runtimeError(
        'PLAN.RELATION_WHERE_OPERATOR_INVALID',
        'Relation where contains unknown operators.',
        details: <String, Object?>{
          'model': modelName,
          'relation': relationName,
          'unknownOperators': unknownOperators,
          'supportedOperators': _relationWhereOperators.toList(growable: false),
        },
      );
    }

    final clauses = <JsonMap>[];

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
    final relatedRows = await _client
        .model(relation.relatedModel)
        ._findManyInternal(
          action: OrmAction.findMany,
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
  final List<String> select;
  final Map<String, IncludeSpec> include;

  const ModelQueryState({
    this.where = const <String, Object?>{},
    this.skip,
    this.take,
    this.orderBy = const <OrmOrderBy>[],
    this.select = const <String>[],
    this.include = const <String, IncludeSpec>{},
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

  List<String> get selectedFields => _state.select;

  Map<String, IncludeSpec> get includeValues => _state.include;

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
        select: _state.select,
        include: _state.include,
      ),
    );
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
        select: _state.select,
        include: _state.include,
      ),
    );
  }

  ModelQuery orderByField(String field, {SortOrder order = SortOrder.asc}) {
    return orderBy(<OrmOrderBy>[OrmOrderBy(field, order: order)]);
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
        select: nextSelect,
        include: _state.include,
      ),
    );
  }

  ModelQuery selectField(String field) {
    return select(<String>[field], append: true);
  }

  ModelQuery include(Map<String, IncludeSpec> include, {bool merge = true}) {
    final nextInclude = merge
        ? <String, IncludeSpec>{..._state.include, ...include}
        : <String, IncludeSpec>{...include};

    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        select: _state.select,
        include: nextInclude,
      ),
    );
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
        select: _state.select,
        include: _state.include,
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
        select: _state.select,
        include: _state.include,
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
        select: _state.select,
        include: _state.include,
      ),
    );
  }

  Future<List<JsonMap>> findMany() {
    return _delegate.findMany(
      where: _state.where,
      skip: _state.skip,
      take: _state.take,
      orderBy: _state.orderBy,
      select: _state.select,
      include: _state.include,
    );
  }

  Stream<JsonMap> stream() {
    return _delegate.streamMany(
      where: _state.where,
      skip: _state.skip,
      take: _state.take,
      orderBy: _state.orderBy,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> findUnique() => _delegate.findUnique(
    where: _state.where,
    select: _state.select,
    include: _state.include,
  );

  Future<JsonMap?> findFirst() => _delegate.findFirst(
    where: _state.where,
    skip: _state.skip,
    orderBy: _state.orderBy,
    select: _state.select,
    include: _state.include,
  );

  Future<int> count() => _delegate.count(where: _state.where);

  Future<bool> exists() => _delegate.exists(where: _state.where);

  Future<JsonMap> create({required JsonMap data}) {
    return _delegate.create(
      data: data,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<List<JsonMap>> createMany({required List<JsonMap> data}) {
    return _delegate.createMany(
      data: data,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<int> deleteMany() => _delegate.deleteMany(where: _state.where);

  Future<JsonMap> upsert({required JsonMap create, required JsonMap update}) {
    return _delegate.upsert(
      where: _state.where,
      create: create,
      update: update,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> update({required JsonMap data}) {
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
    return _delegate.updateNested(
      where: _state.where,
      data: data,
      create: create,
      select: _state.select,
      include: _state.include,
    );
  }

  Future<JsonMap?> delete() => _delegate.delete(
    where: _state.where,
    select: _state.select,
    include: _state.include,
  );

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

List<JsonMap> _readRows(Object? data) {
  if (data == null) {
    return const <JsonMap>[];
  }
  if (data is! List<Object?>) {
    throw RuntimeResponseShapeException(
      action: 'findMany',
      expected: 'List<Map<String, Object?>>',
      actual: data,
    );
  }
  return data
      .map((value) => _coerceRow(value, action: 'findMany'))
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
