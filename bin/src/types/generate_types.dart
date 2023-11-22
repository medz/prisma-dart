import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_enum.dart';

Library generateTypesLibrary(dmmf.DMMF document) {
  return Library((builder) {
    builder.name = 'prisma.client.types';

    // Generate enums.
    builder.body.addAll(generateEnums(document));
  });
}
