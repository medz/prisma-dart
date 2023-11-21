import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';
import '../refs.dart';

final enumProperty = Field((builder) {
  builder.name = '_prismaEnumName';
  builder.type = refer('String');
  builder.modifier = FieldModifier.final$;
});

final enumConstructor = Constructor((builder) {
  builder.constant = true;
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = enumProperty.name;
    builder.toThis = true;
  }));
});

final modelScalarConstructor = enumConstructor.rebuild((builder) {});

final toPrismaEnumName = Method((builder) {
  builder.name = 'toPrismaEnumName';
  builder.returns = refer('String');
  builder.annotations.add(refer('override'));
  builder.body = refer(enumProperty.name).code;
  builder.lambda = true;
});

final isolationLevel = Method((builder) {
  builder.name = 'value';
  builder.type = MethodType.getter;
  builder.returns = refer('String');
  builder.annotations.add(refer('override'));
  builder.body = refer(enumProperty.name).code;
  builder.lambda = true;
});

String generateModelScalarEnumName(String name) {
  return name.replaceFirst('ScalarFieldEnum', 'Scalar').toDartClassNameString();
}

Iterable<Enum> generateEnums(Iterable<dmmf.Enum> enums) sync* {
  for (final dmmf.Enum element in enums) {
    yield generateEnum(element);
  }
}

Enum generateEnum(dmmf.Enum element) {
  return Enum((builder) {
    builder.name = element.name.toDartClassNameString();
    builder.implements.add(runtimeRef('PrismaEnum'));
    builder.fields.add(enumProperty);
    builder.constructors.add(enumConstructor);
    builder.values.addAll(element.values.map(
      (e) => EnumValue((builder) {
        builder.name = e.toDartPropertyNameString();
        builder.arguments.add(literalString(e));
      }),
    ));
    builder.methods.add(toPrismaEnumName);

    // TransactionIsolationLevel
    if (element.name == 'TransactionIsolationLevel') {
      builder.implements.add(runtimeRef('IsolationLevel'));
      builder.methods.add(isolationLevel);
    }

    // Model scalar field enum.
    if (element.name.endsWith('ScalarFieldEnum')) {
      builder.name = generateModelScalarEnumName(element.name);
      builder.types.add();

      builder.constructors.clear();
      builder.constructors.add(modelScalarConstructor);
    }
  });
}
