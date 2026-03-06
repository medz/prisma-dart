import 'package:meta/meta.dart';

import '../core/sort_order.dart';
import 'types.dart';

enum OrmAction { read, create, update, delete }

enum OrmReadResultMode { all, firstOrNull, oneOrNull }

enum OrmMutationResultMode { row, rowOrNull }

enum OrmReadShape { rows, aggregate, groupedAggregate }

enum OrmGroupByHavingLogicalOperator { and, or, not }

enum OrmGroupByHavingMetricBucket { count, min, max, sum, avg }

@immutable
final class OrmReadCursorPlan {
  final JsonMap values;

  OrmReadCursorPlan({JsonMap values = const <String, Object?>{}})
    : values = Map.unmodifiable(values);

  JsonMap toJson() => <String, Object?>{'values': values};
}

@immutable
final class OrmReadPagePlan {
  final int size;
  final JsonMap? after;
  final JsonMap? before;

  OrmReadPagePlan({required this.size, JsonMap? after, JsonMap? before})
    : after = after == null ? null : Map.unmodifiable(after),
      before = before == null ? null : Map.unmodifiable(before);

  JsonMap toJson() => <String, Object?>{
    'size': size,
    if (after != null) 'after': after,
    if (before != null) 'before': before,
  };
}

@immutable
final class OrmRepositoryTrace {
  final String operationId;
  final String kind;
  final int step;
  final String phase;
  final String strategy;
  final String? relation;
  final int? itemIndex;

  const OrmRepositoryTrace({
    required this.operationId,
    required this.kind,
    required this.step,
    required this.phase,
    required this.strategy,
    this.relation,
    this.itemIndex,
  });

  JsonMap toJson() => <String, Object?>{
    'operationId': operationId,
    'kind': kind,
    'step': step,
    'phase': phase,
    'strategy': strategy,
    if (relation != null) 'relation': relation,
    if (itemIndex != null) 'itemIndex': itemIndex,
  };
}

@immutable
final class OrmOrderBy {
  final String field;
  final SortOrder order;

  const OrmOrderBy(this.field, {this.order = SortOrder.asc});

  JsonMap toJson() => <String, Object?>{'field': field, 'order': order.name};
}

@immutable
final class OrmIncludePlan {
  final JsonMap where;
  final int? skip;
  final int? take;
  final List<OrmOrderBy> orderBy;
  final List<String> select;
  final Map<String, OrmIncludePlan> include;

  OrmIncludePlan({
    JsonMap where = const <String, Object?>{},
    this.skip,
    this.take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
    Map<String, OrmIncludePlan> include = const <String, OrmIncludePlan>{},
  }) : where = Map.unmodifiable(where),
       orderBy = List.unmodifiable(orderBy),
       select = List.unmodifiable(select),
       include = Map.unmodifiable(include);

  JsonMap toJson() => <String, Object?>{
    'where': where,
    if (skip != null) 'skip': skip,
    if (take != null) 'take': take,
    'orderBy': orderBy.map((entry) => entry.toJson()).toList(growable: false),
    'select': select,
    'include': <String, Object?>{
      for (final entry in include.entries) entry.key: entry.value.toJson(),
    },
  };
}

@immutable
final class OrmReadPlan {
  final JsonMap where;
  final int? skip;
  final int? take;
  final List<OrmOrderBy> orderBy;
  final List<String> distinct;
  final List<String> select;
  final Map<String, OrmIncludePlan> include;
  final OrmReadCursorPlan? cursor;
  final OrmReadPagePlan? page;
  final OrmReadResultMode resultMode;
  final OrmReadShape shape;
  final OrmReadAggregatePlan? aggregate;
  final OrmReadGroupByPlan? groupBy;

  OrmReadPlan({
    JsonMap where = const <String, Object?>{},
    this.skip,
    this.take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, OrmIncludePlan> include = const <String, OrmIncludePlan>{},
    this.cursor,
    this.page,
    required this.resultMode,
    this.shape = OrmReadShape.rows,
    this.aggregate,
    this.groupBy,
  }) : where = Map.unmodifiable(where),
       orderBy = List.unmodifiable(orderBy),
       distinct = List.unmodifiable(distinct),
       select = List.unmodifiable(select),
       include = Map.unmodifiable(include);

