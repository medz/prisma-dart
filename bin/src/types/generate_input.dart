import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';
import '../scalars.dart';
import '../reference.dart';
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
    builder.constructors.add(generateInputConstructor(input, document));
  });
}

Constructor generateInputConstructor(dmmf.InputType type, dmmf.DMMF document) {
  return Constructor((builder) {
    builder.constant = true;
    builder.optionalParameters.addAll(
      generateInputConstructorParameters(type.fields, document),
    );
  });
}

Iterable<Parameter> generateInputConstructorParameters(
    Iterable<dmmf.InputField> fields, dmmf.DMMF document) sync* {
  for (dmmf.InputField field in fields) {
    yield generateInputConstructorParameter(field, document);
  }
}

Parameter generateInputConstructorParameter(
    dmmf.InputField field, dmmf.DMMF document) {
  return Parameter((builder) {
    builder.name = field.name.toDartPropertyNameString();
    builder.named = true;
    builder.toThis = true;
    builder.required = field.isRequired;
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
    builder.modifier = FieldModifier.final$;
    builder.type = generateInputFieldType(field.inputTypes, document);
    if (!field.isRequired || field.isNullable) {
      builder.type = builder.type?.toNullable();
    }
  });
}

Reference generateInputFieldType(
    Iterable<dmmf.TypeReference> types, dmmf.DMMF document) {
  return switch (types) {
    Iterable(length: 1, first: final type) => type.toDartReference(document),
    _ => refer('PrismaUnion').toPrismaRuntime().copyWith(
        types: [
          types.first.toDartReference(document),
          generateInputFieldType(types.skip(1), document)
        ],
      ),
  };
}
