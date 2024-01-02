import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_type.dart';
import 'generator.dart';

extension GenerateFieldRef on Generator {
  Reference generateFieldRef(String name) {
    final ref = findRef(name).allowTypes.first;
    final type = generateType(ref);

    return TypeReference((builder) {
      builder.symbol = 'Reference';
      builder.url = 'package:orm/orm.dart';
      builder.types.add(type);
    });
  }
}

extension on Generator {
  dmmf.FieldRefType findRef(String name) {
    return options.dmmf.schema.fieldRefTypes.prisma
        .firstWhere((element) => element.name == name);
  }
}