  JsonMap toJson() => <String, Object?>{
    'where': where,
    if (skip != null) 'skip': skip,
    if (take != null) 'take': take,
    'orderBy': orderBy.map((entry) => entry.toJson()).toList(growable: false),
    'distinct': distinct,
    'select': select,
    'include': <String, Object?>{
      for (final entry in include.entries) entry.key: entry.value.toJson(),
    },
    if (cursor != null) 'cursor': cursor!.toJson(),
    if (page != null) 'page': page!.toJson(),
    'resultMode': resultMode.name,
    'shape': shape.name,
    if (aggregate != null) 'aggregate': aggregate!.toJson(),
    if (groupBy != null) 'groupBy': groupBy!.toJson(),
  };
}

@immutable
final class OrmReadAggregatePlan {
  final bool countAll;
  final List<String> count;
  final List<String> min;
  final List<String> max;
  final List<String> sum;
  final List<String> avg;

  OrmReadAggregatePlan({
    this.countAll = false,
    List<String> count = const <String>[],
    List<String> min = const <String>[],
    List<String> max = const <String>[],
    List<String> sum = const <String>[],
    List<String> avg = const <String>[],
  }) : count = List.unmodifiable(count),
       min = List.unmodifiable(min),
       max = List.unmodifiable(max),
       sum = List.unmodifiable(sum),
       avg = List.unmodifiable(avg);

  JsonMap toJson() => <String, Object?>{
    'countAll': countAll,
    'count': count,
    'min': min,
    'max': max,
    'sum': sum,
    'avg': avg,
  };
}

@immutable
final class OrmGroupByHavingCondition {
  final Object? shorthand;
  final Object? equals;
  final Object? not;
  final List<Object?>? inValues;
  final List<Object?>? notInValues;
  final String? contains;
  final String? startsWith;
  final String? endsWith;
  final Object? gt;
  final Object? gte;
  final Object? lt;
  final Object? lte;

  const OrmGroupByHavingCondition({
    this.shorthand,
    this.equals,
    this.not,
    this.inValues,
    this.notInValues,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.gt,
    this.gte,
    this.lt,
    this.lte,
  });

  factory OrmGroupByHavingCondition.parse(Object? value) {
    if (value is! Map) {
      return OrmGroupByHavingCondition(shorthand: value);
    }

    return OrmGroupByHavingCondition(
      equals: value['equals'],
      not: value['not'],
      inValues: _coerceObjectList(value['in']),
      notInValues: _coerceObjectList(value['notIn']),
      contains: value['contains'] as String?,
      startsWith: value['startsWith'] as String?,
      endsWith: value['endsWith'] as String?,
      gt: value['gt'],
      gte: value['gte'],
      lt: value['lt'],
      lte: value['lte'],
    );
  }

  bool get isEmpty =>
      shorthand == null &&
      equals == null &&
      not == null &&
      inValues == null &&
      notInValues == null &&
      contains == null &&
      startsWith == null &&
      endsWith == null &&
      gt == null &&
      gte == null &&
      lt == null &&
      lte == null;

  Object? toJsonValue() {
    if (shorthand != null) {
      return shorthand;
    }

    final map = <String, Object?>{};
    if (equals != null) {
      map['equals'] = equals;
    }
    if (not != null) {
      map['not'] = not;
    }
    if (inValues != null) {
      map['in'] = inValues;
    }
    if (notInValues != null) {
      map['notIn'] = notInValues;
    }
    if (contains != null) {
      map['contains'] = contains;
    }
    if (startsWith != null) {
      map['startsWith'] = startsWith;
    }
    if (endsWith != null) {
      map['endsWith'] = endsWith;
    }
    if (gt != null) {
      map['gt'] = gt;
    }
    if (gte != null) {
      map['gte'] = gte;
    }
    if (lt != null) {
      map['lt'] = lt;
    }
    if (lte != null) {
      map['lte'] = lte;
    }
    return map;
  }
}

sealed class OrmGroupByHavingNode {
  const OrmGroupByHavingNode();

  JsonMap toJson();
}

@immutable
final class OrmGroupByHavingLogicalNode extends OrmGroupByHavingNode {
  final OrmGroupByHavingLogicalOperator operator;
  final List<OrmGroupByHaving> clauses;

  OrmGroupByHavingLogicalNode({
    required this.operator,
    List<OrmGroupByHaving> clauses = const <OrmGroupByHaving>[],
  }) : clauses = List.unmodifiable(clauses);

  @override
  JsonMap toJson() => <String, Object?>{
    _logicalOperatorName(operator): clauses
        .map((clause) => clause.toJson())
        .toList(growable: false),
  };
}

@immutable
final class OrmGroupByHavingPredicateNode extends OrmGroupByHavingNode {
  final String field;
  final OrmGroupByHavingCondition condition;
  final OrmGroupByHavingMetricBucket? bucket;

  const OrmGroupByHavingPredicateNode({
    required this.field,
    required this.condition,
    this.bucket,
  });

