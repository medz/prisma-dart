class PrismaUnion<T0, T1> {
  final T0? _$0;
  final T1? _$1;

  const PrismaUnion.$0(T0 value)
      : _$0 = value,
        _$1 = null;

  const PrismaUnion.$1(T1 value)
      : _$0 = null,
        _$1 = value;

  R cast<R>() {
    if (_$0 is R || R == T0) return _$0 as R;
    if (_$1 is R || R == T1) return _$1 as R;

    throw ArgumentError('Cannot cast $this to $R');
  }
}
