import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

Library generateClientLibrary(dmmf.DMMF dmmf) {
  return Library((builder) {
    builder.name = 'prisma.client';
  });
}
