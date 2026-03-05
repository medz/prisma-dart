import 'package:meta/meta.dart';

import '../core/sort_order.dart';
import 'types.dart';

enum OrmAction { findMany, findUnique, create, update, delete }

@immutable
final class OrmOrderBy {
  final String field;
  final SortOrder order;

  const OrmOrderBy(this.field, {this.order = SortOrder.asc});
}

@immutable
final class OrmPlan {
  final String contractHash;
  final String model;
  final OrmAction action;
  final JsonMap where;
  final JsonMap data;
  final int? skip;
  final int? take;
  final List<OrmOrderBy> orderBy;
  final List<String> select;

  OrmPlan({
    required this.contractHash,
    required this.model,
    required this.action,
    JsonMap where = const <String, Object?>{},
    JsonMap data = const <String, Object?>{},
    this.skip,
    this.take,
    List<OrmOrderBy> orderBy = const <OrmOrderBy>[],
    List<String> select = const <String>[],
  }) : where = Map.unmodifiable(where),
       data = Map.unmodifiable(data),
       orderBy = List.unmodifiable(orderBy),
       select = List.unmodifiable(select);
}
