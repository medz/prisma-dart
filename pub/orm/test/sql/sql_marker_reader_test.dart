import 'package:orm/orm.dart';
import 'package:test/test.dart';

void main() {
  group('SqlContractMarkerReader', () {
    test('implements ContractMarkerReader for runtime verify', () {
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => const SqlMarkerQueryResult(),
        ),
      );

      expect(reader, isA<ContractMarkerReader>());
    });

    test('reads marker hash from single-row result', () async {
      SqlMarkerQuery? capturedQuery;
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor((query) async {
          capturedQuery = query;
          return const SqlMarkerQueryResult(
            rows: <JsonMap>[
              <String, Object?>{'storage_hash': 'hash-v1'},
            ],
          );
        }),
      );

      final markerHash = await reader.readContractHash();
      expect(markerHash, 'hash-v1');
      expect(
        capturedQuery?.sql,
        'SELECT storage_hash FROM orm_contract.marker WHERE id = ?',
      );
      expect(capturedQuery?.parameters, <Object?>[1]);
    });

    test('supports custom query and hash column', () async {
      SqlMarkerQuery? capturedQuery;
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor((query) async {
          capturedQuery = query;
          return const SqlMarkerQueryResult(
            rows: <JsonMap>[
              <String, Object?>{'core_hash': 'hash-v2'},
            ],
          );
        }),
        query: SqlMarkerQuery(
          sql: 'SELECT core_hash FROM contract_marker WHERE marker_id = ?',
          parameters: const <Object?>[7],
        ),
        hashColumn: 'core_hash',
      );

      final markerHash = await reader.readContractHash();
      expect(markerHash, 'hash-v2');
      expect(
        capturedQuery?.sql,
        'SELECT core_hash FROM contract_marker WHERE marker_id = ?',
      );
      expect(capturedQuery?.parameters, <Object?>[7]);
    });

    test('returns null for empty result', () async {
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => const SqlMarkerQueryResult(rows: <JsonMap>[]),
        ),
      );

      final markerHash = await reader.readContractHash();
      expect(markerHash, isNull);
    });

    test('throws stable error when result has multiple rows', () async {
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => const SqlMarkerQueryResult(
            rows: <JsonMap>[
              <String, Object?>{'storage_hash': 'hash-v1'},
              <String, Object?>{'storage_hash': 'hash-v2'},
            ],
          ),
        ),
      );

      await expectLater(
        reader.readContractHash(),
        throwsA(
          isA<SqlMarkerMultipleRowsException>()
              .having(
                (error) => error.code,
                'code',
                'RUNTIME.SQL_MARKER_MULTIPLE_ROWS',
              )
              .having((error) => error.details['rowCount'], 'rowCount', 2),
        ),
      );
    });

    test('throws stable error when required column is missing', () async {
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => const SqlMarkerQueryResult(
            rows: <JsonMap>[
              <String, Object?>{'core_hash': 'hash-v1'},
            ],
          ),
        ),
      );

      await expectLater(
        reader.readContractHash(),
        throwsA(
          isA<SqlMarkerColumnMissingException>()
              .having(
                (error) => error.code,
                'code',
                'RUNTIME.SQL_MARKER_COLUMN_MISSING',
              )
              .having(
                (error) => error.details['column'],
                'column',
                'storage_hash',
              ),
        ),
      );
    });

    test('throws stable error when hash type is invalid', () async {
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => const SqlMarkerQueryResult(
            rows: <JsonMap>[
              <String, Object?>{'storage_hash': 123},
            ],
          ),
        ),
      );

      await expectLater(
        reader.readContractHash(),
        throwsA(
          isA<SqlMarkerHashTypeException>()
              .having(
                (error) => error.code,
                'code',
                'RUNTIME.SQL_MARKER_HASH_TYPE_INVALID',
              )
              .having(
                (error) => error.details['actualType'],
                'actualType',
                'int',
              ),
        ),
      );
    });

    test('wraps executor errors with stable marker query code', () async {
      final reader = SqlContractMarkerReader(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => throw StateError('driver broken'),
        ),
      );

      await expectLater(
        reader.readContractHash(),
        throwsA(
          isA<SqlMarkerQueryExecutionException>()
              .having(
                (error) => error.code,
                'code',
                'RUNTIME.SQL_MARKER_QUERY_FAILED',
              )
              .having(
                (error) => error.details['causeType'],
                'causeType',
                'StateError',
              ),
        ),
      );
    });
  });

  group('sqlRuntimeVerifyOptions', () {
    test('creates runtime verify options with defaults', () {
      final options = sqlRuntimeVerifyOptions(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => const SqlMarkerQueryResult(),
        ),
      );

      expect(options.mode, RuntimeVerifyMode.onFirstUse);
      expect(options.requireMarker, isTrue);
      expect(options.markerReader, isA<SqlContractMarkerReader>());

      final reader = options.markerReader! as SqlContractMarkerReader;
      expect(reader.hashColumn, SqlContractMarkerReader.defaultHashColumn);
      expect(
        reader.query.sql,
        'SELECT storage_hash FROM orm_contract.marker WHERE id = ?',
      );
      expect(reader.query.parameters, <Object?>[1]);
    });

    test('supports overriding helper options', () {
      final options = sqlRuntimeVerifyOptions(
        executor: CallbackSqlMarkerQueryExecutor(
          (_) async => const SqlMarkerQueryResult(),
        ),
        mode: RuntimeVerifyMode.always,
        requireMarker: false,
        query: SqlMarkerQuery(
          sql: 'SELECT core_hash FROM contract_marker WHERE marker_id = ?',
          parameters: const <Object?>[7],
        ),
        hashColumn: 'core_hash',
      );

      expect(options.mode, RuntimeVerifyMode.always);
      expect(options.requireMarker, isFalse);
      expect(options.markerReader, isA<SqlContractMarkerReader>());

      final reader = options.markerReader! as SqlContractMarkerReader;
      expect(
        reader.query.sql,
        'SELECT core_hash FROM contract_marker WHERE marker_id = ?',
      );
      expect(reader.query.parameters, <Object?>[7]);
      expect(reader.hashColumn, 'core_hash');
    });
  });

  group('sqlRuntimeVerifyOptions runtime integration', () {
    test('can be consumed by runtime client', () async {
      final contract = _contract(hash: 'hash-v1');
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        verify: sqlRuntimeVerifyOptions(
          executor: CallbackSqlMarkerQueryExecutor(
            (_) async => const SqlMarkerQueryResult(
              rows: <JsonMap>[
                <String, Object?>{'storage_hash': 'hash-v1'},
              ],
            ),
          ),
        ),
      );

      await client.connect();
      await expectLater(client.model('User').all(), completes);
      await client.disconnect();
    });

    test('empty marker result maps to missing marker when required', () async {
      final contract = _contract(hash: 'hash-v1');
      final client = OrmClient(
        contract: contract,
        engine: MemoryEngine(),
        verify: sqlRuntimeVerifyOptions(
          executor: CallbackSqlMarkerQueryExecutor(
            (_) async => const SqlMarkerQueryResult(),
          ),
        ),
      );

      await client.connect();
      await expectLater(
        client.model('User').all(),
        throwsA(isA<ContractMarkerMissingException>()),
      );
      await client.disconnect();
    });
  });
}

OrmContract _contract({required String hash}) {
  return OrmContract(
    version: '1',
    hash: hash,
    models: <String, ModelContract>{
      'User': ModelContract(
        name: 'User',
        table: 'users',
        fields: <String>{'id', 'email'},
      ),
    },
  );
}
