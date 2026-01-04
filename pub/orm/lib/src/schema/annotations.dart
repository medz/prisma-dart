import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

@immutable
@Target({.typedefType})
class Schema {
  final String schema;

  @literal
  const Schema(@mustBeConst this.schema);
}

@Target({.typedefType})
class _Model {
  @literal
  const _Model();
}

const model = _Model();

enum ReferenceAction { noAction, restrict, cascade, setNull, setDefault }

class Relation {
  final Iterable<String> references;
  final Iterable<String>? fields;
  final ReferenceAction? onDelete;
  final ReferenceAction? onUpdate;

  @literal
  const Relation({
    @mustBeConst required this.references,
    @mustBeConst this.fields,
    @mustBeConst this.onDelete,
    @mustBeConst this.onUpdate,
  });
}

class ID {
  final Iterable<String>? fields;

  @literal
  const ID([@mustBeConst this.fields]);
}

const id = ID();

class Map {
  final String name;

  const Map(this.name);
}
