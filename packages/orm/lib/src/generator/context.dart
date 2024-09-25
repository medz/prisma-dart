import '../dmmf/dmmf.dart';
import '../generator_helper/options.dart';

class Reference {
  Reference(this.uri, this.prefix);

  final String uri;
  final String prefix;
  final List<String> types = [];
}

class Library {
  Library(this.name);
  int _referenceIndex = 0;

  final String name;
  final references = <String, Reference>{};
  final types = <String, String>{};

  String refer(String type, String uri) {
    final ref = references.putIfAbsent(
        uri, () => Reference(uri, '__r${_referenceIndex++}'));
    if (!ref.types.contains(type)) {
      ref.types.add(type);
    }

    return '${ref.prefix}.$type';
  }

  R using<R>(Function(Library library) callback) {
    return callback(this);
  }
}

class Context {
  Context(this.options);

  final GeneratorOptions options;
  final libraries = <Library>[];
  DMMF get dmmf => options.dmmf;

  Library getLibrary(String name) {
    return libraries.firstWhere(
      (library) => library.name == name,
      orElse: () => Library(name).using((libaray) {
        libraries.add(libaray);
        return libaray;
      }),
    );
  }
}
