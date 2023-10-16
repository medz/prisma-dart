import '../../engine_core/transaction.dart';

/// Default query request headers.
final Map<String, String> _defaultHeaders = {
  'user-agent': 'Prisma ORM (https://prisma.pub)',
  'content-type': 'application/json; charset=utf-8',
  'accept': 'application/json; charset=utf-8',
};

/// Wrapper for the HTTP headers.
Map<String, String> headersWrapper({
  Iterable<Map<String, String>?>? headers,
  TransactionInfo? info,
}) {
  final entries =
      headers?.whereType<Map<String, String>>().expand((e) => e.entries);
  final result = <String, String>{
    ..._defaultHeaders,
    ...Map.fromEntries(entries ?? []),
  };
  if (info != null) {
    result['x-transaction-id'] = info.id;
  }

  return result;
}
