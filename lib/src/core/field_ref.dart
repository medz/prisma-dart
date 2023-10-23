abstract interface class FieldRef<T> {
  abstract final String $name;
  abstract final String $model;
  Type get $type => T;
  bool Function(dynamic) get $is;

  static createIs<T>(FieldRef<T> ref) => (dynamic value) => switch (value) {
        FieldRef value => value.$type == ref.$type,
        Type type => type == T,
        _ => value is T,
      };
}
