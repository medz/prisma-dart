import '../_internal/extension.dart';
import 'json_convertible.dart';

class PrismaUnion<T0, T1> implements JsonConvertible {
  final T0? _$0;
  final T1? _$1;

  const PrismaUnion.$0(T0 value)
      : _$0 = value,
        _$1 = null;

  const PrismaUnion.$1(T1 value)
      : _$0 = null,
        _$1 = value;

  @override
  toJson() {
    if (_$0 != null) return _serialize(_$0);
    if (_$1 != null) return _serialize(_$1);

    throw Exception('PrismaUnion is empty');
  }

  dynamic _serialize(dynamic value) {
    return switch (value) {
      JsonConvertible value => _serialize(value.toJson()),
      Iterable value => value.withoutNulls.map((e) => _serialize(e)),
      Map value => value.withoutNulls
          .map((key, value) => MapEntry(key, _serialize(value))),
      _ => value
    };
  }
}
