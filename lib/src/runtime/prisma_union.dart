class PrismaUnion<T0, T1> {
  final T0? zero;
  final T1? one;

  const PrismaUnion({this.zero, this.one})
      : assert(zero != null || one != null, 'PrismaUnion must have a value');

  const PrismaUnion.zero(this.zero)
      : one = null,
        assert(zero != null, 'PrismaUnion.zero must have a value');

  const PrismaUnion.one(this.one)
      : zero = null,
        assert(one != null, 'PrismaUnion.one must have a value');
}
