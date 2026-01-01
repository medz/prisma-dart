import 'package:meta/meta_meta.dart';

@Target({.classType, .mixinType})
abstract mixin class Schema {
  const Schema();

  String get schema;
}
