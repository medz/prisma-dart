import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:recase/recase.dart';

import 'context.dart';
import 'scalar_resolver.dart';

class ModelScalarGenerator {
  final Context context;

  const ModelScalarGenerator(this.context);

  Future<void> handle(String name) async {
    final meta = LibraryMeta(type: '${name}Scalar'.pascalCase);
    if (context.libraries.containsKey(meta)) {
      return;
    }

    final model = context.options.dmmf.datamodel.models
        .where((element) => element.name == name)
        .first;
    final fields = context.options.dmmf.schema.enumTypes.prisma
        .where((element) => element.name == '${meta.type}FieldEnum')
        .firstOrNull
        ?.values
        .map((e) => model.fields.firstWhere((element) => element.name == e));
    if (fields == null) {
      return;
    }

    final library = Library((builder) {
      builder.body.add(_generateScalar(meta, name, fields));
    });

    context.libraries[meta] = library;
  }

  Enum _generateScalar(
      LibraryMeta meta, String model, Iterable<dmmf.Field> fields) {
    return Enum((builder) {
      builder.name = meta.type;
      builder.types.add(refer('T'));

      builder.implements.add(TypeReference((builder) {
        final fieldRef = coreRefer('FieldRef');

        builder.symbol = fieldRef.symbol;
        builder.url = fieldRef.url;
        builder.types.add(refer('T'));
      }));

      builder.fields.add(Field((builder) {
        builder.name = r'$name';
        builder.type = refer('String');
        builder.modifier = FieldModifier.final$;
        builder.annotations.add(refer('override'));
      }));

      builder.fields.add(Field((builder) {
        builder.name = r'$model';
        builder.type = refer('String');
        builder.modifier = FieldModifier.final$;
        builder.annotations.add(refer('override'));
      }));

      builder.methods.add(Method((builder) {
        builder.name = r'$type';
        builder.returns = refer('Type');
        builder.body = refer('T').code;
        builder.lambda = true;
        builder.type = MethodType.getter;
        builder.annotations.add(refer('override'));
      }));

      builder.methods.add(Method((builder) {
        builder.name = r'$is';
        builder.returns = refer('bool Function(dynamic)');
        builder.body = coreRefer('FieldRef')
            .property('createIs')
            .call([refer('this')]).code;
        builder.lambda = true;
        builder.type = MethodType.getter;
        builder.annotations.add(refer('override'));
      }));

      builder.constructors.add(Constructor((builder) {
        builder.constant = true;

        builder.requiredParameters.add(Parameter((builder) {
          builder.name = r'$model';
          builder.toThis = true;
        }));

        builder.requiredParameters.add(Parameter((builder) {
          builder.name = r'$name';
          builder.toThis = true;
        }));
      }));

      for (final field in fields) {
        builder.values.add(EnumValue((builder) {
          builder.name = field.name.camelCase;
          builder.types.add(typeResolver(field.type, context));
          builder.arguments.add(literalString(model));
          builder.arguments.add(literalString(field.name));
          if (field.documentation != null) {
            builder.docs.add(field.documentation!);
          }
        }));
      }
    });
  }
}
