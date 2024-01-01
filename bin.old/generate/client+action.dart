// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../src/dart_style_fixer.dart';
import 'client+action+where.dart';
import 'client.dart';

extension Client$Action on Client {
  Reference generateActionOptions(
      String model, dmmf.ModelAction action, dmmf.OutputField field) {
    final typeName =
        '${model}_${action.name}_ActionOptions'.toDartClassNameString();
    if (types[client]?.contains(typeName) == true) {
      return refer(typeName);
    }

    final implements = [
      generatePagination(field.args),
      generateActionWhereOptions(field.args),
    ];

    final options = Class((builder) {
      builder.name = typeName;
      builder.abstract = true;
      builder.modifier = ClassModifier.final$;
      builder.implements.addAll(implements.whereType<Reference>());
    });
    client.body.add(options);

    types[client] = [...?types[client], options.name];

    return refer(options.name);
  }
}

extension on Client {
  Reference? generatePagination(Iterable<dmmf.InputField> fields) {
    final args = fields
        .where((element) => element.name == 'take' || element.name == 'skip');
    if (args.length == 2) {
      return refer('ActionPaginationOption', 'package:orm/orm.dart');
    }

    return null;
  }
}
