/// Factory function, Returns [R] and takes [dynamic] as argument.
typedef Factory<R> = R Function(dynamic);

/// The [Call] class is used to create a new instance of a [Factory].
abstract class Call<R, T, N> {
  /// The [factory] function.
  final Factory<R> factory;

  /// Creates a new [Call] with the given [factory].
  const Call(this.factory);

  /// Calls the [factory] with the given [value].
  ///
  /// Called with the required [T] as argument, returns an instance of type [R].
  R call(T value) => factory(value);
}
