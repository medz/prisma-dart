import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_enum.dart';
import 'generate_input.dart';
import 'generate_output.dart';

Library generateTypesLibrary(dmmf.DMMF document) {
  return Library((builder) {
    builder.name = 'prisma.client.types';

    builder.ignoreForFile.add('non_constant_identifier_names');

    // Generate enums.
    builder.body.addAll(generateEnums(document));

    // Generate input types.
    builder.body.addAll(generateInputTypes(document));

    // Generate output types.
    builder.body.addAll(generateOutputTypes(document));
  });
}
