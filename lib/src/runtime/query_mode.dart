import '../core/json_convertible.dart';

enum QueryMode implements JsonConvertible<String> {
  $default('default'),
  insensitive('insensitive'),

  //---------------------------------------------
  ;

  final String value;
  const QueryMode(this.value);

  @override
  String toJson() => value;
}
