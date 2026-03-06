import '../core/sort_order.dart';
import '../runtime/plan.dart';
import '../runtime/types.dart';
import 'engine.dart';

const List<String> _whereOperatorOrder = <String>[
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

const Set<String> _whereOperators = <String>{
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

final class MemoryEngine implements OrmEngine, ConnectionCapableEngine {
  final Map<String, List<JsonMap>> _store;
  bool _opened = false;

  MemoryEngine({Map<String, List<JsonMap>> seed = const {}})
    : _store = _cloneStore(seed);

  @override
  Future<void> open() async {
    _opened = true;
  }

  @override
  Future<void> close() async {
    _opened = false;
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _ensureOpen();
    return _executeOnStore(_store, plan);
  }

  EngineResponse _executeOnStore(
    Map<String, List<JsonMap>> store,
    OrmPlan plan,
  ) {
    final bucket = store.putIfAbsent(plan.model, () => <JsonMap>[]);

    return switch (plan.action) {
      OrmAction.read => _read(bucket, plan),
      OrmAction.create => _create(bucket, plan),
      OrmAction.update => _update(bucket, plan),
      OrmAction.delete => _delete(bucket, plan),
    };
  }

  @override
  Future<EngineConnection> connection() async {
    _ensureOpen();
    return _MemoryConnection(this);
  }

  Map<String, List<JsonMap>> _snapshotStore() => _cloneStore(_store);

  void _replaceStore(Map<String, List<JsonMap>> nextStore) {
    _ensureOpen();
    _store
      ..clear()
      ..addAll(_cloneStore(nextStore));
  }

  void _ensureOpen() {
    if (_opened) {
      return;
    }
    throw StateError('MemoryEngine is closed. Call open() before execute().');
  }

  EngineResponse _read(List<JsonMap> bucket, OrmPlan plan) {
    var rows = bucket.where((row) => _matches(row, plan.where)).toList();

    if (plan.orderBy.isNotEmpty) {
      rows.sort((left, right) => _compareRows(left, right, plan.orderBy));
    }

    if (plan.skip case final skip?) {
      rows = skip >= rows.length ? <JsonMap>[] : rows.sublist(skip);
    }

    if (plan.take case final take?) {
      rows = take >= rows.length ? rows : rows.sublist(0, take);
    }

    final projected = rows
        .map((row) => _projectRow(row, plan.select))
        .toList(growable: false);

    return switch (plan.resultMode) {
      OrmReadResultMode.firstOrNull || OrmReadResultMode.oneOrNull =>
        EngineResponse(data: _firstOrNull(projected)),
      _ => EngineResponse(data: projected),
    };
  }

  EngineResponse _create(List<JsonMap> bucket, OrmPlan plan) {
    final row = _cloneRow(plan.data);
    bucket.add(row);
    return EngineResponse(data: _projectRow(row, plan.select), affectedRows: 1);
  }

  EngineResponse _update(List<JsonMap> bucket, OrmPlan plan) {
    for (var index = 0; index < bucket.length; index++) {
      final row = bucket[index];
      if (!_matches(row, plan.where)) {
        continue;
      }

      final updated = <String, Object?>{...row, ...plan.data};
      bucket[index] = updated;
      return EngineResponse(
        data: _projectRow(updated, plan.select),
        affectedRows: 1,
      );
    }
    return const EngineResponse(data: null, affectedRows: 0);
  }

  EngineResponse _delete(List<JsonMap> bucket, OrmPlan plan) {
    for (var index = 0; index < bucket.length; index++) {
      final row = bucket[index];
      if (!_matches(row, plan.where)) {
        continue;
      }

      bucket.removeAt(index);
      return EngineResponse(
        data: _projectRow(row, plan.select),
        affectedRows: 1,
      );
    }
    return const EngineResponse(data: null, affectedRows: 0);
  }

  bool _matches(JsonMap row, JsonMap where) {
    for (final entry in where.entries) {
      final matched = switch (entry.key) {
        'AND' => _matchesWhereAnd(row, entry.value),
        'OR' => _matchesWhereOr(row, entry.value),
        'NOT' => _matchesWhereNot(row, entry.value),
        _ => _matchesWhereField(
          row: row,
          field: entry.key,
          condition: entry.value,
        ),
      };
      if (!matched) {
        return false;
      }
    }
    return true;
  }

  bool _matchesWhereAnd(JsonMap row, Object? operand) {
    final whereList = _coerceWhereList(operand);
    if (whereList != null) {
      if (whereList.isEmpty) {
        return true;
      }
      for (final where in whereList) {
        if (!_matches(row, where)) {
          return false;
        }
      }
      return true;
    }

    final where = _coerceWhereMap(operand);
    if (where != null) {
      return _matches(row, where);
    }
    return false;
  }

  bool _matchesWhereOr(JsonMap row, Object? operand) {
    final whereList = _coerceWhereList(operand);
    if (whereList != null) {
      if (whereList.isEmpty) {
        return false;
      }
      for (final where in whereList) {
        if (_matches(row, where)) {
          return true;
        }
      }
      return false;
    }

    final where = _coerceWhereMap(operand);
    if (where != null) {
      return _matches(row, where);
    }
    return false;
  }

  bool _matchesWhereNot(JsonMap row, Object? operand) {
    final whereList = _coerceWhereList(operand);
    if (whereList != null) {
      if (whereList.isEmpty) {
        return true;
      }
      for (final where in whereList) {
        if (_matches(row, where)) {
          return false;
        }
      }
      return true;
    }

    final where = _coerceWhereMap(operand);
    if (where != null) {
      return !_matches(row, where);
    }
    return false;
  }

  bool _matchesWhereField({
    required JsonMap row,
    required String field,
    required Object? condition,
  }) {
    if (!row.containsKey(field)) {
      return false;
    }

    final actualValue = row[field];
    final operatorMap = _coerceOperatorMap(condition);
    if (operatorMap == null) {
      return actualValue == condition;
    }

    for (final operator in _whereOperatorOrder) {
      if (!operatorMap.containsKey(operator)) {
        continue;
      }

      final operand = operatorMap[operator];
      final matched = switch (operator) {
        'equals' => actualValue == operand,
        'not' => actualValue != operand,
        'in' => _matchIn(actualValue, operand),
        'notIn' => _matchNotIn(actualValue, operand),
        'contains' => _matchStringOperation(actualValue, operand, operator),
        'startsWith' => _matchStringOperation(actualValue, operand, operator),
        'endsWith' => _matchStringOperation(actualValue, operand, operator),
        'gt' => _matchComparison(actualValue, operand, operator),
        'gte' => _matchComparison(actualValue, operand, operator),
        'lt' => _matchComparison(actualValue, operand, operator),
        'lte' => _matchComparison(actualValue, operand, operator),
        _ => false,
      };

      if (!matched) {
        return false;
      }
    }

    return true;
  }

  Map<String, Object?>? _coerceOperatorMap(Object? value) {
    if (value is! Map) {
      return null;
    }
    if (value.isEmpty) {
      return null;
    }

    final normalized = <String, Object?>{};
    for (final entry in value.entries) {
      final key = entry.key;
      if (key is! String) {
        return null;
      }
      if (!_whereOperators.contains(key)) {
        return null;
      }
      normalized[key] = entry.value;
    }

    return normalized;
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

  bool _matchIn(Object? actualValue, Object? operand) {
    final values = _coerceListOperand(operand);
    if (values.isEmpty) {
      return false;
    }
    return values.contains(actualValue);
  }

  bool _matchNotIn(Object? actualValue, Object? operand) {
    final values = _coerceListOperand(operand);
    if (values.isEmpty) {
      return true;
    }
    return !values.contains(actualValue);
  }

  bool _matchStringOperation(
    Object? actualValue,
    Object? operand,
    String operator,
  ) {
    if (actualValue is! String || operand is! String) {
      return false;
    }

    return switch (operator) {
      'contains' => actualValue.contains(operand),
      'startsWith' => actualValue.startsWith(operand),
      'endsWith' => actualValue.endsWith(operand),
      _ => false,
    };
  }

  List<Object?> _coerceListOperand(Object? operand) {
    if (operand is List<Object?>) {
      return operand;
    }
    if (operand is List) {
      return List<Object?>.from(operand);
    }
    return const <Object?>[];
  }

  bool _matchComparison(Object? actualValue, Object? operand, String operator) {
    final comparison = _compareWhereValues(actualValue, operand);
    if (comparison == null) {
      return false;
    }
    return switch (operator) {
      'gt' => comparison > 0,
      'gte' => comparison >= 0,
      'lt' => comparison < 0,
      'lte' => comparison <= 0,
      _ => false,
    };
  }

  int? _compareWhereValues(Object? left, Object? right) {
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
      final leftInt = left ? 1 : 0;
      final rightInt = right ? 1 : 0;
      return leftInt.compareTo(rightInt);
    }
    if (left is Comparable<Object?> && left.runtimeType == right.runtimeType) {
      return left.compareTo(right);
    }
    return null;
  }

  int _compareRows(JsonMap left, JsonMap right, List<OrmOrderBy> orderBy) {
    for (final order in orderBy) {
      final leftValue = left[order.field];
      final rightValue = right[order.field];
      final comparison = _compareValues(leftValue, rightValue);
      if (comparison == 0) {
        continue;
      }
      return order.order == SortOrder.asc ? comparison : -comparison;
    }
    return 0;
  }

  int _compareValues(Object? left, Object? right) {
    if (left == right) {
      return 0;
    }
    if (left == null) {
      return -1;
    }
    if (right == null) {
      return 1;
    }
    if (left is Comparable<Object?> && left.runtimeType == right.runtimeType) {
      return left.compareTo(right);
    }
    return left.toString().compareTo(right.toString());
  }
}

JsonMap _cloneRow(JsonMap source) => Map<String, Object?>.unmodifiable(source);

JsonMap _projectRow(JsonMap source, List<String> select) {
  if (select.isEmpty) {
    return _cloneRow(source);
  }

  final projected = <String, Object?>{
    for (final field in select) field: source[field],
  };
  return Map<String, Object?>.unmodifiable(projected);
}

final class _MemoryConnection implements EngineConnection {
  final MemoryEngine _engine;
  bool _released = false;

  _MemoryConnection(this._engine);

  @override
  Future<EngineResponse> execute(OrmPlan plan) {
    _ensureActive();
    return _engine.execute(plan);
  }

  @override
  Future<EngineTransaction> transaction() async {
    _ensureActive();
    return _MemoryTransaction(_engine);
  }

  @override
  Future<void> release() async {
    _released = true;
  }

  void _ensureActive() {
    if (_released) {
      throw StateError('Memory connection has been released.');
    }
  }
}

final class _MemoryTransaction implements EngineTransaction {
  final MemoryEngine _engine;
  final Map<String, List<JsonMap>> _snapshot;
  bool _completed = false;

  _MemoryTransaction(this._engine) : _snapshot = _engine._snapshotStore();

  @override
  Future<void> commit() async {
    _ensureActive();
    _engine._replaceStore(_snapshot);
    _completed = true;
  }

  @override
  Future<EngineResponse> execute(OrmPlan plan) async {
    _ensureActive();
    _engine._ensureOpen();
    return _engine._executeOnStore(_snapshot, plan);
  }

  @override
  Future<void> rollback() async {
    _ensureActive();
    _completed = true;
  }

  void _ensureActive() {
    if (_completed) {
      throw StateError('Memory transaction is already completed.');
    }
  }
}

Map<String, List<JsonMap>> _cloneStore(Map<String, List<JsonMap>> source) {
  return <String, List<JsonMap>>{
    for (final entry in source.entries)
      entry.key: List<JsonMap>.from(entry.value.map(_cloneRow)),
  };
}

T? _firstOrNull<T>(List<T> values) {
  if (values.isEmpty) {
    return null;
  }
  return values.first;
}
