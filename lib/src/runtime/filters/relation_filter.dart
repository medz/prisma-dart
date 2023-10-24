import '../call.dart';

class RelationFilter<R> {
  final Factory<R> factory;

  const RelationFilter(this.factory);

  R $is(R where) => factory({'is': where});
  R isNot(R where) => factory({'isNot': where});
}

class ListRelationFilter<R> {
  final Factory<R> factory;

  const ListRelationFilter(this.factory);

  R every(R where) => factory({'every': where});
  R some(R where) => factory({'some': where});
  R none(R where) => factory({'none': where});
}
