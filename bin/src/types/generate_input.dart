import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';
import '../refs.dart';
import '../scalars.dart';
import '../utils/dmmf_schema_types.dart';

Iterable<Class> generateInputTypes(dmmf.DMMF document) sync* {
  for (final input in document.schema.inputTypes.pattern) {
    yield generateInputType(input, document);
  }
}

Class generateInputType(dmmf.InputType input, dmmf.DMMF document) {
  return Class((builder) {
    builder.name = input.name.toDartClassNameString();

    builder.fields.addAll(generateInputFields(input.fields, document));
  });
}

Iterable<Field> generateInputFields(
    Iterable<dmmf.InputField> fields, dmmf.DMMF document) sync* {
  for (dmmf.InputField field in fields) {
    yield generateInputField(field, document);
  }
}

Field generateInputField(dmmf.InputField field, dmmf.DMMF document) {
  return Field((builder) {
    builder.name = field.name.toDartPropertyNameString();
    if (const <String>['AND', 'OR', 'NOT'].contains(field.name)) {
      builder.name = field.name;
    }

    builder.modifier = FieldModifier.final$;
    builder.type = generateInputFieldType(field.inputTypes, document);
  });
}

Reference generateInputFieldType(
    Iterable<dmmf.TypeReference> types, dmmf.DMMF document) {
  return switch (types) {
    Iterable(length: 1, first: final type) => type.toDartReference(),
    // Iterable(length: 2, first: final a, last: final b) =>
    //   union([a.toDartReference(), b.toDartReference()]),
    _ => union([
        types.first.toDartReference(),
        generateInputFieldType(types.skip(1), document),
      ]),
  };
}
