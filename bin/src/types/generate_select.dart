import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';
import '../reference.dart';

extension on dmmf.OutputType {
  String toSelectClassName() => '${name}Select'.toDartClassNameString();
  String toIncludeClassName() => '${name}Include'.toDartClassNameString();

  Iterable<dmmf.OutputField> get includeFields => fields.where((e) {
        return e.isIncludeField();
      });
}

extension on dmmf.OutputField {
  bool isModelRelation() =>
      outputType.location == dmmf.TypeLocation.outputObjectTypes &&
      outputType.namespace == dmmf.TypeNamespace.model;

  bool isIncludeField() => isModelRelation() || name == '_count';
}

Iterable<Class> generateSelectTypes(dmmf.DMMF document) sync* {
  for (final model in document.schema.outputTypes.model) {
    yield generateModelSelect(model, document);
    yield generateModelInclude(model, document);
  }
}

Class generateModelSelect(dmmf.OutputType model, dmmf.DMMF document) {
  return Class((builder) {
    builder.name = model.toSelectClassName();
    builder.implements.add(refer('MapJsonConvertible').copyWith(
      types: [refer('String'), refer('bool')],
    ).toPackage(Packages.prismaRuntime));
    builder.fields.addAll(generateFields(model.fields));
    builder.methods.add(generateToJson(model.fields));
    builder.constructors.add(generateDefaultConstructor(model.fields));
  });
}

Iterable<Field> generateFields(Iterable<dmmf.OutputField> fields) sync* {
  for (final field in fields) {
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

Method generateToJson(Iterable<dmmf.OutputField> fields) {
  return Method((builder) {
    builder.name = 'toJson';
    builder.annotations.add(refer('override'));
    builder.returns = refer('Map').copyWith(
      types: [refer('String'), refer('bool')],
    );

    final entries = fields.map((e) {
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

Constructor generateDefaultConstructor(Iterable<dmmf.OutputField> fields) {
  return Constructor((builder) {
    builder.optionalParameters.addAll(fields.map((e) {
      return Parameter((builder) {
        builder.name = e.name.toDartPropertyNameString();
        builder.toThis = true;
        builder.named = true;
      });
    }));
  });
}

Class generateModelInclude(dmmf.OutputType model, dmmf.DMMF document) {
  return Class((builder) {
    builder.name = model.toIncludeClassName();
    builder.implements.add(refer('MapJsonConvertible').copyWith(
      types: [refer('String'), refer('bool')],
    ).toPackage(Packages.prismaRuntime));
    builder.fields.addAll(generateFields(model.includeFields));
    builder.methods.add(generateToJson(model.includeFields));
    builder.constructors.add(generateDefaultConstructor(model.includeFields));
  });
}
