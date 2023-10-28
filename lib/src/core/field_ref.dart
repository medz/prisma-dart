abstract interface class FieldRef<T> {
  const FieldRef();

  abstract final String $name;
  abstract final String $model;
  Type get $type => T;
  bool Function(dynamic) get $is;

  static bool Function(dynamic) createIs<T>(FieldRef<T> ref) {
    return (dynamic value) {
      return switch (value) {
        FieldRef value => value.$type == ref.$type,
        Type type => type == T,
        _ => value is T,
      };
    };
  }

  const factory FieldRef.create(String model, String name) = _FieldRefImpl;
}

class _FieldRefImpl<T> extends FieldRef<T> {
  @override
  bool Function(dynamic p1) get $is => FieldRef.createIs(this);

  @override
  final String $model;

  @override
  final String $name;

  const _FieldRefImpl(this.$model, this.$name);
}
