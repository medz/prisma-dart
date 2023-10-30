import 'package:code_builder/code_builder.dart';

extension ReferenceExtension on Reference {
  TypeReference typed(Reference reference) => TypeReference((builder) {
        builder.symbol = symbol;
        builder.url = url;

        if (this is TypeReference) {
          final self = this as TypeReference;
          builder.bound = self.bound;
          builder.isNullable = self.isNullable;
          builder.types.addAll(self.types);
        }

        builder.types.add(reference);
      });

  TypeReference get nullable => TypeReference((builder) {
        builder
          ..symbol = symbol
          ..url = url;

        if (this is TypeReference) {
          final self = this as TypeReference;
          builder.bound = self.bound;
          builder.types.addAll(self.types);
        }

        builder.isNullable = true;
      });
}