  @override
  JsonMap toJson() {
    final value = condition.toJsonValue();
    if (bucket == null) {
      return <String, Object?>{field: value};
    }
    return <String, Object?>{
      _metricBucketName(bucket!): <String, Object?>{field: value},
    };
  }
}

@immutable
final class OrmGroupByHaving {
  final List<OrmGroupByHavingNode> nodes;

  const OrmGroupByHaving.empty() : nodes = const <OrmGroupByHavingNode>[];

  OrmGroupByHaving([List<OrmGroupByHavingNode> nodes = const []])
    : nodes = List.unmodifiable(nodes);

  factory OrmGroupByHaving.parse(JsonMap having) {
    final nodes = <OrmGroupByHavingNode>[];
    for (final entry in having.entries) {
      final key = entry.key;
      final value = entry.value;
      final logicalOperator = _parseLogicalOperator(key);
      if (logicalOperator != null) {
        final clauses = _parseLogicalClauses(value);
        nodes.add(
          OrmGroupByHavingLogicalNode(
            operator: logicalOperator,
            clauses: clauses,
          ),
        );
        continue;
      }

      final bucket = _parseMetricBucket(key);
      if (bucket != null) {
        if (value is! Map) {
          continue;
        }
        final bucketMap = Map<String, Object?>.from(value);
        for (final bucketEntry in bucketMap.entries) {
          nodes.add(
            OrmGroupByHavingPredicateNode(
              field: bucketEntry.key,
              condition: OrmGroupByHavingCondition.parse(bucketEntry.value),
              bucket: bucket,
            ),
          );
        }
        continue;
      }

      nodes.add(
        OrmGroupByHavingPredicateNode(
          field: key,
          condition: OrmGroupByHavingCondition.parse(value),
        ),
      );
    }
    return OrmGroupByHaving(nodes);
  }

  bool get isEmpty => nodes.isEmpty;
  bool get isNotEmpty => nodes.isNotEmpty;

  OrmGroupByHaving merge(OrmGroupByHaving other) =>
      OrmGroupByHaving.parse(<String, Object?>{...toJson(), ...other.toJson()});

  JsonMap toJson() {
    final map = <String, Object?>{};
    for (final node in nodes) {
      map.addAll(node.toJson());
    }
    return map;
  }
}

@immutable
final class OrmReadGroupByPlan {
  final List<String> by;
  final OrmGroupByHaving having;
  final List<OrmOrderBy> orderBy;
  final int? skip;
  final int? take;

  OrmReadGroupByPlan({
    required List<String> by,
    this.having = const OrmGroupByHaving.empty(),
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    this.skip,
    this.take,
  }) : by = List.unmodifiable(by),
       orderBy = List.unmodifiable(orderBy);

  JsonMap toJson() => <String, Object?>{
    'by': by,
    'having': having.toJson(),
    'orderBy': orderBy.map((entry) => entry.toJson()).toList(growable: false),
    if (skip != null) 'skip': skip,
    if (take != null) 'take': take,
  };
}

List<Object?>? _coerceObjectList(Object? value) {
  if (value is! List) {
    return null;
  }
  return List<Object?>.unmodifiable(value.cast<Object?>());
}

OrmGroupByHavingLogicalOperator? _parseLogicalOperator(String key) {
  return switch (key) {
    'AND' => OrmGroupByHavingLogicalOperator.and,
    'OR' => OrmGroupByHavingLogicalOperator.or,
    'NOT' => OrmGroupByHavingLogicalOperator.not,
    _ => null,
  };
}

String _logicalOperatorName(OrmGroupByHavingLogicalOperator operator) {
  return switch (operator) {
    OrmGroupByHavingLogicalOperator.and => 'AND',
    OrmGroupByHavingLogicalOperator.or => 'OR',
    OrmGroupByHavingLogicalOperator.not => 'NOT',
  };
}

OrmGroupByHavingMetricBucket? _parseMetricBucket(String key) {
  return switch (key) {
    '_count' => OrmGroupByHavingMetricBucket.count,
    '_min' => OrmGroupByHavingMetricBucket.min,
    '_max' => OrmGroupByHavingMetricBucket.max,
    '_sum' => OrmGroupByHavingMetricBucket.sum,
    '_avg' => OrmGroupByHavingMetricBucket.avg,
    _ => null,
  };
}

String _metricBucketName(OrmGroupByHavingMetricBucket bucket) {
  return switch (bucket) {
    OrmGroupByHavingMetricBucket.count => '_count',
    OrmGroupByHavingMetricBucket.min => '_min',
    OrmGroupByHavingMetricBucket.max => '_max',
    OrmGroupByHavingMetricBucket.sum => '_sum',
    OrmGroupByHavingMetricBucket.avg => '_avg',
  };
}

