import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'reference.dart';
import 'utils/dmmf_schema_types.dart';

final scalars = <String, Reference>{
  'Int': refer('int'),
  'Float': refer('double'),
  'String': refer('String'),
  'Decimal': refer('Decimal').toPackage(Packages.prismaRuntime),
  'BigInt': refer('BigInt'),
  'Bytes': refer('Uint8List').toPackage(Packages.dartTypedData),
  'Json': refer('PrismaJson').toPackage(Packages.prismaRuntime),
  'DateTime': refer('DateTime'),
  'Null': refer('PrismaNull').toPackage(Packages.prismaRuntime),
  'Boolean': refer('bool'),
};

extension DmmfFieldExtension on dmmf.Field {
  Reference toDartReference() {
    return switch (kind) {
      dmmf.FieldKind.scalar => scalars[type] ?? refer(type),
      dmmf.FieldKind.$enum => refer(type),
      _ => throw UnimplementedError(),
    };
  }
}

extension DmmfTypeReferenceExtension on dmmf.TypeReference {
  Reference toDartReference(dmmf.DMMF document, {bool innerTypes = false}) {
    final reference = switch (location) {
      dmmf.TypeLocation.scalar => scalars[type] ?? refer(type),
      dmmf.TypeLocation.enumTypes =>
        _generateEnumReference(type, document, innerTypes),
      dmmf.TypeLocation.fieldRefTypes =>
        _toFieldRefTypeReference(document, innerTypes),
      _ => refer(type).innerTypes(innerTypes),
    };

    if (isList) {
      return TypeReference((builder) {
        builder.symbol = 'Iterable';
        builder.types.add(reference);
      });
    }

    return reference;
  }

  Reference _generateEnumReference(
      String type, dmmf.DMMF document, bool innerTypes) {
    if (type.endsWith('ScalarFieldEnum')) {
      return refer(type.substring(0, type.length - 'FieldEnum'.length))
          .innerTypes(innerTypes);
    }

    return refer(type).innerTypes(innerTypes);
  }

  Reference _toFieldRefTypeReference(dmmf.DMMF document, bool innerTypes) {
    final field = document.schema.fieldRefTypes.pattern
        .firstWhere((element) => element.name == type)
        .allowTypes
        .first;

    return refer('FieldRef').toPackage(Packages.prismaRuntime).copyWith(
      types: [field.toDartReference(document, innerTypes: innerTypes)],
    );
  }
}
