import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart';
import 'package:orm/generator_helper.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

class LibraryMeta {
  final String type;
  final FieldLocation? location;
  final FieldNamespace? namespace;

  const LibraryMeta({
    required this.type,
    this.location,
    this.namespace,
  });

  String get filename => '${type.snakeCase}.dart';
  Reference get refer => Reference(type.pascalCase, filename);
  Reference get referWithoutUri => Reference(type.pascalCase);

  String output(String root) => join(root, filename);
}

class Context {
  final GeneratorOptions options;
  final Map<LibraryMeta, Library> libraries = {};

  Context(this.options);
}

Reference coreRefer(String name) => refer(name, 'package:orm/orm.dart');
