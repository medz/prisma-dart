import 'package:orm/adapter.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import 'sqlite_transaction.dart';

/// SQLite adapter implementation
class SQLiteAdapter implements Adapter {
  final String path;
  sqlite.Database? _db;

  SQLiteAdapter(this.path);

  sqlite.Database get db {
    final database = _db;
    if (database == null) {
      throw StateError('Database is not connected. Call connect() first.');
    }
    return database;
  }

  @override
  Provider get provider => Provider.sqlite;

  @override
  String get adapterName => 'sqlite3';

  @override
  Future<void> connect() async {
    if (_db != null) {
      throw StateError('Database is already connected');
    }
    _db = sqlite.sqlite3.open(path);
  }

  @override
  Future<void> close() async {
    final database = _db;
    if (database == null) {
      throw StateError('Database is not connected');
    }
    database.dispose();
    _db = null;
  }

  @override
  Future<ResultSet> queryRaw(Query query) async {
    final result = db.select(query.sql, query.args);

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
      lastInsertId: db.lastInsertRowId,
    );
  }

  @override
  Future<int> executeRaw(Query query) async {
    db.execute(query.sql, query.args);
    return db.getUpdatedRows();
  }

  @override
  Future<void> executeScript(String script) async {
    db.execute(script);
  }

  @override
  Future<Transaction> startTransaction({IsolationLevel? isolationLevel}) async {
    // SQLite supports isolation levels via PRAGMA, but for simplicity
    // we'll start with basic BEGIN TRANSACTION
    final isolationSQL = _getIsolationLevelSQL(isolationLevel);

    if (isolationSQL != null) {
      db.execute(isolationSQL);
    }

    db.execute('BEGIN TRANSACTION');
    return SQLiteTransaction(db);
  }

  String? _getIsolationLevelSQL(IsolationLevel? level) {
    if (level == null) return null;

    switch (level) {
      case IsolationLevel.readUncommitted:
        return 'PRAGMA read_uncommitted = 1';
      case IsolationLevel.readCommitted:
      case IsolationLevel.repeatableRead:
      case IsolationLevel.serializable:
        // SQLite's default isolation is SERIALIZABLE
        // Other levels are not directly supported
        return null;
    }
  }
}
