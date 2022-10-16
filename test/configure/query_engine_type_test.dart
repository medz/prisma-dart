import 'package:orm/src/configure/query_engine_type.dart';
import 'package:test/test.dart';

void main() {
  test('toString() eq name', () {
    for (final QueryEngineType type in QueryEngineType.values) {
      expect(type.toString(), type.name);
    }
  });

  test('lookup', () {
    for (final QueryEngineType type in QueryEngineType.values) {
      expect(QueryEngineType.lookup(type.name), type);
    }

    // Default is binary.
    expect(QueryEngineType.lookup(''), QueryEngineType.binary);
  });
}
