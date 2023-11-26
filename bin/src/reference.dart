import 'package:code_builder/code_builder.dart';

enum Packages {
  dartTypedData('dart:typed_data'),
  prismaRuntime('package:orm/orm.dart'),
  prismaDmmf('package:orm/dmmf.dart'),
  generatedTypes('types.dart'),
  generatedDmmf('dmmf.dart'),
  ;

  final String url;
  const Packages(this.url);
}

extension TypeReferenceExtension on TypeReference {
  TypeReference copyWith({
    String? symbol,
    String? url,
    Iterable<Reference>? types,
    bool? isNullable,
  }) {
    return TypeReference((builder) {
      builder.symbol = symbol ?? this.symbol;
      builder.url = url ?? this.url;
      builder.types.replace(types ?? this.types);
      builder.isNullable = isNullable ?? this.isNullable;
    });
  }
}

extension ReferenceExtension on Reference {
  TypeReference copyWith({
    String? symbol,
    String? url,
    Iterable<Reference>? types,
    bool? isNullable,
  }) {
    return toTypeReference().copyWith(
      symbol: symbol,
      url: url,
      types: types,
      isNullable: isNullable,
    );
  }

  TypeReference toTypeReference() {
    return switch (this) {
      TypeReference reference => reference,
      _ => TypeReference((builder) {
          builder.symbol = symbol;
          builder.url = url;
        }),
    };
  }

  TypeReference toNullable() {
    return toTypeReference().copyWith(isNullable: true);
  }

  TypeReference toNonNullable() {
    return toTypeReference().copyWith(isNullable: false);
  }

  TypeReference switchNullable(bool nullable) {
    return nullable ? toNullable() : toNonNullable();
  }

  TypeReference toPackage(Packages package) {
    return toTypeReference().copyWith(url: package.url);
  }

  Reference innerTypes(bool isTypes) {
    return isTypes ? this : toPackage(Packages.generatedTypes);
  }
}
