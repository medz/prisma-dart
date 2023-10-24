import '../core/prisma_null.dart';
import 'call.dart';

/// Extension for [Call] with [PrismaNull] type.
extension NullProperty<R, T> on Call<R, T, PrismaNull> {
  /// Returns a value of type [R] with [PrismaNull] type.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final users = await prisma.user.findMany()
  ///   .where(UserWhereInput.name.$null);
  /// ```
  ///
  /// This will generate the following query:
  ///
  /// ```json
  /// {"name": null}
  /// ```
  ///
  /// ## Why?
  ///
  /// In Prisma, null is a valid database query value, while in Dart null
  /// should not be used as an actual valid value.
  ///
  /// The reason is that we may have types such as [String?]. It is meaningless
  /// to pass in `null`, and it is difficult for us to distinguish whether the
  /// parameter should be a null value. Prisma was born for TS/JS. `null` in
  /// Dart and TS/JS `undefined` value equivalent.
  R get $null => factory(const PrismaNull());
}
