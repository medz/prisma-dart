class PrismaUnion<T0, T1> {
  final T0? zero;
  final T1? one;

  const PrismaUnion({this.zero, this.one})
      : assert(zero != null || one != null, 'zore and one must be not null');

  factory PrismaUnion.zero(T0 zero) => PrismaUnion(zero: zero);
  factory PrismaUnion.one(T1 one) => PrismaUnion(one: one);
}
