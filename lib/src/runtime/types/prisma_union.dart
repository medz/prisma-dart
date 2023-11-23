class PrismaUnion<A, B> {
  final A? $1;
  final B? $2;

  const PrismaUnion.$1(A value)
      : $1 = value,
        $2 = null;

  const PrismaUnion.$2(B value)
      : $1 = null,
        $2 = value;
}
