import 'package:code_builder/code_builder.dart';
import 'package:orm/generator_helper.dart';

import '../src/dart_style_fixer.dart';
import 'client+delegate.dart';

class Client {
  final GeneratorOptions options;
  final Map<LibraryBuilder, List<String>> types = {};

  final LibraryBuilder client = LibraryBuilder()..name = 'prisna.client';
  final LibraryBuilder model = LibraryBuilder()
    ..name = 'prisma.namespace.model';
  final LibraryBuilder prisma = LibraryBuilder()
    ..name = 'prisma.namespace.prisma';

  Client(this.options);

  Future<void> generate() async {
    client.body.add(generateClient());
  }
}

extension on Client {
  Extension generateClient() {
    return Extension((builder) {
      builder.name = 'PrismaClientExtension';
      builder.types.add(refer('T'));
      builder.on = TypeReference((builder) {
        builder.symbol = 'PrismaClient';
        builder.types.add(refer('T'));
        builder.url = 'package:orm/orm.dart';
      });
      builder.methods.addAll(generateMethods());
      builder.fields.add(generateDatamodel());
    });
  }

  Iterable<Method> generateMethods() sync* {
    for (final modelMapping in options.dmmf.mappings.modelOperations) {
      final delegate = generateDelegate(modelMapping);

      yield Method((builder) {
        builder.name = modelMapping.model.toDartPropertyNameString();
        builder.type = MethodType.getter;
        builder.returns = delegate;
        builder.body = delegate.newInstanceNamed('_', [refer('this')]).code;
      });
    }
  }

  Field generateDatamodel() {
    final type = refer('DataModel', 'package:orm/dmmf.dart');
    final value = options.dmmf.source['datamodel'];
    final datamodel = type.newInstanceNamed('fromJson', [literalMap(value)]);

    return Field((builder) {
      builder.name = '_datamodel';
      builder.static = true;
      builder.modifier = FieldModifier.final$;
      builder.type = type;
      builder.assignment = datamodel.code;
    });
  }
}
