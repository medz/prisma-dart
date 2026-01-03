import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

@immutable
@Target({.classType})
class Schema {
  final String schema;

  @literal
  const Schema(@mustBeConst this.schema);
}

@Target({.classType})
class _Model {
  @literal
  const _Model();
}

const model = _Model();

enum ReferenceAction { noAction, restrict, cascade, setNull, setDefault }

@Target({.getter})
class Relation {
  final Iterable<String> references;
  final ReferenceAction? onDelete;
  final ReferenceAction? onUpdate;

  @literal
  const Relation({
    @mustBeConst required this.references,
    @mustBeConst this.onDelete,
    @mustBeConst this.onUpdate,
  });
}

@Target({.classType, .getter})
class ID {
  final Iterable<String>? fields;

  @literal
  const ID([@mustBeConst this.fields]);
}

class Map {
  final String name;

  const Map(this.name);
}
