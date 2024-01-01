// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../utils/iterable.dart';
import 'client+input+where.dart';
import 'client.dart';

extension Client$Action$Where on Client {
  Reference? generateActionWhereOptions(Iterable<dmmf.InputField> args) {
    final where = args.firstWhereOrNull((element) => element.name == 'where');
    if (where == null) return null;

    final type = where.inputTypes.first;
    final input = findInputType(type);
    final ref = generateWhereInput(input, type.namespace!);

    return TypeReference((builder) {
      builder.symbol = 'ActionWhereOption';
      builder.url = 'package:orm/orm.dart';
      builder.types.add(ref);
    });
  }
}

extension on Client {
  dmmf.InputType findInputType(dmmf.TypeReference type) {
    final types = switch (type.namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.inputTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.inputTypes.prisma,
      _ => throw Exception('Unknown namespace ${type.namespace}'),
    };

    return types.firstWhere((element) => element.name == type.type);
  }
}
