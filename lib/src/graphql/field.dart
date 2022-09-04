import '../runtime/language_keyword.dart';
import 'arg.dart';

class GraphQLField {
  final String name;
  final GraphQLArgs? args;
  final GraphQLFields? fields;

  const GraphQLField(
    this.name, {
    this.args,
    this.fields,
  });

  /// Build GraphQL field SDL.
  String toSdl() {
    final StringBuffer sdl = StringBuffer(languageKeywordDecode(name));

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

class GraphQLFields {
  final List<GraphQLField> children;

  bool get isEmpty => children.isEmpty;

  const GraphQLFields(this.children);

  // Build GraphQL fields SDL.
  String? toSdl() {
    final List<String> results = children.map((e) => e.toSdl()).toList();

    if (results.isEmpty) return null;

    return '{${results.join(', ')}}';
  }
}

void main(List<String> args) {
  final sdl = GraphQLField(
    'query',
    fields: GraphQLFields([
      GraphQLField(
        'user',
        args: GraphQLArgs([
          GraphQLArg('where', {
            'id': 'String',
          }),
        ]),
        fields: GraphQLFields([
          GraphQLField('id'),
          GraphQLField('name'),
        ]),
      ),
    ]),
  );

  print(sdl.toSdl());
}