List<OrmGroupByHaving> _parseLogicalClauses(Object? operand) {
  if (operand is Map) {
    return <OrmGroupByHaving>[
      OrmGroupByHaving.parse(Map<String, Object?>.from(operand)),
    ];
  }
  if (operand is List) {
    return operand
        .whereType<Map>()
        .map(
          (entry) => OrmGroupByHaving.parse(Map<String, Object?>.from(entry)),
        )
        .toList(growable: false);
  }
  return const <OrmGroupByHaving>[];
}

@immutable
final class OrmMutationPlan {
  final JsonMap where;
  final JsonMap data;
  final List<String> select;
  final OrmMutationResultMode resultMode;

  OrmMutationPlan({
    JsonMap where = const <String, Object?>{},
    JsonMap data = const <String, Object?>{},
    List<String> select = const <String>[],
    required this.resultMode,
  }) : where = Map.unmodifiable(where),
       data = Map.unmodifiable(data),
       select = List.unmodifiable(select);

  JsonMap toJson() => <String, Object?>{
    'where': where,
    'data': data,
    'select': select,
    'resultMode': resultMode.name,
  };
}

@immutable
final class OrmPlan {
  final String contractHash;
  final String? target;
  final String? storageHash;
  final String? profileHash;
  final String? lane;
  final JsonMap annotations;
  final OrmRepositoryTrace? repositoryTrace;
  final String model;
  final OrmAction action;
  final OrmReadPlan? read;
  final OrmMutationPlan? mutation;

  OrmPlan({
    required this.contractHash,
    this.target,
    this.storageHash,
    this.profileHash,
    this.lane,
    JsonMap annotations = const <String, Object?>{},
    this.repositoryTrace,
    required this.model,
    required this.action,
    this.read,
    this.mutation,
  }) : annotations = Map.unmodifiable(annotations);

  factory OrmPlan.read({
    required String contractHash,
    String? target,
    String? storageHash,
    String? profileHash,
    String? lane,
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
    required String model,
    JsonMap where = const <String, Object?>{},
    int? skip,
    int? take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, OrmIncludePlan> include = const <String, OrmIncludePlan>{},
    OrmReadCursorPlan? cursor,
    OrmReadPagePlan? page,
    required OrmReadResultMode resultMode,
    OrmReadShape shape = OrmReadShape.rows,
    OrmReadAggregatePlan? aggregate,
    OrmReadGroupByPlan? groupBy,
  }) {
    return OrmPlan(
      contractHash: contractHash,
      target: target,
      storageHash: storageHash,
      profileHash: profileHash,
      lane: lane,
      annotations: annotations,
      repositoryTrace: repositoryTrace,
      model: model,
      action: OrmAction.read,
      read: OrmReadPlan(
        where: where,
        skip: skip,
        take: take,
        orderBy: orderBy,
        distinct: distinct,
        select: select,
        include: include,
        cursor: cursor,
        page: page,
        resultMode: resultMode,
        shape: shape,
        aggregate: aggregate,
        groupBy: groupBy,
      ),
    );
  }

  factory OrmPlan.mutation({
    required String contractHash,
    String? target,
    String? storageHash,
    String? profileHash,
    String? lane,
    JsonMap annotations = const <String, Object?>{},
    OrmRepositoryTrace? repositoryTrace,
    required String model,
    required OrmAction action,
    JsonMap where = const <String, Object?>{},
    JsonMap data = const <String, Object?>{},
    List<String> select = const <String>[],
    required OrmMutationResultMode resultMode,
  }) {
    return OrmPlan(
      contractHash: contractHash,
      target: target,
      storageHash: storageHash,
      profileHash: profileHash,
      lane: lane,
      annotations: annotations,
      repositoryTrace: repositoryTrace,
      model: model,
      action: action,
      mutation: OrmMutationPlan(
        where: where,
        data: data,
        select: select,
        resultMode: resultMode,
      ),
    );
  }

  JsonMap toJson() => <String, Object?>{
    'contractHash': contractHash,
    if (target != null) 'target': target,
    if (storageHash != null) 'storageHash': storageHash,
    if (profileHash != null) 'profileHash': profileHash,
    if (lane != null) 'lane': lane,
    'annotations': annotations,
    if (repositoryTrace != null) 'repositoryTrace': repositoryTrace!.toJson(),
    'model': model,
    'action': action.name,
    if (read != null) 'read': read!.toJson(),
    if (mutation != null) 'mutation': mutation!.toJson(),
  };
}
