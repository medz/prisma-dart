import '../context.dart';
import '../../generator_helper/options.dart';

/// Returns the generated SQL query result type identifier and creates factory.
(String, String Function(String)) buildSqlQueryResultType(
    Context context, String libraryName, SqlQuery query) {
  if (query.resultColumns.isEmpty) return 'void';

  final library = context.getLibrary(libraryName);
  final name = '${query.name}Result';
  if (library.types.containsKey(name)) {
    return name;
  }

  final buffer = StringBuffer();
  buffer.write('extension type $name(Map<String, any> _)');
  buffer.writeln(' implements Map<String, any> {');
  for (final column in query.resultColumns) {
    final (type, factory) = buildType(context, column.typ);
  }
}
