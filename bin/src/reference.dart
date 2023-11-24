import 'package:code_builder/code_builder.dart';

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

  TypeReference toPrismaRuntime() {
    return toTypeReference().copyWith(url: 'package:orm/orm.dart');
  }

  TypeReference toPrismaDmmf() {
    return toTypeReference().copyWith(url: 'package:orm/dmmf.dart');
  }

  TypeReference toGeneratedTypes() {
    return toTypeReference().copyWith(url: 'types.dart');
  }

  TypeReference toDartTypedData() {
    return toTypeReference().copyWith(url: 'dart:typed_data');
  }

  TypeReference toDartCore() {
    return toTypeReference().copyWith(url: 'dart:core');
  }
}
