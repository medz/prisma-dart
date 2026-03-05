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

abstract interface class OrmModelContext {
  OrmContract get contract;

  Future<EngineResponse> execute(OrmPlan plan);

  ModelDelegate model(String modelKey);

  ModelDelegate collection(String modelKey);
}

final class OrmClient implements OrmModelContext {
  @override
  final OrmContract contract;
  final OrmEngine engine;
  final OrmRuntimeCore _runtime;
  final Map<String, ModelDelegate> _delegates = <String, ModelDelegate>{};
  final Map<String, String> _modelAliases;
  final Map<String, CollectionFactory> _collectionRegistry;

  OrmClient({
    required this.contract,
    required this.engine,
    List<OrmPlugin> plugins = const <OrmPlugin>[],
    RuntimeVerifyOptions verify = const RuntimeVerifyOptions(),
    RuntimeMode mode = RuntimeMode.strict,
    RuntimeLog log = const SilentRuntimeLog(),
    Map<String, CollectionFactory> collections =
        const <String, CollectionFactory>{},
  }) : _runtime = OrmRuntimeCore(
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

  OrmScopedClient._({
    required this.contract,
    required Future<EngineResponse> Function(OrmPlan plan) executePlan,
    required Map<String, String> modelAliases,
    required Map<String, CollectionFactory> collectionRegistry,
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

  Future<List<JsonMap>> findMany({
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
  }) async {
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        model: modelName,
        action: OrmAction.findMany,
        where: where,
        skip: skip,
        take: take,
        orderBy: orderBy,
        select: select,
      ),
    );
    return _readRows(response.data);
  }

  Future<JsonMap?> findUnique({
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
  }) async {
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        model: modelName,
        action: OrmAction.findUnique,
        where: where,
        select: select,
      ),
    );
    return _readRow(response.data, action: 'findUnique');
  }

  Future<JsonMap> create({
    required JsonMap data,
    List<String> select = const <String>[],
  }) async {
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        model: modelName,
        action: OrmAction.create,
        data: data,
        select: select,
      ),
    );
    final row = _readRow(response.data, action: 'create');
    if (row == null) {
      throw RuntimeCreateResultMissingException(model: modelName);
    }
    return row;
  }

  Future<JsonMap?> update({
    JsonMap where = const <String, Object?>{},
    required JsonMap data,
    List<String> select = const <String>[],
  }) async {
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        model: modelName,
        action: OrmAction.update,
        where: where,
        data: data,
        select: select,
      ),
    );
    return _readRow(response.data, action: 'update');
  }

  Future<JsonMap?> delete({
    JsonMap where = const <String, Object?>{},
    List<String> select = const <String>[],
  }) async {
    final response = await _client.execute(
      OrmPlan(
        contractHash: _client.contract.hash,
        model: modelName,
        action: OrmAction.delete,
        where: where,
        select: select,
      ),
    );
    return _readRow(response.data, action: 'delete');
  }
}

@immutable
final class ModelQueryState {
  final JsonMap where;
  final int? skip;
  final int? take;
  final List<OrmOrderBy> orderBy;
  final List<String> select;

  const ModelQueryState({
    this.where = const <String, Object?>{},
    this.skip,
    this.take,
    this.orderBy = const <OrmOrderBy>[],
    this.select = const <String>[],
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

  ModelQuery where(JsonMap where, {bool merge = true}) {
    final nextWhere = merge
        ? Map<String, Object?>.unmodifiable(<String, Object?>{
            ..._state.where,
            ...where,
          })
        : Map<String, Object?>.unmodifiable(where);
    return _next(
      ModelQueryState(
        where: nextWhere,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        select: _state.select,
      ),
    );
  }

  ModelQuery orderBy(List<OrmOrderBy> orderBy, {bool append = true}) {
    final nextOrderBy = append
        ? List<OrmOrderBy>.unmodifiable(<OrmOrderBy>[
            ..._state.orderBy,
            ...orderBy,
          ])
        : List<OrmOrderBy>.unmodifiable(orderBy);
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: nextOrderBy,
        select: _state.select,
      ),
    );
  }

  ModelQuery orderByField(String field, {SortOrder order = SortOrder.asc}) {
    return orderBy(<OrmOrderBy>[OrmOrderBy(field, order: order)]);
  }

  ModelQuery select(List<String> fields, {bool append = false}) {
    final nextSelect = append
        ? List<String>.unmodifiable(<String>[..._state.select, ...fields])
        : List<String>.unmodifiable(fields);
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: _state.skip,
        take: _state.take,
        orderBy: _state.orderBy,
        select: nextSelect,
      ),
    );
  }

  ModelQuery selectField(String field) {
    return select(<String>[field], append: true);
  }

  ModelQuery skip(int value) {
    return _next(
      ModelQueryState(
        where: _state.where,
        skip: value,
        take: _state.take,
        orderBy: _state.orderBy,
        select: _state.select,
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
    );
  }

  Future<JsonMap?> findUnique() =>
      _delegate.findUnique(where: _state.where, select: _state.select);

  Future<JsonMap> create({required JsonMap data}) {
    return _delegate.create(data: data, select: _state.select);
  }

  Future<JsonMap?> update({required JsonMap data}) {
    return _delegate.update(
      where: _state.where,
      data: data,
      select: _state.select,
    );
  }

  Future<JsonMap?> delete() =>
      _delegate.delete(where: _state.where, select: _state.select);

  ModelQuery _next(ModelQueryState nextState) =>
      ModelQuery._(_delegate, nextState);
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

  return Map<String, CollectionFactory>.unmodifiable(registry);
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
  return List<JsonMap>.unmodifiable(
    data.map((value) => _coerceRow(value, action: 'findMany')),
  );
}

JsonMap? _readRow(Object? data, {required String action}) {
  if (data == null) {
    return null;
  }
  return _coerceRow(data, action: action);
}

JsonMap _coerceRow(Object? value, {required String action}) {
  if (value is Map<String, Object?>) {
    return Map<String, Object?>.unmodifiable(value);
  }
  if (value is Map<Object?, Object?>) {
    return Map<String, Object?>.unmodifiable(
      value.map((key, item) => MapEntry(key.toString(), item)),
    );
  }
  throw RuntimeResponseShapeException(
    action: action,
    expected: 'Map<String, Object?>',
    actual: value,
  );
}

String _lowercaseFirst(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value[0].toLowerCase() + value.substring(1);
}
