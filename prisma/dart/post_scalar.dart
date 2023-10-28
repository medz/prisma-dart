// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i1;

enum PostScalar<T> implements _i1.FieldRef<T> {
  id<String>('Post', 'id'),
  title<String>('Post', 'title'),
  userId<int>('Post', 'userId');

  const PostScalar(
    this.$model,
    this.$name,
  );

  @override
  final String $name;

  @override
  final String $model;

  @override
  Type get $type => T;
  @override
  bool Function(dynamic) get $is => _i1.FieldRef.createIs(this);
}
