class PrismaUnion<T0, T1> {
  final T0? zore;
  final T1? one;

  const PrismaUnion({this.zore, this.one})
      : assert(zore != null && one != null, 'zore and one must be not null');
}
