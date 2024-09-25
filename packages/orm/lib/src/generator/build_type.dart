import 'context.dart';

String buildType(Context context, String type, String current) {
  final finders = [
    () => findTypeInCurrent(context, type, current),
    () =>
        findOrCreateTypeForNamespace(context, Namespace.prisma, type, current),
    () => findOrCreateTypeForNamespace(context, Namespace.model, type, current),
  ];
  for (final finder in finders) {
    final type = finder();
    if (type != null) return type;
  }

  throw UnsupportedError('Type $type not found');
}

String? findTypeInCurrent(Context context, String type, String current) {
  final library = context.getLibrary(current);
  if (library.types.containsKey(type)) {
    return type;
  }

  return null;
}

enum Namespace { prisma, model }

String? buildNamespaceType(
    Context context, Namespace namespace, String type, String current) {
  final enums = buildNamespaceEnumType(context, namespace);
}

Iterable buildNamespaceEnumType(Context context, Namespace namespace) {
  final finders = [];
}
