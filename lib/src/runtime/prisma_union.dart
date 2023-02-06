class PrismaUnion<T1, T2> {
  final T1? $1;
  final T2? $2;

  PrismaUnion._(this.$1, this.$2);

  factory PrismaUnion.$1(T1 value) => PrismaUnion._(value, null);
  factory PrismaUnion.$2(T2 value) => PrismaUnion._(null, value);

  R when<R>(R Function(T1) $1, R Function(T2) $2) {
    if (this.$1 != null) {
      return $1(this.$1 as T1);
    } else if (this.$2 != null) {
      return $2(this.$2 as T2);
    } else {
      throw StateError('Invalid state');
    }
  }
}
