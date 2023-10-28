import 'package:code_builder/code_builder.dart';

import 'context.dart';

final _types = {
  'Int': refer('int'),
  'BigInt': refer('BigInt'),
  'Bytes': refer('ByteBuffer', 'dart:typed_data'),
  'Decimal': coreRefer('Decimal'),
  'Json': coreRefer('PrismaJson'),
  'Float': refer('double'),
  'String': refer('String'),
  'Boolean': refer('bool'),
  'DateTime': refer('DateTime'),
};

Reference typeResolver(String type, Context context) {
  if (_types.containsKey(type)) {
    return _types[type]!;
  }

  return context.libraries.keys
      .firstWhere((element) => element.type == type)
      .refer;
}
