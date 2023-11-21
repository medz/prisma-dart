import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_enum.dart';

extension on dmmf.SchemaTypes<dmmf.Enum> {
  Iterable<dmmf.Enum> get pattern => [...model, ...prisma];
}

Library generateTypesLibrary(dmmf.Schema schema) {
  return Library((builder) {
    builder.name = 'prisma.client.types';

    // Generate enums.
    builder.body.addAll(generateEnums(schema.enumTypes.pattern));
  });
}
