import 'package:meta/meta.dart';

import '../runtime/plan.dart';
import '../runtime/types.dart';

@immutable
final class SqlStatement {
  final OrmAction action;
  final String text;
  final List<Object?> parameters;

  SqlStatement({
    required this.action,
    required this.text,
    List<Object?> parameters = const <Object?>[],
  }) : parameters = List<Object?>.from(parameters, growable: false);
}

@immutable
final class SqlResult {
  final List<JsonMap> rows;
  final int affectedRows;

  const SqlResult({this.rows = const <JsonMap>[], this.affectedRows = 0});
}
