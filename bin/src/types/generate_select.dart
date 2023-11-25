import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';
import '../reference.dart';

extension on dmmf.OutputType {
  String toSelectClassName() => '${name}Select'.toDartClassNameString();
}

Iterable<Class> generateSelectTypes(dmmf.DMMF document) sync* {
  for (final model in document.schema.outputTypes.model) {
    yield generateModelSelect(model, document);
    // yield generateModelInclude(model, document);
  }
}

Class generateModelSelect(dmmf.OutputType model, dmmf.DMMF document) {
  return Class((builder) {
    builder.name = model.toSelectClassName();
    builder.implements.add(refer('MapJsonConvertible').copyWith(
      types: [refer('String'), refer('bool')],
    ).toPackage(Packages.prismaRuntime));
    builder.fields.addAll(generateSelectFields(model));
    builder.methods.add(generateSelectMethod(model));
    builder.constructors.add(generateSelectConstructor(model));
  });
}

Iterable<Field> generateSelectFields(dmmf.OutputType model) sync* {
  for (final field in model.fields) {
    yield generateSelectField(field);
  }
}

Field generateSelectField(dmmf.OutputField field) {
  return Field((builder) {
    builder.name = field.name.toDartPropertyNameString();
    builder.type = refer('bool').toNullable();
    builder.modifier = FieldModifier.final$;
  });
}

Method generateSelectMethod(dmmf.OutputType field) {
  return Method((builder) {
    builder.name = 'toJson';
    builder.annotations.add(refer('override'));
    builder.returns = refer('Map').copyWith(
      types: [refer('String'), refer('bool')],
    );

    final entries = field.fields.map((e) {
      final key = Block((builder) {
        builder.statements.add(
          refer('if').call([
            refer(e.name.toDartPropertyNameString()).notEqualTo(literalNull)
          ]).code,
        );
        builder.statements.add(literalString(e.name).code);
      });

      return MapEntry(
        key,
        refer(e.name.toDartPropertyNameString()).nullChecked,
      );
    });

    builder.body = literalMap(Map.fromEntries(entries)).code;
  });
}

Constructor generateSelectConstructor(dmmf.OutputType model) {
  return Constructor((builder) {
    builder.optionalParameters.addAll(model.fields.map((e) {
      return Parameter((builder) {
        builder.name = e.name.toDartPropertyNameString();
        builder.toThis = true;
        builder.named = true;
      });
    }));
  });
}
