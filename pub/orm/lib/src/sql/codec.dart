import 'package:meta/meta.dart';

typedef SqlCodecFn = Object? Function(Object? value);

abstract interface class SqlFieldCodec {
  Object? encode(Object? value);

  Object? decode(Object? value);
}

final class SqlLambdaFieldCodec implements SqlFieldCodec {
  final SqlCodecFn _encode;
  final SqlCodecFn _decode;

  SqlLambdaFieldCodec({SqlCodecFn? encode, SqlCodecFn? decode})
    : _encode = encode ?? _identityCodec,
      _decode = decode ?? _identityCodec;

  @override
  Object? encode(Object? value) => _encode(value);

  @override
  Object? decode(Object? value) => _decode(value);
}

abstract interface class SqlFieldCodecResolver {
  SqlFieldCodec? resolve({required String model, required String field});
}

@immutable
final class SqlCodecRegistry implements SqlFieldCodecResolver {
  final Map<String, Map<String, SqlFieldCodec>> _entries;

  SqlCodecRegistry({Map<String, Map<String, SqlFieldCodec>> entries = const {}})
    : _entries = _freezeEntries(entries);

  @override
  SqlFieldCodec? resolve({required String model, required String field}) {
    final fields = _entries[model];
    if (fields == null) {
      return null;
    }
    return fields[field];
  }

  SqlCodecRegistry withField({
    required String model,
    required String field,
    required SqlFieldCodec codec,
  }) {
    final nextEntries = <String, Map<String, SqlFieldCodec>>{};
    for (final entry in _entries.entries) {
      nextEntries[entry.key] = Map<String, SqlFieldCodec>.from(entry.value);
    }

    final fields = nextEntries.putIfAbsent(
      model,
      () => <String, SqlFieldCodec>{},
    );
    fields[field] = codec;

    return SqlCodecRegistry(entries: nextEntries);
  }
}

Map<String, Map<String, SqlFieldCodec>> _freezeEntries(
  Map<String, Map<String, SqlFieldCodec>> entries,
) {
  final next = <String, Map<String, SqlFieldCodec>>{};
  for (final entry in entries.entries) {
    next[entry.key] = Map<String, SqlFieldCodec>.unmodifiable(
      Map<String, SqlFieldCodec>.from(entry.value),
    );
  }
  return Map<String, Map<String, SqlFieldCodec>>.unmodifiable(next);
}

Object? _identityCodec(Object? value) => value;
