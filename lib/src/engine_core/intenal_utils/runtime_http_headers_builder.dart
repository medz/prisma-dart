import '../../../version.dart';

/// Runtime http headers builder.
Map<String, String> runtimeHttpHeadersBuilder([Map<String, dynamic>? headers]) {
  final Map<String, String> result = <String, String>{
    'User-Agent': 'Prisma ORM - Dart',
    'Content-Type': 'application/json',
    'X-Prisma-Dart-Version': packageVersion,
    'X-Prisma-Binary-Version': binaryVersion,
  };

  for (final MapEntry<String, dynamic> entry
      in headers?.entries ?? <MapEntry<String, dynamic>>[]) {
    if (entry.key.toLowerCase() == 'transactionid' && entry.value != null) {
      result['X-transaction-id'] = entry.value.toString();
    } else if (entry.value != null) {
      result[entry.key] = entry.value.toString();
    }
  }

  return result;
}
