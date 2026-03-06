import 'package:meta/meta.dart';

import '../core/sort_order.dart';
import 'types.dart';

enum OrmAction { read, create, update, delete }

enum OrmReadResultMode { all, firstOrNull, oneOrNull }

enum OrmMutationResultMode { row, rowOrNull }

@immutable
final class OrmReadCursorPlan {
  final JsonMap values;

  OrmReadCursorPlan({
    JsonMap values = const <String, Object?>{},
  }) : values = Map.unmodifiable(values);

  JsonMap toJson() => <String, Object?>{'values': values};
}

@immutable
final class OrmReadPagePlan {
  final int size;
  final JsonMap? after;
  final JsonMap? before;

  OrmReadPagePlan({
    required this.size,
    JsonMap? after,
    JsonMap? before,
  }) : after = after == null ? null : Map.unmodifiable(after),
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
  };
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
