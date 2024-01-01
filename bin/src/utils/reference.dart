import 'package:code_builder/code_builder.dart';

extension ReferenceHelpers on Reference {
  Reference nullable(bool isNullable) {
    if (this is TypeReference) {
      final TypeReference reference = this as TypeReference;

      return TypeReference((type) {
        type.symbol = reference.symbol;
        type.url = reference.url;
        type.bound = reference.bound;
        type.types.addAll(reference.types);
        type.isNullable = isNullable;
      });
    }

    return TypeReference((type) {
      type.symbol = symbol;
      type.url = url;
      type.isNullable = isNullable;
    });
  }

  Reference list(bool isList) {
    if (isList) {
      return TypeReference((type) {
        type.symbol = 'Iterable';
        type.types.add(this);
      });
    }

    return this;
  }
}
