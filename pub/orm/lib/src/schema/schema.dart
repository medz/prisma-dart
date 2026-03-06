import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

@immutable
@Target({.typedefType})
final class Schema {
  final String schema;

  @literal
  const Schema(this.schema);
}
