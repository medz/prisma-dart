import 'package:code_builder/code_builder.dart';

Reference runtimeRef(String symbol) => refer(symbol, 'package:orm/orm.dart');
Reference dmmfRef(String symbol) => refer(symbol, 'package:orm/dmmf.dart');
Reference typesRef(String symbol) => refer(symbol, 'types.dart');
Reference typedDataRef(String symbol) => refer(symbol, 'dart:typed_data');

Reference union(Iterable<Reference> types, {bool? nullable}) {
  return TypeReference((builder) {
    builder.symbol = 'PrismaUnion';
    builder.url = 'package:orm/orm.dart';
    builder.types.addAll(types);
    builder.isNullable = nullable;
  });
}
