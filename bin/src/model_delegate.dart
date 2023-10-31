import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/generator_helper.dart' show GeneratorOptions;
import 'package:recase/recase.dart';

import 'packages.dart';
import 'references.dart';

Reference generateModelDelegate(
  dmmf.Model model,
  GeneratorOptions options,
  Map<Reference, Library> libraries,
) {
  final className = '${model.name}Delegate'.pascalCase;
  final reference =
      refer(className, '${className.snakeCase}.dart').typed(refer('T'));

  if (libraries.keys
      .where((element) => element.symbol == reference.symbol)
      .isNotEmpty) {
    return reference;
  }

  final delegate = Class((builder) {
    builder.name = reference.symbol;
    builder.types.add(refer('T'));

    // Generate `_engine` property
    builder.fields.add(Field((builder) {
      builder.name = r'_engine';
      builder.type = ormCoreRefer('Engine').typed(refer('T'));
      builder.modifier = FieldModifier.final$;
    }));

    // Generate [InteractiveTransactionInfo] info.
    builder.fields.add(Field((builder) {
      builder
        ..name = '_transaction'
        ..modifier = FieldModifier.final$
        ..type = ormCoreRefer('InteractiveTransactionInfo')
            .typed(refer('T'))
            .nullable;
    }));

    // Generate constructor
    builder.constructors.add(Constructor((builder) {
      builder.constant = true;

      // First parameter, engine
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = r'engine';
        builder.type = ormCoreRefer('Engine').typed(refer('T'));
        builder.types.add(refer('T'));
      }));

      // Optional parameter, transaction
      builder.optionalParameters.add(Parameter((builder) {
        builder.name = r'transaction';
        builder.type = ormCoreRefer('InteractiveTransactionInfo')
            .typed(refer('T'))
            .nullable;
        builder.types.add(refer('T'));
      }));

      // Initializer list
      builder.initializers.addAll([
        refer(r'_engine').assign(refer(r'engine')).code,
        refer(r'_transaction').assign(refer(r'transaction')).code,
      ]);
    }));

    // Generate model actions
    final modelMapping = options.dmmf.mappings.modelOperations
        .firstWhere((element) => element.model == model.name);
    final actions = modelMapping.toJson()
      ..remove('model')
      ..remove('plural');
    for (final MapEntry(key: clientAction, value: schemaAction)
        in actions.entries) {
      builder.methods.add(Method((builder) {
        final Reference actionReference = generateModelDelegateAction();

        builder.name = clientAction.camelCase;
        builder.returns = actionReference;
      }));
    }
  });

  libraries[reference] = Library((builder) {
    builder.body.add(delegate);
  });

  return reference;
}
