import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart';

import 'reference.dart';

Library generateDmmfLibrary(DMMF document) {
  return Library((builder) {
    builder.name = 'prisma.client.dmmf';

    final source =
        declareConst('_source').assign(literalMap(document.source)).statement;
    builder.body.add(source);

    final dmmf = declareFinal('dmmf').assign(refer('DMMF')
        .toPackage(Packages.prismaDmmf)
        .newInstanceNamed('fromJson', [refer('_source')]));
    builder.body.add(dmmf.statement);
  });
}
