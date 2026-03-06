import 'package:meta/meta.dart';

import '../runtime/core.dart';
import '../runtime/errors.dart';
import '../runtime/types.dart';

typedef SqlMarkerQueryRunner =
    Future<SqlMarkerQueryResult> Function(SqlMarkerQuery query);

@immutable
final class SqlMarkerQuery {
  final String sql;
  final List<Object?> parameters;

  SqlMarkerQuery({
    required this.sql,
    List<Object?> parameters = const <Object?>[],
  }) : parameters = List<Object?>.from(parameters, growable: false);
}

@immutable
final class SqlMarkerQueryResult {
  final List<JsonMap> rows;

  const SqlMarkerQueryResult({this.rows = const <JsonMap>[]});
}

abstract interface class SqlMarkerQueryExecutor {
  Future<SqlMarkerQueryResult> query(SqlMarkerQuery query);
}

final class CallbackSqlMarkerQueryExecutor implements SqlMarkerQueryExecutor {
  final SqlMarkerQueryRunner _runner;

  const CallbackSqlMarkerQueryExecutor(this._runner);

  @override
  Future<SqlMarkerQueryResult> query(SqlMarkerQuery query) => _runner(query);
}

final class SqlContractMarkerReader implements ContractMarkerReader {
  static const String defaultHashColumn = 'storage_hash';

  final SqlMarkerQueryExecutor executor;
  final SqlMarkerQuery query;
  final String hashColumn;

  SqlContractMarkerReader({
    required this.executor,
    SqlMarkerQuery? query,
    this.hashColumn = defaultHashColumn,
  }) : query =
           query ??
           SqlMarkerQuery(
             sql: 'SELECT storage_hash FROM orm_contract.marker WHERE id = ?',
             parameters: const <Object?>[1],
           ) {
    if (hashColumn.trim().isEmpty) {
      throw ArgumentError.value(hashColumn, 'hashColumn', 'must not be empty');
    }
  }

  @override
  Future<String?> readContractHash() async {
    final SqlMarkerQueryResult result;
    try {
      result = await executor.query(query);
    } catch (error, stackTrace) {
      if (error is OrmRuntimeError) {
        rethrow;
      }
      Error.throwWithStackTrace(
        SqlMarkerQueryExecutionException(
          sql: query.sql,
          causeType: error.runtimeType.toString(),
        ),
        stackTrace,
      );
    }

    final rows = result.rows;
    if (rows.isEmpty) {
      return null;
    }

    if (rows.length > 1) {
      throw SqlMarkerMultipleRowsException(rowCount: rows.length);
    }

    final row = rows.single;
    if (!row.containsKey(hashColumn)) {
      throw SqlMarkerColumnMissingException(
        column: hashColumn,
        availableColumns: row.keys,
      );
    }

    final markerHash = row[hashColumn];
    if (markerHash == null) {
      throw SqlMarkerHashNullException(column: hashColumn);
    }

    if (markerHash is! String) {
      throw SqlMarkerHashTypeException(
        column: hashColumn,
        actualType: markerHash.runtimeType.toString(),
      );
    }

    final normalized = markerHash.trim();
    if (normalized.isEmpty) {
      throw SqlMarkerHashEmptyException(column: hashColumn);
    }

    return normalized;
  }
}

final class SqlMarkerQueryExecutionException extends OrmRuntimeError {
  SqlMarkerQueryExecutionException({
    required String sql,
    required String causeType,
  }) : super(
         code: 'RUNTIME.SQL_MARKER_QUERY_FAILED',
         category: RuntimeErrorCategory.runtime,
         message: 'SQL marker query execution failed.',
         details: <String, Object?>{'sql': sql, 'causeType': causeType},
       );
}

final class SqlMarkerMultipleRowsException extends OrmRuntimeError {
  SqlMarkerMultipleRowsException({required int rowCount})
    : super(
        code: 'RUNTIME.SQL_MARKER_MULTIPLE_ROWS',
        category: RuntimeErrorCategory.runtime,
        message: 'SQL marker query must return at most one row.',
        details: <String, Object?>{'rowCount': rowCount},
      );
}

final class SqlMarkerColumnMissingException extends OrmRuntimeError {
  SqlMarkerColumnMissingException({
    required String column,
    required Iterable<String> availableColumns,
  }) : super(
         code: 'RUNTIME.SQL_MARKER_COLUMN_MISSING',
         category: RuntimeErrorCategory.runtime,
         message: 'SQL marker query result is missing required column.',
         details: <String, Object?>{
           'column': column,
           'availableColumns': availableColumns.toList(growable: false),
         },
       );
}

final class SqlMarkerHashNullException extends OrmRuntimeError {
  SqlMarkerHashNullException({required String column})
    : super(
        code: 'RUNTIME.SQL_MARKER_HASH_NULL',
        category: RuntimeErrorCategory.runtime,
        message: 'SQL marker hash column value cannot be null.',
        details: <String, Object?>{'column': column},
      );
}

final class SqlMarkerHashTypeException extends OrmRuntimeError {
  SqlMarkerHashTypeException({
    required String column,
    required String actualType,
  }) : super(
         code: 'RUNTIME.SQL_MARKER_HASH_TYPE_INVALID',
         category: RuntimeErrorCategory.runtime,
         message: 'SQL marker hash column value must be a string.',
         details: <String, Object?>{'column': column, 'actualType': actualType},
       );
}

final class SqlMarkerHashEmptyException extends OrmRuntimeError {
  SqlMarkerHashEmptyException({required String column})
    : super(
        code: 'RUNTIME.SQL_MARKER_HASH_EMPTY',
        category: RuntimeErrorCategory.runtime,
        message: 'SQL marker hash column value cannot be empty.',
        details: <String, Object?>{'column': column},
      );
}
