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
    final read = plan.read!;
    return switch (read.shape) {
      OrmReadShape.rows => _readRows(bucket, read),
      OrmReadShape.aggregate => _readAggregate(bucket, read),
      OrmReadShape.groupedAggregate => _readGroupedAggregate(bucket, read),
    };
  }

  EngineResponse _readRows(List<JsonMap> bucket, OrmReadPlan read) {
    var rows = bucket.where((row) => _matches(row, read.where)).toList();

    if (read.orderBy.isNotEmpty) {
      rows.sort((left, right) => _compareRows(left, right, read.orderBy));
    }

    if (read.distinct.isNotEmpty) {
      rows = _applyDistinctRows(rows, read.distinct);
    }

    rows = _applyReadWindow(rows, read);

    final projected = rows
        .map((row) => _projectRow(row, read.select))
        .toList(growable: false);

    return switch (read.resultMode) {
      OrmReadResultMode.firstOrNull || OrmReadResultMode.oneOrNull =>
        EngineResponse.buffered(_firstOrNull(projected)),
      _ => EngineResponse.buffered(projected),
    };
  }

  EngineResponse _readAggregate(List<JsonMap> bucket, OrmReadPlan read) {
    final aggregate = read.aggregate!;
    var rows = bucket.where((row) => _matches(row, read.where)).toList();

    if (read.orderBy.isNotEmpty) {
      rows.sort((left, right) => _compareRows(left, right, read.orderBy));
    }

    if (read.distinct.isNotEmpty) {
      rows = _applyDistinctRows(rows, read.distinct);
    }

    rows = _applyReadWindow(rows, read);
    final projected = rows
        .map((row) => _projectRow(row, read.select))
        .toList(growable: false);

    return EngineResponse.buffered(
      _buildAggregateResult(
        rows: projected,
        countAll: aggregate.countAll,
        count: aggregate.count,
        min: aggregate.min,
        max: aggregate.max,
        sum: aggregate.sum,
        avg: aggregate.avg,
      ),
    );
  }

  List<JsonMap> _applyDistinctRows(List<JsonMap> rows, List<String> distinct) {
    if (rows.isEmpty || distinct.isEmpty) {
      return rows;
    }

    final seen = <_MemoryGroupKey>{};
    final deduplicated = <JsonMap>[];
    for (final row in rows) {
      final key = _MemoryGroupKey(
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

  EngineResponse _readGroupedAggregate(List<JsonMap> bucket, OrmReadPlan read) {
    final aggregate = read.aggregate!;
    final groupBy = read.groupBy!;
    final projected = bucket
        .where((row) => _matches(row, read.where))
        .map((row) => _projectRow(row, read.select))
        .toList(growable: false);

    final groupedRows = <_MemoryGroupKey, List<JsonMap>>{};
    for (final row in projected) {
      final key = _MemoryGroupKey(
        groupBy.by.map((field) => row[field]).toList(growable: false),
      );
      groupedRows.putIfAbsent(key, () => <JsonMap>[]).add(row);
    }

    var results = <JsonMap>[];
    for (final entry in groupedRows.entries) {
      final rows = entry.value;
      if (rows.isEmpty) {
        continue;
      }

      final result = <String, Object?>{};
      final first = rows.first;
      for (final field in groupBy.by) {
        result[field] = first[field];
      }
      result.addAll(
        _buildAggregateResult(
          rows: rows,
          countAll: aggregate.countAll,
          count: aggregate.count,
          min: aggregate.min,
          max: aggregate.max,
          sum: aggregate.sum,
          avg: aggregate.avg,
        ),
      );
      results.add(Map<String, Object?>.unmodifiable(result));
    }

    if (groupBy.having.isNotEmpty) {
      results = results
          .where(
            (row) => _matchesGroupByHaving(row: row, having: groupBy.having),
          )
          .toList(growable: false);
    }

    if (groupBy.orderBy.isNotEmpty) {
      results.sort(
        (left, right) => _compareRowsForGroupByOrderBy(
          left: left,
          right: right,
          orderBy: groupBy.orderBy,
        ),
      );
    }

    if (groupBy.skip case final skip?) {
      results = skip >= results.length ? <JsonMap>[] : results.sublist(skip);
    }
    if (groupBy.take case final take?) {
      results = take >= results.length ? results : results.sublist(0, take);
    }

    return EngineResponse.buffered(results);
  }

  List<JsonMap> _applyReadWindow(List<JsonMap> rows, OrmReadPlan read) {
    var next = rows;

    if (read.page case final page?) {
      return _applyPageWindow(next, read.orderBy, page);
    }

    if (read.cursor case final cursor?) {
      next = next
          .where(
            (row) =>
                _compareRowToBoundary(
                  row: row,
                  boundary: cursor.values,
                  orderBy: read.orderBy,
                ) >=
                0,
          )
          .toList(growable: false);
    }

    if (read.skip case final skip?) {
      next = skip >= next.length ? <JsonMap>[] : next.sublist(skip);
    }

    if (read.take case final take?) {
      next = take >= next.length ? next : next.sublist(0, take);
    }

    return next;
  }

  List<JsonMap> _applyPageWindow(
    List<JsonMap> rows,
    List<OrmOrderBy> orderBy,
    OrmReadPagePlan page,
  ) {
    if (page.after case final after?) {
      final filtered = rows
          .where(
            (row) =>
                _compareRowToBoundary(
                  row: row,
                  boundary: after,
                  orderBy: orderBy,
                ) >
                0,
          )
          .toList(growable: false);
      return page.size >= filtered.length
          ? filtered
          : filtered.sublist(0, page.size);
    }

    if (page.before case final before?) {
      final filtered = rows
          .where(
            (row) =>
                _compareRowToBoundary(
                  row: row,
                  boundary: before,
                  orderBy: orderBy,
                ) <
                0,
          )
          .toList(growable: false);
      if (page.size >= filtered.length) {
        return filtered;
      }
      return filtered.sublist(filtered.length - page.size);
    }

    return page.size >= rows.length ? rows : rows.sublist(0, page.size);
  }

  EngineResponse _create(List<JsonMap> bucket, OrmPlan plan) {
    final mutation = plan.mutation!;
    final row = _cloneRow(mutation.data);
    bucket.add(row);
    return EngineResponse.buffered(
      _projectRow(row, mutation.select),
      affectedRows: 1,
    );
  }

  EngineResponse _update(List<JsonMap> bucket, OrmPlan plan) {
    final mutation = plan.mutation!;
    for (var index = 0; index < bucket.length; index++) {
      final row = bucket[index];
      if (!_matches(row, mutation.where)) {
        continue;
      }

      final updated = <String, Object?>{...row, ...mutation.data};
      bucket[index] = updated;
      return EngineResponse.buffered(
        _projectRow(updated, mutation.select),
        affectedRows: 1,
      );
    }
    return EngineResponse.empty(affectedRows: 0);
  }

  EngineResponse _delete(List<JsonMap> bucket, OrmPlan plan) {
    final mutation = plan.mutation!;
    for (var index = 0; index < bucket.length; index++) {
      final row = bucket[index];
      if (!_matches(row, mutation.where)) {
        continue;
      }

      bucket.removeAt(index);
      return EngineResponse.buffered(
        _projectRow(row, mutation.select),
        affectedRows: 1,
      );
    }
    return EngineResponse.empty(affectedRows: 0);
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

  int _compareRowToBoundary({
    required JsonMap row,
    required JsonMap boundary,
    required List<OrmOrderBy> orderBy,
  }) {
    for (final order in orderBy) {
      final comparison = _compareValues(
        row[order.field],
        boundary[order.field],
      );
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
      result['min'] = <String, Object?>{
        for (final field in min) field: _aggregateMin(rows: rows, field: field),
      };
    }
    if (max.isNotEmpty) {
      result['max'] = <String, Object?>{
        for (final field in max) field: _aggregateMax(rows: rows, field: field),
      };
    }
    if (sum.isNotEmpty) {
      result['sum'] = <String, Object?>{
        for (final field in sum) field: _aggregateSum(rows: rows, field: field),
      };
    }
    if (avg.isNotEmpty) {
      result['avg'] = <String, Object?>{
        for (final field in avg) field: _aggregateAvg(rows: rows, field: field),
      };
    }

    return Map<String, Object?>.unmodifiable(result);
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
    return count == 0 ? null : sum / count;
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

  bool _matchesGroupByHaving({
    required JsonMap row,
    required OrmGroupByHaving having,
  }) {
    for (final node in having.nodes) {
      switch (node) {
        case OrmGroupByHavingLogicalNode():
          if (!_matchesGroupByHavingLogical(row: row, node: node)) {
            return false;
          }
        case OrmGroupByHavingPredicateNode():
          final actual = node.bucket == null
              ? row[node.field]
              : _readGroupByAggregateValue(
                  row: row,
                  bucket: _groupByHavingBucketName(node.bucket!),
                  field: node.field,
                );
          if (!_matchesGroupByHavingCondition(
            actual: actual,
            condition: node.condition,
          )) {
            return false;
          }
      }
    }
    return true;
  }

  bool _matchesGroupByHavingLogical({
    required JsonMap row,
    required OrmGroupByHavingLogicalNode node,
  }) {
    final clauses = node.clauses;
    return switch (node.operator) {
      OrmGroupByHavingLogicalOperator.and => clauses.every(
        (clause) => _matchesGroupByHaving(row: row, having: clause),
      ),
      OrmGroupByHavingLogicalOperator.or => clauses.any(
        (clause) => _matchesGroupByHaving(row: row, having: clause),
      ),
      OrmGroupByHavingLogicalOperator.not => clauses.every(
        (clause) => !_matchesGroupByHaving(row: row, having: clause),
      ),
    };
  }

  bool _matchesGroupByHavingCondition({
    required Object? actual,
    required OrmGroupByHavingCondition condition,
  }) {
    if (condition.shorthand != null) {
      return actual == condition.shorthand;
    }
    if (condition.isEmpty) {
      return true;
    }
    if (condition.equals != null && actual != condition.equals) {
      return false;
    }
    final notOperand = condition.not;
    if (notOperand != null) {
      final matched = notOperand is Map
          ? !_matchesGroupByHavingCondition(
              actual: actual,
              condition: OrmGroupByHavingCondition.parse(notOperand),
            )
          : actual != notOperand;
      if (!matched) {
        return false;
      }
    }
    if (condition.gt != null && !_matchComparison(actual, condition.gt, 'gt')) {
      return false;
    }
    if (condition.gte != null &&
        !_matchComparison(actual, condition.gte, 'gte')) {
      return false;
    }
    if (condition.lt != null && !_matchComparison(actual, condition.lt, 'lt')) {
      return false;
    }
    if (condition.lte != null &&
        !_matchComparison(actual, condition.lte, 'lte')) {
      return false;
    }
    return true;
  }

  String _groupByHavingBucketName(OrmGroupByHavingMetricBucket bucket) {
    return switch (bucket) {
      OrmGroupByHavingMetricBucket.count => 'count',
      OrmGroupByHavingMetricBucket.min => 'min',
      OrmGroupByHavingMetricBucket.max => 'max',
      OrmGroupByHavingMetricBucket.sum => 'sum',
      OrmGroupByHavingMetricBucket.avg => 'avg',
    };
  }

  String? _normalizeAggregateBucket(String bucket) {
    return switch (bucket) {
      'count' || '_count' => 'count',
      'min' || '_min' => 'min',
      'max' || '_max' => 'max',
      'sum' || '_sum' => 'sum',
      'avg' || '_avg' => 'avg',
      _ => null,
    };
  }

  Object? _readGroupByAggregateValue({
    required JsonMap row,
    required String bucket,
    required String field,
  }) {
    final bucketValue = row[bucket];
    if (bucketValue is! Map) {
      return null;
    }
    return bucketValue[field];
  }

  Object? _readGroupByOrderByValue({
    required JsonMap row,
    required String field,
  }) {
    final fieldPath = field.split('.');
    if (fieldPath.length != 2) {
      return row[field];
    }
    final bucket = _normalizeAggregateBucket(fieldPath[0]);
    if (bucket == null) {
      return row[field];
    }
    return _readGroupByAggregateValue(
      row: row,
      bucket: bucket,
      field: fieldPath[1],
    );
  }

  int _compareRowsForGroupByOrderBy({
    required JsonMap left,
    required JsonMap right,
    required List<OrmOrderBy> orderBy,
  }) {
    for (final clause in orderBy) {
      final compared = _compareValues(
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
}

final class _MemoryGroupKey {
  final List<Object?> values;

  const _MemoryGroupKey(this.values);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! _MemoryGroupKey || values.length != other.values.length) {
      return false;
    }
    for (var index = 0; index < values.length; index++) {
      if (values[index] != other.values[index]) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(values);
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
