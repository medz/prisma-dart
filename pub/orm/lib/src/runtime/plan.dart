import 'package:meta/meta.dart';

import '../core/sort_order.dart';
import 'types.dart';

enum OrmAction { read, create, update, delete }

enum OrmReadResultMode { all, firstOrNull, oneOrNull }

enum OrmMutationResultMode { row, rowOrNull }

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
}

@immutable
final class OrmOrderBy {
  final String field;
  final SortOrder order;

  const OrmOrderBy(this.field, {this.order = SortOrder.asc});
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
  final OrmReadResultMode resultMode;

  OrmReadPlan({
    JsonMap where = const <String, Object?>{},
    this.skip,
    this.take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
    Map<String, OrmIncludePlan> include = const <String, OrmIncludePlan>{},
    required this.resultMode,
  }) : where = Map.unmodifiable(where),
       orderBy = List.unmodifiable(orderBy),
       distinct = List.unmodifiable(distinct),
       select = List.unmodifiable(select),
       include = Map.unmodifiable(include);
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
}
