import '../core/field_ref.dart';
import 'call.dart';

class Operation<R, T, N> extends Call<R, T, N> {
  const Operation(super.factory);

  /// Returns a value of type [R] with [FieldRef] type as a parameter.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final users = await prisma.user.findMany()
  ///   .where(UserWhereInput.name.equals(User.nickname);
  /// ```
  ///
  /// This will generate the following query:
  ///
  /// ```sql
  /// WHERE `User`.`name` = `User`.`nickname`
  /// ```
  R ref(FieldRef<T> reference) => factory(reference);

  /// Creates a new operation with the given [name] and [factory].
  factory Operation.create(String name, Factory<R> factory) =>
      Operation((value) => factory({name: value}));
}
