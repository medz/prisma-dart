// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../src/dart_style_fixer.dart';
import '../utils/iterable.dart';
import 'client+common.dart';
import 'client.dart';

extension Client$Action$Where on Client {
  Reference? generateActionWhereOptions(Iterable<dmmf.InputField> args) {
    final where = args.firstWhereOrNull((element) => element.name == 'where');
    if (where == null) return null;

    final type = where.inputTypes.first;
    final typeRef = refer(
      type.type.toDartClassNameString(),
      switch (type.namespace) {
        dmmf.TypeNamespace.model => 'model.dart',
        dmmf.TypeNamespace.prisma => 'prisma.dart',
        _ => null,
      },
    );
    final builder = getNamespaceLibraryBuilder(type.namespace);

    if (types[builder]?.contains(typeRef.symbol) == true) {
      return typeRef;
    }
    types[builder] = [...?types[builder], typeRef.symbol!];

    final input = findInputType(type);
    final spec = Class((builder) {
      builder.name = typeRef.symbol;
      builder.extend = refer('Input', 'package:orm/orm.dart');
      builder.constructors.add(_defaultConstructor);

      for (final field in input.fields) {
        builder.fields.add(generateStaticField(typeRef.symbol!, field));
      }
    });
    builder.body.add(spec);

    return typeRef;
  }
}

final _defaultConstructor = Constructor((builder) {
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = 'keys';
    builder.toSuper = true;
  }));

  builder.requiredParameters.add(Parameter((builder) {
    builder.name = 'value';
    builder.toSuper = true;
  }));
});

extension on Client {
  Field generateStaticField(String name, dmmf.InputField field) {
    final wherebuilder = TypeReference((builder) {
      builder.symbol = 'WhereBuilder';
      builder.url = 'package:orm/orm.dart';
      builder.types.addAll([
        refer(name),
      ]);
    });

    return Field((builder) {
      builder.static = true;
      builder.modifier = FieldModifier.constant;
      builder.name = field.name.toDartPropertyNameString();
      builder.type = wherebuilder;
      builder.assignment = wherebuilder.newInstance([
        literalConstList([literalString(field.name)]),
      ]).code;
    });
  }

  dmmf.InputType findInputType(dmmf.TypeReference type) {
    final types = switch (type.namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.inputTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.inputTypes.prisma,
      _ => throw Exception('Unknown namespace ${type.namespace}'),
    };

    return types.firstWhere((element) => element.name == type.type);
  }
}
