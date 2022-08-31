import 'package:orm/dmmf.dart';

import 'scalar.dart';

String objectFieldType(SchemaType type) {
  if (type.isList) {
    return 'List<${scalar(type.type)}>';
  }

  return scalar(type.type);
}
