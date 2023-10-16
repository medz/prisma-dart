import 'arg.dart';

class GraphQLField {
  final String name;
  final Iterable<GraphQLArg>? args;
  final Iterable<GraphQLField>? fields;

  const GraphQLField(
    this.name, {
    this.args,
    this.fields,
  });

  /// Build GraphQL field SDL.
  String toSdl() {
    final StringBuffer sdl = StringBuffer(name);

    // Build args SDL.
    final String? argsSdl = args?.toSdl();
    if (argsSdl != null) {
      sdl.write(argsSdl);
    }

    // Build fields SDL.
    final String? fieldsSdl = fields?.toSdl();
    if (fieldsSdl != null) {
      sdl.write(' $fieldsSdl');
    }

    return sdl.toString();
  }
}

extension GraphQLFieldsExtension on Iterable<GraphQLField> {
  /// Build GraphQL fields SDL.
  String? toSdl() {
    final results = map((e) => e.toSdl());

    return results.isEmpty ? null : '{${results.join(', ')}}';
  }
}
