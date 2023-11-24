import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';
import '../reference.dart';
import '../scalars.dart';
import '../utils/dmmf_schema_types.dart';

extension on dmmf.Enum {
  dmmf.Model? findModel(dmmf.DMMF document) {
    if (name.endsWith('ScalarFieldEnum')) {
      final modelName = name.replaceFirst('ScalarFieldEnum', '');

      return document.datamodel.models
          .where((element) => element.name == modelName)
          .firstOrNull;
    }

    return null;
  }
}

extension on dmmf.Model {
  String toModelScalarEnumName() {
    return '${name}Scalar'.toDartClassNameString();
  }
}

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

final fieldRefEnumModelName = Field((builder) {
  builder.name = 'modelName';
  builder.type = refer('String');
  builder.modifier = FieldModifier.final$;
  builder.annotations.add(refer('override'));
});

final fieldRefEnumField = Method((builder) {
  builder.name = 'field';
  builder.type = MethodType.getter;
  builder.returns = refer('String');
  builder.annotations.add(refer('override'));
  builder.body = refer(enumProperty.name).code;
  builder.lambda = true;
});

final modelScalarConstructor = enumConstructor.rebuild((builder) {
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = fieldRefEnumModelName.name;
    builder.toThis = true;
  }));
});

String generateModelScalarFieldEnumName(dmmf.Model model) {
  return '${model.name}Scalar'.toDartClassNameString();
}

Iterable<Enum> generateEnums(dmmf.DMMF document) sync* {
  for (final dmmf.Enum element in document.schema.enumTypes.pattern) {
    yield generateEnum(element, document);
  }
}

Enum generateEnum(dmmf.Enum element, dmmf.DMMF document) {
  return Enum((builder) {
    final model = element.findModel(document);

    builder.name = element.name.toDartClassNameString();
    builder.implements.add(refer('PrismaEnum').toPrismaRuntime());
    builder.fields.add(enumProperty);
    builder.constructors.add(enumConstructor);

    builder.values.addAll(element.values.map(
      (e) => EnumValue((builder) {
        builder.name = e.toDartPropertyNameString();
        builder.arguments.add(literalString(e));

        // Model scalar field enum.
        if (model != null) {
          builder.arguments.add(literalString(model.name));

          final field = model.fields.firstWhere((element) => element.name == e);
          builder.types.add(field.toDartReference());
        }
      }),
    ));
    builder.methods.add(toPrismaEnumName);

    // TransactionIsolationLevel
    if (element.name == 'TransactionIsolationLevel') {
      builder.implements.add(refer('IsolationLevel').toPrismaRuntime());
      builder.methods.add(isolationLevel);
    }

    // Model scalar field enum.
    if (model != null) {
      builder.name = model.toModelScalarEnumName();

      builder.constructors.clear();
      builder.constructors.add(modelScalarConstructor);

      builder.types.add(refer('T'));

      builder.implements.add(
        refer('FieldRef').toPrismaRuntime().copyWith(
          types: [refer('T')],
        ),
      );
      builder.fields.add(fieldRefEnumModelName);
      builder.methods.add(fieldRefEnumField);
    }
  });
}
