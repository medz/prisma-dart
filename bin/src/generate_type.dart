import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_enum.dart';
import 'generate_field_ref.dart';
import 'generate_input.dart';
import 'generate_output.dart';
import 'generator.dart';
import 'utils/reference.dart';
import 'utils/scalars.dart';

extension GenerateType on Generator {
  Reference generateType(dmmf.TypeReference type) {
    return switch (type.location) {
      dmmf.TypeLocation.inputObjectTypes =>
        generateInput(type.type, type.namespace, type.isList),
      dmmf.TypeLocation.outputObjectTypes =>
        generateOutput(type.type, type.namespace, type.isList),
      dmmf.TypeLocation.enumTypes =>
        generateEnum(type.type, type.namespace, type.isList),
      dmmf.TypeLocation.fieldRefTypes =>
        generateFieldRef(type.type).list(type.isList),
      _ => generateScalar(type.type, type.isList),
    };
  }
}

extension on Generator {
  Reference generateScalar(String type, bool isList) {
    final reference = type.scalar;
    if (isList) {
      return TypeReference((type) {
        type.symbol = 'Iterable';
        type.types.add(reference);
      });
    }

    return reference;
  }
}
