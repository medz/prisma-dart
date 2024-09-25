import 'package:code_builder/code_builder.dart';
import 'package:orm/generator_helper.dart';

import 'generate_client.dart';

class Libraries {
  final client = LibraryBuilder();
  final prisma = LibraryBuilder();
  final model = LibraryBuilder();
}

class Generated {
  final Set<String> client = {};
  final Set<String> prisma = {};
  final Set<String> model = {};
}

class Generator {
  final GeneratorOptions options;
  final libraries = Libraries();
  final generated = Generated();

  Generator(this.options);

  Iterable<(String, Library)> generate() sync* {
    libraries.prisma.ignoreForFile.add('non_constant_identifier_names');
    libraries.client.body.add(generateClient());

    yield ('client.dart', libraries.client.build());
    yield ('prisma.dart', libraries.prisma.build());
    yield ('model.dart', libraries.model.build());
  }
}
