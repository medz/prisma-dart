import 'package:meta/meta_meta.dart';

@Target({.classType})
final class Model {
  final String? table;

  const Model({this.table});
}
