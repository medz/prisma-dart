import 'package:code_builder/code_builder.dart';

final _scalars = <String, Reference>{
  'Int': refer('int'),
  'Float': refer('double'),
  'String': refer('String'),
  'Boolean': refer('bool'),
  'BigInt': refer('BigInt'),
  'DateTime': refer('DateTime'),
  'Bytes': refer('Uint8List', 'dart:typed_data'),
  'Decimal': refer('Decimal', 'package:orm/orm.dart'),
  'Null': refer('PrismaNull', 'package:orm/orm.dart'),
  'Json': refer('PrismaJson', 'package:orm/orm.dart'),
};

extension Scalar on String {
  Reference get scalar => _scalars[this] ?? refer(this);
}
