import '../context.dart';

const _generatedFilename = 'sql.dart';
void buildTypedSql(Context context) {
  if (context.options.typedSql == null) {
    return;
  }

  for (final query in context.options.typedSql!) {
    final resultType = buildSqlQueryResultType(context, query);
    // buildSqlQueryFunction(context, query, resultType);
  }
}
