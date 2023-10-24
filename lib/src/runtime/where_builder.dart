import 'call.dart';

class WhereBuilder<R, T, N> extends Call<R, T, N> {
  const WhereBuilder(super.factory);

  /// Creates a new [WhereBuilder] with the given [name] and [factory].
  factory WhereBuilder.create(String name, Factory<R> factory) =>
      WhereBuilder((value) => factory({name: value}));
}

class WhereUniqueBuilder<R, T> extends Call<R, T, Null> {
  const WhereUniqueBuilder(super.factory);

  /// Creates a new [WhereBuilder] with the given [name] and [factory].
  factory WhereUniqueBuilder.create(String name, Factory<R> factory) =>
      WhereUniqueBuilder((value) => factory({name: value}));
}
