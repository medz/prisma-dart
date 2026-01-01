/// Database provider types
enum Provider {
  mysql,
  postgres,
  sqlite,
  sqlserver,
  mongodb,
  cockroachdb,
}

/// SQL query with parameters
class Query {
  final String sql;
  final List<dynamic> args;

  const Query(this.sql, [this.args = const []]);
}

/// Query result set
class ResultSet {
  /// Column names in order
  final List<String> columnNames;

  /// Column types
  final List<String> columnTypes;

  /// Result rows
  final List<List<dynamic>> rows;

  /// Last inserted ID (for AUTO_INCREMENT databases)
  final dynamic lastInsertId;

  const ResultSet({
    required this.columnNames,
    required this.columnTypes,
    required this.rows,
    this.lastInsertId,
  });

  /// Convert rows to list of maps
  List<Map<String, dynamic>> toMaps() {
    return rows.map((row) {
      return Map.fromIterables(columnNames, row);
    }).toList();
  }
}

/// Transaction isolation levels
enum IsolationLevel {
  readUncommitted,
  readCommitted,
  repeatableRead,
  serializable,
}

/// Transaction interface
abstract class Transaction {
  /// Execute a query and return its result
  Future<ResultSet> queryRaw(Query query);

  /// Execute a query and return the number of affected rows
  Future<int> executeRaw(Query query);

  /// Commit the transaction
  Future<void> commit();

  /// Rollback the transaction
  Future<void> rollback();
}

/// Adapter information
abstract class AdapterInfo {
  /// Database provider type
  Provider get provider;

  /// Adapter name (e.g., 'sqlite3', 'postgres', 'mysql2')
  String get adapterName;
}

/// Base SQL adapter interface
abstract class Adapter implements AdapterInfo {
  /// Execute a query and return its result
  Future<ResultSet> queryRaw(Query query);

  /// Execute a query and return the number of affected rows
  Future<int> executeRaw(Query query);

  /// Execute multiple SQL statements separated by semicolon
  Future<void> executeScript(String script);

  /// Start a new transaction
  Future<Transaction> startTransaction({IsolationLevel? isolationLevel});

  /// Connect to the database
  Future<void> connect();

  /// Disconnect from the database
  Future<void> close();
}
