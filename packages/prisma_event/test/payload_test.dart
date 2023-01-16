import 'package:prisma_event/prisma_event.dart';
import 'package:test/test.dart';

void main() {
  group('Payload', () {
    test('Create a new payload', () {
      final payload = Payload(message: 'Hi');
      expect(payload.message, 'Hi');
      expect(payload.target, isNull);
      expect(payload.timestamp, isNull);
    });

    test('fromJson(Only message)', () {
      final json = {'message': '1'};
      final payload = Payload.fromJson(json);
      expect(payload.message, '1');
      expect(payload.target, isNull);
      expect(payload.timestamp, isNull);
    });

    test('FromJson(with target)', () {
      final json = {'message': '1', 'target': '2'};
      final payload = Payload.fromJson(json);
      expect(payload.message, '1');
      expect(payload.target, '2');
      expect(payload.timestamp, isNull);
    });

    test('FromJson(with timestamp)', () {
      final now = DateTime.now();
      final json = {'message': '1', 'timestamp': now.toIso8601String()};
      final payload = Payload.fromJson(json);
      expect(payload.message, '1');
      expect(payload.target, isNull);
      expect(payload.timestamp, now);
    });

    test('toString', () {
      expect(Payload(message: '1').toString(), '1');
      expect(Payload(message: '1', target: '2').toString(), '2: 1');

      final now = DateTime.now();
      expect(Payload(message: '1', timestamp: now).toString(),
          '1 - ${now.toString()}');
    });
  });

  group('QueryPayload', () {
    test('Create new Query Payload', () {
      final payload = QueryPayload(query: '1');
      expect(payload.message, 'Query: 1');
      expect(payload.target, isNull);
      expect(payload.timestamp, isNull);
      expect(payload.query, '1');
      expect(payload.params, isNull);
      expect(payload.duration, isNull);
    });

    test('FromJson', () {
      final now = DateTime.now();
      final json = {
        'message': '1',
        'target': '2',
        'timestamp': now.toIso8601String(),
        'query': '3',
        'params': '4',
        'duration': 5,
      };
      final payload = QueryPayload.fromJson(json);
      expect(payload.message, 'Query: 3');
      expect(payload.target, '2');
      expect(payload.timestamp, now);
      expect(payload.query, '3');
      expect(payload.params, '4');
      expect(payload.duration, const Duration(milliseconds: 5));
    });

    test('toString', () {
      final now = DateTime.now();
      expect(QueryPayload(query: '1').toString(), 'Query: 1');
      expect(QueryPayload(query: '1', target: '2').toString(), '2: Query: 1');
      expect(QueryPayload(query: '1', timestamp: now).toString(),
          'Query: 1 - ${now.toString()}');
      expect(
          QueryPayload(query: '1', duration: const Duration(milliseconds: 5))
              .toString(),
          'Query: 1 - 5ms');
      expect(
          QueryPayload(
                  query: '1',
                  target: '2',
                  timestamp: now,
                  duration: const Duration(milliseconds: 5))
              .toString(),
          '2: Query: 1 - ${now.toString()}(5ms)');
    });
  });
}
