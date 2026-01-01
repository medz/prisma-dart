import 'package:orm/adapter.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

/// SQLite transaction implementation
class SQLiteTransaction implements Transaction {
  final sqlite.Database _db;
  bool _completed = false;

  SQLiteTransaction(this._db);

  @override
  Future<ResultSet> queryRaw(Query query) async {
    if (_completed) {
      throw StateError('Transaction has already been completed');
    }

    final result = _db.select(query.sql, query.args);

    if (result.isEmpty) {
      return ResultSet(
        columnNames: [],
        columnTypes: [],
        rows: [],
        lastInsertId: null,
      );
    }

    return ResultSet(
      columnNames: result.first.keys.toList(),
      columnTypes: result.columnTypes?.map((t) => t.toString()).toList() ?? [],
      rows: result.map((row) => row.values.toList()).toList(),
      lastInsertId: null,
    );
  }

  @override
  Future<int> executeRaw(Query query) async {
    if (_completed) {
      throw StateError('Transaction has already been completed');
    }

    _db.execute(query.sql, query.args);
    return _db.getUpdatedRows();
  }

  @override
  Future<void> commit() async {
    if (_completed) {
      throw StateError('Transaction has already been completed');
    }

    _db.execute('COMMIT');
    _completed = true;
  }

  @override
  Future<void> rollback() async {
    if (_completed) {
      throw StateError('Transaction has already been completed');
    }

    _db.execute('ROLLBACK');
    _completed = true;
  }
}
