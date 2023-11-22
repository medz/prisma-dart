import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'refs.dart';

final scalars = <String, Reference>{
  'Int': refer('int'),
  'Float': refer('double'),
  'String': refer('String'),
  'Decimal': runtimeRef('Decimal'),
  'BigInt': refer('BigInt'),
  'Bytes': typedDataRef('Uint8List'),
  'Json': runtimeRef('PrismaJson'),
  'DateTime': refer('DateTime'),
};

extension DmmfFieldExtension on dmmf.Field {
  Reference toDartReference({bool innerTypes = false}) {
    return switch (kind) {
      dmmf.FieldKind.scalar => scalars[type] ?? refer(type),
      dmmf.FieldKind.$enum => innerTypes ? refer(type) : typesRef(type),
      _ => throw UnimplementedError(),
    };
  }
}
