import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';

const typeActionTypeNames = <String>['Query', 'Mutation'];

void wrapSelectArgs(dmmf.DMMF document) {
  for (final mapping in document.mappings.modelOperations) {
    for (final action in mapping.actions.values) {
      final field = findModelAction(action, document);
      if (field == null) continue;

      wrapFieldArgs(field, document);
    }
  }
}

dmmf.OutputField? findModelAction(String action, dmmf.DMMF document) {
  final types = document.schema.outputTypes.prisma
      .where((element) => typeActionTypeNames.contains(element.name));

  for (final type in types) {
    final field =
        type.fields.where((element) => element.name == action).firstOrNull;

    if (field != null) return field;
  }

  return null;
}

void wrapFieldArgs(dmmf.OutputField field, dmmf.DMMF document) {
  final type = field.toOutputType(document);

  // If type is null or already exists, skip.
  if (type == null) return;

  final input = document.schema.inputTypes.prisma.firstWhere(
    (element) => element.name == type.toSelectClassNameString(),
    orElse: () => dmmf.InputType(
      name: type.toSelectClassNameString(),
      constraints: const dmmf.InputTypeConstraints(),
      fields: [],
    ),
  );

  // Add the input type to the schema.
  if (!type.exists(document)) {
    document.schema.inputTypes.add(input);
  }

  final arg = field.args.firstWhere(
    (element) => element.name == r'select',
    orElse: () => dmmf.InputField(
      name: r'select',
      isNullable: true,
      isRequired: false,
      inputTypes: [
        dmmf.TypeReference(
          isList: false,
          location: dmmf.TypeLocation.inputObjectTypes,
          namespace: dmmf.TypeNamespace.prisma,
          type: input.name,
        )
      ],
    ),
  );
  if (!field.args.contains(arg)) {
    field.args.add(arg);
  }
}

extension on dmmf.SchemaTypes<dmmf.InputType> {
  void add(dmmf.InputType type) {
    if (prisma.where((element) => element.name == type.name).isNotEmpty) {
      return;
    }

    return prisma.add(type);
  }
}

extension on dmmf.OutputType {
  String toSelectClassNameString() {
    return '${name}Select'.toDartClassNameString();
  }

  bool exists(dmmf.DMMF document) {
    return document.schema.inputTypes.prisma
        .where((element) => element.name == toSelectClassNameString())
        .isNotEmpty;
  }
}

extension on dmmf.OutputField {
  dmmf.OutputType? toOutputType(dmmf.DMMF document) {
    if (outputType.location != dmmf.TypeLocation.outputObjectTypes) {
      return null;
    }

    final types = switch (outputType.namespace) {
      dmmf.TypeNamespace.prisma => document.schema.outputTypes.prisma,
      dmmf.TypeNamespace.model => document.schema.outputTypes.model,
      _ => null,
    };

    return types?.findType(outputType.type);
  }
}

extension on Iterable<dmmf.OutputType> {
  dmmf.OutputType? findType(String name) {
    return where((element) => element.name == name).firstOrNull;
  }
}
