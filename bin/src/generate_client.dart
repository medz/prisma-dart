import 'package:code_builder/code_builder.dart';
import 'package:orm/generator_helper.dart' show GeneratorOptions;
import 'package:recase/recase.dart';

import 'model_delegate.dart';
import 'packages.dart';
import 'references.dart';

Map<Reference, Library> generateClient(GeneratorOptions options) {
  final Map<Reference, Library> libraries = {};
  final reference = refer('PrismaClient');
  final client = Class((builder) {
    builder.name = reference.symbol;

    // Generate `$engine` property
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

    // Generate `_` constructor
    builder.constructors.add(Constructor((builder) {
      builder.name = '_';

      // Add `_engine` parameter
      builder.optionalParameters.add(Parameter((builder) {
        builder.name = r'engine';
        builder.type = ormCoreRefer('Engine').typed(refer('T'));
        builder.required = true;
        builder.named = true;
      }));

      // add `_info` parameter
      builder.optionalParameters.add(Parameter((builder) {
        builder.name = r'transaction';
        builder.type = ormCoreRefer('InteractiveTransactionInfo')
            .typed(refer('T'))
            .nullable;
        builder.required = false;
        builder.named = true;
      }));

      builder.initializers.addAll([
        refer(r'_engine').assign(refer('engine')).code,
        refer('_transaction').assign(refer('transaction')).code,
      ]);

      builder.constant = true;
    }));

    builder.types.add(refer('T'));

    // Generate model delegates
    for (final model in options.dmmf.datamodel.models) {
      final Reference modelDelegate =
          generateModelDelegate(model, options, libraries);

      builder.methods.add(Method((builder) {
        builder.name = model.name.camelCase;
        builder.type = MethodType.getter;
        builder.returns = modelDelegate;
        builder.lambda = true;

        builder.body = modelDelegate.newInstance([
          refer('_engine'),
          refer('_transaction'),
        ]).code;
      }));
    }
  });

  libraries[reference] = Library((builder) {
    builder.body.add(client);
  });

  return libraries;
}
