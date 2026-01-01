import 'package:orm/adapter.dart';
import 'package:orm_sqlite/orm_sqlite.dart';

Future<void> main() async {
  // Create SQLite adapter
  final adapter = SQLiteAdapter('test.db');

  // Connect to database
  await adapter.connect();
  print('✓ Connected to SQLite database');

  // Create a test table
  await adapter.executeScript('''
    DROP TABLE IF EXISTS users;
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT NOT NULL UNIQUE,
      name TEXT,
      role TEXT DEFAULT 'user',
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  ''');
  print('✓ Created users table');

  // Insert data
  final insertCount = await adapter.executeRaw(
    Query(
      'INSERT INTO users (email, name) VALUES (?, ?)',
      ['test@example.com', 'Test User'],
    ),
  );
  print('✓ Inserted $insertCount row(s)');

  // Query data
  final result = await adapter.queryRaw(Query('SELECT * FROM users'));
  print('✓ Queried ${result.rows.length} row(s)');
  print('  Last insert ID: ${result.lastInsertId}');
  print('  Columns: ${result.columnNames}');
  print('  Data: ${result.toMaps()}');

  // Test transaction
  print('\n--- Testing Transaction ---');
  final tx = await adapter.startTransaction();

  try {
    await tx.executeRaw(
      Query(
        'INSERT INTO users (email, name) VALUES (?, ?)',
        ['tx@example.com', 'Transaction User'],
      ),
    );
    print('✓ Inserted row in transaction');

    final txResult = await tx.queryRaw(Query('SELECT * FROM users'));
    print('✓ Queried ${txResult.rows.length} row(s) in transaction');

    await tx.commit();
    print('✓ Transaction committed');
  } catch (e) {
    await tx.rollback();
    print('✗ Transaction rolled back: $e');
  }

  // Verify transaction result
  final finalResult = await adapter.queryRaw(Query('SELECT * FROM users'));
  print('\n--- Final Results ---');
  print('Total users: ${finalResult.rows.length}');
  for (final user in finalResult.toMaps()) {
    print('  - ${user['email']}: ${user['name']}');
  }

  // Close connection
  await adapter.close();
  print('\n✓ Connection closed');
}
