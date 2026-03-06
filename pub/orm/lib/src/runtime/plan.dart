import 'package:meta/meta.dart';

import '../core/sort_order.dart';
import 'types.dart';

enum OrmAction { findMany, findUnique, create, update, delete }

enum OrmReadResultMode { all, firstOrNull, oneOrNull }

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
final class OrmPlan {
  final String contractHash;
  final String? target;
  final String? storageHash;
  final String? profileHash;
  final String? lane;
  final OrmReadResultMode? resultMode;
  final Map<String, OrmIncludePlan> include;
  final JsonMap annotations;
  final String model;
  final OrmAction action;
  final JsonMap where;
  final JsonMap data;
  final int? skip;
  final int? take;
  final List<OrmOrderBy> orderBy;
  final List<String> distinct;
  final List<String> select;

  OrmPlan({
    required this.contractHash,
    this.target,
    this.storageHash,
    this.profileHash,
    this.lane,
    this.resultMode,
    Map<String, OrmIncludePlan> include = const <String, OrmIncludePlan>{},
    JsonMap annotations = const <String, Object?>{},
    required this.model,
    required this.action,
    JsonMap where = const <String, Object?>{},
    JsonMap data = const <String, Object?>{},
    this.skip,
    this.take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> distinct = const <String>[],
    List<String> select = const <String>[],
  }) : include = Map.unmodifiable(include),
       annotations = Map.unmodifiable(annotations),
       where = Map.unmodifiable(where),
       data = Map.unmodifiable(data),
       orderBy = List.unmodifiable(orderBy),
       distinct = List.unmodifiable(distinct),
       select = List.unmodifiable(select);
}
